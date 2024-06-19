function db_download() {

	env=$1

	if [[ -z $env ]]; then
		log_error "Missing env ( dev, staging, prod ) "
		return
	fi

	log "Check if in root"
	check_if_in_wp_root

	local_domain=$(wp option get siteurl --skip-plugins)

	log "Local Domain = $local_domain"

	if [[ "$local_domain" == "" ]]; then
		log_error "Missing local domain"
		return
	fi

	wpe_install_name=$(wp config get WPE_${env:u}_INSTALL_NAME --skip-plugins)
	download_path="cli_db_export.sql"

	log "Checking if a recent 5 min database export exists locally..."

	file_age=$(find wp-content/cli_db_export.sql -mmin -5 -print)

	if [[ -n $file_age ]]; then
		log "Using existing database export file."
	else
		log "Exporting DB..."
		run_wpe_command $env "pwd && wp db export wp-content/cli_db_export.sql --skip-plugins"
		log "Downloading db from $wpe_install_name"
		path_local="$PWD"
		download_path="cli_db_export.sql"
		rsync -r -a -v -P $wpe_install_name@$wpe_install_name.ssh.wpengine.net:~/sites/$wpe_install_name/wp-content/$download_path $path_local/wp-content/$download_path

		log "Clean up sql file on remote"
		run_wpe_command $env "pwd && rm -fr wp-content/cli_db_export.sql"
	fi

	wp db import wp-content/cli_db_export.sql --skip-plugins
	imported_domain=$(wp option get siteurl --skip-plugins)

	log "Replacing db $imported_domain with $local_domain"
	wp search-replace "$imported_domain" "$local_domain"
}

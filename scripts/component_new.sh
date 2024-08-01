#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Directory containing the templates
TEMPLATE_DIR="../templates/component"

check_if_in_theme_root

# Function to create directory and files from templates
create_files_from_templates() {
	print_info "Enter the component name (in snake case, e.g., my_component_name):"
	read component_name

	component_name_title_case=$(snake_to_title_case "$component_name")
	component_tag="${component_name//_/-}"

	schema_version=$(prompt_with_default "Enter the schema version" "5")
	version=$(prompt_with_default "Enter the version" "1.0.0")

	print_info "Enter the component description:"
	read component_description
	print_info "Enter the component category:"
	read component_category

	# Escape single quotes for PHP strings
	component_description=$(escape_single_quotes "$component_description")
	component_category=$(escape_single_quotes "$component_category")

	# Directory where the command is run
	current_dir="$(pwd)"

	# Create the component directory inside the current directory
	component_dir="$current_dir/$component_name"
	mkdir -p "$component_dir"
	print_success "Component directory '$component_dir' created."

	# Define the list of files to create
	files=(
		"component.html"
		"component.js"
		"component.json"
		"component.php"
		"component.scss"
		"component.tpl.php"
	)

	for template in "${files[@]}"; do
		template_path="$TEMPLATE_DIR/$template"
		file_name="${component_name}${template#component}"
		file_path="$component_dir/$file_name"

		# Read template content
		if [[ -f "$template_path" ]]; then
			content=$(<"$template_path")
		else
			print_error "Template file '$template_path' not found."
			continue
		fi

		# Replace placeholders with user input
		content="${content//\{\{COMPONENT_CLASS\}\}/$component_name}"
		content="${content//\{\{SCHEMA_VERSION\}\}/$schema_version}"
		content="${content//\{\{VERSION\}\}/$version}"
		content="${content//\{\{COMPONENT_SLUG\}\}/$component_name}"
		content="${content//\{\{COMPONENT_NAME\}\}/$component_name_title_case}"
		content="${content//\{\{COMPONENT_DESCRIPTION\}\}/$component_description}"
		content="${content//\{\{COMPONENT_CATEGORY\}\}/$component_category}"
		content="${content//\{\{COMPONENT_TAG\}\}/$component_tag}"

		# Write the customized content to the new file
		echo "$content" >"$file_path"
		print_success "File '$file_name' created with customized content."
	done

	print_success "All files created in '$component_dir' directory."
}

# Call the function
create_files_from_templates

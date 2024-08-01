<style>
    *[slot] {
        visibility: hidden;
    }
</style>

<{{COMPONENT_TAG}} <?php $this->component_class($module); ?> >
    <!-- Example slot elements -->
    <h5 slot="header">{{COMPONENT_NAME}} Header</h5>
    <p slot="content">{{COMPONENT_DESCRIPTION}}</p>
    <a slot="footer" href="#">Footer Link</a>
</{{COMPONENT_TAG}}>

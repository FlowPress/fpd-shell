import template from "./{{COMPONENT_SLUG}}.html";
import { init } from "../../utils.js";

import "./{{COMPONENT_SLUG}}.scss";

class {{COMPONENT_CLASS}} extends HTMLElement {
  constructor() {
    super();
    init(this, template);
  }
}

// Define the new element
customElements.define("{{COMPONENT_TAG}}", {{COMPONENT_CLASS}});

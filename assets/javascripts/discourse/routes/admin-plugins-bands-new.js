import { ajax } from "discourse/lib/ajax";
import DiscourseRoute from "discourse/routes/discourse";
import EmberObject from "@ember/object";

export default DiscourseRoute.extend({
  model() {
    return {}
  },
  renderTemplate() {
    this.render('admin.plugins.bands.new');
  },
  controllerName: 'admin-plugins-bands-new',
});

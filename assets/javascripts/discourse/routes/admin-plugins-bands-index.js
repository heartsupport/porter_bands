import { ajax } from "discourse/lib/ajax";
import DiscourseRoute from "discourse/routes/discourse";
import EmberObject from "@ember/object";

export default DiscourseRoute.extend({
  model() {
    return ajax("/admin/plugins/porter/bands.json").then((data) => {
      return data.bands.map((band) => EmberObject.create(band));
    });
  },
  renderTemplate() {
    this.render('admin.plugins.bands.index');
  },
  controllerName: 'admin-plugins-bands-index',
  actions: {
    refreshRoute() {
      this.refresh();
    }
  }


});

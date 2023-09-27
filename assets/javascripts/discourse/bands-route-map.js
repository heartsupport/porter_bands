export default {
  resource: "admin.adminPlugins",
  path: "/plugins",
  map() {
    this.route("bands", { path: "/bands" }, function () {
      this.route("new", { path: "/new" });
      this.route("create", { path: "/create" });
      this.route("destroy", { path: "/destroy/:band_id" });
    });
  }
}

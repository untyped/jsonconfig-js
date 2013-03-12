window.require.define({
    config: function(exports, require, module) {
        "use strict";
        var Config, parse;
        parse = require("parser");
        module.exports = Config = function() {
            function Config(data) {
                this.data = data;
            }
            Config.prototype.get = function(path) {
                return parse(path).get(data);
            };
            return Config;
        }();
    }
});

window.require.define({
    jsonconfig: function(exports, require, module) {
        "use strict";
        module.exports = require("config");
    }
});

window.require.define({
    parser: function(exports, require, module) {
        "use strict";
        var Root, root, _, _this = this;
        _ = require("underscore");
        Root = require("path/root");
        root = new Root();
        exports.parse = function(path) {
            console.log("a", root);
            _.reduce(path.split("."), function(memo, name) {
                console.log("b", memo, name);
                return memo.field(name);
            });
            return root;
        };
    }
});

window.require.define({
    "path/field": function(exports, require, module) {
        "use strict";
        var Field, Path, __bind = function(fn, me) {
            return function() {
                return fn.apply(me, arguments);
            };
        }, __hasProp = {}.hasOwnProperty, __extends = function(child, parent) {
            for (var key in parent) {
                if (__hasProp.call(parent, key)) child[key] = parent[key];
            }
            function ctor() {
                this.constructor = child;
            }
            ctor.prototype = parent.prototype;
            child.prototype = new ctor();
            child.__super__ = parent.prototype;
            return child;
        };
        Path = require("./path");
        module.exports = Field = function(_super) {
            __extends(Field, _super);
            function Field(parent, name) {
                this.get = __bind(this.get, this);
                Field.__super__.constructor.call(this, parent);
                this.name = name;
            }
            Field.prototype.get = function(data) {
                return data[name];
            };
            return Field;
        }(Path);
    }
});

window.require.define({
    "path/path": function(exports, require, module) {
        "use strict";
        var Path, __bind = function(fn, me) {
            return function() {
                return fn.apply(me, arguments);
            };
        };
        module.exports = Path = function() {
            function Path(parent) {
                this.get = __bind(this.get, this);
                this.field = __bind(this.field, this);
                this.parent = parent;
            }
            Path.prototype.field = function(name) {
                return new Field(this, name);
            };
            Path.prototype.get = function(data) {
                return parent.get(data)[name];
            };
            return Path;
        }();
    }
});

window.require.define({
    "path/root": function(exports, require, module) {
        "use strict";
        var Field, Path, Root, __bind = function(fn, me) {
            return function() {
                return fn.apply(me, arguments);
            };
        }, __hasProp = {}.hasOwnProperty, __extends = function(child, parent) {
            for (var key in parent) {
                if (__hasProp.call(parent, key)) child[key] = parent[key];
            }
            function ctor() {
                this.constructor = child;
            }
            ctor.prototype = parent.prototype;
            child.prototype = new ctor();
            child.__super__ = parent.prototype;
            return child;
        };
        Path = require("./path");
        Field = require("./field");
        module.exports = Root = function(_super) {
            __extends(Root, _super);
            function Root(parent) {
                this.get = __bind(this.get, this);
                Root.__super__.constructor.call(this, parent);
            }
            Root.prototype.get = function(data) {
                return data;
            };
            return Root;
        }(Path);
    }
});
//@ sourceMappingURL=dist/jsonconfig.js.map
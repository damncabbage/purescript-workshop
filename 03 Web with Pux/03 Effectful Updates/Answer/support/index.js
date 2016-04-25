var main = require('../src/Main.purs').main;
var initialState = require('../src/Layout.purs').init;
var styles = require('../html/styles.css');

if(module.hot) {
	var app = main(window.puxLastState || initialState)();
	app.state.subscribe(function (state) {
	 window.puxLastState = state;
	});
	module.hot.accept();
} else {
	main(initialState)();
}

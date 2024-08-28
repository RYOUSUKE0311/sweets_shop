// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import "jquery-raty-js";
const images = require.context("../images", true);
const imagePath = name => images(name, true);

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", () => {
  const starInput = (model, params) => ({
    starOn: "/star-on.png",
    starOff: "/star-off.png",
    starHalf: "/star-half.png",
    scoreName: `${model}[${params}]`,
    score: $(`#${params}Score`).data('star')
  })
  
  const starShow = (params) => ({ 
    starOn: "/star-on.png",
    starOff: "/star-off.png",
    starHalf: "/star-half.png",
    score: $(`#star_show_${params}`).data('star'),
    readOnly: true
  })
  
  $('#star_sweetness').raty( starInput('post', 'sweetness') )
  $('#star_cost_performance').raty( starInput('post', 'cost_performance') )
  $('#star_looks').raty( starInput('post', 'looks') )
  
  $('#star_show_sweetness').raty( starShow('sweetness') )
  $('#star_show_cost_performance').raty( starShow('cost_performance') )
  $('#star_show_looks').raty( starShow('looks') )
  
  $('#star_comment').raty( starInput('comment', 'star') )

  $('#star_show_average').raty( starShow('average') )
})



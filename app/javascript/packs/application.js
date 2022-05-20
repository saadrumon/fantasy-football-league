// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "../src/datatable";
import "../src/global_config";

import "bootstrap"
import "../stylesheets/application"

require('datatables.net-bs4')

const images = require.context("../images", true)

Rails.start()
ActiveStorage.start()

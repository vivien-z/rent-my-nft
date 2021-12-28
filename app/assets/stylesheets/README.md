# Frontend Setup

## Bootstrap and dependencies setup

1. Yarn add: Bootstrap and dependencies (terminal)

```bash
yarn add bootstrap
yarn add jquery popper.js
```

2. Rails `Gemfile`: add following gems

```ruby
# Gemfile
gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'simple_form'
```

3. SimpleForm: with Bootstrap config (terminal)

```bash
bundle install
rails generate simple_form:install --bootstrap
```

4. Arrange stylesheets

<!-- app/assets/stylesheets -->
folders(components, config, pages) + application.scss


5. APP <head> setup

```html
<!-- app/views/layouts/application.html.erb -->
<head>
  <!-- Add these line for detecting device width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <!-- [...] -->
</head>
```

6. Bootstrap JS setup

- Make sure you change the webpack config with the following code to include jQuery & Popper in webpack:

```js
// config/webpack/environment.js
const { environment } = require('@rails/webpacker')

// Bootstrap 4 has a dependency over jQuery & Popper.js:
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
```

- import Bootstrap @ application.js

```js
// app/javascript/packs/application.js
import 'bootstrap';
```

7. Adding new `.scss` files

Look at your main `application.scss` file to see how SCSS files are imported. There should **not** be a `*= require_tree .` line in the file.

```scss
// app/assets/stylesheets/application.scss

// External libraries
@import "bootstrap/scss/bootstrap"; // from the node_modules
@import "font-awesome-sprockets";
@import "font-awesome";

// Your CSS partials
@import "config/index";
@import "components/index";
@import "pages/index";

```

For every folder (**`components`**, **`pages`**), there is one `_index.scss` partial which is responsible for importing all the other partials of its folder.

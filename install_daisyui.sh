#!/bin/bash

# daisyui-tailwind-setup.sh

# Exit immediately if a command exits with a non-zero status
set -e

echo "Setting up daisyUI and Tailwind CSS for Rails project..."

# Install dependencies
echo "Installing dependencies..."
yarn add daisyui@latest postcss@latest autoprefixer@latest tailwindcss@latest

# Generate Tailwind CSS config file
echo "Generating Tailwind CSS config file..."
npx tailwindcss init

# Update Tailwind config
echo "Updating Tailwind config..."
cat << EOF > tailwind.config.js
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
}
EOF

# Update PostCSS config
echo "Updating PostCSS config..."
cat << EOF > postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
EOF

# Create or update application.tailwind.css
echo "Creating Tailwind CSS file..."
mkdir -p app/assets/stylesheets
cat << EOF > app/assets/stylesheets/application.tailwind.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Update package.json scripts
echo "Updating package.json scripts..."
npm pkg set scripts.build="tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify"

# Setup for Rails 7 with import maps (optional)
if [ -f "./bin/importmap" ]; then
  echo "Setting up for Rails 7 with import maps..."
  ./bin/importmap pin tailwindcss
  
  # Add Tailwind imports to application.js
  echo "Updating application.js..."
  cat << EOF >> app/javascript/application.js

// Tailwind CSS
import "tailwindcss/base"
import "tailwindcss/components"
import "tailwindcss/utilities"
EOF
fi

echo "Setup complete! Remember to run 'yarn build' to compile your CSS and restart your Rails server."
echo "You may need to add <%= stylesheet_link_tag \"application\", \"data-turbo-track\": \"reload\" %> to your layout file if it's not already there."
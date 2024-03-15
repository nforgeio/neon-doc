@echo off
REM Starts the development server for the documentation at http://localhost:3000
REM and then launches a browser that can be used for reviewing how the docs look.

echo.
echo ========================================================
echo * Launching [neon-docs] development server and browser *
echo ========================================================
echo.

cd %ND_ROOT%
yarn start

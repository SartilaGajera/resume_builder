# Resume Builder App

Resume Builder App is a Flutter application designed to allow users to view, update, delete, reorder information about resume and it's details. It utilizes the provider state management library for efficient state handling and hive for store resumes.

## Features

- Create a resume using add information
- Reorder resume items
- Preview resume
- Save resume 
- View a list of Resume 

## Requirements

- Flutter SDK : 3.22.1

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/SartilaGajera/resume_builder.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd resume_builder
    ```

3. **Install dependencies:**

    ```bash
    flutter pub get
    ```

5. **Run the app:**

    ```bash
    flutter run
    ```

## Usage

- Upon launching the app, you'll be presented with form to add information.
- Tap on a preview resume to show resume
- Tap on a save to save resume
- Tap on a view all resumes to show all resume

## State Management

This app uses provider for state management, which provides a simple and efficient way to manage state and update UI components.
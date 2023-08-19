#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use eframe::egui;

fn main() -> Result<(), eframe::Error> {
    let options = eframe::NativeOptions {
        initial_window_size: Some(egui::vec2(320.0, 240.0)),
        ..Default::default()
    };

    eframe::run_native(
        "scanner-rs",
        options,
        Box::new(|_cc| Box::<ScannerApp>::default()),
    )
}

struct ScannerApp {
    name: String,
    age: u32,
}

impl Default for ScannerApp {
    fn default() -> Self {
        Self {
            name: "Test".to_owned(),
            age: 42,
        }
    }
}

impl eframe::App for ScannerApp {
    fn update(&mut self, ctx: &egui::Context, frame: &mut eframe::Frame) {
        egui::CentralPanel::default().show(ctx, |ui| {
            ui.heading("Scanner");
        });
    }
}

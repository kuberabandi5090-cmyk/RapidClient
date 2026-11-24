fn main() {
    #[cfg(windows)]
    {
        let mut res = winresource::WindowsResource::new();
        res.set_icon("icons/icon.ico");

        let version = env!("CARGO_PKG_VERSION");
        res.set("CompanyName", "RAPID CLIENT contributors");
        res.set("ProductName", "RAPID CLIENT");
        res.set("FileDescription", "RAPID CLIENT Minecraft Launcher");
        res.set("LegalCopyright", "© 2026 RAPID CLIENT contributors; based on OneClient by Polyfrost and contributors.");
        res.set("OriginalFilename", "oneclient_app.exe");
        res.set("InternalName", "oneclient_app");
        res.set("FileVersion", version);
        res.set("ProductVersion", version);

        res.compile()
            .expect("failed to embed Windows icon resource");
    }
}

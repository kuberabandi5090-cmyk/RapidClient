package com.rapidclient.skins;

import net.fabricmc.api.ClientModInitializer;

public final class RapidSkinsClient implements ClientModInitializer {
    @Override
    public void onInitializeClient() {
        RapidSkinManager.init();
    }
}

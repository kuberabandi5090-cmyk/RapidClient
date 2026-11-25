package com.rapidclient.skins.mixin;

import com.rapidclient.skins.RapidSkinManager;
import net.minecraft.client.network.PlayerListEntry;
import net.minecraft.entity.player.SkinTextures;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Shadow;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;

@Mixin(PlayerListEntry.class)
public abstract class PlayerListEntryMixin {
    @Shadow
    public abstract com.mojang.authlib.GameProfile getProfile();

    @Inject(method = "getSkinTextures", at = @At("HEAD"), cancellable = true)
    private void rapid$useAccountSkin(CallbackInfoReturnable<SkinTextures> cir) {
        SkinTextures skin = RapidSkinManager.getSkin(getProfile().getName());
        if (skin != null) {
            cir.setReturnValue(skin);
        }
    }
}

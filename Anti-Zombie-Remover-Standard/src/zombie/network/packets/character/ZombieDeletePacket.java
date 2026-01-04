/*
 * Anti-Zombie Remover v1.0.0
 * Copyright (c) 2026 SENTRA Anti-Cheat Research Project
 * Licensed under MIT License - See LICENSE file
 * 
 * Discord: ed.husserl
 * 
 * This file rejects zombie deletion requests from clients.
 * SERVER ONLY - No client-side changes required.
 */

package zombie.network.packets.character;

import java.nio.ByteBuffer;
import zombie.VirtualZombieManager;
import zombie.characters.Capability;
import zombie.characters.IsoZombie;
import zombie.core.network.ByteBufferWriter;
import zombie.core.raknet.UdpConnection;
import zombie.network.PacketSetting;
import zombie.network.ServerMap;
import zombie.network.packets.INetworkPacket;
import zombie.network.statistics.data.GameStatistic;
import zombie.popman.NetworkZombiePacker;
import zombie.popman.ZombieCountOptimiser;

@PacketSetting(ordering = 0, priority = 2, reliability = 2, requiredCapability = Capability.LoginOnServer, handlingType = 1)
public class ZombieDeletePacket implements INetworkPacket {

    @Override
    public void parse(ByteBuffer b, UdpConnection connection) {

        int zombieForDelete = b.getShort();

        for (int i = 0; i < zombieForDelete; i++) {
            short zombieID = b.getShort();

        }
    }

    @Override
    public void write(ByteBufferWriter b) {
        synchronized (ZombieCountOptimiser.zombiesForDelete) {
            int zombiesForDeleteCount = ZombieCountOptimiser.zombiesForDelete.size();
            b.putShort((short) zombiesForDeleteCount);

            for (int k = 0; k < zombiesForDeleteCount; k++) {
                b.putShort(ZombieCountOptimiser.zombiesForDelete.get(k).onlineId);
            }

            ZombieCountOptimiser.zombiesForDelete.clear();
        }
    }
}

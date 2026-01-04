/*
 * Anti-Zombie Remover (Limit Edition) v1.0.0
 * Copyright (c) 2026 SENTRA Anti-Cheat Research Project
 * Licensed under MIT License - See LICENSE file
 * 
 * Discord: ed.husserl
 * 
 * This file modifies the zombie culling limit.
 * SERVER ONLY - No client-side changes required.
 */
package zombie.popman;

import java.util.ArrayList;
import zombie.SandboxOptions;
import zombie.characters.IsoZombie;
import zombie.core.random.Rand;
import zombie.network.GameClient;
import zombie.network.statistics.data.GameStatistic;

public class ZombieCountOptimiser {
    private static int zombieCountForDelete;
    public static final int maxZombieCount = 500;
    public static final int minZombieDistance = 20;
    public static final ArrayList<IsoZombie> zombiesForDelete = new ArrayList<>();

    private static boolean isOutside(IsoZombie zombie) {
        return zombie.getCurrentSquare() == null || !zombie.getCurrentSquare().isInARoom() && !zombie.getCurrentSquare().haveRoof;
    }

    public static void startCount() {
        // MODIFIED: Using custom limit 780 instead of SandboxOptions
        zombieCountForDelete = (int)(
            1.0F * Math.max(0, GameClient.IDToZombieMap.values().length - 780)
        );
    }

    public static void incrementZombie(IsoZombie zombie) {
        if (zombieCountForDelete > 0
            && Rand.Next(10) == 0
            && zombie.getTarget() == null
            && isOutside(zombie)
            && zombie.canBeDeletedUnnoticed(20.0F)
            && !zombie.isReanimatedPlayer()) {
            synchronized (zombiesForDelete) {
                zombiesForDelete.add(zombie);
            }

            zombieCountForDelete--;
            GameStatistic.getInstance().zombiesCulled.increase();
        }
    }
}

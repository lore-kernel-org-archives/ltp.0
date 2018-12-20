From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Dec 2018 13:03:26 +0100
Subject: [LTP] [PATCH] mem/overcommit_memory.c: Fix "CommitLimit <
 Committed_AS" error in some situations
In-Reply-To: <220eb28e-9187-d9f3-8e55-56b1a9c497f7@arm.com>
References: <1539938660-18786-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20181203202755.GA8919@x230>
 <220eb28e-9187-d9f3-8e55-56b1a9c497f7@arm.com>
Message-ID: <20181220120326.GA20573@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao, Cristian,

> Any chance this reviewed/fixed patch will be merged soon ?
Thanks for pointing out. Pushed, with following diff bellow.
(TCONF is for <=, not <).

> Thanks

> Cristian

Kind regards,
Petr

diff --git testcases/kernel/mem/tunable/overcommit_memory.c testcases/kernel/mem/tunable/overcommit_memory.c
index b92232b8d..07f824328 100644
--- testcases/kernel/mem/tunable/overcommit_memory.c
+++ testcases/kernel/mem/tunable/overcommit_memory.c
@@ -243,9 +243,9 @@ static void update_mem_commit(void)
 				"CommitLimit < Committed_AS");
 		}
 
-		tst_brk(TCONF, "Specified overcommit_ratio %ld < default %ld, "
-			"so it's possible for CommitLimit < Committed_AS and "
-			"skip test", overcommit_ratio, old_overcommit_ratio);
+		tst_brk(TCONF, "Specified overcommit_ratio %ld <= default %ld, "
+			"so it's possible for CommitLimit < Committed_AS and skip test",
+			overcommit_ratio, old_overcommit_ratio);
 	}
 }
 

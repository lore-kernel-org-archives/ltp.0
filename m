From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 20:41:44 +0100
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <20210129194144.31299-1-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
Message-ID: <20210129194144.31299-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to avoid unexpected timeout, which occurred even on just 4 devices.
Default setup is 300, using 200 should be safe.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 testcases/kernel/device-drivers/zram/zram_lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 26ed1846b..c24b83cfc 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -47,6 +47,8 @@ zram_load()
 		tst_brk TBROK "dev_num must be > 0"
 	fi
 
+	TST_TIMEOUT=$((dev_num*200))
+
 	tst_res TINFO "create '$dev_num' zram device(s)"
 
 	modprobe zram num_devices=$dev_num || \
-- 
2.30.0


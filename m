From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Mar 2021 18:32:01 +0100
Subject: [LTP] [PATCH 3/3] zram: Increase timeout according to used devices
In-Reply-To: <20210312173201.27708-1-pvorel@suse.cz>
References: <20210312173201.27708-1-pvorel@suse.cz>
Message-ID: <20210312173201.27708-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to avoid unexpected timeout, which occurred even on just 4 zram devices.

On my system where run with ext{2,3,4}, xfs, btrfs, vfat, exfat, ntfs
it run for 12 min, i.e. mean 90s. Multiply by security constant 5,
expecting 450 sec for each filesystem.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as previous
https://patchwork.ozlabs.org/project/ltp/patch/20210301220222.22705-8-pvorel@suse.cz/

 testcases/kernel/device-drivers/zram/zram_lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 65e431e86..fe9c915c3 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -47,6 +47,8 @@ zram_load()
 		tst_brk TBROK "dev_num must be > 0"
 	fi
 
+	tst_set_timeout $((dev_num*450))
+
 	tst_res TINFO "create '$dev_num' zram device(s)"
 
 	modprobe zram num_devices=$dev_num || \
-- 
2.30.1


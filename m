From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 29 Jun 2020 16:06:08 +0800
Subject: [LTP] [PATCH] lib/tst_cgroup.c: Fix general protection fault
Message-ID: <1593417968-3275-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When I test ksm04 on 3.10.0-1136.el7.x86_64, it failed as below:
 ./ksm04
tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
tst_device.c:417: INFO: No device is mounted at /tmp/cgroup_mem
tst_cgroup.c:96: INFO: Cgroup(memory) v1 mount at /tmp/cgroup_mem success
tst_test.c:1292: BROK: Test killed by SIGSEGV

dmesg as below:
[10096.547468] traps: ksm04[25785] general protection ip:410673 sp:7ffc1b1dc870 error:0 in ksm04[400000+22000]

addr2line -e ksm04 -f 410673
tst_cgroup_set_path
/root/ltp/lib/tst_cgroup.c:199

It detects uninitialized mem when using a->next, so it was killed.

Also ksm04_1 and oom5 have the same problem.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 lib/tst_cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 341ecf599..ba420d5f8 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -190,6 +190,7 @@ static void tst_cgroup_set_path(const char *cgroup_dir)
 	tst_cgroup_path = SAFE_MALLOC(sizeof(struct tst_cgroup_path));
 	tst_cgroup_path->mnt_path = SAFE_MALLOC(strlen(cgroup_dir) + 1);
 	tst_cgroup_path->new_path = SAFE_MALLOC(strlen(cgroup_new_dir) + 1);
+	tst_cgroup_path->next = NULL;
 
 	if (!tst_cgroup_paths) {
 		tst_cgroup_paths = tst_cgroup_path;
-- 
2.23.0




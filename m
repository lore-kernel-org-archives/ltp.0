From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 18 May 2020 13:43:35 +0800
Subject: [LTP] [PATCH] lib/tst_test.c: Take account of
 tst_brk(TCONF)/tst_brk(TFAIL) in summary output
Message-ID: <20200518054335.12017-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current summary output doesn't take account of tst_brk(TCONF/TFAIL),
for example:
-----------------------------------------------------
[root@RHEL8U2GA_Intel64 pidfd_send_signal]# ./pidfd_send_signal01
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
../../../../include/lapi/pidfd_send_signal.h:16: CONF: syscall(424) __NR_pidfd_send_signal not supported

Summary:
passed   0
failed   0
skipped  0
warnings 0
-----------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0e58060e0..b28521a67 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -316,6 +316,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
                const char *fmt, va_list va)
 {
 	print_result(file, lineno, ttype, fmt, va);
+	update_results(TTYPE_RESULT(ttype));
 
 	/*
 	 * The getpid implementation in some C library versions may cause cloned
-- 
2.21.0




From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jun 2016 16:42:38 +0200
Subject: [LTP] [PATCH] syscalls/ftruncate04: TCONF on kernels without
 MANDLOCK
In-Reply-To: <1465480705-23649-2-git-send-email-jjaburek@redhat.com>
References: <1465480705-23649-2-git-send-email-jjaburek@redhat.com>
Message-ID: <20160609144237.GA2836@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Pushed with following change:

--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -253,9 +253,8 @@ static void setup(void)
                        tst_brkm(TCONF, cleanup, "Mandatory locking (likely) "
                                 "not supported by this system");
                } else {
-                       tst_brkm(TBROK, cleanup,
-                                "Remount with MS_MANDLOCK failed: %s",
-                                strerror(errno));
+                       tst_brkm(TBROK | TERRNO, cleanup,
+                                "Remount with MS_MANDLOCK failed");
                }
        }
 }


Since in LTP we prefer TERRNO flag over strerror().

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

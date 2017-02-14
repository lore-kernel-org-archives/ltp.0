From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 14:52:31 +0100
Subject: [LTP] [PATCH 3/4] newlib: Allow SAFE_MACROS to be called from
 cleanup
In-Reply-To: <350522678.4314423.1487078592694.JavaMail.zimbra@redhat.com>
References: <20170214122639.442-1-chrubis@suse.cz>
 <20170214122639.442-3-chrubis@suse.cz>
 <350522678.4314423.1487078592694.JavaMail.zimbra@redhat.com>
Message-ID: <20170214135231.GA1383@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
OK to commit the patchset with fixed warnings and this addition to the docs?

 -------------------------------------------------------------------------------
 static void cleanup(void)
 {
-       if (fd1 > 0 && close(fd1))
-               tst_res(TWARN | TERRNO, "close(fd1)");
+       if (fd1 > 0)
+               SAFE_CLOSE(fd1);
 
-       if (fd0 > 0 && close(fd0))
-               tst_res(TWARN | TERRNO, "close(fd0)");
+       if (fd0 > 0)
+               SAFE_CLOSE(fd0);
 
        if (mount_flag && tst_umouont(MNTPOINT))
-               tst_res(TBROK | TERRNO, "umount(%s)", MNTPOINT);
+               tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
 -------------------------------------------------------------------------------
 
+IMPORTANT: 'SAFE_MACROS()' used in cleanup *do not* exit the test. Failure
+           only produces a warning and the 'cleanup()' carries on. This is
+          intentional as we want to execute as much 'cleanup()' as possible.
+
+WARNING: Calling tst_brk() in test 'cleanup()' does not exit the test as well
+         and 'TBROK' is converted to 'TWARN'.
+


-- 
Cyril Hrubis
chrubis@suse.cz

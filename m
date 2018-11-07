From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Nov 2018 12:09:22 +0100
Subject: [LTP] Question about the usage of tst_brk()
In-Reply-To: <5BE2C0D2.6090602@cn.fujitsu.com>
References: <5BE2BF88.3090902@cn.fujitsu.com> <5BE2C0D2.6090602@cn.fujitsu.com>
Message-ID: <20181107110922.GC8603@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If only TFAIL, TBROK and TCONF should be supported by tst_brk() in new library,
> i will add check to mark TWARN and TPASS as invalid.

First of all I think that tst_brk() will only work with TBROK and TCONF at the
moment, see the check_child_status() function, we do handle only TBROK and
TCONF in the switch there, anything else will cause the test library to exit
with invalid exit value. Well the tst_brk(TPASS, ...) will work by accident
since we have to handle zero exit value there as well.

However how the code is now the tst_brk(TPASS, ...) in new library will not
account the passed result in the result counters, so it would be a good idea to
check what value has been passed to the tst_brk() and allow only TBROK and
TCONF there.

If we wanted to enable TPASS and TFAIL we would have to first define sane
semantic for it. I guess that something as "exit currect test process and
increment result counters" would be reasonable, this could be done with:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 661fbbfce..b76871b38 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -311,7 +311,15 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
        if (getpid() == lib_pid)
                do_exit(TTYPE_RESULT(ttype));
 
-       exit(TTYPE_RESULT(ttype));
+       switch (TTYPE_RESULT(ttype)) {
+       case TPASS:
+       case TFAIL:
+               update_results(TTYPE_RESULT(ttype));
+               exit(0);
+       break;
+       default:
+               exit(TTYPE_RESULT(ttype));
+       }
 }

(beware untested)

-- 
Cyril Hrubis
chrubis@suse.cz

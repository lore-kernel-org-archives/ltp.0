From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Dec 2015 21:55:51 +0100
Subject: [LTP] [PATCH v2] sched_setattr/sched_setattr01: Add new
 testcase for sched_setattr
In-Reply-To: <5643267B.5020109@huawei.com>
References: <1446801572-215993-1-git-send-email-cuibixuan@huawei.com>
 <20151110131940.GF23947@rei> <5643267B.5020109@huawei.com>
Message-ID: <20151202205551.GA13131@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following changes:
(To make the error reports more verbose)

@@ -90,8 +90,10 @@ static void sched_setattr_verify(const struct test_case *test)
        TEST(sched_setattr(*(test->pid), test->a, test->flags));
 
        if (TEST_RETURN != test->exp_return) {
-               tst_resm(TFAIL | TTERRNO, "sched_setattr() return "
-                       "unexpectedly: expected: %d", test->exp_return);
+               tst_resm(TFAIL | TTERRNO, "sched_setattr(%i,attr,%u) "
+                        "returned: %ld expected: %d",
+                        *(test->pid), test->flags,
+                        TEST_RETURN, test->exp_return);
                return;
        }
 
@@ -101,8 +103,9 @@ static void sched_setattr_verify(const struct test_case *test)
                return;
        }
 
-       tst_resm(TFAIL | TTERRNO, "sched_setattr() return unexpectedly "
-               ": expected: %d - %s",
+       tst_resm(TFAIL | TTERRNO, "sched_setattr(%i,attr,%u): "
+               "expected: %d - %s",
+               *(test->pid), test->flags,
                test->exp_errno, tst_strerrno(test->exp_errno));
 }

Thanks. And sorry for the delay.

-- 
Cyril Hrubis
chrubis@suse.cz

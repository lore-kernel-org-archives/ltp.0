From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Jun 2021 12:58:11 +0200
Subject: [LTP] [RFC] syscalls/ipc: Make use of TST_EXP_FAIL macro
In-Reply-To: <1624356737-508-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1624356737-508-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YNHCQ8qWSBdHIAra@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Since TST_EXP_FAIL macro only recognizes sycalls succeeded when syscalls return 0,
> Can we use this macro directly for the these syscalls's error test? It may result in
> invalid retval value and print errno when syscall succeeded. I think it
> is a nit and it can improve this api usage range. Is it right?

I guess that it would be slightly cleaner to add more generic macro that
allows us to pass the condition for succeess and build TST_EXP_FAIL() on
the top of that. Maybe something as:

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 89dfe5a31..4d41741a4 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -120,13 +120,13 @@ extern void *TST_RET_PTR;
                        TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
        } while (0)                                                            \

-#define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
+#define TST_EXP_FAIL_(PASS_COND, SCALL, ERRNO, ...)                            \
        do {                                                                   \
                TEST(SCALL);                                                   \
                                                                               \
                TST_PASS = 0;                                                  \
                                                                               \
-               if (TST_RET == 0) {                                            \
+               if (PASS_COND) {                                               \
                        TST_MSG_(TFAIL, " succeeded", #SCALL, ##__VA_ARGS__);  \
                        break;                                                 \
                }                                                              \
@@ -150,4 +150,8 @@ extern void *TST_RET_PTR;
                }                                                              \
        } while (0)

+#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, ERRNO)
+
+#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET >= 0, SCALL, ERRNO)
+
 #endif /* TST_TEST_MACROS_H__ */

The only hard thing is to find a good name for TST_EXP_FAIL2(), I'm out
of ideas here...

-- 
Cyril Hrubis
chrubis@suse.cz

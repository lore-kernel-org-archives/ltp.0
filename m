From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Jun 2018 14:07:33 +0200
Subject: [LTP] LTP CVE "cve-2011-2183" failed on x86_64,
	arm32 beaglebone x15
In-Reply-To: <CA+G9fYuUAPvwBjXjw_EATrMoLPtS5imGo7foqchmAFD=TUdVXQ@mail.gmail.com>
References: <CA+G9fYuUAPvwBjXjw_EATrMoLPtS5imGo7foqchmAFD=TUdVXQ@mail.gmail.com>
Message-ID: <20180604120733.GC3362@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP CVE "cve-2011-2183" failed on x86_64, (arm32) beaglebone x15.
> 
> Please check the history here,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-cve-tests/cve-2011-2183
> 
> Test log:
> ----------
> tst_test.c:980: INFO: Timeout per run is 0h 15m 00s
> ksm05.c:98: CONF: KSM configuration is not enabled
> safe_file_ops.c:238: WARN: Failed to open FILE
> '/sys/kernel/mm/ksm/run' at ksm05.c:110

That is an obvious bug in the test, the value of run should be restored
only if we managed to change it.


We should do at least:

diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index f3bfbf4fa..6deaa8440 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -107,7 +107,8 @@ static void setup(void)
 static void cleanup(void)
 {
        /* restore /sys/kernel/mm/ksm/run value */
-       FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
+       if (!access(PATH_KSM, F_OK))
+               FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz

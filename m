From: Luis Chamberlain <mcgrof@kernel.org>
Date: Mon, 22 Jun 2020 22:49:20 +0000
Subject: [LTP] LTP: crypto: af_alg02 regression on linux-next 20200621
 tag
In-Reply-To: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
Message-ID: <20200622224920.GA4332@42.do-not-panic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 23, 2020 at 12:04:06AM +0530, Naresh Kamboju wrote:
> LTP crypto regressions noticed on linux next 20200621.
> 
> The common case for all tests is timeout after 15 minutes which
> means tests got hung and LTP timers killed those test runs after
> timeout.
> The root cause of the failure is under investigation.
> 
>   ltp-crypto-tests:
>     * af_alg02 - failed
>     * af_alg05 - failed
>   ltp-syscalls-tests:
>     * keyctl07 - failed
>     * request_key03 - failed
> 
> Output log:
> --------------
> af_alg02:
> af_alg02.c:52: BROK: Timed out while reading from request socket.
> 
> Test code at line number 52 is
> 
> pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> SAFE_PTHREAD_CREATE(&thr, NULL, verify_encrypt, NULL);
> 
> TST_CHECKPOINT_WAIT(0);
> 
> while (pthread_kill(thr, 0) != ESRCH) {
>     if (tst_timeout_remaining() <= 10) {
>         pthread_cancel(thr);
>         tst_brk(TBROK,
>                    "Timed out while reading from request socket.");
> 
> 
> af_alg05:
> tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
> [  362.599868] kworker/dying (137) used greatest stack depth: 11600 bytes left
> Test timeouted, sending SIGKILL!
> tst_test.c:1286: INFO: If you are running on slow machine, try
> exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1287: BROK: Test killed! (timeout?)
> 
> request_key03:
> tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
> request_key03.c:65: CONF: kernel doesn't support key type 'encrypted'
> request_key03.c:65: CONF: kernel doesn't support key type 'trusted'
> Test timeouted, sending SIGKILL!
> tst_test.c:1286: INFO: If you are running on slow machine, try
> exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1287: BROK: Test killed! (timeout?)
> 
> keyctl07
> tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
> Test timeouted, sending SIGKILL!
> tst_test.c:1286: INFO: If you are running on slow machine, try
> exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1287: BROK: Test killed! (timeout?)
> 
> metadata:
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git commit: 5a94f5bc041ea9e4d17c93b11ea6f6a2e5ad361b
>   git describe: next-20200621
>   kernel-config:
> https://builds.tuxbuild.com/PB-45Luvlx0yYJ8MZgpijA/kernel.config
> 
> ref:
> https://lkft.validation.linaro.org/scheduler/job/1511938#L2211
> https://lkft.validation.linaro.org/scheduler/job/1511935#L9225

Can you try reverting:

d13ef8e10756873b0a8b7cc8f230a2d1026710ea

The patch is titled "umh: fix processed error when UMH_WAIT_PROC is used"

If this fixes the  issue we have to ask ourselves then why, given that
anything other than 0 is a return code and prior to this patch we were
not accepting negative return codes, but we were never getting them
as the invalid return code was being returned when UMH_WAIT_PROC was
used and an error code was returned. So now, *any* non-zero value is
a return code.  The onlything I can think of is that we may want to
special-case the -ENOMEM error code, or maybe some other one to not
skip it as in the below patch.

If reverting the commit does not fix the issue, this is not the droid
we are looking for.

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index ff462f3d46ca..94ed23a8991f 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -193,7 +193,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
 	ret = call_usermodehelper_keys(request_key, argv, envp, keyring,
 				       UMH_WAIT_PROC);
 	kdebug("usermode -> 0x%x", ret);
-	if (ret != 0) {
+	if (ret != -ENOMEM && ret != 0) {
 		/* ret is the exit/wait code */
 		if (test_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags) ||
 		    key_validate(key) < 0)

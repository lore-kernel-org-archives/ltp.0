From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Apr 2016 05:58:20 -0400 (EDT)
Subject: [LTP] [PATCH] pause01: race condition
In-Reply-To: <1459883500-11524-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459883500-11524-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <2025858883.19408123.1459936700109.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Yury Norov" <ynorov@caviumnetworks.com>
> To: ltp@lists.linux.it
> Sent: Tuesday, 5 April, 2016 9:11:40 PM
> Subject: [LTP] [PATCH] pause01: race condition
> 
> In my environment (aarch64 + ilp32 emulated by QEMU) I see race
> condition here:
> 
> [...]
> static void setup(void);
> 
> int main(int ac, char **av)
> {
> 	int lc;
> 	struct itimerval it = {
> 		.it_interval = {.tv_sec = 0, .tv_usec = 0},
> 		.it_value = {.tv_sec = 0, .tv_usec = 1000},
> 	};
> 
> 	tst_parse_opts(ac, av, NULL, NULL);
> 
> 	setup();
> 
> 	for (lc = 0; TEST_LOOPING(lc); lc++) {
> 		tst_count = 0;
> 
> 		if (setitimer(ITIMER_REAL, &it, NULL))
> 			tst_brkm(TBROK | TERRNO, NULL, "setitimer() failed");
> 
> 		TEST(pause());
> 
> 		if (TEST_RETURN != -1) {
> [...]
> 	}
> 
> 	tst_exit();
> }
> 
> static void go(int sig)
> {
> 	(void)sig;
> }
> 
> void setup(void)
> {
> 	tst_sig(NOFORK, DEF_HANDLER, NULL);
> 	(void)signal(SIGALRM, go);
> 
> 	TEST_PAUSE;
> }
> 
> Alarm may come before pause() is called, and be hiddenly dropped by go()
> handler. Next pause() call hangs test forever.
> 
> Next hack helps me, though it's not a proper fix. Frankly, I don't
> realise how to fix the test properly because sequence of settimer() and
> pause() is not atomic, and any il_value we choose is not safe.

I've seen this hang once in past. At the time I was thinking
we use 2 processes. Parent will fork a child and wait.
Just before child calls pause() we signal parent and
parent will call tst_process_state_wait() to wait until
child process falls asleep (on pause() call).
Then parent can send a signal to child and check it wakes up.

Regards,
Jan

> 
> Yury.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  testcases/kernel/syscalls/pause/pause01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/pause/pause01.c
> b/testcases/kernel/syscalls/pause/pause01.c
> index c967d8e..f4b2dcd 100644
> --- a/testcases/kernel/syscalls/pause/pause01.c
> +++ b/testcases/kernel/syscalls/pause/pause01.c
> @@ -48,7 +48,7 @@ int main(int ac, char **av)
>  	int lc;
>  	struct itimerval it = {
>  		.it_interval = {.tv_sec = 0, .tv_usec = 0},
> -		.it_value = {.tv_sec = 0, .tv_usec = 1000},
> +		.it_value = {.tv_sec = 0, .tv_usec = 10000},
>  	};
>  
>  	tst_parse_opts(ac, av, NULL, NULL);
> --
> 2.5.0
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

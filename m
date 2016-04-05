From: Yury Norov <ynorov@caviumnetworks.com>
Date: Tue, 5 Apr 2016 22:11:40 +0300
Subject: [LTP] [PATCH] pause01: race condition
Message-ID: <1459883500-11524-1-git-send-email-ynorov@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In my environment (aarch64 + ilp32 emulated by QEMU) I see race
condition here:

[...]
static void setup(void);

int main(int ac, char **av)
{
	int lc;
	struct itimerval it = {
		.it_interval = {.tv_sec = 0, .tv_usec = 0},
		.it_value = {.tv_sec = 0, .tv_usec = 1000},
	};

	tst_parse_opts(ac, av, NULL, NULL);

	setup();

	for (lc = 0; TEST_LOOPING(lc); lc++) {
		tst_count = 0;

		if (setitimer(ITIMER_REAL, &it, NULL))
			tst_brkm(TBROK | TERRNO, NULL, "setitimer() failed");

		TEST(pause());

		if (TEST_RETURN != -1) {
[...]
	}

	tst_exit();
}

static void go(int sig)
{
	(void)sig;
}

void setup(void)
{
	tst_sig(NOFORK, DEF_HANDLER, NULL);
	(void)signal(SIGALRM, go);

	TEST_PAUSE;
}

Alarm may come before pause() is called, and be hiddenly dropped by go()
handler. Next pause() call hangs test forever.

Next hack helps me, though it's not a proper fix. Frankly, I don't
realise how to fix the test properly because sequence of settimer() and
pause() is not atomic, and any il_value we choose is not safe.

Yury.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 testcases/kernel/syscalls/pause/pause01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
index c967d8e..f4b2dcd 100644
--- a/testcases/kernel/syscalls/pause/pause01.c
+++ b/testcases/kernel/syscalls/pause/pause01.c
@@ -48,7 +48,7 @@ int main(int ac, char **av)
 	int lc;
 	struct itimerval it = {
 		.it_interval = {.tv_sec = 0, .tv_usec = 0},
-		.it_value = {.tv_sec = 0, .tv_usec = 1000},
+		.it_value = {.tv_sec = 0, .tv_usec = 10000},
 	};
 
 	tst_parse_opts(ac, av, NULL, NULL);
-- 
2.5.0


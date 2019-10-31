From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 08:35:58 +0100
Subject: [LTP] [PATCH v2] Port ptrace01 to new library
In-Reply-To: <20191030141617.31446-1-jcronenberg@suse.de>
References: <20191030141617.31446-1-jcronenberg@suse.de>
Message-ID: <20191031073557.GA9065@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jorik,

> Ported ptrace01 to the new library

> Signed-off-by: Jorik Cronenberg <jcronenberg@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Good work, almost ready. I suggest some changes.
> ---
>  testcases/kernel/syscalls/ptrace/ptrace01.c | 296 ++++++----------------------
>  1 file changed, 63 insertions(+), 233 deletions(-)

>  v2: Implemented changes suggested by Cyril.

> diff --git a/testcases/kernel/syscalls/ptrace/ptrace01.c b/testcases/kernel/syscalls/ptrace/ptrace01.c
...
> - *    DESCRIPTION
> + * DESCRIPTION
>   *	This test case tests the functionality of ptrace() for
>   *	PTRACE_TRACEME & PTRACE_KILL requests.
>   *	Here, we fork a child & the child does ptrace(PTRACE_TRACEME, ...).
> @@ -39,248 +16,101 @@
>   *	to kill the child. Again parent wait() for child to finish.
>   *	If child finished abnormally, test passes.
>   *		We test two cases
> - * 			1) By telling child to ignore SIGUSR2 signal
> - * 			2) By installing a signal handler for child for SIGUSR2
> - * 		In both cases, child should stop & notify parent on reception
> - * 		of SIGUSR2
> - *
> - * 	Setup:
> - * 	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> + *			1) By telling child to ignore SIGUSR2 signal
> + *			2) By installing a signal handler for child for SIGUSR2
> + *		In both cases, child should stop & notify parent on reception
> + *		of SIGUSR2

Reword and reformatting the test description and remove "DESCRIPTION", added
your copyright (actually I don't like using that date in ported to new library,
we have git these days, this was used 10-20 years ago, but that's just my opinion):

// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
 * Copyright (c) 2019 Jorik Cronenberg <jcronenberg@suse.de>
 *
 * Author:	Saji Kumar.V.R <saji.kumar@wipro.com>
 * Ported to new library:
 * 10/2019	Jorik Cronenberg <jcronenberg@suse.de>
 *
 * Test the functionality of ptrace() for PTRACE_TRACEME & PTRACE_KILL requests.
 * Forked child does ptrace(PTRACE_TRACEME, ...).
 * Then a signal is delivered to the child and verified that parent
 * is notified via wait().
 * After parent does ptrace(PTRACE_KILL, ..) to kill the child
 * and parent wait() for child to finish.
 * Test passes if child finished abnormally.
 *
 * Testing two cases:
 * 1) child ignore SIGUSR2 signal
 * 2) using a signal handler for child for SIGUSR2
 * In both cases, child should stop & notify parent on reception of SIGUSR2.
 */

...
> +static void child_handler(void)
>  {
> +	SAFE_KILL(getppid(), SIGUSR2);
> +}
You get a warning: assignment to ?__sighandler_t? {aka ?void (*)(int)?} from
incompatible pointer type ?void (*)(void)? [-Wincompatible-pointer-types]

We try to avoid warnings, so use:
static void child_handler(int sig LTP_ATTRIBUTE_UNUSED)

...
> +static void parent_handler(void)
> +{
> +	got_signal = 1;
>  }
The same here:
static void parent_handler(int sig LTP_ATTRIBUTE_UNUSED)

> -/* do_child() */
> -void do_child(void)
> +static void do_child(unsigned int i)
>  {
>  	struct sigaction child_act;

> -	/* Setup signal handler for child */
> -	if (i == 0) {
> +	if (i == 0)
>  		child_act.sa_handler = SIG_IGN;
> -	} else {
> +	else
>  		child_act.sa_handler = child_handler;
> -	}
> +
>  	child_act.sa_flags = SA_RESTART;
>  	sigemptyset(&child_act.sa_mask);

> -	if ((sigaction(SIGUSR2, &child_act, NULL)) == -1) {
> -		tst_resm(TWARN, "sigaction() failed in child");
> -		exit(1);
> -	}
> +	SAFE_SIGACTION(SIGUSR2, &child_act, NULL);

>  	if ((ptrace(PTRACE_TRACEME, 0, 0, 0)) == -1) {
> -		tst_resm(TWARN, "ptrace() failed in child");
> -		exit(1);
> -	}
> -	/* ensure that child bypasses signal handler */
> -	if ((kill(getpid(), SIGUSR2)) == -1) {
> -		tst_resm(TWARN, "kill() failed in child");
> +		tst_res(TWARN, "ptrace() failed in child");
>  		exit(1);
>  	}
> +	SAFE_KILL(getpid(), SIGUSR2);
>  	exit(1);
>  }

> -/* setup() - performs all ONE TIME setup for this test */
> -void setup(void)
> +static void run(unsigned int i)
>  {
> +	pid_t child_pid;
> +	int status;
> +	struct sigaction parent_act;

> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	got_signal = 0;

> -	TEST_PAUSE;
> +	if (i == 1) {
> +		parent_act.sa_handler = parent_handler;
> +		parent_act.sa_flags = SA_RESTART;
> +		sigemptyset(&parent_act.sa_mask);

> -}
> +		SAFE_SIGACTION(SIGUSR2, &parent_act, NULL);
> +	}

> -/*
> - *cleanup() -  performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup(void)
> -{
> +	child_pid = SAFE_FORK();

> -}
> +	if (!child_pid)
> +		do_child(i);

> -/*
> - * child_handler() - Signal handler for child
> - */
> -void child_handler(void)
> -{
> +	SAFE_WAITPID(child_pid, &status, 0);

> -	if ((kill(getppid(), SIGUSR2)) == -1) {
> -		tst_resm(TWARN, "kill() failed in child_handler()");
> -		exit(1);
> +	if (((WIFEXITED(status))
> +		&& (WEXITSTATUS(status)))
> +		 || (got_signal == 1)) {
> +		tst_res(TFAIL, "Test Failed");
> +	} else {
> +		if ((ptrace(PTRACE_KILL, child_pid, 0, 0)) == -1) {
> +			tst_res(TFAIL | TERRNO,
> +			    "ptrace(PTRACE_KILL, %i, 0, 0) failed",
> +				child_pid);

Also some code simplification:
	if (((WIFEXITED(status)) && (WEXITSTATUS(status)))
		 || (got_signal == 1))
		tst_res(TFAIL, "Test Failed");
	else if ((ptrace(PTRACE_KILL, child_pid, 0, 0)) == -1)
		tst_res(TFAIL | TERRNO, "ptrace(PTRACE_KILL, %i, 0, 0) failed",
				child_pid);

Below is the final diff I suggest to apply.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/ptrace/ptrace01.c testcases/kernel/syscalls/ptrace/ptrace01.c
index 9fa365d76..526bf2060 100644
--- testcases/kernel/syscalls/ptrace/ptrace01.c
+++ testcases/kernel/syscalls/ptrace/ptrace01.c
@@ -1,26 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) 2019 Jorik Cronenberg <jcronenberg@suse.de>
  *
  * Author:	Saji Kumar.V.R <saji.kumar@wipro.com>
- *
  * Ported to new library:
  * 10/2019	Jorik Cronenberg <jcronenberg@suse.de>
  *
- * DESCRIPTION
- *	This test case tests the functionality of ptrace() for
- *	PTRACE_TRACEME & PTRACE_KILL requests.
- *	Here, we fork a child & the child does ptrace(PTRACE_TRACEME, ...).
- *	Then a signal is delivered to the child & verified that parent
- *	is notified via wait(). then parent does ptrace(PTRACE_KILL, ..)
- *	to kill the child. Again parent wait() for child to finish.
- *	If child finished abnormally, test passes.
- *		We test two cases
- *			1) By telling child to ignore SIGUSR2 signal
- *			2) By installing a signal handler for child for SIGUSR2
- *		In both cases, child should stop & notify parent on reception
- *		of SIGUSR2
+ * Test the functionality of ptrace() for PTRACE_TRACEME & PTRACE_KILL requests.
+ * Forked child does ptrace(PTRACE_TRACEME, ...).
+ * Then a signal is delivered to the child and verified that parent
+ * is notified via wait().
+ * After parent does ptrace(PTRACE_KILL, ..) to kill the child
+ * and parent wait() for child to finish.
+ * Test passes if child finished abnormally.
  *
+ * Testing two cases:
+ * 1) child ignore SIGUSR2 signal
+ * 2) using a signal handler for child for SIGUSR2
+ * In both cases, child should stop & notify parent on reception of SIGUSR2.
  */
 
 #include <stdlib.h>
@@ -33,12 +31,12 @@
 
 static volatile int got_signal;
 
-static void child_handler(void)
+static void child_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	SAFE_KILL(getppid(), SIGUSR2);
 }
 
-static void parent_handler(void)
+static void parent_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	got_signal = 1;
 }
@@ -77,7 +75,6 @@ static void run(unsigned int i)
 		parent_act.sa_handler = parent_handler;
 		parent_act.sa_flags = SA_RESTART;
 		sigemptyset(&parent_act.sa_mask);
-
 		SAFE_SIGACTION(SIGUSR2, &parent_act, NULL);
 	}
 
@@ -88,17 +85,12 @@ static void run(unsigned int i)
 
 	SAFE_WAITPID(child_pid, &status, 0);
 
-	if (((WIFEXITED(status))
-		&& (WEXITSTATUS(status)))
-		 || (got_signal == 1)) {
+	if (((WIFEXITED(status)) && (WEXITSTATUS(status)))
+		 || (got_signal == 1))
 		tst_res(TFAIL, "Test Failed");
-	} else {
-		if ((ptrace(PTRACE_KILL, child_pid, 0, 0)) == -1) {
-			tst_res(TFAIL | TERRNO,
-			    "ptrace(PTRACE_KILL, %i, 0, 0) failed",
+	else if ((ptrace(PTRACE_KILL, child_pid, 0, 0)) == -1)
+		tst_res(TFAIL | TERRNO, "ptrace(PTRACE_KILL, %i, 0, 0) failed",
 				child_pid);
-		}
-	}
 
 	SAFE_WAITPID(child_pid, &status, 0);
 

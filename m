Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1POYGQ-0001hh-Nh
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 16:13:38 +0000
Date: Fri, 3 Dec 2010 17:26:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101203162644.GC28084@saboteur.suse.cz>
References: <456905695.757931291112868201.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1609599410.757951291112870787.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1609599410.757951291112870787.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] a race in pid generation that causes pids to be
 reused immediatelly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include "test.h"
> +#include "usctest.h"
> +
> +char *TCID = "fork13";
> +int TST_TOTAL = 1;
> +extern int Tst_count;
> +
> +static void setup(void);
> +static int PidDistance(pid_t first, pid_t second);

Just to cite from linux kernel conding style:

"mixed-case names are frowned upon"

> +static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
> +static int check(void);
> +
> +int main(int argc, char* argv[])
> +{
> +	/* message returned from parse_opts */
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL) {
> +		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s",
> +			msg);
> +		tst_exit();
> +	}
> +	setup();
> +	TEST(check());
> +	cleanup();
> +}
> +
> +int check(void)
> +{
> +	/* loop counter */

Once again, this comment is useless ;).

> +	int lc;
> +
> +	pid_t last_pid = 0;
> +	pid_t pid;
> +	int child_exit_code, distance, reaped, status;
> +
> +	/* Check looping state if -i option given */

Here as well.

> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		if (lc % 32786 == 0)
> +			tst_resm(TINFO, "Iter: %d", lc/32768);
> +		child_exit_code = lc % 256;
> +		switch (pid = fork()) {
> +		case -1:
> +			tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +			tst_exit();
> +		case 0:
> +			// Child

I would remove this one as well. Everybody who plays with lowlevel OS
api should know how fork works.

> +			exit(child_exit_code);
> +		default:
> +			// Parent

Here as well.

> +			if (lc > 0) {
> +				printf("last_pid = %d\npid = %d\n", last_pid, pid);
> +				distance = PidDistance(last_pid, pid);
> +				if (distance == 0 || distance > 30000) {

Hmm are you sure that distance > 30000 is good thing to assert? Who says
that two pids keeps at least 2768 distance and even then, who says that
32768 is maximal pid (see below)?

> +					tst_resm(TFAIL,
> +						"Unexpected pid "
> +						"sequence: previous "
> +						"fork: pid=%d, current "
> +						"fork: pid=%d for "
> +						"iteration=%d.",
> +						last_pid, pid, lc);
> +				}
> +			}
> +			last_pid = pid;
> +
> +			reaped = wait(&status);
> +			if (reaped != pid) {
> +				tst_resm(TFAIL,
> +					"Wait return value: expected "
> +					"pid=%d, got %d, iteration %d.",
> +					pid, reaped, lc);
> +			} else if (WEXITSTATUS(status != child_exit_code)
> +				!= child_exit_code) {
> +				tst_resm(TFAIL,
> +					"Unexpected exit status %x, "
> +					"iteration %d.",
> +					WEXITSTATUS(status), lc);
> +			}
> +		}
> +	}
> +	return 0;

Rather use tst_exit() here.

> +}
> +
> +void setup(void)
> +{
> +	/* capture signals */
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	/* Pause if that option was specified */
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();

Do you really need temporary directory to test fork() ?

> +}
> +
> +void cleanup(void)
> +{
> +	/*
> +	 * print timing stats if that option was specified.
> +	 * print errno log if that option was specified.
> +	 */
> +	TEST_CLEANUP;
> +
> +	/* exit with return code appropriate for results */
> +	tst_rmdir();
> +	tst_exit();
> +}
>
> +/* The distance mod 32768 between two pids, where the first pid is
> +   expected to be smaller than the second. */
> +int PidDistance(pid_t first, pid_t second) {
> +	return (second + 32768 - first) % 32768;
> +}

The comment doesn't hold as when second is smaller than first the
negative value would be smaller than 32768.

Moreover the maximal pid value may be changed by writing to
"/proc/sys/kernel/pid_max", then this code is broken.

Also I'm not sure if the result of such computation couldn't
overflow/underflow as int may not be the same size as pid_t. 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

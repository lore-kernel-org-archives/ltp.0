Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XPXn9-0002uw-UR
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 14:13:39 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XPXn8-0000l1-3A
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 14:13:39 +0000
Date: Thu, 4 Sep 2014 10:13:31 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1803448098.18473481.1409840011670.JavaMail.zimbra@redhat.com>
In-Reply-To: <1409319967-12730-1-git-send-email-mmarhefk@redhat.com>
References: <1409047170-18251-1-git-send-email-mmarhefk@redhat.com>
	<1409319967-12730-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2 v2] containers: added mountns/mountns03.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Matus Marhefka" <mmarhefk@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 29 August, 2014 3:46:07 PM
> Subject: [LTP] [PATCH 1/2 v2] containers: added mountns/mountns03.c
> 
> * Tests a slave mount: slave mount is like a shared mount except that
>   mount and umount events only propagate towards it
> 
> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
> ---
>  runtest/containers                              |   1 +
>  testcases/kernel/containers/.gitignore          |   1 +
>  testcases/kernel/containers/mountns/mountns03.c | 245
>  ++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)
>  create mode 100644 testcases/kernel/containers/mountns/mountns03.c
> 
> diff --git a/runtest/containers b/runtest/containers
> index 56977c0..3653c9c 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -58,3 +58,4 @@ utstest_clone_5 utstest clone 5
>  
>  mountns01 mountns01
>  mountns02 mountns02
> +mountns03 mountns03
> diff --git a/testcases/kernel/containers/.gitignore
> b/testcases/kernel/containers/.gitignore
> index f175296..5b96cb9 100644
> --- a/testcases/kernel/containers/.gitignore
> +++ b/testcases/kernel/containers/.gitignore
> @@ -1,3 +1,4 @@
>  /check_for_unshare
>  mountns/mountns01
>  mountns/mountns02
> +mountns/mountns03
> diff --git a/testcases/kernel/containers/mountns/mountns03.c
> b/testcases/kernel/containers/mountns/mountns03.c
> new file mode 100644
> index 0000000..acca44c
> --- /dev/null
> +++ b/testcases/kernel/containers/mountns/mountns03.c
> @@ -0,0 +1,245 @@
> +/* Copyright (c) 2014 Red Hat, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of version 2 the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + ***********************************************************************
> + * File: mountns03.c
> + *
> + * Tests a slave mount: slave mount is like a shared mount except that
> + * mount and umount events only propagate towards it.
> + * Description:
> + * 1. Creates directories "A", "B", "C", "D" and files "A/A", "B/B"
> + *    "C/C", "D/D"
> + * 2. Unshares mount namespace and makes it private (so mounts/umounts
> + *    have no effect on a real system)

Hi,

> + * 3. Bind mounts directory "A" to "A" and "B" to "B"

is the "B" to "B" part necessary in this case? First thing child does is
it mounts A to B.

> + * 4. Makes both directories ("A" and "B") shared

related to above, is it necessary to make B shared?

> + * 5. Clones a new child process with CLONE_NEWNS flag - the new child
> + *    then:
> + *    a) bind mounts directory "A" to directory "B"
> + *    b) makes mount "B" a slave of "A"
> + *    c) bind mounts directory "C" to "A"
> + *    d) checks that mount in c) propagated also to direcoty "B" (as "B"
> + *       is a slave of "A"):
> + *       - if it does, test #1 passes
> + *       - if it doesn't, test #1 fails
> + *    e) bind mounts direcory "D" to "B"
> + *    f) waits for parent approval to terminate
> + * 6. Parent checks if directory "A" doesn't contain the file "D"
> + *    (as slave mount ("B") doesn't forward propagation (to "A")):
> + *    - if it doesn't, test #2 passes
> + *    - if it does, test #2 fails
> + * 7. Parent allows child to terminate
> + ***********************************************************************/
> +
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <sys/mount.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "libclone.h"
> +#include "safe_macros.h"
> +#include "safe_file_ops.h"
> +#include "mountns_helper.h"
> +
> +
> +#define DIRA "A"
> +#define DIRB "B"
> +#define DIRC "C"
> +#define DIRD "D"
> +char *TCID	= "mountns03";
> +int TST_TOTAL	= 2;
> +int pipefd1[2];
> +int pipefd2[2];
> +
> +
> +/* checks if following mountflags are defined */
> +#if defined(MS_SHARED) && defined(MS_PRIVATE) \
> +    && defined(MS_REC) && defined(MS_SLAVE)
> +
> +static void cleanup(void)
> +{
> +	close(pipefd1[0]);
> +	close(pipefd1[1]);
> +	close(pipefd2[0]);
> +	close(pipefd2[1]);
> +	umount(DIRA);
> +	umount(DIRB);
> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_newns();	/* from mountns_helper.h */
> +	tst_tmpdir();
> +	SAFE_MKDIR(cleanup, DIRA, 0777);
> +	SAFE_MKDIR(cleanup, DIRB, 0777);
> +	SAFE_MKDIR(cleanup, DIRC, 0777);
> +	SAFE_MKDIR(cleanup, DIRD, 0777);
> +	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRC"/C", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRD"/D", 0, NULL);
> +}
> +
> +int child_func(void *arg)
> +{
> +	char buf;
> +
> +	/* bind mounts DIRA to DIRB making contents of DIRA visible
> +	 * in DIRB */
> +	if (mount(DIRA, DIRB, "none", MS_BIND, NULL) == -1) {
> +		perror("mount");
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* makes mount DIRB a slave of DIRA (all slave mounts have
> +	 * a master mount which is a shared mount) */
> +	if (mount("none", DIRB, "none", MS_SLAVE, NULL) == -1) {
> +		perror("mount");
> +		umount(DIRB);
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* bind mounts DIRC to DIRA making contents of DIRC visible
> +	 * in DIRA */
> +	if (mount(DIRC, DIRA, "none", MS_BIND, NULL) == -1) {
> +		perror("mount");
> +		umount(DIRB);
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* as DIRB is a slave of DIRA, previous mount (DIRC to DIRA)
> +	 * should be also propageted into DIRB */
> +	if (access(DIRB"/C", F_OK) != -1)
> +		tst_resm(TPASS, "propagation to slave mount passed");
> +	else
> +		tst_resm(TFAIL, "propagation to slave mount failed");
> +
> +	/* bind mounts DIRD to DIRB making contents of DIRD visible
> +	 * in DIRB (should not propagate to DIRA as DIRB is its slave) */
> +	if (mount(DIRD, DIRB, "none", MS_BIND, NULL) == -1) {
> +		perror("mount");
> +		umount(DIRA);
> +		umount(DIRB);
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* tells parent to stop waiting and continue */
> +	write(pipefd1[1], "0", 1);
> +
> +	/* waits for parent approval to terminate */
> +	read(pipefd2[0], &buf, 1);
> +
> +	umount(DIRB);
> +	umount(DIRA);
> +	umount(DIRB);
> +	return 0;

You need to use tst_exit() to propagate exit value from tst_resm above.

> +}
> +
> +static void test(void)
> +{
> +	int status, pass;
> +	char buf;
> +
> +	/* creates a pipe for synchronization between parent and child */
> +	SAFE_PIPE(cleanup, pipefd1);
> +	SAFE_PIPE(cleanup, pipefd2);
> +
> +	/* unshares the mount ns */
> +	if (unshare(CLONE_NEWNS) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
> +	/* makes sure parent mounts/umounts have no effect on a real system */
> +	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
> +
> +	/* bind mounts DIRA to itself */
> +	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
> +	/* bind mounts DIRB to itself */
> +	SAFE_MOUNT(cleanup, DIRB, DIRB, "none", MS_BIND, NULL);
> +
> +	/* makes mount DIRA shared */
> +	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_SHARED, NULL);
> +	/* makes mount DIRB shared */
> +	SAFE_MOUNT(cleanup, "none", DIRB, "none", MS_SHARED, NULL);
> +
> +	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
> +
> +	/* waits for child bind mount */
> +	SAFE_READ(cleanup, 0, pipefd1[0], &buf, 1);
> +
> +	/* checks that mount in slave (DIRB) doesn't propagate to shared
> +	 * mount (DIRA) */
> +	if (access(DIRA"/D", F_OK) == -1)

I'd suggest to add here: "&& access(DIRA"/C", F_OK) == 0"
it's more restrictive in case something unexpected happens.

> +		pass = 1;
> +	else
> +		pass = 0;
> +
> +	/* tells child to terminate (if no error occured in child) */
> +	SAFE_WRITE(cleanup, 0, pipefd2[1], "0", 1);
> +
> +	SAFE_WAIT(cleanup, &status);
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +		tst_brkm(TBROK, cleanup, "child failed");
> +
> +	if (WIFSIGNALED(status)) {
> +		tst_resm(TFAIL, "child was killed with signal %s",
> +			 tst_strsig(WTERMSIG(status)));
> +		return;
> +	}

Hmm, shouldn't this be the other way around? TFAIL on exit code
and TBROK on signal?

Regards,
Jan

> +
> +	close(pipefd1[0]);
> +	close(pipefd1[1]);
> +	close(pipefd2[0]);
> +	close(pipefd2[1]);
> +	SAFE_UMOUNT(cleanup, DIRA);
> +	SAFE_UMOUNT(cleanup, DIRB);
> +
> +	if (pass)
> +		tst_resm(TPASS, "propagation from slave mount passed");
> +	else
> +		tst_resm(TFAIL, "propagation form slave mount failed");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *msg;
> +	int lc;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		test();
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +#else /* MS_SHARED && MS_PRIVATE && MS_REC && MS_SLAVE */
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "needed mountflags are not defined");
> +}
> +#endif
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Slashdot TV.
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

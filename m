Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XLraa-00055B-4p
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 10:33:28 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XLraY-0004Y6-7A
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 10:33:28 +0000
Date: Mon, 25 Aug 2014 06:33:19 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <743848590.12257585.1408962799605.JavaMail.zimbra@redhat.com>
In-Reply-To: <1408115809-18653-1-git-send-email-mmarhefk@redhat.com>
References: <1408099965-15748-3-git-send-email-mmarhefk@redhat.com>
	<1408115809-18653-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3 v2] containers: added mountns/mountns02.c
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
> Sent: Friday, 15 August, 2014 5:16:49 PM
> Subject: [LTP] [PATCH 3/3 v2] containers: added mountns/mountns02.c
> 
> * Tests a private mount: private mount does not forward or receive
>   propagation.
> 
> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
> ---
>  runtest/containers                              |   1 +
>  testcases/kernel/containers/mountns/mountns02.c | 190
>  ++++++++++++++++++++++++
>  2 files changed, 191 insertions(+)
>  create mode 100644 testcases/kernel/containers/mountns/mountns02.c
> 
> diff --git a/runtest/containers b/runtest/containers
> index bf50ae4..ab16bc0 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -15,5 +15,6 @@ pidns30 pidns30
>  pidns31 pidns31
>  
>  mountns01 mountns01
> +mountns02 mountns02
>  
>  Containers	container_test.sh
> diff --git a/testcases/kernel/containers/mountns/mountns02.c
> b/testcases/kernel/containers/mountns/mountns02.c
> new file mode 100644
> index 0000000..8a677b7
> --- /dev/null
> +++ b/testcases/kernel/containers/mountns/mountns02.c
> @@ -0,0 +1,190 @@
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
> + * File: mountns02.c
> + *
> + * Tests a private mount: private mount does not forward or receive
> + * propagation.
> + * Description:
> + * 1. Creates directories "A", "B" and files "A/A", "B/B"
> + * 2. Unshares mount namespace and makes it private (so mounts/umounts
> + *    have no effect on a real system)
> + * 3. Bind mounts directory "A" to "A" and "B" to "B"
> + * 4. Makes both directories ("A" and "B") shared
> + * 5. Clones a new child process with CLONE_NEWNS flag - the new child
> + *    then mounts directory "A" as private and bind mounts directory
> + *    "B" to "A" (now child must wait for parent to make check - wait
> + *    is needed because mount ns in child stops exist as soon as child
> + *    terminates)
> + * 6. Parent checks if directory "A" doesn't contain the file "B"
> + *    (changes in child should not be visible in parent as mount in child
> + *    was private):
> + *    - if it doesn't, test passes
> + *    - if it does, test fails
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
> +char *TCID	= "mountns02";
> +int TST_TOTAL	= 1;
> +int pipefd1[2];
> +int pipefd2[2];
> +
> +
> +static void cleanup(void)
> +{
> +	close(pipefd1[0]);
> +	close(pipefd1[1]);
> +	close(pipefd2[0]);
> +	close(pipefd2[1]);
> +	umount(DIRA);
> +	umount(DIRA);
> +	umount(DIRB);
> +	tst_rmdir();

As in mountns01, try with -i 2:

# ./mountns02 -i 2
mountns02    1  TPASS  :  private mount passed
mountns02    2  TPASS  :  private mount passed
mountns02    0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmp/mouY0X2xg) failed: remove(/tmp/mouY0X2xg/B) failed; errno=16: Device or resource busy

> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_newns();	/* from mountns_helper.h */
> +	tst_tmpdir();
> +	SAFE_MKDIR(cleanup, DIRA, 0777);
> +	SAFE_MKDIR(cleanup, DIRB, 0777);
> +	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
> +}
> +
> +int child_func(void *arg)
> +{
> +	char buf;
> +
> +	/* makes DIRA private */
> +	if (mount("none", DIRA, "none", MS_PRIVATE, NULL) == -1) {
> +		perror("mount");
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* bind mounts DIRB to DIRA making contents of DIRB visible
> +	 * in DIRA (should apply only for child as DIRA is private) */
> +        if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
> +		perror("mount");
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
> +	return 0;
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
> +
> +	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
> +
> +	/* waits for child bind mount */
> +	SAFE_READ(cleanup, 0, pipefd1[0], &buf, 1);
> +	/* in case some mount failed in child */
> +	if (buf == '1')
> +		tst_brkm(TBROK, cleanup, "child failed");

Is this check needed if child returns same value via ret code,
which is checked few lines below in EXISTSTATUS?

Regards,
Jan

> +
> +	/* as child made private mount from DIRA, parent should not
> +	 * see file "B" in DIRA; following checks if DIRA doesn't contain
> +	 * file "B" */
> +	if (access(DIRA"/B", F_OK) == -1)
> +		pass = 1;
> +	else
> +		pass = 0;
> +
> +	/* tells child to terminate */
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
> +
> +	if (pass)
> +		tst_resm(TPASS, "private mount passed");
> +	else
> +		tst_resm(TFAIL, "private mount failed");
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
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
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

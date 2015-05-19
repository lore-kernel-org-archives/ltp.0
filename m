Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YugaB-0007qF-U8
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 12:25:15 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yuga6-0002H0-78
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 12:25:15 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4JCP3fu019714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 19 May 2015 08:25:04 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t4JCP2UX016296
	for <ltp-list@lists.sourceforge.net>; Tue, 19 May 2015 08:25:03 -0400
Message-ID: <555B2B9E.1050609@redhat.com>
Date: Tue, 19 May 2015 14:25:02 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <1432063864-24858-1-git-send-email-sunyuan3@huawei.com>
In-Reply-To: <1432063864-24858-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] Add userns01 testcase to verify user namespace.
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
To: ltp-list@lists.sourceforge.net

On 05/19/2015 09:31 PM, Yuan Sun wrote:
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  testcases/kernel/containers/userns/Makefile        |  28 ++++++
>  testcases/kernel/containers/userns/README          |  22 +++++
>  testcases/kernel/containers/userns/userns01.c      | 104 +++++++++++++++++++++
>  testcases/kernel/containers/userns/userns_helper.h |  37 ++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 testcases/kernel/containers/userns/Makefile
>  create mode 100644 testcases/kernel/containers/userns/README
>  create mode 100644 testcases/kernel/containers/userns/userns01.c
>  create mode 100644 testcases/kernel/containers/userns/userns_helper.h

Hi,

I suggest using checkpatch.pl, which can help you identify places
where you (presumably) copied also style issues from original code:
  line going over 80 characters
  mixing spaces and tabs
  whitespace at the end of lines

> 
> diff --git a/testcases/kernel/containers/userns/Makefile b/testcases/kernel/containers/userns/Makefile
> new file mode 100644
> index 0000000..6dfe694
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/Makefile
> @@ -0,0 +1,28 @@
> +###############################################################################
> +#                                                                            ##
> +# Copyright (c) International Business Machines  Corp., 2007                 ##

You can use your name/company or "Linux Test Project" with current year

> +#                                                                            ##
> +# This program is free software;  you can redistribute it and#or modify      ##
> +# it under the terms of the GNU General Public License as published by       ##
> +# the Free Software Foundation; either version 2 of the License, or          ##
> +# (at your option) any later version.                                        ##
> +#                                                                            ##
> +# This program is distributed in the hope that it will be useful, but        ##
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +# for more details.                                                          ##
> +#                                                                            ##
> +# You should have received a copy of the GNU General Public License          ##
> +# along with this program;  if not, write to the Free Software               ##
> +# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##

Line above is clearly more than 80 characters. You can drop the part about
the address of FSF.

> +#                                                                            ##
> +###############################################################################
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../Makefile.inc
> +
> +LDLIBS			:= -lpthread -lrt -lclone -lltp

Is -lpthread and -lrt needed here?

> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/containers/userns/README b/testcases/kernel/containers/userns/README
> new file mode 100644
> index 0000000..8011cff
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/README

This README seems redundant, there is description in userns01.c

> @@ -0,0 +1,22 @@
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) International Business Machines  Corp., 2007                 ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> +##                                                                            ##
> +################################################################################
> +
> +USERNS testcases Overview:
> +User namespaces allow per-namespace mappings of user and group IDs. This means that a process's user and group IDs inside a user namespace can be different from its IDs outside of the namespace. 
> diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
> new file mode 100644
> index 0000000..ca516e7
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns01.c
> @@ -0,0 +1,104 @@
> +/*
> +* Copyright (c) International Business Machines Corp., 2007
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of the GNU General Public License as published by
> +* the Free Software Foundation; either version 2 of the License, or
> +* (at your option) any later version.
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> +* the GNU General Public License for more details.
> +* You should have received a copy of the GNU General Public License
> +* along with this program; if not, write to the Free Software
> +* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

This GPL block looks a bit mangled.

> +*
> +***************************************************************************
> +
> +* File: userns01.c

The above comments like what file we are in and "*" separator lines are useless.

> +*
> +* Description:
> +*  The userns01.c testcase builds into the ltp framework to verify
> +*  the basic functionality of USER Namespace.

The above description is too generic and doesn't really help to explain what
is this test about.

> +*
> +* Verify that:
> +*  If a user ID has no mapping inside the namespace, user ID and group 
> +* ID will be the value defined in the file /proc/sys/kernel/overflowuid, 65534.

This is good, that gives reader some clue what this test is about.

> +*
> +* Total Tests:
> +*
> +* Test Name: userns01
> +*
> +* History:
> +*
> +* FLAG DATE		NAME			DESCRIPTION
> +* 16/05/15  Yuan Sun <sunyuan3@huawei.com> Created this test
> +*
> +*******************************************************************************************/

All above can be removed as it's stored in git history.

> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <assert.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include "test.h"
> +#include "libclone.h"
> +#include "userns_helper.h"
> +
> +char *TCID = "user_namespace1";
> +int TST_TOTAL = 1;
> +
> +#define OVERFLOWUID 65534

I'd suggest getting the value from /proc if possible, and rely on
hardcoded value only if that fails, for example in setup() by:
  SAFE_FILE_SCANF()

> +
> +/*
> + * child_fn1() - Inside a new user namespace
> + */
> +static int child_fn1(void *arg)
> +{
> +        int exit_val;
> +        int uid, gid;
> +        uid = geteuid();
> +        gid = getegid();
> +
> +        tst_resm(TINFO, "USERNS test is running in a new user namespace.");
> +        if (uid == OVERFLOWUID && gid == OVERFLOWUID) {
> +                printf("Got expected cpid and ppid\n");

The printf message needs updating, there's no cpid and ppid here.

> +                exit_val = 0;
> +        } else {
> +                printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
> +                exit_val = 1;
> +        }
> +
> +        return exit_val;
> +}
> +
> +static void setup(void)
> +{
> +	check_newuser();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int status;
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +	setup();
> +
> +	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, child_fn1, NULL));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
> +	} else if ((wait(&status)) == -1) {
> +		tst_brkm(TWARN | TERRNO, NULL, "wait failed");
> +	}
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +		tst_resm(TFAIL, "child exited abnormally");
> +	else if (WIFSIGNALED(status)) {
> +		tst_resm(TFAIL, "child was killed with signal = %d",
> +			 WTERMSIG(status));
> +	}

A TPASS message would be nice if everything goes as expected.

Regards,
Jan

> +
> +	tst_exit();
> +}
> +
> diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
> new file mode 100644
> index 0000000..36e75ad
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns_helper.h
> @@ -0,0 +1,37 @@
> +/*
> +* Copyright (c) International Business Machines Corp., 2007
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of the GNU General Public License as published by
> +* the Free Software Foundation; either version 2 of the License, or
> +* (at your option) any later version.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> +* the GNU General Public License for more details.
> +*/
> +
> +#include "../libclone/libclone.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +static int dummy_child(void *v)
> +{
> +	(void) v;
> +	return 0;
> +}
> +
> +static int check_newuser(void)
> +{
> +	int pid, status;
> +
> +	if (tst_kvercmp(3, 8, 0) < 0)
> +		tst_brkm(TCONF, NULL, "CLONE_NEWUSER not supported");
> +
> +	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, dummy_child, NULL);
> +	if (pid == -1)
> +		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUSER not supported");
> +	SAFE_WAIT(NULL, &status);
> +
> +	return 0;
> +}
> 


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

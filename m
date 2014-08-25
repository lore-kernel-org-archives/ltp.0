Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XLrTZ-0004jF-F5
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 10:26:13 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XLrTW-0004KI-V0
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 10:26:13 +0000
Date: Mon, 25 Aug 2014 06:26:04 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <555865557.12247931.1408962364264.JavaMail.zimbra@redhat.com>
In-Reply-To: <1408099965-15748-2-git-send-email-mmarhefk@redhat.com>
References: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
	<1408099965-15748-2-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3] containers: added mountns dir
	and	mountns/mountns01.c
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
> Sent: Friday, 15 August, 2014 12:52:44 PM
> Subject: [LTP] [PATCH 2/3] containers: added mountns dir and	mountns/mountns01.c
> 
> * tests shared mount: shared mount can be replicated to as many
>   mountpoints and all the replicas continue to be exactly same.
> 
> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
> ---
>  runtest/containers                                 |   2 +
>  testcases/kernel/containers/mountns/Makefile       |  23 ++++
>  testcases/kernel/containers/mountns/mountns01.c    | 142
>  +++++++++++++++++++++
>  .../kernel/containers/mountns/mountns_helper.h     |  39 ++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 testcases/kernel/containers/mountns/Makefile
>  create mode 100644 testcases/kernel/containers/mountns/mountns01.c
>  create mode 100644 testcases/kernel/containers/mountns/mountns_helper.h

Hi,

for both testcases, can you add them to "../.gitignore"?

> 
> diff --git a/runtest/containers b/runtest/containers
> index 5f5eeab..bf50ae4 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -14,4 +14,6 @@ pidns20 pidns20
>  pidns30 pidns30
>  pidns31 pidns31
>  
> +mountns01 mountns01
> +
>  Containers	container_test.sh
> diff --git a/testcases/kernel/containers/mountns/Makefile
> b/testcases/kernel/containers/mountns/Makefile
> new file mode 100644
> index 0000000..f9b6b99
> --- /dev/null
> +++ b/testcases/kernel/containers/mountns/Makefile
> @@ -0,0 +1,23 @@
> +# Copyright (c) 2014 Red Hat, Inc.
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of version 2 the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +##############################################################################
> +
> +top_srcdir              ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../Makefile.inc
> +
> +LDLIBS                  := -lclone -lltp
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/containers/mountns/mountns01.c
> b/testcases/kernel/containers/mountns/mountns01.c
> new file mode 100644
> index 0000000..0393e0a
> --- /dev/null
> +++ b/testcases/kernel/containers/mountns/mountns01.c
> @@ -0,0 +1,142 @@
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
> + * File: mountns01.c
> + *
> + * Tests a shared mount: shared mount can be replicated to as many
> + * mountpoints and all the replicas continue to be exactly same.
> + * Description:
> + * 1. Creates directories "A", "B" and files "A/A", "B/B"
> + * 2. Unshares mount namespace and makes it private (so mounts/umounts
> + *    have no effect on a real system)
> + * 3. Bind mounts directory "A" to "A" and "B" to "B"
> + * 4. Makes both directories ("A" and "B") shared
> + * 5. Clones a new child process with CLONE_NEWNS flag - the new child
> + *    then bind mounts directory "B" to "A"
> + * 6. Parent then checks if directory "A" contains the file "B"
> + *    (changes in child should be visible in parent as mounts were
> + *    shared):
> + *    - if it does, test passes
> + *    - if it doesn't, test fails
> + ***********************************************************************/
> +
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <sys/mount.h>
> +#include <stdio.h>
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
> +char *TCID	= "mountns01";
> +int TST_TOTAL	= 1;
> +
> +
> +static void cleanup(void)
> +{
> +	umount(DIRA);
> +	umount(DIRA);
> +	umount(DIRB);

Try "./mountns01 -i 2":

# ./mountns01 -i 2
mountns01    1  TPASS  :  share mount passed
mountns01    2  TPASS  :  share mount passed
mountns01    0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmp/mour49V5j) failed: remove(/tmp/mour49V5j/A) failed; errno=16: Device or resource busy

> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_newns();	/* from mountns_helper.h */

We should probably also check availability of MS_SHARED/MS_PRIVATE/MS_REC/etc.
For example, an old distro like RHEL5.3 has kernel support, but these
flags are not defined in glibc headers ().

Regards,
Jan

> +	tst_tmpdir();
> +	SAFE_MKDIR(cleanup, DIRA, 0777);
> +	SAFE_MKDIR(cleanup, DIRB, 0777);
> +	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
> +}
> +

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

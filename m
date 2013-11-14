Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgxyN-00055X-5P
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 14:32:43 +0000
Date: Thu, 14 Nov 2013 15:32:28 +0100
From: chrubis@suse.cz
Message-ID: <20131114143228.GB14170@rei>
References: <1a7334c8ecd0ea0adb174c7c55667844d971a3f2.1384419525.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a7334c8ecd0ea0adb174c7c55667844d971a3f2.1384419525.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] add test for tst_checkpoint_signal_child timing
	out
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This is simple test for patch which adds timeout to
> tst_checkpoint_signal_child().
> 
> The test is expected to end with:
>   Failed to open fifo 'tst_checkpoint_fifo' at
>   tst_checkpoint_child_exits2.c:56: errno=ETIMEDOUT(110): Connection timed out
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .gitignore                              |    1 +
>  lib/tests/tst_checkpoint_child_exits2.c |   62 +++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 0 deletions(-)
>  create mode 100644 lib/tests/tst_checkpoint_child_exits2.c
> 
> diff --git a/.gitignore b/.gitignore
> index 140f5f4..dfee1ad 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -55,6 +55,7 @@ logfile.*
>  /lib/tests/tst_tmpdir_test
>  /lib/tests/tst_checkpoint_child
>  /lib/tests/tst_checkpoint_child_exits
> +/lib/tests/tst_checkpoint_child_exits2
>  /lib/tests/tst_checkpoint_parent
>  /lib/tests/tst_checkpoint_parent_exits
>  /lib/tests/tst_process_state
> diff --git a/lib/tests/tst_checkpoint_child_exits2.c b/lib/tests/tst_checkpoint_child_exits2.c
> new file mode 100644
> index 0000000..fb79145
> --- /dev/null
> +++ b/lib/tests/tst_checkpoint_child_exits2.c
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright (C) 2013 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <sys/wait.h>
> +
> +#include "test.h"
> +
> +char *TCID = "tst_checkpoint_child_exits2";
> +int TST_TOTAL = 1;
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +int main(void)
> +{
> +	int pid;
> +	struct tst_checkpoint checkpoint;
> +
> +	tst_tmpdir();
> +
> +	pid = fork();
> +
> +	switch (pid) {
> +	case -1:
> +		tst_brkm(TBROK | TERRNO, NULL, "Fork failed");
> +		break;
> +	case 0:
> +		fprintf(stderr, "Child: exiting prior checkpoint init\n");
> +		exit(0);
> +		break;

We don't even have the do the for here simply calling just the
checkpoint init and checkpoint signal would do. :)

If you agree I can commit the simplified version right away.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

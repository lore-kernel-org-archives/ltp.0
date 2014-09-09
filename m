Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRLTU-00012e-Sm
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 13:28:48 +0000
Date: Tue, 9 Sep 2014 15:28:33 +0200
From: chrubis@suse.cz
Message-ID: <20140909132833.GA5193@rei>
References: <1408099965-15748-2-git-send-email-mmarhefk@redhat.com>
	<1409315004-11702-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409315004-11702-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 2/3 v3] containers: added mountns dir and
 mountns/mountns01.c
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

Hi!
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
> +/* checks if following mountflags are defined */

This comment is close to "commenting the obvious" category. Everybody
can tell what the preprocessor #if below do. I would personaly omit this
comment.

> +#if defined(MS_SHARED) && defined(MS_PRIVATE) && defined(MS_REC)
> +
> +static void cleanup(void)
> +{
> +	umount(DIRA);
> +	umount(DIRA);
> +	umount(DIRB);
> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_newns();	/* from mountns_helper.h */

Here as well. It's not a good idea to comment where functions are
implemented, it only makes the source code longer and less clear.


The rest of the test looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

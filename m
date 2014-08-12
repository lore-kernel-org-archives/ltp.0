Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XHCJC-0002Kp-7z
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 13:40:14 +0000
Date: Tue, 12 Aug 2014 15:39:17 +0200
From: chrubis@suse.cz
Message-ID: <20140812133917.GA3587@rei.suse.cz>
References: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
	<1407252982-27023-2-git-send-email-asavkov@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1407252982-27023-2-git-send-email-asavkov@redhat.com>
Subject: Re: [LTP] [PATCH 1/5] mqns tests: runmqnsstest.sh ->
 runtest/containers
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
To: Artem Savkov <asavkov@redhat.com>
Cc: ltp-list@lists.sourceforge.net

> diff --git a/testcases/kernel/containers/mqns/mqns_helper.h b/testcases/kernel/containers/mqns/mqns_helper.h
> new file mode 100644
> index 0000000..f1281fa
> --- /dev/null
> +++ b/testcases/kernel/containers/mqns/mqns_helper.h
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (c) International Business Machines Corp., 2009
> + * Copyright (c) Nadia Derbey, 2009
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> + * the GNU General Public License for more details.
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *
> + * Author: Serge Hallyn <serue@us.ibm.com>
> + ***************************************************************************/
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include "../libclone/libclone.h"
> +#include "test.h"
> +#include "mqns.h"
> +
> +static int dummy_child(void *v)
> +{
> +	(void) v;
> +	return 0;
> +}
> +
> +static int check_mqns(void)
> +{
> +	int pid;
> +	mqd_t mqd;
> +
> +	if (tst_kvercmp(2, 6, 30) < 0)
> +		tst_brkm(TCONF, NULL, "Kernel version is lower than expected");
> +
> +	mq_unlink("/checkmqnsenabled");
> +	mqd =
> +	    mq_open("/checkmqnsenabled", O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
> +	if (mqd == -1)
> +		tst_brkm(TCONF, NULL, "mq_open check failed");
> +
> +	mq_close(mqd);
> +	mq_unlink("/checkmqnsenabled");
> +
> +	pid = ltp_clone_quick(CLONE_NEWIPC, dummy_child, NULL);
> +	if (pid == -1)
> +		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWIPC not supported");

I guess that we should reap the child with waitpid(pid, ...) here.

> +	return 0;

And since the function calls tst_brkm() we don't have to return any
value here so we can define it as void check_mqns(void).

> +}

The rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

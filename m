Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYIpE-0001I1-Jb
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:04 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYIp9-0000Vf-8y
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:04 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74C80hr006950
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 06:08:00 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74C8b4T225948
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 06:08:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74C8aOp009264
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 06:08:37 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
	<b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
Date: Tue, 04 Aug 2009 17:38:13 +0530
Message-Id: <1249387694.15587.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 2/4] tst_is_cwd: Add support for ramfs
Reply-To: subrata@linux.vnet.ibm.com
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

On Mon, 2009-08-03 at 15:24 +0200, michal.simek@petalogix.com wrote: 
> From: Michal Simek <monstr@monstr.eu>
> 
> I added support for testing ramfs and add together
> tests for nfs, tmpfs and ramfs.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>

Thanks.

Regards--
Subrata

> ---
>  lib/tst_is_cwd.c       |   42 ++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_is_cwd_nfs.c   |   41 -----------------------------------------
>  lib/tst_is_cwd_tmpfs.c |   24 ------------------------
>  3 files changed, 42 insertions(+), 65 deletions(-)
>  create mode 100644 lib/tst_is_cwd.c
>  delete mode 100644 lib/tst_is_cwd_nfs.c
>  delete mode 100644 lib/tst_is_cwd_tmpfs.c
> 
> diff --git a/lib/tst_is_cwd.c b/lib/tst_is_cwd.c
> new file mode 100644
> index 0000000..ad6b747
> --- /dev/null
> +++ b/lib/tst_is_cwd.c
> @@ -0,0 +1,42 @@
> +/*
> + * Michal Simek <monstr@monstr.eu>, 2009-08-03 - ramfs
> + * Kumar Gala <galak@kernel.crashing.org>, 2007-11-14 - nfs
> + * Ricky Ng-Adam <rngadam@yahoo.com>, 2005-01-01 - tmpfs
> + *
> + * DESCRIPTION
> + *	Check if current directory is on a tmpfs/nfs/ramfs filesystem
> + *	If current directory is tmpfs/nfs/ramfs, return 1
> + *	If current directory is NOT tmpfs/nfs/ramfs, return 0
> + */
> +
> +#include <sys/vfs.h>
> +
> +#define TMPFS_MAGIC 0x01021994 /* man 2 statfs */
> +int tst_is_cwd_tmpfs(void)
> +{
> +	struct statfs sf;
> +	statfs(".", &sf);
> +
> +	/* Verify that the file is not on a tmpfs (in-memory) filesystem */
> +	return sf.f_type == TMPFS_MAGIC ? 1 : 0;
> +}
> +
> +#define NFS_MAGIC 0x6969 /* man 2 statfs */
> +int tst_is_cwd_nfs(void)
> +{
> +	struct statfs sf;
> +	statfs(".", &sf);
> +
> +	/* Verify that the file is not on a nfs filesystem */
> +	return sf.f_type == NFS_MAGIC ? 1 : 0;
> +}
> +
> +#define RAMFS_MAGIC 0x858458f6
> +int tst_is_cwd_ramfs(void)
> +{
> +	struct statfs sf;
> +	statfs(".", &sf);
> +
> +	/* Verify that the file is not on a ramfs (in-memory) filesystem */
> +	return sf.f_type == RAMFS_MAGIC ? 1 : 0;
> +}
> diff --git a/lib/tst_is_cwd_nfs.c b/lib/tst_is_cwd_nfs.c
> deleted file mode 100644
> index 130c6c2..0000000
> --- a/lib/tst_is_cwd_nfs.c
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/******************************************************************************/
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> -/******************************************************************************/
> -/*
> - *    AUTHOR
> - *     Kumar Gala <galak@kernel.crashing.org>, 2007-11-14
> - *     based on tst_is_cwd_tmpfs()
> - *
> - *    DESCRIPTION
> - *     Check if current directory is on a nfs filesystem
> - *     If current directory is nfs, return 1
> - *     If current directory is NOT nfs, return 0
> - *
> - *
> - */
> -/******************************************************************************/
> -
> -#include <sys/vfs.h>
> -
> -#define NFS_MAGIC 0x6969 /* man 2 statfs */
> -
> -int tst_is_cwd_nfs(void)
> -{
> -	struct statfs sf;
> -	statfs(".", &sf);
> -
> -	/* Verify that the file is not on a nfs filesystem */
> -	return sf.f_type == NFS_MAGIC?1:0;
> -}
> diff --git a/lib/tst_is_cwd_tmpfs.c b/lib/tst_is_cwd_tmpfs.c
> deleted file mode 100644
> index 61c5c39..0000000
> --- a/lib/tst_is_cwd_tmpfs.c
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - *    AUTHOR
> - *    	Ricky Ng-Adam <rngadam@yahoo.com>, 2005-01-01
> - *
> - *    DESCRIPTION
> - * 	Check if current directory is on a tmpfs filesystem
> - * 	If current directory is tmpfs, return 1
> - * 	If current directory is NOT tmpfs, return 0
> - *
> - *
> - */
> -
> -#include <sys/vfs.h>
> -
> -#define TMPFS_MAGIC 0x01021994 /* man 2 statfs */
> -
> -int tst_is_cwd_tmpfs(void)
> -{
> -	struct statfs sf;
> -	statfs(".", &sf);
> -
> -	/* Verify that the file is not on a tmpfs (in-memory) filesystem */
> -	return sf.f_type == TMPFS_MAGIC?1:0;
> -}


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

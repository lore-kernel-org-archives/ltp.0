Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1O9Qil-00054F-Gn
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 22:36:07 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9Qij-0007OZ-BT
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 22:36:07 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o44MSuoW011714
	for <ltp-list@lists.sourceforge.net>; Tue, 4 May 2010 16:28:56 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o44MZlAO125012
	for <ltp-list@lists.sourceforge.net>; Tue, 4 May 2010 16:35:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o44MZkmH020234
	for <ltp-list@lists.sourceforge.net>; Tue, 4 May 2010 16:35:47 -0600
Date: Tue, 4 May 2010 15:35:45 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20100504223545.GF31830@count0.beaverton.ibm.com>
References: <4BD53483.9080603@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BD53483.9080603@in.ibm.com>
Subject: Re: [LTP] PATCH : test_fs_bind testscript for busybox machines
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: risrajak@in.ibm.com, ltp-list@lists.sourceforge.net

On Mon, Apr 26, 2010 at 12:06:51PM +0530, Suzuki Poulose wrote:
> Hi,
> 
> The test_fs_bind testscript hangs indefinitely when run on a machine
> where busybox applets are used.
> 
> The test hangs while trying to restore the mounts after a test run.
> 
> 
> This happens because the "xargs" applet from busybox doesn't
> understand the --max-args=1 option. Thus, the mounts from the test
> are not removed and this goes on in a loop, indefinitely.
> 
> This could be avoided by using "-n" option which is supported by
> both the implementations of xargs.
> 
> 
> Attached the patch here.
> 
> Thanks
> 
> Suzuki

Just noticed this thread. Looks good, thanks!

Acked-by: Matt Helsley <matthltc@us.ibm.com>

> 
> Signed-off-by: Suzuki K P <suzuki@in.ibm.com>
> 
> Index: ltp/testscripts/test_fs_bind.sh
> ===================================================================
> --- ltp.orig/testscripts/test_fs_bind.sh	2009-12-22 03:28:25.000000000 +0000
> +++ ltp/testscripts/test_fs_bind.sh	2010-04-26 05:50:41.000000000 +0000
> @@ -238,7 +238,7 @@
>  	# new mounts around and will never remove mounts outside the test
>  	# directory
>  	( while grep_proc_mounts ; do
> -		grep_proc_mounts | awk '{print $2}' | xargs -r --max-args=1 umount -l
> +		grep_proc_mounts | awk '{print $2}' | xargs -r -n 1 umount -l
>  	done ) >& /dev/null
>  	
>  	# mount list and exit with 0

> ------------------------------------------------------------------------------

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@in.ibm.com>) id 1O9WWy-00087W-5S
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 04:48:20 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9WWw-0001oe-OK
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 04:48:20 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o453sKXw026744
	for <ltp-list@lists.sourceforge.net>; Wed, 5 May 2010 09:24:20 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o454m9lW3403832
	for <ltp-list@lists.sourceforge.net>; Wed, 5 May 2010 10:18:09 +0530
Received: from d28av06.in.ibm.com (loopback [127.0.0.1])
	by d28av06.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o454m9Kw027324
	for <ltp-list@lists.sourceforge.net>; Wed, 5 May 2010 10:18:10 +0530
In-Reply-To: <20100504223545.GF31830@count0.beaverton.ibm.com>
References: <4BD53483.9080603@in.ibm.com>
	<20100504223545.GF31830@count0.beaverton.ibm.com>
Message-ID: <OF2B187143.114C8A0E-ON6525771A.0019E815-6525771A.001A5C55@in.ibm.com>
From: Rishikesh K Rajak <risrajak@in.ibm.com>
Date: Wed, 5 May 2010 10:14:17 +0530
MIME-Version: 1.0
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, suzuki@linux.vnet.ibm.com

Thanks matt. This has been already applied and released to April month LTP
tarball.

Commit ID : d9f3d25b9db35073c7104b759d526869d9867692

Warm Regards

Rishi
Linux Tech Centre
IBM-ISTL, Manyata
Bangalore



                                                                           
             Matt Helsley                                                  
             <matthltc@us.ibm.                                             
             com>                                                       To 
                                       suzuki@linux.vnet.ibm.com           
             05/05/2010 04:05                                           cc 
             AM                        Rishikesh K Rajak/India/IBM@IBMIN,  
                                       ltp-list@lists.sourceforge.net      
                                                                   Subject 
                                       Re: [LTP] PATCH : test_fs_bind      
                                       testscript for busybox machines     
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




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
> --- ltp.orig/testscripts/test_fs_bind.sh		 2009-12-22
03:28:25.000000000 +0000
> +++ ltp/testscripts/test_fs_bind.sh		 2010-04-26
05:50:41.000000000 +0000
> @@ -238,7 +238,7 @@
>  		 # new mounts around and will never remove mounts outside the
test
>  		 # directory
>  		 ( while grep_proc_mounts ; do
> -		 		 grep_proc_mounts | awk '{print $2}' | xargs -r
--max-args=1 umount -l
> +		 		 grep_proc_mounts | awk '{print $2}' | xargs -r -n
1 umount -l
>  		 done ) >& /dev/null
>
>  		 # mount list and exit with 0

>
------------------------------------------------------------------------------


> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

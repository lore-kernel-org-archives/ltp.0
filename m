Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OseOK-0000LN-GZ
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:56 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OseOE-00056U-S3
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:56 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o86FwLad004096
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 11:58:21 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o86GHjik2367630
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 12:17:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o86GHieL008313
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 13:17:45 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C77999B.1070804@bull.net>
References: <4C77999B.1070804@bull.net>
Date: Mon, 06 Sep 2010 21:47:03 +0530
Message-Id: <1283789825.4947.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ltp-aiodio.sh script failed to find aio-stress testcase
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
To: "Jacky.Malcles" <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net

Can you please send off a patch for this ?

Regards--
Subrata

On Fri, 2010-08-27 at 12:55 +0200, Jacky.Malcles wrote: 
> Hi,
> ltp-aiodio.sh script failed to find aio-stress testcase
> 
> it failed as follows:
> initiation_status="pan(ltp-aiostresspart1): execvp of 'aio-stress' (tag 
> ADS1044) failed.  errno:2  No such file or directory"
> duration=0 termination_type=exited termination_id=2 corefile=no
> ...
> 
> I just added a line to ltp-aiodio.sh script and then it finds aio-stress TC.
> 
> [root@xena5 testscripts]# diff -ru ltp-aiodio.sh.ori ltp-aiodio.sh
> --- ltp-aiodio.sh.ori   2010-08-27 11:05:52.000000000 +0200
> +++ ltp-aiodio.sh       2010-08-27 08:26:44.000000000 +0200
> @@ -16,6 +16,7 @@
>   cd ..
>   export LTPROOT=${PWD}
>  fi
> +export PATH=$LTPROOT/testcases/bin:$PATH
> 
>  run0=0
>  runTest=0
> [root@xena5 testscripts]#
> 
> now it works for me.
> ..
> tag=ADS1044 stime=1282901877
> cmdline="aio-stress -I500  -o1 -O -r4    -t4   /test/aiodio/junkfile 
> /test/aiodio/file2        /test/aiodio/file7  
> /test/aiodio/file8                                                                               
> "
> contacts=""
> analysis=exit
> <<<test_output>>>
> adding stage read
> starting with read
> file size 1024MB, record size 4KB, depth 64, ios per iteration 8
> max io_submit 32, buffer alignment set to 4KB
> ...etc
> 
> please could you fixed this up,
> regards,
> 


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

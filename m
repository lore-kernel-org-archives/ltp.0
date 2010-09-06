Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OseOW-0000NE-N4
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:18:08 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OseOV-0005AB-SH
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:18:08 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <52CF90264091A14888078A031D780F4305936FA5@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F4305936FA4@ism-mail03.corp.ad.wrs.com>
	<52CF90264091A14888078A031D780F4305936FA5@ism-mail03.corp.ad.wrs.com>
Date: Mon, 06 Sep 2010 21:47:10 +0530
Message-Id: <1283789832.4947.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal
	-	11	--- exiting
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
To: "Liang, RenXiu" <RenXiu.Liang@windriver.com>, Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sf.net

I think we missed this as well.

Regards--
Subrata

On Tue, 2010-08-17 at 07:57 +0200, Liang, RenXiu wrote:
> In mtest06/mmap1.c, when handling the signal 11 in sig_handler, it
> doesn't cover another two race conditions:
> one is si_code equals "SEGV_MAPERR" but si_address does not equal to
> map_address;
> and one is si_code equals to "SEGV_ACCERR"; see below error log:
> 
> <<<test_start>>>
> tag=mtest06 stime=1270902396
> cmdline="  mmap1 -x 0.05"
> contacts=""
> analysis=exit
> initiation_status="ok"
> <<<test_output>>>
> mmap1       0  INFO  :  pid[5456]: map, change contents, unmap files
> 1000 times
> mmap1       0  INFO  :  created thread[1216369840]
> mmap1       0  INFO  :  pid[5456] - read contents of memory 0x48002000
> 1000 times
> mmap1       0  INFO  :  page fault occurred at 0x48002000
> mmap1       0  INFO  :  page fault occurred at 0x48002000
> mmap1       0  INFO  :  page fault occurred at 0x48002000
> mmap1       0  INFO  :  page fault occurred at 0x48002000
> ......
> mmap1       0  INFO  :  page fault occurred at 0x48002000
> mmap1       0  INFO  :  page fault occurred at 0x48002000
> caught unexpected signal - 11 --- exiting
> <<<execution_status>>>
> duration=1 termination_type=exited termination_id=255 corefile=no
> cutime=0 cstime=4
> <<<test_end>>>
> 
> After cover all the three race conditions in one case in
> sig_handler(), run mtest06 repeatedly, test will not fail by catching
> signal 11.
> 
> See attached patch.
> 
> Thanks,
> Renxiu
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by 
> 
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev 
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

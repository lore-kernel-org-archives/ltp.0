Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NjmQi-0004aB-Cf
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 04:31:28 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjmQg-000803-5P
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 04:31:28 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1N4S6Ug006474
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 23:28:06 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1N4VKo8142748
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 23:31:20 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1N4VKt0021980
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Feb 2010 01:31:20 -0300
Date: Tue, 23 Feb 2010 10:01:17 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100223043117.GA11102@linux.vnet.ibm.com>
References: <4B82586C020000E80005EC9E@sinclair.provo.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B82586C020000E80005EC9E@sinclair.provo.novell.com>
Subject: Re: [LTP] January interim build test failures
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list@lists.sourceforge.net

Hi Murlin,

Thanks for taking interest into it. Here are the current failure which i ran on
2.6.32-7 kerenl with feb'10 interim release.

mhs21a:~ # cat /tmp/result-log.12258 | grep FAIL
rt_sigaction01                 FAIL       11   
rt_sigprocmask01               FAIL       11   
rt_sigsuspend01                FAIL       11   
swapon03                       FAIL       1    
utimensat01                    FAIL       1    
proc01                         FAIL       1    
Containers                     FAIL       1    
mhs21a:~ # 


The first three failures are already being worked by "Liubo":
http://marc.info/?l=ltp-list&m=126683033423523&w=2


Please let us know which one you are willing to take. 

Thanks
Rishi

On Mon, Feb 22, 2010 at 10:11:56AM -0700, Murlin Wenzel wrote:
> I've lost track of which test cases currently have issues.  These are the failures from running ltplite on January interim build.  Could someone give me a quick idea which cases are known issues and which ones I need to investigate further.  These were from system with 2.6.32-7 kernel.
> 
> Thanks
> Murlin
> 


> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

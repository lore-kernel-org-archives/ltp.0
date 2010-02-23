Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1Nk1WV-0006ut-I5
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 20:38:27 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nk1WU-00020f-1n
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 20:38:27 +0000
Message-Id: <4B83DA48020000E80005EDDC@sinclair.provo.novell.com>
Date: Tue, 23 Feb 2010 13:38:16 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <4B82586C020000E80005EC9E@sinclair.provo.novell.com>
	<20100223043117.GA11102@linux.vnet.ibm.com>
In-Reply-To: <20100223043117.GA11102@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

>>> On 2/22/2010 at 09:31 PM, in message
<20100223043117.GA11102@linux.vnet.ibm.com>, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote: 
> Hi Murlin,
> 
> Thanks for taking interest into it. Here are the current failure which i ran 
> on
> 2.6.32-7 kerenl with feb'10 interim release.
> 
> mhs21a:~ # cat /tmp/result-log.12258 | grep FAIL
> rt_sigaction01                 FAIL       11   
> rt_sigprocmask01               FAIL       11   
> rt_sigsuspend01                FAIL       11   
> swapon03                       FAIL       1    
> utimensat01                    FAIL       1    
> proc01                         FAIL       1    
> Containers                     FAIL       1    
> mhs21a:~ # 
> 
> 
> The first three failures are already being worked by "Liubo":
> http://marc.info/?l=ltp-list&m=126683033423523&w=2
> 
> 
> Please let us know which one you are willing to take. 

With the Feb interim build, I can 'runltp' with the ltplite command file and I only get the swapon03 failure so I'm looking at that one.  I don't know the code that well, but so far it looks like the maximum number of swap files supported is less than expected or defined.  The test fails on swapfile30 which should only be 29 counting the actual swap device.  There is also a bug in the cleanup code where all the existing swap files are not being deactivated before being deleted.  You only get one chance to run the test, then you have to re-boot to clean everything up.

Murlin


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

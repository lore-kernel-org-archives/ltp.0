Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1Npkcn-0007aO-75
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 15:48:37 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Npkcm-00065O-8f
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 15:48:37 +0000
Message-Id: <4B98AE5B020000E80005FC3D@sinclair.provo.novell.com>
Date: Thu, 11 Mar 2010 08:48:27 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
	<20100225062615.GB3377@linux.vnet.ibm.com>
	<20100310121544.GB11404@linux.vnet.ibm.com>
In-Reply-To: <20100310121544.GB11404@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: Re: [LTP] [patch] swapon03 cleanup v2
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
To: Garrett Cooper <yanegomi@gmail.com>, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net

>>> On 3/10/2010 at 05:15 AM, in message
<20100310121544.GB11404@linux.vnet.ibm.com>, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote: 
> On Thu, Feb 25, 2010 at 11:56:15AM +0530, Rishikesh K Rajak wrote:
>> On Wed, Feb 24, 2010 at 05:08:56PM -0800, Garrett Cooper wrote:
>> > On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
>> > > Added clean_swap() to cleanup routine.  This makes sure all leftover swap 
> files are removed.
>> > >
>> > > Signed-off-By:  Murlin Ray Wenzel mwenzel@novell.com
>> > 
>> > Committed -- thanks!
>> > -Garrett
>> 
>> Thanks Garret & Murlin.
> 
> 
> Hi Murlin,
> 
> can you please look into this failure as it still fails on my SLES11 & 
> RHEl5.4
> boxes.
> 
> [root@mx3455a bin]# ./swapon03 
> swapon03    1  TFAIL  :  Failed swapon for file swapfile29: errno=EPERM(1):
> Operation not permitted
> swapon03    0  TWARN  :  tst_rmdir(): rmobj(/tmp/swasf2sLb) failed:
> unlink(/tmp/swasf2sLb/swapfile22) failed; errno=1: Operation not permitted
> swapon03    1  TFAIL  :  Failed to setup swaps
> 
> attached is the strace log.
> 
> -Rishi


That's the other part of the problem that I'm not sure what to do with yet.  The original test was written entirely based on the assumption that there were always a max of 30 swap files available.  With newer kernels (SLE11 RHEL5.4) the kernel can be configured so that the max could be as low as 29 if not 28.  The kernel is doing the right thing returning EPERM, but the test needs to be re-worked to deal with new maximum limits/possibilites.

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

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1NxLFE-00087M-MA
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 14:19:40 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NxLFC-0002Xl-BZ
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 14:19:40 +0000
Message-Id: <4BB45713020000E800060EEC@sinclair.provo.novell.com>
Date: Thu, 01 Apr 2010 08:19:31 -0600
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
	<20100225062615.GB3377@linux.vnet.ibm.com>
	<20100310121544.GB11404@linux.vnet.ibm.com>
	<4B98AE5B020000E80005FC3D@sinclair.provo.novell.com>
	<364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>
	<4B9B684F020000E80005FE67@sinclair.provo.novell.com>
	<364299f41003131356p3ac589b0mcc0ffe22d8e3ec18@mail.gmail.com>
	<20100331092225.GB5048@linux.vnet.ibm.com>
In-Reply-To: <20100331092225.GB5048@linux.vnet.ibm.com>
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

>>> On 3/31/2010 at 03:22 AM, in message
<20100331092225.GB5048@linux.vnet.ibm.com>, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote: 
> Hi Murlin,
> 
> Can you please look into this problem again ? It seems you had some 
> discussion
> with garret to reach to some conclusion about the reported failure.
>

I'm trying to get back to it, but have been swamped with work right now.  The inherent problem is the fact that the test is based on a macro used during kernel build/compile time which was hard coded at one point in time.  The maximum number of swap files supported can vary based on kernel compile time switches.  I really don't think we want to try and build a kernel module or try to build the test assuming kernel headers and complete config are always available.
 
> -Rishi
> 
> On Sat, Mar 13, 2010 at 01:56:25PM -0800, Garrett Cooper wrote:
>> On Sat, Mar 13, 2010 at 9:26 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
>> >>>> On 3/13/2010 at 12:32 AM, in message
>> > <364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>, Garrett Cooper
>> > <yanegomi@gmail.com> wrote:
>> >> On Thu, Mar 11, 2010 at 7:48 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
>> >>>>>> On 3/10/2010 at 05:15 AM, in message
>> >>> <20100310121544.GB11404@linux.vnet.ibm.com>, Rishikesh K Rajak
>> >>> <risrajak@linux.vnet.ibm.com> wrote:
>> >>>> On Thu, Feb 25, 2010 at 11:56:15AM +0530, Rishikesh K Rajak wrote:
>> >>>>> On Wed, Feb 24, 2010 at 05:08:56PM -0800, Garrett Cooper wrote:
>> >>>>> > On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
>> >>>>> > > Added clean_swap() to cleanup routine.  This makes sure all leftover swap
>> >>>> files are removed.
>> >>>>> > >
>> >>>>> > > Signed-off-By:  Murlin Ray Wenzel mwenzel@novell.com
>> >>>>> >
>> >>>>> > Committed -- thanks!
>> >>>>> > -Garrett
>> >>>>>
>> >>>>> Thanks Garret & Murlin.
>> >>>>
>> >>>>
>> >>>> Hi Murlin,
>> >>>>
>> >>>> can you please look into this failure as it still fails on my SLES11 &
>> >>>> RHEl5.4
>> >>>> boxes.
>> >>>>
>> >>>> [root@mx3455a bin]# ./swapon03
>> >>>> swapon03    1  TFAIL  :  Failed swapon for file swapfile29: errno=EPERM(1):
>> >>>> Operation not permitted
>> >>>> swapon03    0  TWARN  :  tst_rmdir(): rmobj(/tmp/swasf2sLb) failed:
>> >>>> unlink(/tmp/swasf2sLb/swapfile22) failed; errno=1: Operation not permitted
>> >>>> swapon03    1  TFAIL  :  Failed to setup swaps
>> >>>>
>> >>>> attached is the strace log.
>> >>>
>> >>> That's the other part of the problem that I'm not sure what to do with yet.
>> >> The original test was written entirely based on the assumption that there
>> >> were always a max of 30 swap files available.  With newer kernels (SLE11
>> >> RHEL5.4) the kernel can be configured so that the max could be as low as 29
>> >> if not 28.  The kernel is doing the right thing returning EPERM, but the 
> test
>> >> needs to be re-worked to deal with new maximum limits/possibilites.
>> >>
>> >> It should actually be KERNEL_MAX - (CONFIG_MIGRATION enabled ? 2 : 0)
>> >> - used_swap_devices ...
>> >>
>> >> NOTES
>> >>        The partition or path must be prepared with mkswap(8).
>> >>
>> >>        There is an upper limit on the number of swap files that may  be
>> >> used,
>> >>        defined  by  the  kernel constant MAX_SWAPFILES.  Before kernel
>> >> 2.4.10,
>> >>        MAX_SWAPFILES has the value 8; since kernel 2.4.10, it  has  the
>> >> value
>> >>        32.  Since kernel 2.6.18, the limit is decreased by 2 (thus: 30) if
>> >> the
>> >>        kernel is built with the CONFIG_MIGRATION option  (which  reserves
>> >> two
>> >>        swap  table  entries  for  the  page migration features of mbind(2)
>> >> and
>> >>        migrate_pages(2)).
>> >>
>> >>     The fun unknown is CONFIG_MIGRATION -- how do you know whether or
>> >> not this is set from userspace? There's too much handwaving in this
>> >> testcase that needs to be fixed.
>> >
>> > That's my point.  There are even more config options in newer kernels which 
> affect the number of swap files.  AFAIK none of that info is available to 
> userspace app.  The only known is MAX_SWAPFILES which is 32, or 8 on 2.4 
> kernels.  The current test makes an assumption that there would always be 32 
> or 30 swapfiles available based on a kernel config at some point in the past. 
>  I'm thinking the test should just use MAX_SWAPFILES(32 in this case), try to 
> create that many until EPERM error is returned, provide that TINFO to tester, 
> clean up everything and if that succeeds call the test a pass.  It is too 
> ugly trying to start guessing about is 29 ok, or 30 ok or 32 ok with no way 
> of knowing how the kernel was configured.
>> 
>>     Here's a good question: where is this information stored in the
>> kernel? If we can create an ltp test module to export some of this
>> data [and extend it to other reporting as necessary] via sysfs
>> STRICTLY for testing, it would help determinism a lot.
>> Thanks,
>> -Garrett




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

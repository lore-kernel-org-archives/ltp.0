Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nwu8C-0005mo-9W
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 09:22:36 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nwu8A-0001fK-Ts
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 09:22:36 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2V9FmT5024759
	for <ltp-list@lists.sourceforge.net>; Wed, 31 Mar 2010 03:15:48 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o2V9MT50264602
	for <ltp-list@lists.sourceforge.net>; Wed, 31 Mar 2010 03:22:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2V9MTJC001336
	for <ltp-list@lists.sourceforge.net>; Wed, 31 Mar 2010 03:22:29 -0600
Date: Wed, 31 Mar 2010 14:52:25 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100331092225.GB5048@linux.vnet.ibm.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
	<20100225062615.GB3377@linux.vnet.ibm.com>
	<20100310121544.GB11404@linux.vnet.ibm.com>
	<4B98AE5B020000E80005FC3D@sinclair.provo.novell.com>
	<364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>
	<4B9B684F020000E80005FE67@sinclair.provo.novell.com>
	<364299f41003131356p3ac589b0mcc0ffe22d8e3ec18@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41003131356p3ac589b0mcc0ffe22d8e3ec18@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list@lists.sourceforge.net

Hi Murlin,

Can you please look into this problem again ? It seems you had some discuss=
ion
with garret to reach to some conclusion about the reported failure.

-Rishi

On Sat, Mar 13, 2010 at 01:56:25PM -0800, Garrett Cooper wrote:
> On Sat, Mar 13, 2010 at 9:26 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
> >>>> On 3/13/2010 at 12:32 AM, in message
> > <364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>, Garrett =
Cooper
> > <yanegomi@gmail.com> wrote:
> >> On Thu, Mar 11, 2010 at 7:48 AM, Murlin Wenzel <mwenzel@novell.com> wr=
ote:
> >>>>>> On 3/10/2010 at 05:15 AM, in message
> >>> <20100310121544.GB11404@linux.vnet.ibm.com>, Rishikesh K Rajak
> >>> <risrajak@linux.vnet.ibm.com> wrote:
> >>>> On Thu, Feb 25, 2010 at 11:56:15AM +0530, Rishikesh K Rajak wrote:
> >>>>> On Wed, Feb 24, 2010 at 05:08:56PM -0800, Garrett Cooper wrote:
> >>>>> > On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.co=
m> wrote:
> >>>>> > > Added clean_swap() to cleanup routine. =A0This makes sure all l=
eftover swap
> >>>> files are removed.
> >>>>> > >
> >>>>> > > Signed-off-By: =A0Murlin Ray Wenzel mwenzel@novell.com
> >>>>> >
> >>>>> > Committed -- thanks!
> >>>>> > -Garrett
> >>>>>
> >>>>> Thanks Garret & Murlin.
> >>>>
> >>>>
> >>>> Hi Murlin,
> >>>>
> >>>> can you please look into this failure as it still fails on my SLES11=
 &
> >>>> RHEl5.4
> >>>> boxes.
> >>>>
> >>>> [root@mx3455a bin]# ./swapon03
> >>>> swapon03 =A0 =A01 =A0TFAIL =A0: =A0Failed swapon for file swapfile29=
: errno=3DEPERM(1):
> >>>> Operation not permitted
> >>>> swapon03 =A0 =A00 =A0TWARN =A0: =A0tst_rmdir(): rmobj(/tmp/swasf2sLb=
) failed:
> >>>> unlink(/tmp/swasf2sLb/swapfile22) failed; errno=3D1: Operation not p=
ermitted
> >>>> swapon03 =A0 =A01 =A0TFAIL =A0: =A0Failed to setup swaps
> >>>>
> >>>> attached is the strace log.
> >>>
> >>> That's the other part of the problem that I'm not sure what to do wit=
h yet.
> >> The original test was written entirely based on the assumption that th=
ere
> >> were always a max of 30 swap files available. =A0With newer kernels (S=
LE11
> >> RHEL5.4) the kernel can be configured so that the max could be as low =
as 29
> >> if not 28. =A0The kernel is doing the right thing returning EPERM, but=
 the test
> >> needs to be re-worked to deal with new maximum limits/possibilites.
> >>
> >> It should actually be KERNEL_MAX - (CONFIG_MIGRATION enabled ? 2 : 0)
> >> - used_swap_devices ...
> >>
> >> NOTES
> >> =A0 =A0 =A0 =A0The partition or path must be prepared with mkswap(8).
> >>
> >> =A0 =A0 =A0 =A0There is an upper limit on the number of swap files tha=
t may =A0be
> >> used,
> >> =A0 =A0 =A0 =A0defined =A0by =A0the =A0kernel constant MAX_SWAPFILES. =
=A0Before kernel
> >> 2.4.10,
> >> =A0 =A0 =A0 =A0MAX_SWAPFILES has the value 8; since kernel 2.4.10, it =
=A0has =A0the
> >> value
> >> =A0 =A0 =A0 =A032. =A0Since kernel 2.6.18, the limit is decreased by 2=
 (thus: 30) if
> >> the
> >> =A0 =A0 =A0 =A0kernel is built with the CONFIG_MIGRATION option =A0(wh=
ich =A0reserves
> >> two
> >> =A0 =A0 =A0 =A0swap =A0table =A0entries =A0for =A0the =A0page migratio=
n features of mbind(2)
> >> and
> >> =A0 =A0 =A0 =A0migrate_pages(2)).
> >>
> >> =A0 =A0 The fun unknown is CONFIG_MIGRATION -- how do you know whether=
 or
> >> not this is set from userspace? There's too much handwaving in this
> >> testcase that needs to be fixed.
> >
> > That's my point. =A0There are even more config options in newer kernels=
 which affect the number of swap files. =A0AFAIK none of that info is avail=
able to userspace app. =A0The only known is MAX_SWAPFILES which is 32, or 8=
 on 2.4 kernels. =A0The current test makes an assumption that there would a=
lways be 32 or 30 swapfiles available based on a kernel config at some poin=
t in the past. =A0I'm thinking the test should just use MAX_SWAPFILES(32 in=
 this case), try to create that many until EPERM error is returned, provide=
 that TINFO to tester, clean up everything and if that succeeds call the te=
st a pass. =A0It is too ugly trying to start guessing about is 29 ok, or 30=
 ok or 32 ok with no way of knowing how the kernel was configured.
> =

>     Here's a good question: where is this information stored in the
> kernel? If we can create an ltp test module to export some of this
> data [and extend it to other reporting as necessary] via sysfs
> STRICTLY for testing, it would help determinism a lot.
> Thanks,
> -Garrett

-- =

Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NqLq1-00058p-Sj
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 07:32:45 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NqLq1-00085t-7M
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 07:32:45 +0000
Received: by iwn6 with SMTP id 6so406562iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Mar 2010 23:32:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B98AE5B020000E80005FC3D@sinclair.provo.novell.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
	<20100225062615.GB3377@linux.vnet.ibm.com>
	<20100310121544.GB11404@linux.vnet.ibm.com>
	<4B98AE5B020000E80005FC3D@sinclair.provo.novell.com>
Date: Fri, 12 Mar 2010 23:32:39 -0800
Message-ID: <364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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

On Thu, Mar 11, 2010 at 7:48 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>> On 3/10/2010 at 05:15 AM, in message
> <20100310121544.GB11404@linux.vnet.ibm.com>, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
>> On Thu, Feb 25, 2010 at 11:56:15AM +0530, Rishikesh K Rajak wrote:
>>> On Wed, Feb 24, 2010 at 05:08:56PM -0800, Garrett Cooper wrote:
>>> > On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.com> w=
rote:
>>> > > Added clean_swap() to cleanup routine. =A0This makes sure all lefto=
ver swap
>> files are removed.
>>> > >
>>> > > Signed-off-By: =A0Murlin Ray Wenzel mwenzel@novell.com
>>> >
>>> > Committed -- thanks!
>>> > -Garrett
>>>
>>> Thanks Garret & Murlin.
>>
>>
>> Hi Murlin,
>>
>> can you please look into this failure as it still fails on my SLES11 &
>> RHEl5.4
>> boxes.
>>
>> [root@mx3455a bin]# ./swapon03
>> swapon03 =A0 =A01 =A0TFAIL =A0: =A0Failed swapon for file swapfile29: er=
rno=3DEPERM(1):
>> Operation not permitted
>> swapon03 =A0 =A00 =A0TWARN =A0: =A0tst_rmdir(): rmobj(/tmp/swasf2sLb) fa=
iled:
>> unlink(/tmp/swasf2sLb/swapfile22) failed; errno=3D1: Operation not permi=
tted
>> swapon03 =A0 =A01 =A0TFAIL =A0: =A0Failed to setup swaps
>>
>> attached is the strace log.
>
> That's the other part of the problem that I'm not sure what to do with ye=
t. =A0The original test was written entirely based on the assumption that t=
here were always a max of 30 swap files available. =A0With newer kernels (S=
LE11 RHEL5.4) the kernel can be configured so that the max could be as low =
as 29 if not 28. =A0The kernel is doing the right thing returning EPERM, bu=
t the test needs to be re-worked to deal with new maximum limits/possibilit=
es.

It should actually be KERNEL_MAX - (CONFIG_MIGRATION enabled ? 2 : 0)
- used_swap_devices ...

NOTES
       The partition or path must be prepared with mkswap(8).

       There is an upper limit on the number of swap files that may  be  us=
ed,
       defined  by  the  kernel constant MAX_SWAPFILES.  Before kernel 2.4.=
10,
       MAX_SWAPFILES has the value 8; since kernel 2.4.10, it  has  the  va=
lue
       32.  Since kernel 2.6.18, the limit is decreased by 2 (thus: 30) if =
the
       kernel is built with the CONFIG_MIGRATION option  (which  reserves  =
two
       swap  table  entries  for  the  page migration features of mbind(2) =
and
       migrate_pages(2)).

    The fun unknown is CONFIG_MIGRATION -- how do you know whether or
not this is set from userspace? There's too much handwaving in this
testcase that needs to be fixed.
Thanks,
-Garrett

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

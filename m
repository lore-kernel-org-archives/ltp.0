Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NguTc-0002BT-Uo
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 06:30:36 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NguTc-00027Z-1h
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 06:30:36 +0000
Received: by pzk9 with SMTP id 9so2887686pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Feb 2010 22:30:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100215055102.GA21277@rishikesh.in.ibm.com>
References: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
	<4B6FA757.2010309@linux.vnet.ibm.com>
	<5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com>
	<4B6FBD49.6050605@linux.vnet.ibm.com>
	<5a774f4c1002141937n4eb1033bx3c64ed5618869716@mail.gmail.com>
	<20100215055102.GA21277@rishikesh.in.ibm.com>
Date: Sun, 14 Feb 2010 22:30:30 -0800
Message-ID: <364299f41002142230q1b12fbf4oe4f4ee978770c59b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] about "hugetlbshmget03"
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Feb 14, 2010 at 9:51 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Mon, Feb 15, 2010 at 11:37:03AM +0800, shenghui wrote:
>> 2010/2/8 Rishikesh <risrajak@linux.vnet.ibm.com>
>>
>> > Hi Rishi,
>> >
>> > =A0 =A0 =A0 =A0Please refer to the following for my error info. And wi=
ll you please
>> > try it on your workstation and send me
>> > your result?
>> >
>> > Hi Shengui,
>> >
>> > Yes i am also facing this different issue on my TP. Let me investigate=
 more
>> > on that. Meanwhile if you know the solution can you please post your t=
hought
>> > on this problem ?
>> >
>> > Thanks
>> > Rishi
>> >
>> >
>> >
>> > =A0 =A0 =A0 =A0Thanks!
>> >
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> >
>> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-2010=
0119/testcases/kernel/mem/hugetlb/hugeshmget#
>> > ls
>> > hugeshmget01 =A0 =A0hugeshmget02 =A0 =A0hugeshmget03 =A0 =A0hugeshmget=
05 =A0 =A0Makefile
>> > hugeshmget01.c =A0hugeshmget02.c =A0hugeshmget03.c =A0hugeshmget05.c
>> >
>> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-2010=
0119/testcases/kernel/mem/hugetlb/hugeshmget#
>> > echo 10 > /proc/sys/vm/nr_hugepages
>> >
>> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-2010=
0119/testcases/kernel/mem/hugetlb/hugeshmget#
>> > cat /proc/meminfo
>> > MemTotal: =A0 =A0 =A0 =A04048440 kB
>> > MemFree: =A0 =A0 =A0 =A0 1576656 kB
>> > Buffers: =A0 =A0 =A0 =A0 =A0122652 kB
>> > Cached: =A0 =A0 =A0 =A0 =A01487772 kB
>> > SwapCached: =A0 =A0 =A0 =A0 =A0 =A00 kB
>> > Active: =A0 =A0 =A0 =A0 =A01225860 kB
>> > Inactive: =A0 =A0 =A0 =A01043268 kB
>> > Active(anon): =A0 =A0 684228 kB
>> > Inactive(anon): =A0 =A0 =A0 16 kB
>> > Active(file): =A0 =A0 541632 kB
>> > Inactive(file): =A01043252 kB
>> > Unevictable: =A0 =A0 =A0 =A0 =A0 0 kB
>> > Mlocked: =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
>> > HighTotal: =A0 =A0 =A0 3211696 kB
>> > HighFree: =A0 =A0 =A0 =A01044060 kB
>> > LowTotal: =A0 =A0 =A0 =A0 836744 kB
>> > LowFree: =A0 =A0 =A0 =A0 =A0532596 kB
>> > SwapTotal: =A0 =A0 =A0 3903752 kB
>> > SwapFree: =A0 =A0 =A0 =A03903752 kB
>> > Dirty: =A0 =A0 =A0 =A0 =A0 =A0 =A0 204 kB
>> > Writeback: =A0 =A0 =A0 =A0 =A0 =A0 0 kB
>> > AnonPages: =A0 =A0 =A0 =A0658692 kB
>> > Mapped: =A0 =A0 =A0 =A0 =A0 239928 kB
>> > Slab: =A0 =A0 =A0 =A0 =A0 =A0 109460 kB
>> > SReclaimable: =A0 =A0 =A093676 kB
>> > SUnreclaim: =A0 =A0 =A0 =A015784 kB
>> > PageTables: =A0 =A0 =A0 =A0 8332 kB
>> > NFS_Unstable: =A0 =A0 =A0 =A0 =A00 kB
>> > Bounce: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
>> > WritebackTmp: =A0 =A0 =A0 =A0 =A00 kB
>> > CommitLimit: =A0 =A0 5917732 kB
>> > Committed_AS: =A0 =A01389392 kB
>> > VmallocTotal: =A0 =A0 122880 kB
>> > VmallocUsed: =A0 =A0 =A0 44644 kB
>> > VmallocChunk: =A0 =A0 =A075956 kB
>> > HugePages_Total: =A0 =A0 =A010
>> > HugePages_Free: =A0 =A0 =A0 10
>> > HugePages_Rsvd: =A0 =A0 =A0 =A00
>> > HugePages_Surp: =A0 =A0 =A0 =A00
>> > Hugepagesize: =A0 =A0 =A0 2048 kB
>> > DirectMap4k: =A0 =A0 =A0 =A08184 kB
>> > DirectMap2M: =A0 =A0 =A0903168 kB
>> >
>> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-2010=
0119/testcases/kernel/mem/hugetlb/hugeshmget#
>> > ./hugeshmget03
>> > hugeshmget03 =A0 =A00 =A0TINFO =A0: =A0errno =3D 12 : Cannot allocate =
memory
>> > hugeshmget03 =A0 =A01 =A0TBROK =A0: =A0Didn't get ENOSPC in test setup
>> >
>> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-2010=
0119/testcases/kernel/mem/hugetlb/hugeshmget#
>> > echo 32 > /proc/sys/vm/nr_hugepages
>> >
>> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-2010=
0119/testcases/kernel/mem/hugetlb/hugeshmget#
>> > ./hugeshmget03
>> > hugeshmget03 =A0 =A00 =A0TINFO =A0: =A0errno =3D 12 : Cannot allocate =
memory
>> > hugeshmget03 =A0 =A01 =A0TBROK =A0: =A0Didn't get ENOSPC in test setup
>> >
>> >
>> > --
>> >
>> >
>> > Thanks and Best Regards,
>> > shenghui
>> >
>> >
>> >
>> Hi Rishi,
>>
>> =A0 =A0 =A0 I found hugetlbshmget01 has the same problem. Seems we need =
do
>> further investigation on these two programs. :)
>
> Hi Shenghui,
> Sure i will have a look into it soon.
> Thanks
> Rishi

    If the issue isn't supposedly with the running system, please keep
in mind that if the developers are the same in the testcases, odds are
more than likely it's either a) library code, or b) copy-pasted code
(hopefully it's not the latter case, but there's a large amount of
code like that in the tree).
    I know it's not extremely helpful at first glance, but that's the
usual case if you can get a fix to work with one testcase, and others
need fixing...
HTH,
-Garrett

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

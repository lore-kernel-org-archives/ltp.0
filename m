Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NeQLz-0000JF-41
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 09:56:27 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NeQLy-0006gb-9J
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 09:56:27 +0000
Received: by mail-pz0-f199.google.com with SMTP id 37so3987870pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Feb 2010 01:56:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5a774f4c1002080055o36ee92f5te92a1c67f26856d@mail.gmail.com>
References: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
	<4B6FA757.2010309@linux.vnet.ibm.com>
	<5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com>
	<4B6FBD49.6050605@linux.vnet.ibm.com>
	<5a774f4c1002080055o36ee92f5te92a1c67f26856d@mail.gmail.com>
Date: Mon, 8 Feb 2010 01:56:25 -0800
Message-ID: <364299f41002080156y18cc4f11r5641943bc2cc7677@mail.gmail.com>
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
To: shenghui <crosslonelyover@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Feb 8, 2010 at 12:55 AM, shenghui <crosslonelyover@gmail.com> wrote:
>
>
> 2010/2/8 Rishikesh <risrajak@linux.vnet.ibm.com>
>>
>> On 02/08/2010 12:32 PM, shenghui wrote:
>>
>> 2010/2/8 Rishikesh <risrajak@linux.vnet.ibm.com>
>>>
>>> On 02/06/2010 09:04 PM, shenghui wrote:
>>>
>>> Hi all,
>>>
>>> =A0=A0=A0=A0=A0=A0 I want to know how to run hugetlbshmget03? Does it n=
eed some
>>> arguments?
>>> For I have run it several times, always got error "NOMEM" for cannot get
>>> hugetlb
>>> page. But "cat /proc/meminfo" shows that free hugetlb pages are enough
>>> for its
>>> request.
>>> =A0=A0=A0=A0=A0=A0 Does anyone know how to handle this problem?
>>>
>>> Hi Shenghui,
>>>
>>> Have you run this testcase after setting up nr_hugepages ? You need to
>>> set the pages accordingly and then you need to run the testcase.
>>>
>>> e.g:
>>>
>>> echo 10 > /proc/sys/vm/nr_hugepages
>>>
>>> Please post your result if you still finding issue.
>>>
>>> Thanks
>>> Rishi
>>>
>>>
>>> --
>>>
>>>
>>> Thanks and Best Regards,
>>> shenghui
>>>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> The Planet: dedicated and managed hosting, cloud storage, colocation
>>> Stay online with enterprise data centers and the best network in the
>>> business
>>> Choose flexible plans and management services without long-term contrac=
ts
>>> Personal 24x7 support from experience hosting pros just a phone call
>>> away.
>>> http://p.sf.net/sfu/theplanet-com
>>>
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>
>>
>> Hi Rishi,
>>
>> =A0=A0=A0=A0=A0=A0 Please refer to the following for my error info. And =
will you
>> please try it on your workstation and send me
>> your result?
>>
>> Hi Shengui,
>>
>> Yes i am also facing this different issue on my TP. Let me investigate
>> more on that. Meanwhile if you know the solution can you please post your
>> thought on this problem ?
>>
>> Thanks
>> Rishi
>>
>>
>> =A0=A0=A0=A0=A0=A0 Thanks!
>>
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>
>>
>> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-201001=
19/testcases/kernel/mem/hugetlb/hugeshmget#
>> ls
>> hugeshmget01=A0=A0=A0 hugeshmget02=A0=A0=A0 hugeshmget03=A0=A0=A0 hugesh=
mget05=A0=A0=A0 Makefile
>> hugeshmget01.c=A0 hugeshmget02.c=A0 hugeshmget03.c=A0 hugeshmget05.c
>>
>>
>> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-201001=
19/testcases/kernel/mem/hugetlb/hugeshmget#
>> echo 10 > /proc/sys/vm/nr_hugepages
>>
>>
>> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-201001=
19/testcases/kernel/mem/hugetlb/hugeshmget#
>> cat /proc/meminfo
>> MemTotal:=A0=A0=A0=A0=A0=A0=A0 4048440 kB
>> MemFree:=A0=A0=A0=A0=A0=A0=A0=A0 1576656 kB
>> Buffers:=A0=A0=A0=A0=A0=A0=A0=A0=A0 122652 kB
>> Cached:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1487772 kB
>> SwapCached:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB
>> Active:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1225860 kB
>> Inactive:=A0=A0=A0=A0=A0=A0=A0 1043268 kB
>> Active(anon):=A0=A0=A0=A0 684228 kB
>> Inactive(anon):=A0=A0=A0=A0=A0=A0 16 kB
>> Active(file):=A0=A0=A0=A0 541632 kB
>> Inactive(file):=A0 1043252 kB
>> Unevictable:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB
>> Mlocked:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB
>> HighTotal:=A0=A0=A0=A0=A0=A0 3211696 kB
>> HighFree:=A0=A0=A0=A0=A0=A0=A0 1044060 kB
>> LowTotal:=A0=A0=A0=A0=A0=A0=A0=A0 836744 kB
>> LowFree:=A0=A0=A0=A0=A0=A0=A0=A0=A0 532596 kB
>> SwapTotal:=A0=A0=A0=A0=A0=A0 3903752 kB
>> SwapFree:=A0=A0=A0=A0=A0=A0=A0 3903752 kB
>> Dirty:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 204 kB
>> Writeback:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB
>> AnonPages:=A0=A0=A0=A0=A0=A0=A0 658692 kB
>> Mapped:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 239928 kB
>> Slab:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 109460 kB
>> SReclaimable:=A0=A0=A0=A0=A0 93676 kB
>> SUnreclaim:=A0=A0=A0=A0=A0=A0=A0 15784 kB
>> PageTables:=A0=A0=A0=A0=A0=A0=A0=A0 8332 kB
>> NFS_Unstable:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB
>> Bounce:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB
>> WritebackTmp:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB
>> CommitLimit:=A0=A0=A0=A0 5917732 kB
>> Committed_AS:=A0=A0=A0 1389392 kB
>> VmallocTotal:=A0=A0=A0=A0 122880 kB
>> VmallocUsed:=A0=A0=A0=A0=A0=A0 44644 kB
>> VmallocChunk:=A0=A0=A0=A0=A0 75956 kB
>> HugePages_Total:=A0=A0=A0=A0=A0 10
>> HugePages_Free:=A0=A0=A0=A0=A0=A0 10
>> HugePages_Rsvd:=A0=A0=A0=A0=A0=A0=A0 0
>> HugePages_Surp:=A0=A0=A0=A0=A0=A0=A0 0
>> Hugepagesize:=A0=A0=A0=A0=A0=A0 2048 kB
>> DirectMap4k:=A0=A0=A0=A0=A0=A0=A0 8184 kB
>> DirectMap2M:=A0=A0=A0=A0=A0 903168 kB
>>
>>
>> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-201001=
19/testcases/kernel/mem/hugetlb/hugeshmget#
>> ./hugeshmget03
>> hugeshmget03=A0=A0=A0 0=A0 TINFO=A0 :=A0 errno =3D 12 : Cannot allocate =
memory
>> hugeshmget03=A0=A0=A0 1=A0 TBROK=A0 :=A0 Didn't get ENOSPC in test setup
>>
>>
>> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-201001=
19/testcases/kernel/mem/hugetlb/hugeshmget#
>> echo 32 > /proc/sys/vm/nr_hugepages
>>
>>
>> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-201001=
19/testcases/kernel/mem/hugetlb/hugeshmget#
>> ./hugeshmget03
>> hugeshmget03=A0=A0=A0 0=A0 TINFO=A0 :=A0 errno =3D 12 : Cannot allocate =
memory
>> hugeshmget03=A0=A0=A0 1=A0 TBROK=A0 :=A0 Didn't get ENOSPC in test setup
>
> Sure.=A0 : )

    The some incorrect assumptions are being made as the test is
running out of allocatable memory when calling shmget:

#define ENOMEM          12      /* Out of memory */

#define ENOSPC          28      /* No space left on device */

    From shmget(2):

       ENOMEM No memory could be allocated for segment overhead.

       ENOSPC All possible shared memory IDs  have  been  taken  (SHMMNI), =
 or
              allocating  a segment of the requested size would cause the s=
ys-
              tem to exceed the system-wide limit on shared memory (SHMALL).

    I think this is the ultimate problem with the assumption being
made about the system:

/*
 * The MAXIDS value is somewhat arbitrary and may need to be increased
 * depending on the system being tested.
 */
#define MAXIDS  8192

    This means that 8192 * 1024 * 2048 =3D 16GB worth of hugepages are
required in order for the testcase to succeed. That's clearly wrong
for systems with less than that available memory, and most likely
won't even be true unless you have an excess of that available memory
on your running system.
    This value needs to be variable given the number of free available
hugepages as found in /proc/meminfo, i.e.

gcooper@orangebox /scratch/ltp $ grep HugePages /proc/meminfo
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0

    The testcase needs to be adjusted for this case, or at the very
least the maximum number of shared memory IDs need to be scooped up,
then one free'd, then allocated as a hugepage shared memory segment --
otherwise pulling this off would be impossible on standard systems.
HTH,
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

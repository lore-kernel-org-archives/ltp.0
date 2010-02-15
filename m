Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <crosslonelyover@gmail.com>) id 1Ngrlr-00066O-8J
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 03:37:15 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ngrlq-0000nA-7v
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 03:37:15 +0000
Received: by pxi28 with SMTP id 28so3026138pxi.7
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Feb 2010 19:37:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B6FBD49.6050605@linux.vnet.ibm.com>
References: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
	<4B6FA757.2010309@linux.vnet.ibm.com>
	<5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com>
	<4B6FBD49.6050605@linux.vnet.ibm.com>
Date: Mon, 15 Feb 2010 11:37:03 +0800
Message-ID: <5a774f4c1002141937n4eb1033bx3c64ed5618869716@mail.gmail.com>
From: shenghui <crosslonelyover@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7870449088342337032=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--===============7870449088342337032==
Content-Type: multipart/alternative; boundary=00504502e64d9efb16047f9b54e4

--00504502e64d9efb16047f9b54e4
Content-Type: text/plain; charset=ISO-8859-1

2010/2/8 Rishikesh <risrajak@linux.vnet.ibm.com>

>  On 02/08/2010 12:32 PM, shenghui wrote:
>
>
>
> 2010/2/8 Rishikesh <risrajak@linux.vnet.ibm.com>
>
>>  On 02/06/2010 09:04 PM, shenghui wrote:
>>
>> Hi all,
>>
>>        I want to know how to run hugetlbshmget03? Does it need some
>> arguments?
>> For I have run it several times, always got error "NOMEM" for cannot get
>> hugetlb
>> page. But "cat /proc/meminfo" shows that free hugetlb pages are enough for
>> its
>> request.
>>        Does anyone know how to handle this problem?
>>
>>  Hi Shenghui,
>>
>> Have you run this testcase after setting up nr_hugepages ? You need to set
>> the pages accordingly and then you need to run the testcase.
>>
>> e.g:
>>
>> echo 10 > /proc/sys/vm/nr_hugepages
>>
>> Please post your result if you still finding issue.
>>
>> Thanks
>> Rishi
>>
>>
>> --
>>
>>
>> Thanks and Best Regards,
>> shenghui
>>
>>
>> ------------------------------------------------------------------------------
>> The Planet: dedicated and managed hosting, cloud storage, colocation
>> Stay online with enterprise data centers and the best network in the business
>> Choose flexible plans and management services without long-term contracts
>> Personal 24x7 support from experience hosting pros just a phone call away.
>> http://p.sf.net/sfu/theplanet-com
>>
>>
>> _______________________________________________
>> Ltp-list mailing listLtp-list@lists.sourceforge.nethttps://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>>
>>
> Hi Rishi,
>
>        Please refer to the following for my error info. And will you please
> try it on your workstation and send me
> your result?
>
> Hi Shengui,
>
> Yes i am also facing this different issue on my TP. Let me investigate more
> on that. Meanwhile if you know the solution can you please post your thought
> on this problem ?
>
> Thanks
> Rishi
>
>
>
>        Thanks!
>
>
> ===============================================================================
>
> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> ls
> hugeshmget01    hugeshmget02    hugeshmget03    hugeshmget05    Makefile
> hugeshmget01.c  hugeshmget02.c  hugeshmget03.c  hugeshmget05.c
>
> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> echo 10 > /proc/sys/vm/nr_hugepages
>
> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> cat /proc/meminfo
> MemTotal:        4048440 kB
> MemFree:         1576656 kB
> Buffers:          122652 kB
> Cached:          1487772 kB
> SwapCached:            0 kB
> Active:          1225860 kB
> Inactive:        1043268 kB
> Active(anon):     684228 kB
> Inactive(anon):       16 kB
> Active(file):     541632 kB
> Inactive(file):  1043252 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> HighTotal:       3211696 kB
> HighFree:        1044060 kB
> LowTotal:         836744 kB
> LowFree:          532596 kB
> SwapTotal:       3903752 kB
> SwapFree:        3903752 kB
> Dirty:               204 kB
> Writeback:             0 kB
> AnonPages:        658692 kB
> Mapped:           239928 kB
> Slab:             109460 kB
> SReclaimable:      93676 kB
> SUnreclaim:        15784 kB
> PageTables:         8332 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:     5917732 kB
> Committed_AS:    1389392 kB
> VmallocTotal:     122880 kB
> VmallocUsed:       44644 kB
> VmallocChunk:      75956 kB
> HugePages_Total:      10
> HugePages_Free:       10
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> DirectMap4k:        8184 kB
> DirectMap2M:      903168 kB
>
> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> ./hugeshmget03
> hugeshmget03    0  TINFO  :  errno = 12 : Cannot allocate memory
> hugeshmget03    1  TBROK  :  Didn't get ENOSPC in test setup
>
> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> echo 32 > /proc/sys/vm/nr_hugepages
>
> root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> ./hugeshmget03
> hugeshmget03    0  TINFO  :  errno = 12 : Cannot allocate memory
> hugeshmget03    1  TBROK  :  Didn't get ENOSPC in test setup
>
>
> --
>
>
> Thanks and Best Regards,
> shenghui
>
>
>
Hi Rishi,

      I found hugetlbshmget01 has the same problem. Seems we need do
further investigation on these two programs. :)


-- 


Thanks and Best Regards,
shenghui

--00504502e64d9efb16047f9b54e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/2/8 Rishikesh <span dir=3D"ltr">&lt=
;<a href=3D"mailto:risrajak@linux.vnet.ibm.com">risrajak@linux.vnet.ibm.com=
</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">



 =20

<div text=3D"#000000" bgcolor=3D"#ffffff"><div><div></div><div class=3D"h5"=
>
On 02/08/2010 12:32 PM, shenghui wrote:
<blockquote type=3D"cite"><br>
  <br>
  <div class=3D"gmail_quote">2010/2/8 Rishikesh <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:risrajak@linux.vnet.ibm.com" target=3D"_blank">risrajak@linux.=
vnet.ibm.com</a>&gt;</span><br>
  <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
    <div text=3D"#000000" bgcolor=3D"#ffffff">
    <div>On 02/06/2010 09:04 PM, shenghui wrote:
    <blockquote type=3D"cite">Hi all,<br>
=A0<br>
=A0=A0=A0=A0=A0=A0 I want to know how to run hugetlbshmget03? Does it need =
some
arguments?<br>
For I have run it several times, always got error &quot;NOMEM&quot; for can=
not
get hugetlb<br>
page. But &quot;cat /proc/meminfo&quot; shows that free hugetlb pages are e=
nough
for its<br>
request.<br>
=A0=A0=A0=A0=A0=A0 Does anyone know how to handle this problem?<br clear=3D=
"all">
    </blockquote>
    </div>
Hi Shenghui,<br>
    <br>
Have you run this testcase after setting up nr_hugepages ? You need to
set the pages accordingly and then you need to run the testcase.<br>
    <br>
e.g:<br>
    <br>
echo 10 &gt; /proc/sys/vm/nr_hugepages<br>
    <br>
Please post your result if you still finding issue.<br>
    <br>
Thanks<br>
Rishi<br>
    <br>
    <blockquote type=3D"cite">
      <div><br>
-- <br>
      <br>
      <br>
Thanks and Best Regards,<br>
shenghui<br>
      </div>
      <pre><fieldset></fieldset>
---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
<div><a href=3D"http://p.sf.net/sfu/theplanet-com" target=3D"_blank">http:/=
/p.sf.net/sfu/theplanet-com</a></div></pre>
      <div>
      <pre><fieldset></fieldset>
_______________________________________________
Ltp-list mailing list
<a href=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank">Ltp-lis=
t@lists.sourceforge.net</a>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
      </div>
    </blockquote>
    <br>
    </div>
  </blockquote>
  </div>
  <br>
Hi Rishi,<br>
  <br>
=A0=A0=A0=A0=A0=A0 Please refer to the following for my error info. And wil=
l you
please try it on your workstation and send me <br>
your result?<br>
</blockquote></div></div>
Hi Shengui,<br>
<br>
Yes i am also facing this different issue on my TP. Let me investigate
more on that. Meanwhile if you know the solution can you please post
your thought on this problem ?<br>
<br>
Thanks<br>
Rishi<div><div></div><div class=3D"h5"><br>
<br>
<br>
<blockquote type=3D"cite">=A0=A0=A0=A0=A0=A0 Thanks!<br>
  <br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/=
testcases/kernel/mem/hugetlb/hugeshmget#
ls<br>
hugeshmget01=A0=A0=A0 hugeshmget02=A0=A0=A0 hugeshmget03=A0=A0=A0 hugeshmge=
t05=A0=A0=A0 Makefile<br>
hugeshmget01.c=A0 hugeshmget02.c=A0 hugeshmget03.c=A0 hugeshmget05.c<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/=
testcases/kernel/mem/hugetlb/hugeshmget#
echo 10 &gt; /proc/sys/vm/nr_hugepages<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/=
testcases/kernel/mem/hugetlb/hugeshmget#
cat /proc/meminfo <br>
MemTotal:=A0=A0=A0=A0=A0=A0=A0 4048440 kB<br>
MemFree:=A0=A0=A0=A0=A0=A0=A0=A0 1576656 kB<br>
Buffers:=A0=A0=A0=A0=A0=A0=A0=A0=A0 122652 kB<br>
Cached:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1487772 kB<br>
SwapCached:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>
Active:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1225860 kB<br>
Inactive:=A0=A0=A0=A0=A0=A0=A0 1043268 kB<br>
Active(anon):=A0=A0=A0=A0 684228 kB<br>
Inactive(anon):=A0=A0=A0=A0=A0=A0 16 kB<br>
Active(file):=A0=A0=A0=A0 541632 kB<br>
Inactive(file):=A0 1043252 kB<br>
Unevictable:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>
Mlocked:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>
HighTotal:=A0=A0=A0=A0=A0=A0 3211696 kB<br>
HighFree:=A0=A0=A0=A0=A0=A0=A0 1044060 kB<br>
LowTotal:=A0=A0=A0=A0=A0=A0=A0=A0 836744 kB<br>
LowFree:=A0=A0=A0=A0=A0=A0=A0=A0=A0 532596 kB<br>
SwapTotal:=A0=A0=A0=A0=A0=A0 3903752 kB<br>
SwapFree:=A0=A0=A0=A0=A0=A0=A0 3903752 kB<br>
Dirty:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 204 kB<br>
Writeback:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>
AnonPages:=A0=A0=A0=A0=A0=A0=A0 658692 kB<br>
Mapped:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 239928 kB<br>
Slab:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 109460 kB<br>
SReclaimable:=A0=A0=A0=A0=A0 93676 kB<br>
SUnreclaim:=A0=A0=A0=A0=A0=A0=A0 15784 kB<br>
PageTables:=A0=A0=A0=A0=A0=A0=A0=A0 8332 kB<br>
NFS_Unstable:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>
Bounce:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>
WritebackTmp:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 kB<br>
CommitLimit:=A0=A0=A0=A0 5917732 kB<br>
Committed_AS:=A0=A0=A0 1389392 kB<br>
VmallocTotal:=A0=A0=A0=A0 122880 kB<br>
VmallocUsed:=A0=A0=A0=A0=A0=A0 44644 kB<br>
VmallocChunk:=A0=A0=A0=A0=A0 75956 kB<br>
HugePages_Total:=A0=A0=A0=A0=A0 10<br>
HugePages_Free:=A0=A0=A0=A0=A0=A0 10<br>
HugePages_Rsvd:=A0=A0=A0=A0=A0=A0=A0 0<br>
HugePages_Surp:=A0=A0=A0=A0=A0=A0=A0 0<br>
Hugepagesize:=A0=A0=A0=A0=A0=A0 2048 kB<br>
DirectMap4k:=A0=A0=A0=A0=A0=A0=A0 8184 kB<br>
DirectMap2M:=A0=A0=A0=A0=A0 903168 kB<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/=
testcases/kernel/mem/hugetlb/hugeshmget#
./hugeshmget03<br>
hugeshmget03=A0=A0=A0 0=A0 TINFO=A0 :=A0 errno =3D 12 : Cannot allocate mem=
ory<br>
hugeshmget03=A0=A0=A0 1=A0 TBROK=A0 :=A0 Didn&#39;t get ENOSPC in test setu=
p<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/=
testcases/kernel/mem/hugetlb/hugeshmget#
echo 32 &gt; /proc/sys/vm/nr_hugepages<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/=
testcases/kernel/mem/hugetlb/hugeshmget#
./hugeshmget03<br>
hugeshmget03=A0=A0=A0 0=A0 TINFO=A0 :=A0 errno =3D 12 : Cannot allocate mem=
ory<br>
hugeshmget03=A0=A0=A0 1=A0 TBROK=A0 :=A0 Didn&#39;t get ENOSPC in test setu=
p<br>
  <br clear=3D"all">
  <br>
-- <br>
  <br>
  <br>
Thanks and Best Regards,<br>
shenghui<br>
</blockquote>
<br>
</div></div></div>

</blockquote></div><br>Hi Rishi,<br><br>=A0=A0=A0=A0=A0 I found hugetlbshmg=
et01 has the same problem. Seems we need do<br>further investigation on the=
se two programs. :)<br>
<br>
=A0=A0=A0=A0=A0 <br>-- <br><br><br>Thanks and Best Regards,<br>shenghui<br>

--00504502e64d9efb16047f9b54e4--


--===============7870449088342337032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============7870449088342337032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7870449088342337032==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NeO3r-0005aA-VQ
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 07:29:35 +0000
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NeO3q-0003le-98
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 07:29:35 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o187QGXv028131
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 18:26:16 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o187OBD21773782
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 18:24:11 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o187TFtH002504
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 18:29:16 +1100
Message-ID: <4B6FBD49.6050605@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2010 12:59:13 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
	<4B6FA757.2010309@linux.vnet.ibm.com>
	<5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com>
In-Reply-To: <5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============9140855421630374144=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: shenghui <crosslonelyover@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============9140855421630374144==
Content-Type: multipart/alternative;
	boundary="------------020900030605060604090207"

This is a multi-part message in MIME format.
--------------020900030605060604090207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2010 12:32 PM, shenghui wrote:
>
>
> 2010/2/8 Rishikesh <risrajak@linux.vnet.ibm.com 
> <mailto:risrajak@linux.vnet.ibm.com>>
>
>     On 02/06/2010 09:04 PM, shenghui wrote:
>>     Hi all,
>>
>>            I want to know how to run hugetlbshmget03? Does it need
>>     some arguments?
>>     For I have run it several times, always got error "NOMEM" for
>>     cannot get hugetlb
>>     page. But "cat /proc/meminfo" shows that free hugetlb pages are
>>     enough for its
>>     request.
>>            Does anyone know how to handle this problem?
>     Hi Shenghui,
>
>     Have you run this testcase after setting up nr_hugepages ? You
>     need to set the pages accordingly and then you need to run the
>     testcase.
>
>     e.g:
>
>     echo 10 > /proc/sys/vm/nr_hugepages
>
>     Please post your result if you still finding issue.
>
>     Thanks
>     Rishi
>
>>
>>     -- 
>>
>>
>>     Thanks and Best Regards,
>>     shenghui
>>
>>
>>     ------------------------------------------------------------------------------
>>     The Planet: dedicated and managed hosting, cloud storage, colocation
>>     Stay online with enterprise data centers and the best network in the business
>>     Choose flexible plans and management services without long-term contracts
>>     Personal 24x7 support from experience hosting pros just a phone call away.
>>     http://p.sf.net/sfu/theplanet-com
>>
>>
>>     _______________________________________________
>>     Ltp-list mailing list
>>     Ltp-list@lists.sourceforge.net  <mailto:Ltp-list@lists.sourceforge.net>
>>     https://lists.sourceforge.net/lists/listinfo/ltp-list
>>        
>
>
> Hi Rishi,
>
>        Please refer to the following for my error info. And will you 
> please try it on your workstation and send me
> your result?
Hi Shengui,

Yes i am also facing this different issue on my TP. Let me investigate 
more on that. Meanwhile if you know the solution can you please post 
your thought on this problem ?

Thanks
Rishi


>        Thanks!
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


--------------020900030605060604090207
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 02/08/2010 12:32 PM, shenghui wrote:
<blockquote
 cite="mid:5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com"
 type="cite"><br>
  <br>
  <div class="gmail_quote">2010/2/8 Rishikesh <span dir="ltr">&lt;<a
 moz-do-not-send="true" href="mailto:risrajak@linux.vnet.ibm.com">risrajak@linux.vnet.ibm.com</a>&gt;</span><br>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
    <div text="#000000" bgcolor="#ffffff">
    <div class="im">On 02/06/2010 09:04 PM, shenghui wrote:
    <blockquote type="cite">Hi all,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I want to know how to run hugetlbshmget03? Does it need some
arguments?<br>
For I have run it several times, always got error "NOMEM" for cannot
get hugetlb<br>
page. But "cat /proc/meminfo" shows that free hugetlb pages are enough
for its<br>
request.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Does anyone know how to handle this problem?<br clear="all">
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
    <blockquote type="cite">
      <div class="im"><br>
-- <br>
      <br>
      <br>
Thanks and Best Regards,<br>
shenghui<br>
      </div>
      <pre><fieldset></fieldset>
------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
<div class="im"><a moz-do-not-send="true"
 href="http://p.sf.net/sfu/theplanet-com" target="_blank">http://p.sf.net/sfu/theplanet-com</a></div></pre>
      <div class="im">
      <pre><fieldset></fieldset>
_______________________________________________
Ltp-list mailing list
<a moz-do-not-send="true" href="mailto:Ltp-list@lists.sourceforge.net"
 target="_blank">Ltp-list@lists.sourceforge.net</a>
<a moz-do-not-send="true"
 href="https://lists.sourceforge.net/lists/listinfo/ltp-list"
 target="_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Please refer to the following for my error info. And will you
please try it on your workstation and send me <br>
your result?<br>
</blockquote>
Hi Shengui,<br>
<br>
Yes i am also facing this different issue on my TP. Let me investigate
more on that. Meanwhile if you know the solution can you please post
your thought on this problem ?<br>
<br>
Thanks<br>
Rishi<br>
<br>
<br>
<blockquote
 cite="mid:5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com"
 type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks!<br>
  <br>
===============================================================================<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
ls<br>
hugeshmget01&nbsp;&nbsp;&nbsp; hugeshmget02&nbsp;&nbsp;&nbsp; hugeshmget03&nbsp;&nbsp;&nbsp; hugeshmget05&nbsp;&nbsp;&nbsp; Makefile<br>
hugeshmget01.c&nbsp; hugeshmget02.c&nbsp; hugeshmget03.c&nbsp; hugeshmget05.c<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
echo 10 &gt; /proc/sys/vm/nr_hugepages<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
cat /proc/meminfo <br>
MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4048440 kB<br>
MemFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1576656 kB<br>
Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 122652 kB<br>
Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1487772 kB<br>
SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1225860 kB<br>
Inactive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1043268 kB<br>
Active(anon):&nbsp;&nbsp;&nbsp;&nbsp; 684228 kB<br>
Inactive(anon):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 kB<br>
Active(file):&nbsp;&nbsp;&nbsp;&nbsp; 541632 kB<br>
Inactive(file):&nbsp; 1043252 kB<br>
Unevictable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
Mlocked:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
HighTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3211696 kB<br>
HighFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1044060 kB<br>
LowTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 836744 kB<br>
LowFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 532596 kB<br>
SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3903752 kB<br>
SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3903752 kB<br>
Dirty:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 204 kB<br>
Writeback:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
AnonPages:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 658692 kB<br>
Mapped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 239928 kB<br>
Slab:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 109460 kB<br>
SReclaimable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93676 kB<br>
SUnreclaim:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15784 kB<br>
PageTables:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8332 kB<br>
NFS_Unstable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
Bounce:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
WritebackTmp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
CommitLimit:&nbsp;&nbsp;&nbsp;&nbsp; 5917732 kB<br>
Committed_AS:&nbsp;&nbsp;&nbsp; 1389392 kB<br>
VmallocTotal:&nbsp;&nbsp;&nbsp;&nbsp; 122880 kB<br>
VmallocUsed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44644 kB<br>
VmallocChunk:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75956 kB<br>
HugePages_Total:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10<br>
HugePages_Free:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10<br>
HugePages_Rsvd:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
HugePages_Surp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
Hugepagesize:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2048 kB<br>
DirectMap4k:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8184 kB<br>
DirectMap2M:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 903168 kB<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
./hugeshmget03<br>
hugeshmget03&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; errno = 12 : Cannot allocate memory<br>
hugeshmget03&nbsp;&nbsp;&nbsp; 1&nbsp; TBROK&nbsp; :&nbsp; Didn't get ENOSPC in test setup<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
echo 32 &gt; /proc/sys/vm/nr_hugepages<br>
  <br>
root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
./hugeshmget03<br>
hugeshmget03&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; errno = 12 : Cannot allocate memory<br>
hugeshmget03&nbsp;&nbsp;&nbsp; 1&nbsp; TBROK&nbsp; :&nbsp; Didn't get ENOSPC in test setup<br>
  <br clear="all">
  <br>
-- <br>
  <br>
  <br>
Thanks and Best Regards,<br>
shenghui<br>
</blockquote>
<br>
</body>
</html>

--------------020900030605060604090207--


--===============9140855421630374144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
--===============9140855421630374144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9140855421630374144==--


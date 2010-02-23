Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NjnMn-0000B7-Sv
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 05:31:29 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjnMl-0006il-Ml
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 05:31:29 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1N5KYrk011896
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Feb 2010 00:20:34 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1N5VBht132380
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Feb 2010 00:31:11 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1N5VBOO032685
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Feb 2010 02:31:11 -0300
Message-ID: <4B836817.6030103@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2010 11:01:03 +0530
From: Subrata Modak <subrata@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4B823681.7010300@linux.vnet.ibm.com>
	<OF7B2672AC.4ABA3E07-ON652576D2.005673AB-652576D2.005717E8@in.ibm.com>
	<20100222164921.GC2992@linux.vnet.ibm.com>
	<364299f41002221017y4b49a212qd81ebc248d4b89d2@mail.gmail.com>
In-Reply-To: <364299f41002221017y4b49a212qd81ebc248d4b89d2@mail.gmail.com>
Subject: Re: [LTP] [ANNOUNCEMENT]: Intermediate release for FEB'10
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7263549873488897432=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Iranna D Ankad <iranna.ankad@in.ibm.com>, Rishikesh K Rajak <risrajak@in.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, Vishukumar S Shetty <svishuku@in.ibm.com>

This is a multi-part message in MIME format.
--===============7263549873488897432==
Content-Type: multipart/alternative;
	boundary="------------020701090908060903030301"

This is a multi-part message in MIME format.
--------------020701090908060903030301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Garrett Cooper wrote:
> On Mon, Feb 22, 2010 at 8:49 AM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
>   
>> Hi Iranna,
>>
>>
>> Thanks for reporting this build failure and helping, as it will
>> really help to make ltp more stable.
>>
>> Here is the quick patch i am attaching which solves the problem.
>>
>> Signed-off By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>
>> Tested By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>
>> ---
>> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c
>> b/testcases/kernel/syscalls/mbind/mbind01.c
>> index 5d7eb69..847186a 100644
>> --- a/testcases/kernel/syscalls/mbind/mbind01.c
>> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
>> @@ -74,6 +74,7 @@ int  TST_TOTAL = 2;           /* total number of tests
>> in this file.   */
>>  #include <unistd.h>
>>  #include "include_j_h.h"
>>  #include "numa_helpers.h"
>> +#include <linux/mempolicy.h>
>>     
And also, including <linux/*.h> in any application(s) other than the 
kernel itself is better avoided.

Regards--
Subrata
>>  #if ! defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
>>     
>
> No. This patch shouldn't be committed because of namespace collisions
> between numa and mempolicy (thank the developers for just copy-pasting
> constants, macros, etc instead of properly requiring numa on the
> target system in order for mempolicy to work...).
>
> Thanks,
> -Garrett
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
>   


--------------020701090908060903030301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Garrett Cooper wrote:
<blockquote
 cite="mid:364299f41002221017y4b49a212qd81ebc248d4b89d2@mail.gmail.com"
 type="cite">
  <pre wrap="">On Mon, Feb 22, 2010 at 8:49 AM, Rishikesh K Rajak
<a class="moz-txt-link-rfc2396E" href="mailto:risrajak@linux.vnet.ibm.com">&lt;risrajak@linux.vnet.ibm.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi Iranna,


Thanks for reporting this build failure and helping, as it will
really help to make ltp more stable.

Here is the quick patch i am attaching which solves the problem.

Signed-off By: Rishikesh K Rajak<a class="moz-txt-link-rfc2396E" href="mailto:risrajak@linux.vnet.ibm.com">&lt;risrajak@linux.vnet.ibm.com&gt;</a>
Tested By: Rishikesh K Rajak<a class="moz-txt-link-rfc2396E" href="mailto:risrajak@linux.vnet.ibm.com">&lt;risrajak@linux.vnet.ibm.com&gt;</a>
---
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c
b/testcases/kernel/syscalls/mbind/mbind01.c
index 5d7eb69..847186a 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -74,6 +74,7 @@ int &nbsp;TST_TOTAL = 2; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* total number of tests
in this file. &nbsp; */
&nbsp;#include &lt;unistd.h&gt;
&nbsp;#include "include_j_h.h"
&nbsp;#include "numa_helpers.h"
+#include &lt;linux/mempolicy.h&gt;
    </pre>
  </blockquote>
</blockquote>
And also, including &lt;linux/*.h&gt; in any application(s) other than
the kernel itself is better avoided.<br>
<br>
Regards--<br>
Subrata<br>
<blockquote
 cite="mid:364299f41002221017y4b49a212qd81ebc248d4b89d2@mail.gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">
&nbsp;#if ! defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION &lt; 2
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No. This patch shouldn't be committed because of namespace collisions
between numa and mempolicy (thank the developers for just copy-pasting
constants, macros, etc instead of properly requiring numa on the
target system in order for mempolicy to work...).

Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&amp;#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/intel-sw-dev">http://p.sf.net/sfu/intel-sw-dev</a>
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------020701090908060903030301--



--===============7263549873488897432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============7263549873488897432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7263549873488897432==--



Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N5Fo0-0006tw-Pj
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 09:36:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5Fnr-0000PH-2i
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 09:36:00 +0000
Message-ID: <4AEFF972.3080405@cn.fujitsu.com>
Date: Tue, 03 Nov 2009 17:35:46 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AEFF53D.1010908@in.ibm.com>
In-Reply-To: <4AEFF53D.1010908@in.ibm.com>
Subject: Re: [LTP] [PATCH][RFC]Testcases mbind01.c and get_mempolicy01 fails
 with EINVAL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0140392078504497757=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Sharyathi Nagesh <sharyath@in.ibm.com>
Cc: "Rishikesh K. Rajak" <risrajak@in.ibm.com>, ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0140392078504497757==
Content-Type: multipart/alternative;
	boundary="------------090908070700060301070000"

This is a multi-part message in MIME format.
--------------090908070700060301070000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

On 11/03/2009 05:17 PM, Sharyathi Nagesh wrote:
> Hi
>     We observed that LTP test cases are failing when run on some of
> the distros
>
> Problem Statement:
>
>     I observed that test cases mbind01.c and get_mempolicy01.c are
> failing during call to get_mempolicy() with error -EINVAL.
>     In the kernel code the error comes from
> ----------------------------------------------------------------
>
> SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
>                 unsigned long __user *, nmask, unsigned long, maxnode,
>                 unsigned long, addr, unsigned long, flags)
> {
>         int err;
>         int uninitialized_var(pval);
>         nodemask_t nodes;
>
>         if (nmask != NULL && maxnode < MAX_NUMNODES)
>                 return -EINVAL;
>                                                  <== in the kernel code,
> MAX_NUMNODES comes to 512

  Is it better that "MAX_NUMNODES" get from configure file?

  For different platforms may have different  MAX_NUMNODES.


  Regards--
  Liu Bo

> ----------------------------------------------------------------
> Analysis:
>     
>     When kernel config option 'configure maximum number of SMP
> processors and NUMA node'  is set MAX_NUMNODES will be initialized to
> 512 and any call to get_mempolicy() with maxnode value  less than that
> cause the test to fail.
> ----------------------------------------------------------------
> Fix:
>     increase the default maxnode value in the test case to reflect
> this value. maxnode value comes from numaif.h and this patch increase
> the value to 512 from earlier 128.
>
> Note:
>     I will submit it in the format, once the patch is accepted
>
> Thanks
> Yeehaw
>

> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


--------------090908070700060301070000
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
Hi<br>
<br>
On 11/03/2009 05:17 PM, Sharyathi Nagesh wrote:
<blockquote cite="mid:4AEFF53D.1010908@in.ibm.com" type="cite">Hi
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;We observed that LTP test cases are failing when run on some of the
distros
  <br>
  <br>
Problem Statement:
  <br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;I observed that test cases mbind01.c and get_mempolicy01.c are
failing during call to get_mempolicy() with error -EINVAL.
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;In the kernel code the error comes from
  <br>
----------------------------------------------------------------
  <br>
  <br>
SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long __user *, nmask, unsigned long, maxnode,
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long, addr, unsigned long, flags)
  <br>
{
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int uninitialized_var(pval);
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nodemask_t nodes;
  <br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nmask != NULL &amp;&amp; maxnode &lt; MAX_NUMNODES)
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;== in the kernel
code,
  <br>
MAX_NUMNODES comes to 512
  <br>
</blockquote>
<br>
&nbsp; Is it better that "MAX_NUMNODES" get from configure file?<br>
<br>
&nbsp; For different platforms may have different&nbsp; MAX_NUMNODES.<br>
<br>
<br>
&nbsp; Regards--<br>
&nbsp; Liu Bo<br>
<br>
<blockquote cite="mid:4AEFF53D.1010908@in.ibm.com" type="cite">----------------------------------------------------------------
  <br>
Analysis:
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;When kernel config option 'configure maximum number of SMP
processors and NUMA node'&nbsp; is set MAX_NUMNODES will be initialized to
512 and any call to get_mempolicy() with maxnode value&nbsp; less than that
cause the test to fail.
  <br>
----------------------------------------------------------------
  <br>
Fix:
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;increase the default maxnode value in the test case to reflect this
value. maxnode value comes from numaif.h and this patch increase the
value to 512 from earlier 128.
  <br>
  <br>
Note:
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;I will submit it in the format, once the patch is accepted
  <br>
  <br>
Thanks
  <br>
Yeehaw
  <br>
  <br>
</blockquote>
<br>
<blockquote cite="mid:4AEFF53D.1010908@in.ibm.com" type="cite">
  <pre wrap=""><hr size="4" width="90%">
------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/devconference">http://p.sf.net/sfu/devconference</a></pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------090908070700060301070000--


--===============0140392078504497757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============0140392078504497757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0140392078504497757==--


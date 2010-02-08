Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NeMbG-0007ob-Ld
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 05:55:58 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NeMbE-0001jk-Qe
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 05:55:58 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o185tbQH023907
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 16:55:37 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o185oTvn1306754
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 16:50:29 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o185tbsg023557
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 16:55:37 +1100
Message-ID: <4B6FA757.2010309@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2010 11:25:35 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
In-Reply-To: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3254224525962275036=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: shenghui <crosslonelyover@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3254224525962275036==
Content-Type: multipart/alternative;
	boundary="------------010502050201060206090509"

This is a multi-part message in MIME format.
--------------010502050201060206090509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2010 09:04 PM, shenghui wrote:
> Hi all,
>
>        I want to know how to run hugetlbshmget03? Does it need some 
> arguments?
> For I have run it several times, always got error "NOMEM" for cannot 
> get hugetlb
> page. But "cat /proc/meminfo" shows that free hugetlb pages are enough 
> for its
> request.
>        Does anyone know how to handle this problem?
Hi Shenghui,

Have you run this testcase after setting up nr_hugepages ? You need to 
set the pages accordingly and then you need to run the testcase.

e.g:

echo 10 > /proc/sys/vm/nr_hugepages

Please post your result if you still finding issue.

Thanks
Rishi

>
> -- 
>
>
> Thanks and Best Regards,
> shenghui
>
>
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>    


--------------010502050201060206090509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 02/06/2010 09:04 PM, shenghui wrote:
<blockquote
 cite="mid:5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com"
 type="cite">Hi all,<br>
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
<blockquote
 cite="mid:5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com"
 type="cite"><br>
-- <br>
  <br>
  <br>
Thanks and Best Regards,<br>
shenghui<br>
  <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/theplanet-com">http://p.sf.net/sfu/theplanet-com</a></pre>
  <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------010502050201060206090509--


--===============3254224525962275036==
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
--===============3254224525962275036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3254224525962275036==--


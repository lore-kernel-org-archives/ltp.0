Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1PrYKn-0003aA-6d
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 16:10:01 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1PrYKl-0001Od-Tt
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 16:10:01 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id p1LG9q3Q011912
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Feb 2011 03:09:52 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1LG9quD2490458
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Feb 2011 03:09:52 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p1LG9pUm020494
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Feb 2011 03:09:52 +1100
Message-ID: <4D628E4A.5040202@linux.vnet.ibm.com>
Date: Mon, 21 Feb 2011 21:39:46 +0530
From: Shubham Goyal <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <AANLkTinOqU_P=kD065O7MayXgN30NV_=D2cpqWGVwM5E@mail.gmail.com>
	<AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com>
In-Reply-To: <AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com>
Subject: Re: [LTP] LTP test cases fpathconf syscall and signal_test_06 ipc
 test cases found hanging on android Gingerbread kernel
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3256841936214511441=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Amit kumar <kumaratreya@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3256841936214511441==
Content-Type: multipart/alternative;
	boundary="------------010607090008090605000701"

This is a multi-part message in MIME format.
--------------010607090008090605000701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Amit,

Can you please let us know where exactly this test case is hanging for you?

Thanks,
Shubham


On Monday 21 February 2011 12:01 PM, Amit kumar wrote:
> Hi,
> I am using LTP to test Android platform and successively ported to 
> Eclair after customization.
>
>
> fpathconf syscall and signal_test_06 ipc test cases found hanging on 
> Android Gingerbread Kernel.
>
>
> Are these know issues or we need to fix them?
>
>
>
>
> Thanks and Regards,
>
> Amit kumar
>



--------------010607090008090605000701
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
    <title></title>
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <pre>Hi Amit,

Can you please let us know where exactly this test case is hanging for you?

Thanks,
Shubham
</pre>
    <br>
    On Monday 21 February 2011 12:01 PM, Amit kumar wrote:
    <blockquote
      cite="mid:AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com"
      type="cite">
      <meta http-equiv="Context-Type" content="text/html;
        charset=ISO-8859-1">
      <div>Hi,<br>
        I am using LTP to test Android platform and successively ported
        to Eclair after customization.<br>
        <br>
        <br>
        fpathconf syscall and signal_test_06 ipc test cases found
        hanging on Android Gingerbread Kernel.<br>
        <br>
        <br>
        Are these know issues or we need to fix them?<br>
        <br>
        <br>
        <br>
        <br>
        Thanks and Regards,<br>
        <br>
        Amit kumar<br>
        <br>
      </div>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------010607090008090605000701--


--===============3256841936214511441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
--===============3256841936214511441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3256841936214511441==--


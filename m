Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <john.maxin@nokia.com>) id 1PrUjj-0004a1-03
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 12:19:31 +0000
Received: from smtp.nokia.com ([147.243.128.24] helo=mgw-da01.nokia.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1PrUjh-0005yg-MP
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 12:19:30 +0000
Message-ID: <4D6266A3.1020800@nokia.com>
Date: Mon, 21 Feb 2011 14:20:35 +0100
From: maxin <john.maxin@nokia.com>
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
Content-Type: multipart/mixed; boundary="===============4048253478496587855=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ext Amit kumar <kumaratreya@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============4048253478496587855==
Content-Type: multipart/alternative;
	boundary="------------010903010700000208080208"

This is a multi-part message in MIME format.
--------------010903010700000208080208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi Amit,

The "fpathconf" test case works fine in my PC. Please share some more 
information on test case execution using 'strace'. ie:
# strace ./fpathconf01

This will help in analyzing the cause of failure.

Best Regards,
Maxin Baby John

On 11-02-21 07:31 AM, ext Amit kumar wrote:
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
>
>
> ------------------------------------------------------------------------------
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--------------010903010700000208080208
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
    <br>
    Hi Amit,<br>
    <br>
    The "fpathconf" test case works fine in my PC. Please share some
    more information on test case execution using 'strace'. ie:<br>
    # strace ./fpathconf01<br>
    <br>
    This will help in analyzing the cause of failure. <br>
    <br>
    Best Regards,<br>
    Maxin Baby John<br>
    <br>
    On 11-02-21 07:31 AM, ext Amit kumar wrote:
    <blockquote
      cite="mid:AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div class="gmail_quote">Hi,<br>
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
        <font color="#888888"><br>
          Amit kumar<br>
        </font><br>
      </div>
      <br>
      <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/intel-dev2devfeb">http://p.sf.net/sfu/intel-dev2devfeb</a></pre>
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

--------------010903010700000208080208--


--===============4048253478496587855==
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
--===============4048253478496587855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4048253478496587855==--


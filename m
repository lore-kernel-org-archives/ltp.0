Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SmJqa-0007Hh-D0
	for ltp-list@lists.sourceforge.net; Wed, 04 Jul 2012 07:18:00 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SmJqW-0000gb-CY
	for ltp-list@lists.sourceforge.net; Wed, 04 Jul 2012 07:18:00 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q647Ho88005671
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 4 Jul 2012 00:17:50 -0700 (PDT)
Message-ID: <4FF3EE1B.1060508@windriver.com>
Date: Wed, 4 Jul 2012 15:17:47 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] POSIX: does case mmap/27-1 valid?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2966031348150960273=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2966031348150960273==
Content-Type: multipart/alternative;
	boundary="------------080104050009010608040506"

--------------080104050009010608040506
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

The posix test case mmap/27-1 try to test c lib implementation which 
doesn't support MAP_FIXED and MAP_PRIVATE.
When MAP_FIXED is defined then the case quits  with  UNTESTED.
If MAP_FIXED and other flags are not defined, then the case try to test 
mmap with MAP_FIXED.
But at this time MAP_FIXED is not defined, how the case can be compiled? 
Then I suppose this case is NOT valid.

What's your opinions? Thanks.

Regards,
Kai



--------------080104050009010608040506
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <font size="+1">Hi All, <br>
      <br>
      The posix test case mmap/27-1 try to test c lib implementation
      which doesn't support MAP_FIXED and MAP_PRIVATE. <br>
      When MAP_FIXED is defined then the case quits&nbsp; with&nbsp; UNTESTED.<br>
      If MAP_FIXED and other flags are not defined, then the case try to
      test mmap with </font><font size="+1">MAP_FIXED.<br>
      But at this time </font><font size="+1">MAP_FIXED is not defined,
      how the case can be compiled? Then I suppose this case is NOT
      valid.<br>
      <br>
      What's your opinions? Thanks.<br>
      <br>
      Regards,<br>
      Kai<br>
      <br>
      <br>
    </font>
  </body>
</html>

--------------080104050009010608040506--


--===============2966031348150960273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============2966031348150960273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2966031348150960273==--


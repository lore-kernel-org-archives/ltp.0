Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MOkJO-0003pU-8r
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 03:28:42 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOkJF-0004Jb-6D
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 03:28:37 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id A8D081AFDC
	for <ltp-list@lists.sourceforge.net>;
	Wed,  8 Jul 2009 20:28:29 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA0044.AF993AAD"
Date: Wed, 8 Jul 2009 20:23:47 -0700
Message-ID: <8368651DACC1964480F951191B94A078D013C0@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH] utimensat_test.sh, fix hardcoded tmp directory
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA0044.AF993AAD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here is a patch for utimensat_test.sh to change the hardcoded tmp =
directory to use the LTP variable TMPDIR which may bet set by the user =
to point to other than /tmp


Henry Yei
MontaVista Software, Inc.
hyei@mvista.com


=20

------_=_NextPart_001_01CA0044.AF993AAD
Content-Type: application/octet-stream;
	name="utimensat_tests.patch"
Content-Transfer-Encoding: base64
Content-Description: utimensat_tests.patch
Content-Disposition: attachment;
	filename="utimensat_tests.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVuc2F0
L3V0aW1lbnNhdF90ZXN0cy5zaAkyMDA5LTA0LTA1IDIyOjIzOjAxLjAwMDAwMDAwMCAtMDcwMAor
KysgbHRwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVuc2F0L3V0aW1lbnNhdF90ZXN0
cy5zaAkyMDA5LTA3LTA4IDE5OjU3OjA2LjY2ODYxODQwMCAtMDcwMApAQCAtMzEsOSArMzEsOSBA
QAogICAgICAgIGV4aXQgMAogZmkKIAotUkVTVUxUX0ZJTEU9L3RtcC91dGltZW5zYXQucmVzdWx0
CitSRVNVTFRfRklMRT0kVE1QRElSL3V0aW1lbnNhdC5yZXN1bHQKIAotVEVTVF9ESVI9L3RtcC91
dGltZW5zYXRfdGVzdHMKK1RFU1RfRElSPSRUTVBESVIvdXRpbWVuc2F0X3Rlc3RzCiBGSUxFPSRU
RVNUX0RJUi91dGltZW5zYXQudGVzdF9maWxlCiAKIFRFU1RfUFJPRz11dGltZW5zYXQwMQo=

------_=_NextPart_001_01CA0044.AF993AAD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
------_=_NextPart_001_01CA0044.AF993AAD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA0044.AF993AAD--


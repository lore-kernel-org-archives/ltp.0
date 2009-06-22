Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MIsL3-0002f6-VN
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 22:50:09 +0000
Received: from [63.81.120.158] (helo=gateway-1237.mvista.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIsL1-0001QU-LC
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 22:50:09 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id F21881AE5B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 15:49:45 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9F38B.3A3AD624"
Date: Mon, 22 Jun 2009 15:46:04 -0700
Message-ID: <8368651DACC1964480F951191B94A078BC0B6B@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP]  [FIX PATCH] runltp, set user-defined tmp directory correctly
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

------_=_NextPart_001_01C9F38B.3A3AD624
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'd like to submit this patch to fix the functionality to set =
user-defined tmp directories for LTP runs. This undos the hardcoded =
TMPDIR from version 1.33 which added some special case handling of the =
passed in directory string, but broke the general case with what looks =
like debug code.

Patch is against 1.45 version iof runltp (head)



Henry Yei (QA)
MontaVista Software, Inc.
hyei@mvista.com


=20

------_=_NextPart_001_01C9F38B.3A3AD624
Content-Type: application/octet-stream;
	name="runltp.patch"
Content-Transfer-Encoding: base64
Content-Description: runltp.patch
Content-Disposition: attachment;
	filename="runltp.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3J1bmx0cAkyMDA5LTA1LTE5IDAyOjM5OjExLjAwMDAwMDAw
MCAtMDcwMAorKysgbHRwL3J1bmx0cAkyMDA5LTA2LTIyIDE1OjQzOjEyLjQwMjUzMjAwMCAtMDcw
MApAQCAtNDYzLDkgKzQ2Myw5IEBACiAgICAgICAgIGV4aXQgMQogICAgIH0KICAgICBleHBvcnQg
VE1QCi0gICAgIyBUbyBiZSBldm9rZWQgYnkgdHN0X3RtcGRpcigpCi0gICAgIyAgd3JpdGUgdG8g
aXQgYXMgdXNlciBub2JvZHkKLSAgICBleHBvcnQgVE1QRElSPSIvdG1wIiAKKyAgICAjIFRvIGJl
IGludm9rZWQgYnkgdHN0X3RtcGRpcigpCisgICAgIyB3cml0ZSB0byBpdCBhcyB1c2VyIG5vYm9k
eQorICAgIGV4cG9ydCBUTVBESVI9JFRNUAogCiAgICAgY2htb2QgNzc3ICRUTVAgfHwgXAogICAg
IHsK

------_=_NextPart_001_01C9F38B.3A3AD624
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
------_=_NextPart_001_01C9F38B.3A3AD624
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01C9F38B.3A3AD624--


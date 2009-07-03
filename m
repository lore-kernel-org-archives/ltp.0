Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXEt-0004ST-Pz
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:06:55 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXEt-0002Xg-Bw
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:06:55 +0000
Received: by mail-yx0-f195.google.com with SMTP id 33so1892050yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:06:54 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:45:42 -0700
Message-ID: <364299f40907021745k4d5b704ficb338c1edf40934@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016369fa2cadba0b1046dc279a4
Subject: [LTP] [PATCH 7/10] config.mk not required for clean
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
To: LTP list <ltp-list@lists.sourceforge.net>

--0016369fa2cadba0b1046dc279a4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016369fa2cadba0b1046dc279a4
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.7.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.7.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6p8dg0

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fZGVzdHJveS9NYWtlZmlsZQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaW9fZGVzdHJveS9NYWtlZmlsZSx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4zCmRpZmYgLXUg
LXIxLjMgTWFrZWZpbGUKLS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fZGVzdHJveS9N
YWtlZmlsZQkyMCBKYW4gMjAwOSAxMDo0ODo0MSAtMDAwMAkxLjMKKysrIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvaW9fZGVzdHJveS9NYWtlZmlsZQkzIEp1bCAyMDA5IDAwOjQwOjAzIC0wMDAw
CkBAIC0yMCwxNSArMjAsMTcgQEAKICMgIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0
LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAgMDIxMTAtMTMwMSAgVVNBCiAjCiAKK3NyY2RpcgkJ
CT89IC4uLy4uLy4uLy4uLy4uCiAKLWluY2x1ZGUgLi4vLi4vLi4vLi4vY29uZmlnLm1rCitpZm5l
cSAoJChNQUtFQ01ER09BTFMpLGNsZWFuKQoraW5jbHVkZSAkKHNyY2RpcikvY29uZmlnLm1rCitl
bmRpZgogCitDRkxBR1MgCQkJKz0gLUkkKHNyY2RpcikvaW5jbHVkZSAtV2FsbAorTERGTEFHUwkJ
CSs9ICQoQUlPX0xJQlMpIC1MJChzcmNkaXIpL2xpYgorTERMSUJTCQkJKz0gLWxsdHAKIAotU1JD
UyAgICA9ICQod2lsZGNhcmQgKi5jKQotVEFSR0VUUyA9ICQocGF0c3Vic3QgJS5jLCUsJChTUkNT
KSkKLQotQ0ZMQUdTICs9IC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAtV2FsbAotTERMSUJTICs9ICQo
QUlPX0xJQlMpIC1MLi4vLi4vLi4vLi4vbGliIC1sbHRwCitUQVJHRVRTIAkJOj0gJChwYXRzdWJz
dCAlLmMsJSwkKHdpbGRjYXJkICouYykpCiAKIGFsbDogJChUQVJHRVRTKQogCg==
--0016369fa2cadba0b1046dc279a4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016369fa2cadba0b1046dc279a4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016369fa2cadba0b1046dc279a4--


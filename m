Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MKO3G-0002PV-TA
	for ltp-list@lists.sourceforge.net; Sat, 27 Jun 2009 02:54:02 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MKO3F-00015D-PD
	for ltp-list@lists.sourceforge.net; Sat, 27 Jun 2009 02:54:02 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 694431ABB2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 26 Jun 2009 18:30:36 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9F6C6.DEFF4819"
Date: Fri, 26 Jun 2009 18:30:33 -0700
Message-ID: <8368651DACC1964480F951191B94A078BC133A@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH] cacheflush01,
	remove extraneous characters for mips specific section
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

------_=_NextPart_001_01C9F6C6.DEFF4819
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am submitting a patch for cacheflush01, it looks like there are =
unneeded characters before=20
return syscall(__NR_cacheflush, addr, nbytes, cache) inside the mips =
section.

Without this patch, the test does not compile with a mips compiler.

Henry Yei (QA)
MontaVista Software, Inc.
hyei@mvista.com


=20

------_=_NextPart_001_01C9F6C6.DEFF4819
Content-Type: application/octet-stream;
	name="cacheflush01.patch"
Content-Transfer-Encoding: base64
Content-Description: cacheflush01.patch
Content-Disposition: attachment;
	filename="cacheflush01.patch"

ZGlmZiAtcnVOIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2Fj
aGVmbHVzaC9jYWNoZWZsdXNoMDEuYyBsdHAtZnVsbC0yMDA5MDUzMS50ZXN0L3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvY2FjaGVmbHVzaC9jYWNoZWZsdXNoMDEuYw0KLS0tIGx0cC1mdWxsLTIw
MDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2FjaGVmbHVzaC9jYWNoZWZsdXNoMDEu
YyAgICAgMjAwOS0wNC0xNCAyMzozMjozNS4wMDAwMDAwMDAgLTA3MDANCisrKyBsdHAtZnVsbC0y
MDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NhY2hlZmx1c2gvY2FjaGVmbHVzaDAx
LmMgICAgMjAwOS0wNi0yNSAwNjowNzoyNi4wMDAwMDAwMDAgLTA3MDANCkBAIC00OSw3ICs0OSw3
IEBADQogI2luY2x1ZGUgPGFzbS9jYWNoZWN0bC5oPg0KIGludCBjYWNoZWZsdXNoKGNoYXIgKmFk
ZHIsIGludCBuYnl0ZXMsIGludCBjYWNoZSkNCiB7DQotQiAgQiAgQiAgQiByZXR1cm4gc3lzY2Fs
bChfX05SX2NhY2hlZmx1c2gsIGFkZHIsIG5ieXRlcywgY2FjaGUpOw0KK3JldHVybiBzeXNjYWxs
KF9fTlJfY2FjaGVmbHVzaCwgYWRkciwgbmJ5dGVzLCBjYWNoZSk7DQogfQ0KICNlbmRpZiAvKiBf
X21pcHNfXyAqLw0KDQo=

------_=_NextPart_001_01C9F6C6.DEFF4819
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------_=_NextPart_001_01C9F6C6.DEFF4819
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01C9F6C6.DEFF4819--


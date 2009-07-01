Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MM9Kq-0006CS-LD
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 23:35:28 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MM9Js-0005f6-GE
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 23:35:28 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 95FA51AF35
	for <ltp-list@lists.sourceforge.net>;
	Wed,  1 Jul 2009 16:34:26 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9FAA4.78BCE450"
Date: Wed, 1 Jul 2009 16:34:25 -0700
Message-ID: <8368651DACC1964480F951191B94A078BC18DD@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH][syscalls] change io_* testcases to run directly
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

------_=_NextPart_001_01C9FAA4.78BCE450
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Again, I forgot the subject..

It looks like the io_*.sh files are now not needed since the test source =
has been modified to check for an autoconf definition.
This patch modifies the syscalls runtest file to call those test =
directly. (io_cancel, io_destroy01, io_getevents01, io_setup01, =
io_submit01)

As the scripts are not needed any more, can we remove the following?

ltp/testcases/kernel/syscalls/io_cancel01.sh
ltp/testcases/kernel/syscalls/io_destroy01.sh
ltp/testcases/kernel/syscalls/io_getevents0101.sh
ltp/testcases/kernel/syscalls/io_setup01.sh
ltp/testcases/kernel/syscalls/io_submit01.sh

These scripts were not being copied into testcases/bin anyway and so =
AFAIK, were not being run correctly by pan anyway.

Henry Yei
MontaVista Software, Inc.
hyei@mvista.com


=20

------_=_NextPart_001_01C9FAA4.78BCE450
Content-Type: application/octet-stream;
	name="syscalls-io.patch"
Content-Transfer-Encoding: base64
Content-Description: syscalls-io.patch
Content-Disposition: attachment;
	filename="syscalls-io.patch"

LS0tIGNvbW11bml0eS9sdHAvcnVudGVzdC9zeXNjYWxscwkyMDA5LTA3LTAxIDEyOjUyOjA4LjEz
NzUwNDgwMCAtMDcwMAorKysgbHRwL3J1bnRlc3Qvc3lzY2FsbHMJMjAwOS0wNy0wMSAxMjo1Mjow
OC4zNDA2MjcyMDAgLTA3MDAKQEAgLTQ0MSwxMSArNDQxLDExIEBACiBpb3BsMDEgaW9wbDAxCiBp
b3BsMDIgaW9wbDAyCiAKLWlvX2NhbmNlbDAxIHJ1bi1pb19jYW5jZWwuc2gKLWlvX2Rlc3Ryb3kw
MSBydW4taW9fZGVzdHJveS5zaAotaW9fZ2V0ZXZlbnRzMDEgcnVuLWlvX2dldGV2ZW50cy5zaAot
aW9fc2V0dXAwMSBydW4taW9fc2V0dXAuc2gKLWlvX3N1Ym1pdDAxIHJ1bi1pb19zdWJtaXQuc2gK
K2lvX2NhbmNlbDAxIGlvX2NhbmNlbDAxCitpb19kZXN0cm95MDEgaW9fZGVzdHJveTAxCitpb19n
ZXRldmVudHMwMSBpb19nZXRldmVudHMwMQoraW9fc2V0dXAwMSBpb19zZXR1cDAxCitpb19zdWJt
aXQwMSBpb19zdWJtaXQwMQogCiBrZXljdGwwMSBrZXljdGwwMQogCg==

------_=_NextPart_001_01C9FAA4.78BCE450
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------_=_NextPart_001_01C9FAA4.78BCE450
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01C9FAA4.78BCE450--


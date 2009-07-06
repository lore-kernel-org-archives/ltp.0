Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNwAA-0007dW-A8
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:55:50 +0000
Received: from an-out-0708.google.com ([209.85.132.244])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNwA4-0004iK-1A
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:55:50 +0000
Received: by an-out-0708.google.com with SMTP id c38so1764605ana.37
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 14:55:43 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 6 Jul 2009 14:55:43 -0700
Message-ID: <364299f40907061455n2f95c877sb40d6a97e856fd03@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e644de5e50857d046e109170
Subject: [LTP] [PATCH] Missing limits.h include and test.h style in
	system_specific_process_info.c
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

--0016e644de5e50857d046e109170
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

1. test.h is in .../include/. Thus #include should be #include
"test.h", not #include <test.h>.
2. limits.h should be explicitly stated because certain constants are
used in system_specific_process_info.c (SHRT_MAX for instance).

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016e644de5e50857d046e109170
Content-Type: application/octet-stream; 
	name="system-specific-process-info-fix-includes.diff"
Content-Disposition: attachment; 
	filename="system-specific-process-info-fix-includes.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwtqdzrl0

SW5kZXg6IGxpYi9zeXN0ZW1fc3BlY2lmaWNfcHJvY2Vzc19pbmZvLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC9saWIvc3lzdGVtX3NwZWNpZmljX3Byb2Nlc3NfaW5mby5j
LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjIKZGlmZiAtcjEuMiBzeXN0ZW1fc3BlY2lmaWNfcHJv
Y2Vzc19pbmZvLmMKMzBkMjkKPCAKMzFhMzEKPiAjaW5jbHVkZSA8bGltaXRzLmg+CjMzYzMzCjwg
I2luY2x1ZGUgPHRlc3QuaD4KLS0tCj4gI2luY2x1ZGUgInRlc3QuaCIK
--0016e644de5e50857d046e109170
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016e644de5e50857d046e109170
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e644de5e50857d046e109170--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <isimatu.yasuaki@jp.fujitsu.com>) id 1Na0Gv-0007mV-NK
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 05:16:57 +0000
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Na0Gt-00050U-6c
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 05:16:57 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o0R5Gl43018811 for <ltp-list@lists.sourceforge.net> (envelope-from
	isimatu.yasuaki@jp.fujitsu.com); Wed, 27 Jan 2010 14:16:47 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 3DA7445DE50
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 14:16:47 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 0993F45DE4C
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 14:16:47 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id E47701DB803F
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 14:16:46 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id A0DC71DB8037
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 14:16:46 +0900 (JST)
Message-ID: <4B5FCC2D.7070304@jp.fujitsu.com>
Date: Wed, 27 Jan 2010 14:16:29 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix aio_suspend/3-1
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: isimatu.yasuaki@jp.fujitsu.com

Hi all

When the aio_suspend/3-1.test ran, SIGSEGV occured with following message
on my x86_64 box.

---
/bin/sh: line 38: 10675 Segmentation fault      ./t0 240 conformance/interfaces/aio_suspend/3-1.test
> $COMPLOG 2>&1
---

This test does not initialize a list[1] array as follows.

---
 40 int main()
...
 88         list[0] = NULL;
 89         list[2] = &aiocb[0];
 90         list[3] = NULL;
 91         list[4] = NULL;
 92         list[5] = &aiocb[1];
 93         list[6] = &aiocb[2];
 94         list[7] = NULL;
...
---

So, list[1] holds a strange value. Since aio_suspend() uses this value as address,
SIGSEGV occurred.

When applying this patch, this test succeeds as follows.

---
conformance/interfaces/aio_suspend/3-1: execution: PASS
---

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Index: ltp-2010-01-27/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
===================================================================
--- ltp-2010-01-27.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
2010-01-27 11:44:30.000000000 +0900
+++ ltp-2010-01-27/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
2010-01-27 11:45:23.000000000 +0900
@@ -82,6 +82,7 @@ int main()
 	}

 	list[0] = NULL;
+	list[1] = NULL;
 	list[2] = &aiocb[0];
 	list[3] = NULL;
 	list[4] = NULL;



------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <isimatu.yasuaki@jp.fujitsu.com>) id 1NaImQ-0006GU-Ga
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 01:02:42 +0000
Received: from fgwmail9.fujitsu.co.jp ([192.51.44.39])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NaImM-0000OX-Ri
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 01:02:41 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail9.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o0S0mdW7019430 for <ltp-list@lists.sourceforge.net> (envelope-from
	isimatu.yasuaki@jp.fujitsu.com); Thu, 28 Jan 2010 09:48:39 +0900
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o0S0mctq010686 for <ltp-list@lists.sourceforge.net> (envelope-from
	isimatu.yasuaki@jp.fujitsu.com); Thu, 28 Jan 2010 09:48:39 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id ABA4C45DE60
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Jan 2010 09:48:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6980445DE70
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Jan 2010 09:48:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id D9DDF1DB803A
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Jan 2010 09:48:37 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 03ED11DB8041
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Jan 2010 09:48:37 +0900 (JST)
Message-ID: <4B60DED0.70508@jp.fujitsu.com>
Date: Thu, 28 Jan 2010 09:48:16 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
References: <4B5FCC2D.7070304@jp.fujitsu.com>
	<364299f41001270101s6821a3a3l64bf928e599073cc@mail.gmail.com>
In-Reply-To: <364299f41001270101s6821a3a3l64bf928e599073cc@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix aio_suspend/3-1
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net
Cc: isimatu.yasuaki@jp.fujitsu.com

Hi Garrett

 >     Wouldn't it just be better to memset(&list, 0, sizeof(list)) the
 > array and just set that one array value to &aiocb[0]? Seems like a
 > much better idea...

Thank you for your good idea.
I applied it.

Regards,
Yasuaki Ishimatsu

--------------------------------------------------------------------------
When the aio_suspend/3-1.test ran, SIGSEGV occured with following message
on my x86_64 box.

---
/bin/sh: line 38: 10675 Segmentation fault      ./t0 240 conformance/interfaces/aio_suspend/3-1.test
  $COMPLOG 2>&1
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

Index: ltp-2010-01-28/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
===================================================================
--- ltp-2010-01-28.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c 
2010-01-28 09:10:48.000000000 +0900
+++ ltp-2010-01-28/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c 
2010-01-28 09:11:16.000000000 +0900
@@ -81,13 +81,11 @@ int main()
  		}
  	}

-	list[0] = NULL;
+	memset(&list, 0, sizeof(list));
+
  	list[2] = &aiocb[0];
-	list[3] = NULL;
-	list[4] = NULL;
  	list[5] = &aiocb[1];
  	list[6] = &aiocb[2];
-	list[7] = NULL;

  	if (aio_suspend(list, NENT, NULL) != 0)
  	{


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

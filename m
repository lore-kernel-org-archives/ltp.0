Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B2DC4345F
	for <ltp@archiver.kernel.org>; Sun, 21 Apr 2024 07:16:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 915293CFE00
	for <ltp@archiver.kernel.org>; Sun, 21 Apr 2024 09:16:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6413C27DE
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 09:15:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=13.245.218.24; helo=smtpbg153.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D5FD600C57
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 09:15:49 +0200 (CEST)
X-QQ-mid: bizesmtpsz15t1713683742tf71pu
X-QQ-Originating-IP: FWqxIDMcKczcqTuwkq3Y3GFShCCcVBdphVPhqwAEf2k=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 21 Apr 2024 15:15:40 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: dcYQFNbI8vEqxznn2Iw2if1ktbAtUexm3t5kR0Wl+hk9R5RSTWXmet0LuZ7lF
 mkyDYR0yZW3n6hStID5T0efVbJvvUI8/LEX2moBwTikJnDxFVOpcj3HXZO3iVZ5zvFvtkIM
 6h7X5L3Aaq9aBmT1uSrztzlmDejTJQA4kZ58C1ljZYVe6rAqAMNj4WuBz6v8G5YqHiO2KvH
 JIEuXoO9RRk5XvpNVc4l0gjhWB3+2guHcXCQmPdbkYu6kCSWbfMtEakPFId/dvwOX7MPOHy
 bvbF5WJGxsOFFKfm3Z4CtxUO1nFv/Z9poRraSk2zs8J8p/ne2cnRtDjNAYjtHZ3F6/IqtfB
 FIMtnywyQ9zdqZga/AuYw5V6g8fnrM17e2POjyI+ecCVYensbg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16519439166371074378
From: lufei <lufei@uniontech.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Sun, 21 Apr 2024 15:15:38 +0800
Message-Id: <20240421071539.2547355-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240419070717.2506101-1-lufei@uniontech.com>
References: <20240419070717.2506101-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] (no subject)
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Cyril.
Thanks for you quickly response.

Some of your point has been fixed. Some are not:
1. I'm using gcc (GCC) 11.4.1 20230605, `addr` without initialization would output some warnings.
2. I read the manpage of arch_prctl, the ARCH_GET_CPUID seems return the flag, instead of storing `addr`:
```
ARCH_GET_CPUID (since Linux 4.12)
              Return the setting of the flag manipulated by ARCH_SET_CPUID as the result of the system call (1  for  enabled,  0  for
              disabled).  addr is ignored.
```
I'm not sure if this is a problem of my environment. 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

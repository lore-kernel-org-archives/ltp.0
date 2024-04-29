Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDFBC25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715770554; h=mime-version :
 message-id : to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=vH2nc9QUD/eaXgsF1zoXSV9f2HHPeQo0na5u6+xZITE=;
 b=BtNAxtZ8bvEpo5ZjyJtdny9G5OArj0aT8a/hU23EujRGVksDVrtAip/psg1F4slSuZ7DG
 iXR+vNRzpkPoLdrR7Exnc9wHqsc92pkF+Wbfkgc/EUMbyibmz3JofLXHagQz+5eMCQ2XFrK
 pC+XYG72Lvyy5KoqhN/NjvNeNyu0gOQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE76F3CF7DF
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 12:55:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2DD93C6552
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 01:53:43 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=web.de
 (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=wine.dev@web.de;
 receiver=lists.linux.it)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DFF852005F7
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 01:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1714434821; x=1715039621; i=wine.dev@web.de;
 bh=IsqtlEVqMf1MQ+xouZG3hVl8fU5xNCLqSeUb1O/OAGE=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
 from:message-id:mime-version:reply-to:subject:to;
 b=BUDViJealgBqEarDtLp0HKuuRnbrvDl3fCor9UYEA2zgzrPFJxUp0R2QO1DXmFMh
 JxsTdxOo21lzxdE7qNwA64jMpmRhZE+bG8X1aVaahdgrz9nyuh+5+Evyk8cnmkiEA
 peR1C6TqzZ0rjTrD62EIFjqxWKTrvoGAYEFhq7Aw3bwX2P/O8FUzA4/a31AiQ5SJc
 kCuf1O7lJkFCultW4DxgTSJJwXZ4GrSpWdUQgaNVlkI5t5Ejk8h/c+NkBMe2ZZyKA
 TJ/B50VOVfEPXv5pZWzhRzS2oB0HonrqDklMpmSlkw39uJ8yyWI/+q6bZM7g3axmv
 +X7Vy2MNjIUYi+EfMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [79.232.205.151] ([79.232.205.151]) by web-mail.web.de
 (3c-app-webde-bap15.server.lan [172.19.172.15]) (via HTTP); Tue, 30 Apr
 2024 01:53:41 +0200
MIME-Version: 1.0
Message-ID: <trinity-b91f2394-92c0-46c1-a3a4-87335bff6a7f-1714434821460@3c-app-webde-bap15>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 01:53:41 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:Ulh3ykeYayL4Iq4XSQzUJrBLLVFihkx8qckjC7KtxUBNbBYfMaoTKuY8FXlZHKRIB61j1
 SsoVvDHIqcuro7rlDu0oqBmz8LgeVX7DKnXjvMrCWTquBWiofrqRO+Xg7A3sGLkNpfChkCDD9Lf4
 nHZYj8T/Ie6GMw0NlQtH3c4msZiUJShBQWVbv+5ZNG93hWQxus5eLUub1fbeW04WkEUuVs1HKWJV
 LhVflU4XGqVKGYaOrT6z/GczWQ7HM6sH2xYG9r1dlMw8oQg0S1KbGSPprAZpf61DSQN/m4KiIfdO
 GQ=
UI-OutboundReport: notjunk:1;M01:P0:Hr+fgfR5vNU=;PmEvvoXqDbSQyxsBIy2PwMCttQ+
 sw461blKNyDYPd5r36FaI89FKlDGqIee4RP1TmSoQfSF0xRFhnn23b93qtkbeM/SimAp4tpUU
 D1ZXnkJg0X+rIsQkmMGfqvQGWyEKwGhkF9QLOkpDWi08966sT7jfcbOqlTt28HzQRdD3iDkM2
 GYnsc7RCmZkmMcMWEElG1iA86Vqm/W5+GkGqibWWz9l/rAgpNiMVS6ZIGOZhMJ5df1EM230nx
 n/2t/rxkMpCOZV+Fu/NzsMB2jdo2ZxNTu7VK5GHpA/p8XIqpBM7mUwlbVE1uJfdi0kTFD0R0V
 rBXrQ4oTtchj16c3DrZ4LY2AYtJXSGUuCyzTqM/fUG7jroui9FEaTRb6iQxBcaw+GE23mEpzB
 umbqNVU/WVE0nhvSmbGQB5p3aMplXQ7MbC80OToTzG7NfRc2nM2nGL82mU+8G5T9yD1U2iWNO
 Ub8w3CcFflGRES+6KppApvxzy86juAd4cK4IR4eJN/yWI8ON6Y+uFRWuV5+TmjUgXDPQYRNb6
 oAr1QjzcB/AGBW+wRh0jSzvXKmuUFOGj0UYLHe/ZnIDBTtKO1I72cf4N8TDSmYIfpbtpCxb50
 oBbaYLVOB9tgSmzrJ9oYt1YxxAAlV56jNBGNGgnBuHWX/owBIy0VJrL5Bnn0+pG0KOt8UGva/
 oTXM1ujU8MRqMdkOAc5rBysgX5gt7RtsMty7JcBvG/Ikp8hF+yXG1cpGd4gazes=
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 15 May 2024 12:55:32 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] open_posix_testsuite: Avoid non portable GCC
 extensions for other compiler
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
From: Detlef Riekenberg via ltp <ltp@lists.linux.it>
Reply-To: Detlef Riekenberg <wine.dev@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


The GCC extension "__attribute__" breaks other compiler and produces 458 test failures.
(I tested with owcc from OpenWatcom)


This patch adds a guard around the defines.


--
Regards ... Detlef

Signed-off-by: Detlef Riekenberg <wine.dev@web.de>
---
 .../open_posix_testsuite/include/posixtest.h  | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

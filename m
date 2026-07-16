Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A19C44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784183657; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gDmXJRN0ppyrY/n7jyO5r48iBtZtMrn5ZdEY2mH10+8=;
 b=qw4giM8GvXLBsgQeBGHOmC7oluFYgHdH6CLRapiP8YCe+LeHuCSLD0Rx4HAVhRiM7JpQK
 KrNfsaNjcPu5H52VOzs7vy21rsJiuKN4Ga9zWIzQamnS10JSvO9Fg7vN2fUe4FWD1XzcU0z
 bJ4gFLQtru54ypGhTdkbSQLld7lFGc4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 214C73E1C4B
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 08:34:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54A363E1DD7
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 08:33:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8C3EE1A00356
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 08:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784183615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JzWl/3QM8YqLc9QzgDRr0jjr9gy3xI5Im7XGZAR0xWs=;
 b=Rg5KTYWNoWDYxQzGPVG72jPZMi3uk1o/uf5XnLgH9ulaguMsXIW9lPRnLSzmi5Qqa9op99
 qApCMNwPaMb2cw5wX/ZWJ4ACsIKwZ/FO6S0tRKYCsqjCWU5DXZR+CEvY0BSHGm4gUUrQhi
 fDuZmLD9c2m7nNUpQsTXX5rQx2Wllq0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-VaMAYQCqO0uG6sFLJ52nTg-1; Thu,
 16 Jul 2026 02:33:33 -0400
X-MC-Unique: VaMAYQCqO0uG6sFLJ52nTg-1
X-Mimecast-MFC-AGG-ID: VaMAYQCqO0uG6sFLJ52nTg_1784183612
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B5AE1956068
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:33:32 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.com (unknown [10.44.48.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 853903003EFD
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:33:30 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 08:33:22 +0200
Message-ID: <cover.1784183478.git.tdzik@redhat.com>
In-Reply-To: <cover.1784103831.git.tdzik@redhat.com>
References: <cover.1784103831.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qoe0eUZjcR8BKxDjJKp0Xvl9zc98z5BLkQHb8rtLysg_1784183612
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Fix to float_trigo core dump and related
 enhancements
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
From: Tomas Dzik via ltp <ltp@lists.linux.it>
Reply-To: Tomas Dzik <tdzik@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,
following 3 patches fix a core dump we observed during testing. Because
failed malloc() was contributing factor to it I added also some checks
to malloc() return value. And since I was editing these files I spotted
that they use sprintf() and I replaced it with snprintf() which is IMHO
safer and can make debugging test failures easier.
I would be grateful for review.

Best regards,
Tomas D.

Tomas Dzik (3):
  LTP/Lite test float_trigo core dumps due to free(): invalid pointer
  float: add malloc() NULL check in gen* data generator tools
  Replace sprintf() with more secure snprintf() variant in float tests

 testcases/misc/math/float/bessel/genbessel.c  | 10 +++---
 .../misc/math/float/exp_log/genexp_log.c      | 24 ++++++++++----
 testcases/misc/math/float/iperb/geniperb.c    | 11 +++++--
 testcases/misc/math/float/main.c              | 18 +++++++---
 testcases/misc/math/float/power/genpower.c    | 21 ++++++++----
 testcases/misc/math/float/thread_code.c       | 33 +++++++++++++------
 testcases/misc/math/float/trigo/gentrigo.c    | 24 ++++++++++----
 7 files changed, 98 insertions(+), 43 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

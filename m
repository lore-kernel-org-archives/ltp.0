Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3630C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784108740; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=YTIO3gwVtLfl4UVm+QvDLOGdlWse/LUp8zi+KvNvwig=;
 b=RvFDX1nMXiX6k2xgHNnxXAmOEftdI3jTZzJLtuWecnO+ggI3rEVvh7Zm4FZi8ThR5CsZR
 90wyo5mhtwvODvnUkECkNM5nDevGLmv2cNHr0Eg6wOzfwf+eUOsRmOKpI9jf44vmCFU6Nxp
 iIwzbPaVs2WChVCxTzwuy2I0r+veEeI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 263EF3E65C4
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:45:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8C9D3E5686
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:45:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 162AB60012C
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784108716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VQvxC8jCdtYz80gBmH0Z1QtMfgsuvdqUilBobgeHGdY=;
 b=AyjpGkLPjXu4CiaE7xcQWLz+PtUACtloK6jEWoy/Nw7OJCU045DWSbWLcEmhEZrfz24Ebu
 fJB7FZowkYys+/H6y7wGwtTVhxSS6zFa5W/VDTEgwBtTt3MYpGzv5KrsGyvzHgU8eZ3A9j
 LvbCcIJwgO+8eTFAToxhP3IY1r1D0IM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-8xu0MkqxN-C2uEcUpNayiA-1; Wed,
 15 Jul 2026 05:45:14 -0400
X-MC-Unique: 8xu0MkqxN-C2uEcUpNayiA-1
X-Mimecast-MFC-AGG-ID: 8xu0MkqxN-C2uEcUpNayiA_1784108713
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 787EB19560B5
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:45:13 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.csb (unknown [10.43.3.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2FDE18004D4
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:45:12 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 11:45:01 +0200
Message-ID: <cover.1784103831.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 906BaDmtiPSwcT8UL-BrYi8Nl9yYB15cfbOuZMhixqg_1784108713
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
  Add some checks for malloc() returning NULL
  Replace sprintf() with more secure snprintf() variant in float tests

 testcases/misc/math/float/bessel/genbessel.c  | 10 +++---
 .../misc/math/float/exp_log/genexp_log.c      | 24 +++++++++----
 testcases/misc/math/float/iperb/geniperb.c    | 11 ++++--
 testcases/misc/math/float/main.c              | 18 +++++++---
 testcases/misc/math/float/power/genpower.c    | 21 ++++++++----
 testcases/misc/math/float/thread_code.c       | 34 +++++++++++++------
 testcases/misc/math/float/trigo/gentrigo.c    | 24 +++++++++----
 7 files changed, 99 insertions(+), 43 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

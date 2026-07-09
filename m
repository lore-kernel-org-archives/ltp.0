Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CBC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783612080; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=8IPldw4ReR8T0GL4OWfFQsCyZ0VhUIRAbXcNQ/MVTi4=;
 b=O8JcODeRHn4vBeZBDg+MRy1XKJ8Bbx9Y4dRD8SyU/a/LPRgz9YCWUEnIPvgN3vJ2bigU6
 pZiZix4MmzcUkIhYQOkt1ag5TtIxqonezf7QSJOE7qwuWEAFEZOygEj82vneadjGhZM6cJM
 uUorL2yiu+Nt4CXWu3sKnJ/IrY84kGE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CEAC3E72D1
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:48:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8F443E28F1
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA9C31400104
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783611616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R1G3QNqzikeUthUZHx7bKJBg5tfbQpQu8QDYF1fuWUI=;
 b=XnelpgGSAVdRW8mXJbzceq/0n0Ah1AxSwvML4Eb9kZ4pOVNimHQD7U4BXMm+Xub8+PVOqe
 QLdcc0Kf53VATUSiBrMPaPlVBMomVInhmzPlwmD98rrXzy2NlepIMxoXNCwTdlX6aamCzx
 1Ri3K4KU4SYW/FPVku+pbtuDuP0W+zY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-R9gFaVXONhW8eCUQKXd2qg-1; Thu,
 09 Jul 2026 11:40:14 -0400
X-MC-Unique: R9gFaVXONhW8eCUQKXd2qg-1
X-Mimecast-MFC-AGG-ID: R9gFaVXONhW8eCUQKXd2qg_1783611613
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C1E11955E78
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:13 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.com (unknown [10.44.49.228])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 947AC3000C14
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:12 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 17:40:03 +0200
Message-ID: <cover.1783610933.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cX4z6rX581drgPPRbg2lOfyBJ3mQHfA_DtdrCFiu0ZY_1783611613
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 09 Jul 2026 17:47:41 +0200
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
 testcases/misc/math/float/iperb/geniperb.c    | 10 ++++--
 testcases/misc/math/float/main.c              | 18 +++++++---
 testcases/misc/math/float/power/genpower.c    | 21 ++++++++----
 testcases/misc/math/float/thread_code.c       | 34 +++++++++++++------
 testcases/misc/math/float/trigo/gentrigo.c    | 24 +++++++++----
 7 files changed, 99 insertions(+), 42 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

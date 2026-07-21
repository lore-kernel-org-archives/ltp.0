Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F2C44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784622508; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=gDmXJRN0ppyrY/n7jyO5r48iBtZtMrn5ZdEY2mH10+8=;
 b=DhLWsdlLcqq6AN8ab/6c5hn4pZYUwsUEHohK6L8Zwk3jkwVaZFV62go2Ml5UCD2Ncbh5E
 O/vrtYKVYlQAoJc/qlvxTX3G3121JXrBmFd0gbfkl0V4mTgLeHr/I4ye8jj1PR+UclZpNpy
 XlE3swFyusJo49IqnKh7SXjS8YBEqIw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23FD43E6200
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 10:28:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24A1A3E203E
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:28:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C396600780
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784622484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JzWl/3QM8YqLc9QzgDRr0jjr9gy3xI5Im7XGZAR0xWs=;
 b=LlL9XRIRaBxV1BYXxll6J1hDn8b9U3tCkJWGAXN/ynuHyA7yjxCJdb1VcrVHT0aRAXcTs2
 cen/oku7n2kxz62dKCvcGOArLN4nHrhMUs6rliV+Av7c8jXidAF1m7w7v9pQzLPhfhxlHl
 YIQJ7au+L3UIi5fogmF3S9tsWPzqgFc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-RBti4RtYO2iDyHOePsNQmQ-1; Tue,
 21 Jul 2026 04:28:03 -0400
X-MC-Unique: RBti4RtYO2iDyHOePsNQmQ-1
X-Mimecast-MFC-AGG-ID: RBti4RtYO2iDyHOePsNQmQ_1784622482
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3638195F175
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 08:28:01 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.csb (unknown [10.43.3.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5796A1954231
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 08:28:00 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 10:27:49 +0200
Message-ID: <cover.1784183478.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _W_oh7mkg7rXWKjZ44x0Wd-VrquHUbpiht32B5mVj6A_1784622482
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] Fix to float_trigo core dump and related
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
Message-ID: <20260721082749.8OJSzuE35vu1_Y_61sZnVwxyf56POJuY1Go0tkrRjiw@z>

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

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321F5C4332F
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 12:49:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A96B3C87E7
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 14:49:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 098B73C4F4A
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 14:49:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 609F71401104
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 14:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664801339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QjRrQCPzolcfs/QoUrVUnkjagslGthAJgErX8kd/u8=;
 b=GY3eaQAMNMTLHfT2iHYPcuu1PEmYMAlcoUVEaHbTQpU8Te3cdvwxTHlopJSLRAZ9Fp+/no
 k50ZPiaJetQEtCmNotDmZaQhi8bLMng8Cc4N9uZ1123R2VtRwbeAdSJMtcyJEPJF4VUfXx
 Er8+YLaJgZnAOVk0ysV6HwxPMQlpS5Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-PankEwWPPuKCvygJ_HjBcQ-1; Mon, 03 Oct 2022 08:48:57 -0400
X-MC-Unique: PankEwWPPuKCvygJ_HjBcQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6664D185A79C
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 12:48:57 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8BD0492B04
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 12:48:56 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  3 Oct 2022 14:48:47 +0200
Message-Id: <c229f98781b8d931640eacce947fc269853a9b4a.1664801307.git.jstancek@redhat.com>
In-Reply-To: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls/preadv203: don't treat short write() as
 failure
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

Test is sporadically running into TBROK in setup() due to short write:
  tst_test.c:1064: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
  preadv203.c:257: TBROK: write(501,0x3fff4ef7d15,4123) failed: SUCCESS (0)

Switch to SAFE_WRITE_FULLY().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/preadv2/preadv203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 60dc4a882f16..f3e3ef438de2 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -254,7 +254,7 @@ static void setup(void)
 
 		for (j = 0; j < CHUNKS; j++) {
 			memset(buf, '0' + j, sizeof(buf));
-			SAFE_WRITE(1, fds[i], buf, sizeof(buf));
+			SAFE_WRITE_FULLY(fds[i], buf, sizeof(buf));
 		}
 	}
 }
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

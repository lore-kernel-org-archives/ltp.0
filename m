Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D40C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:41:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D89AC3CA520
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:41:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1CD93CA3CF
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:40:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5815C1A007FD
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649670051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9GkXfA7krfGUd2wYW2GGdnGP8FDKfbH+2QOmyU8lxjI=;
 b=faHKMUuBr+ILHJnEFyh9qDgG6c7Hu0gqko99nCtQnkx37WivP+7KGJLvSI3tSJs7kZBoAC
 Y6s+oB+JNTp3Vl3D1VaEunxS7Zx11XDwiYcqL0zDy0JRzC3JGU+/PdcYLWwu2dFRwHyJtt
 Hxigj/xiMaPY3MC8brdxGfkTpm6ENLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-3pKZfhJjPOOXJSnUdZOBBQ-1; Mon, 11 Apr 2022 05:40:50 -0400
X-MC-Unique: 3pKZfhJjPOOXJSnUdZOBBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BDE0100BAA7
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:40:50 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A070CC28106
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:40:49 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 11 Apr 2022 17:40:47 +0800
Message-Id: <20220411094048.1143292-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] pkey01: print more info when write buff fail
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

We got sporadically failed on POWER9 but couldn't reproduce the problem
manually. Here add printf to show info to see if the PKEY_DISABLE_WRITE
takes effect on buffers.

  pkey01.c:149: TINFO: Set PKEY_DISABLE_WRITE on (MAP_ANONYMOUS|MAP_PRIVATE|MAP_HUGETLB) buffer
  pkey01.c:174: TFAIL: Child: exited with 0
  pkey01.c:176: TINFO: Remove PKEY_DISABLE_WRITE from the buffer

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/pkeys/pkey01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index 04f50924c..1a9194e1a 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -161,6 +161,8 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 		break;
 		case PKEY_DISABLE_WRITE:
 			*buffer = 'a';
+			tst_res(TFAIL | TERRNO,
+				"Write buffer success, buffer[0] = %d", *buffer);
 		break;
 		}
 		exit(0);
@@ -183,6 +185,7 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 	break;
 	case PROT_WRITE:
 		*buffer = 'a';
+		tst_res(TPASS, "Write buffer success, buffer[0] = %d", *buffer);
 	break;
 	case PROT_READ | PROT_WRITE:
 	case PROT_READ | PROT_WRITE | PROT_EXEC:
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

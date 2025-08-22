Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F169BCA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755847381; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=GfY8nWc69kpd7ODf+ad9EDqSfKvld352nAcN01DdpHQ=;
 b=S8sPgd6SigJZp5AIjOEuKlohQg9ACJr3PJtrfjiE7J+0MAQxwBunh5mIC8OytaCyD8sIc
 +dbqDEHObWcTI28AqxWirJQ5Wqzkw6qXYauyZwYvezXAqUnrNld41ImPylcB/Zq7YYSi2ee
 rkgRTAGG2rfN71EXnKKqQJwKnW6bs7Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D2B63CCE36
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 09:23:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092DC3CCE36
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:22:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B53F81A00359
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755847336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGLPdzSd/XN4VJRbuoZv55CIzmJGFj5MOQyyDW/9OiA=;
 b=Ao5bGbSoKEO7TYlpdfTf1zQ813O3fvj8dQ0RKTishGfuv8U+SMioDYM9xWfbKz9w0mP97Y
 YJHe6WZBh7isvVoMdE8It+zuOEB96SZmprhHdtoeQJb90hmv2tRhRByOaEOYGptDz62Wzl
 KBZRH8SdhznhBbcvQFWyKlipT+Nfyvs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-oLg16nMSML-fZujxJ3ebbA-1; Fri,
 22 Aug 2025 03:22:14 -0400
X-MC-Unique: oLg16nMSML-fZujxJ3ebbA-1
X-Mimecast-MFC-AGG-ID: oLg16nMSML-fZujxJ3ebbA_1755847333
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C3451800446
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:22:13 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF25180047F
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:22:11 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 15:22:04 +0800
Message-ID: <20250822072204.2191382-2-liwang@redhat.com>
In-Reply-To: <20250822072204.2191382-1-liwang@redhat.com>
References: <20250822072204.2191382-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HFV6VUbRITOEmZ5Ep-_d5tV0UDhAuhiVG_ouSb9A0jI_1755847333
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] mount05: check if mount path exist before
 tst_is_mounted
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_is_mounted() now internally resolves the mount path via realpath(),
which will fail if the path does not exist. In mount05, MNTPOINT2 may
not always be created during the test flow, so calling tst_is_mounted()
directly could produce misleading warnings or errors.

Add an explicit access(MNTPOINT2, F_OK) check before calling
tst_is_mounted(), ensuring we only query mounts for existing paths.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/mount/mount05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
index 66e102a32..5585e230e 100644
--- a/testcases/kernel/syscalls/mount/mount05.c
+++ b/testcases/kernel/syscalls/mount/mount05.c
@@ -35,7 +35,7 @@ static void cleanup(void)
 	if (tst_is_mounted(MNTPOINT1))
 		SAFE_UMOUNT(MNTPOINT1);
 
-	if (tst_is_mounted(MNTPOINT2))
+	if (!access(MNTPOINT2, F_OK) && tst_is_mounted(MNTPOINT2))
 		SAFE_UMOUNT(MNTPOINT2);
 }
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

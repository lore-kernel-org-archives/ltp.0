Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2142BC3ABC9
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747112795; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=M1OInvM8qe45X+ZV0uHfc92j3bn189Ybxe9j7ZH2Msg=;
 b=Wo2yC6f6/Zx6rDKOaNKA5RHonzpipKFof+aIdr9r4cOmtr9N2+WpDXBvuivMY7R4ybtph
 42uVbOyWRabak6qjLUxD5z6a/G8OpUPEBRy/TneIqqiZtzsFwkf7en9uQZFiJBFoLa50EF+
 hPYIhlycZT+NAEuBEyHneVoZk8x6vvs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 788AC3CC300
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 07:06:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0CFE3CC301
 for <ltp@lists.linux.it>; Tue, 13 May 2025 07:05:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5799B140035C
 for <ltp@lists.linux.it>; Tue, 13 May 2025 07:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747112746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEs59R+Vq3itiGGU4C/9uBH2gkzeM6T3hk1RLOWUbMI=;
 b=JjA7CQz3zptd4YM1IpuFvJ7cCIyTHjcz+R5+D8ozTZLnBz1d/KhJ1K70wzMmK6WR5X9WBD
 kyzMppn0bBQb9j6pGP4wTrWmvuRyOBd4iuEweoOYdqkScZtHO+0/Gpa3QeA0l1YA38LLsH
 m7Nbhyu4EVib+IzEyLP48ozSLw9re+I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-BbBYweuMOCG-dx4Ct3B5YQ-1; Tue,
 13 May 2025 01:05:42 -0400
X-MC-Unique: BbBYweuMOCG-dx4Ct3B5YQ-1
X-Mimecast-MFC-AGG-ID: BbBYweuMOCG-dx4Ct3B5YQ_1747112741
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9203B1955D81; Tue, 13 May 2025 05:05:41 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EC971953B82; Tue, 13 May 2025 05:05:38 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 13 May 2025 13:05:30 +0800
Message-ID: <20250513050530.47541-2-liwang@redhat.com>
In-Reply-To: <20250513050530.47541-1-liwang@redhat.com>
References: <20250513050530.47541-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jvWhxcIDVkN4XTWbQDPL39U6EzJjMfhjKEDAPXjm9aw_1747112741
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] dirtyc0w_shmem: set child_needs_reinit
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index 64b187b35..4b31da831 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -104,6 +104,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_checkpoints = 1,
+	.child_needs_reinit =1 ,
 	.forks_child = 1,
 	.needs_root = 1,
 	.runtime = 120,
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

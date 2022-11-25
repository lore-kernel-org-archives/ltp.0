Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E02EC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:31:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72AA83CC895
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 13:31:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9840B3CC8C2
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:31:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DBB87200D58
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:31:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669379499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XM38j39YKfSJcm1MoXWyo2ZjzlmIC+15mE/tlb4zDo=;
 b=fMc6zGda232jRrXJl9beLwgOREW6Cg9eEi/byPFPEG0BtbBfjNTD0Zs0yDWbo7Ay7Fnf2Y
 Oj3A1pml7qt+iyGU8KwormR4glJPB71pr5GH2G71E041RirdYl2dQFk4bJ8G17BVmZGv00
 lD5lJPC5Mfv9eSOQOXX9BUqjko1nUow=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-gOB27i_5Nb-qg_9U0fmKBA-1; Fri, 25 Nov 2022 07:31:36 -0500
X-MC-Unique: gOB27i_5Nb-qg_9U0fmKBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F1C33C01DFB;
 Fri, 25 Nov 2022 12:31:35 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ABA940C6DC7;
 Fri, 25 Nov 2022 12:31:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Nov 2022 13:31:28 +0100
Message-Id: <20221125123129.102360-2-david@redhat.com>
In-Reply-To: <20221125123129.102360-1-david@redhat.com>
References: <20221125123129.102360-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] security/dirtyc0w_shmem: Fix runtime absence
 of UFFD_FEATURE_MINOR_SHMEM
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We have to test if UFFD_FEATURE_MINOR_SHMEM is really returned by the
UFFD_API ioctl: if the kernel knows about the feature but doesn't support
it, it will be masked off.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
index cb2e9df0c..45cc0ee76 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
@@ -162,6 +162,10 @@ retry:
 			"Could not create userfault file descriptor");
 	}
 
+	if (!(uffdio_api.features & UFFD_FEATURE_MINOR_SHMEM))
+		tst_brk(TCONF,
+			"System does not have userfaultfd minor fault support for shmem");
+
 	uffdio_register.range.start = (unsigned long) map;
 	uffdio_register.range.len = page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

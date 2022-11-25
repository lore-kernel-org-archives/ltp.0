Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D80C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:31:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 109B43CC895
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 13:31:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 579E53CC88C
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:31:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2F48D600357
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669379495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hdpZfX3aiOsUr8KzIHltwMaiPsgft+sAwhXQ8UNhens=;
 b=QJnVZKWMwxuOQF4FXABXNdU8VszeKtOQsyJf0QwyzK3jR7UZZA6iYVzA1p/jFKosUeEtZR
 HIS/rPaLwUzLZ3CKzLpItjLSdCUuh1W1nZTWVxAAhzSqhsJwov9eSv27pgmEQt1O/EMRdV
 /dge1uxY+PMFS8M6nwEDvF6YiVFsZLg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-nzt_n7GZO2aoUMM3-Zp7DA-1; Fri, 25 Nov 2022 07:31:34 -0500
X-MC-Unique: nzt_n7GZO2aoUMM3-Zp7DA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE75D381458B;
 Fri, 25 Nov 2022 12:31:33 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D55740C6DC7;
 Fri, 25 Nov 2022 12:31:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Nov 2022 13:31:27 +0100
Message-Id: <20221125123129.102360-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] security/dirtyc0w_shmem: Two fixes
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

Reworking compile-time absence of UFFD_FEATURE_MINOR_SHMEM and
looking into using fuzzy sync library takes more time. So two patches
separately upfront.

Cc: Martin Doucha <mdoucha@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Petr Vorel <pvorel@suse.cz>

David Hildenbrand (2):
  security/dirtyc0w_shmem: Fix runtime absence of
    UFFD_FEATURE_MINOR_SHMEM
  security/dirtyc0w_shmem: Drop useless needs_tmpdir tag

 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c     | 1 -
 .../kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c     | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

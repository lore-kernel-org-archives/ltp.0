Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E54C5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 10:24:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFE403CEDA1
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 11:24:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4260B3CED00
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 11:23:56 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 281601A0015C
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 11:23:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709288633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TeEzVorVYTFy+tD95V4cELn00LjIcIHOsET60N6mL2k=;
 b=WiLJRSYvneSPsyyUYfP9I7I6ZpWVzOxLdddwTH75Kc7AMrxz2/P/sOxqvg5AtwOCMpjTd6
 2rt0bWjTy/pTLvArA1urZV8WXy1H2X3asAWlfEqZNAf0yiOA9JdTtRZJ7J2IswUJX0Grg/
 XjmqSaXORRwR2E+qUZ5rSfA5n7Zzb/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-dcJVcBgoNjeNhmSSEsgf5Q-1; Fri, 01 Mar 2024 05:23:51 -0500
X-MC-Unique: dcJVcBgoNjeNhmSSEsgf5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 990BB8B39A1;
 Fri,  1 Mar 2024 10:23:51 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED2B112132A;
 Fri,  1 Mar 2024 10:23:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  1 Mar 2024 18:23:47 +0800
Message-Id: <20240301102347.3035546-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_dir_mk: set the umask to '0' before creating
 the subdir
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

This is to resolve the permission issue when creating
a new subdir in the cgroup, in case of system's default
umask is 0077, this will trigger issues for LTP case.

 cgroup_core01.c will report following error msg:
 cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Wei Gao <wegao@suse.com>
---

Notes:
    Hi Wei, can you help confirm if this patch works for you?

 lib/tst_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index a8a598e0e..f6afb51d6 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -361,6 +361,7 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
 			  struct cgroup_dir *const new)
 {
 	const char *dpath;
+	mode_t old_umask = umask(0);
 
 	new->dir_root = parent->dir_root;
 	new->dir_name = dir_name;
@@ -394,6 +395,7 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
 opendir:
 	new->dir_fd = SAFE_OPENAT(parent->dir_fd, dir_name,
 				  O_PATH | O_DIRECTORY);
+	umask(old_umask);
 }
 
 #define PATH_MAX_STRLEN 4095
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

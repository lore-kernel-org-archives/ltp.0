Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1069BEB64DE
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 02:53:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 086F53C0FC2
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 04:53:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 274803C0E16
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 04:53:02 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E4D11600827
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 04:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725850377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LD2eZzZa9wMVxJDt36O0Cke1/KhJPvJot8sE2vYrIM=;
 b=X9ljL4mnIPACVCGPCr6z4/BYv+rf0tVwWs+0wQ402RqM1jt4q05RJhwBD1EeGEjkDNgzaG
 sKqknHV/3KxsX3p8tJayH6NX6FwV5w1qp8lAsI9a5jqTZxXeJceYsBD58DwWkUBhWoao7g
 RERQsr61JwsW2R+TSNLgCoemv1/c4/w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-M9zrpTiHMmqMhZca_QtvRA-1; Sun,
 08 Sep 2024 22:52:54 -0400
X-MC-Unique: M9zrpTiHMmqMhZca_QtvRA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA6E91956096; Mon,  9 Sep 2024 02:52:51 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 847311956086; Mon,  9 Sep 2024 02:52:48 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  9 Sep 2024 10:52:43 +0800
Message-ID: <20240909025243.537071-1-liwang@redhat.com>
In-Reply-To: <20240903140326.773060-1-pvorel@suse.cz>
References: <20240903140326.773060-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] swapoff01/swapon01: Define max_runtime 1 mins
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

From: Petr Vorel <pvorel@suse.cz>

Test run mostly below 1 sec per filesystem, only NTFS is very slow
~ 10-15 sec depending on architecture.

Also this is the only tests in syscalls which fails on due timeout on
emulated risc-v with LTP_TIMEOUT_MUL=2,LTP_RUNTIME_MUL=2 (with the
default 30s runtime => 1 min due LTP_RUNTIME_MUL=2).

Based on the test consumed time on RPi0 and RPi4, we set runtime to 60s,
that should be enough even for slow risc-v and not that high for other archs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/swapoff/swapoff01.c | 1 +
 testcases/kernel/syscalls/swapon/swapon01.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 314630267..965d17cc8 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -53,5 +53,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.needs_root = 1,
 	.test_all = verify_swapoff,
+	.max_runtime = 60,
 	.setup = setup
 };
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 49915c32d..eddcd5788 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -51,5 +51,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.test_all = verify_swapon,
+	.max_runtime = 60,
 	.setup = setup
 };
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

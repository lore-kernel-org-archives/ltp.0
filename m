Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7DC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 18:43:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3DC61078
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 18:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF3DC61078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 510FC3C683A
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 20:43:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C9BA3C697C
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 20:43:19 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AAEA2602511
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 20:43:18 +0200 (CEST)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: krisman)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 913741F43877;
 Tue, 26 Oct 2021 19:43:17 +0100 (BST)
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: ltp@lists.linux.it,
	jack@suse.com,
	amir73il@gmail.com
Date: Tue, 26 Oct 2021 15:42:30 -0300
Message-Id: <20211026184239.151156-2-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/10] syscalls: fanotify: Add macro to require
 specific mark types
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
Cc: linux-ext4@vger.kernel.org, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>, khazhy@google.com,
 repnop@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Like done for init flags and event types, and a macro to require a
specific mark type.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index a2be183385e4..c67db3117e29 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 	return rval;
 }
 
+#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
+	fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
+				    fanotify_mark_supported_by_kernel(mark_type)); \
+} while (0)
+
 #endif /* __FANOTIFY_H__ */
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

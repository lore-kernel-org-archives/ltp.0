Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D04C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:42:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8522B3C95B5
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 12:42:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7C8B3C0F3F
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 12:42:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3EEBC600A09
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 12:42:32 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5AD3221C8C;
 Thu, 23 Jun 2022 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1655980952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3G5lUk5WZMcqPLAFoSs9KKD/kTQfLc8DF+yEhaWhJAM=;
 b=byeGDpv/OKes7O1myxCJDYcx9cfd5fpTVlexeSE9FpkvHVkV+3SIMpp3xA4BRxjLFwns7i
 Kt/bKtpXCr5rtWdFG7SBlCg3X4n6wHNjmixm1s78GX+ZIGvcL34O2IDOeOfk9eSPPJgpCy
 NK0HZMOxQRG4V0PJS/fBlbbcDRx1ZiY=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id 230262C142;
 Thu, 23 Jun 2022 10:42:32 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 23 Jun 2022 11:42:23 +0100
Message-Id: <20220623104224.18751-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] API/bpf: Copy more map and function types from
 kernel
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

bpf_prog06 needs ringbuf map type.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/bpf.h | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index f9e50c6b7..73e4d12cc 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -130,6 +130,12 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_QUEUE,
 	BPF_MAP_TYPE_STACK,
 	BPF_MAP_TYPE_SK_STORAGE,
+	BPF_MAP_TYPE_DEVMAP_HASH,
+	BPF_MAP_TYPE_STRUCT_OPS,
+	BPF_MAP_TYPE_RINGBUF,
+	BPF_MAP_TYPE_INODE_STORAGE,
+	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_BLOOM_FILTER,
 };
 
 enum bpf_prog_type {
@@ -428,7 +434,33 @@ union bpf_attr {
 	FN(strtoul),			\
 	FN(sk_storage_get),		\
 	FN(sk_storage_delete),		\
-	FN(send_signal),
+	FN(send_signal),		\
+	FN(tcp_gen_syncookie),		\
+	FN(skb_output),			\
+	FN(probe_read_user),		\
+	FN(probe_read_kernel),		\
+	FN(probe_read_user_str),	\
+	FN(probe_read_kernel_str),	\
+	FN(tcp_send_ack),		\
+	FN(send_signal_thread),		\
+	FN(jiffies64),			\
+	FN(read_branch_records),	\
+	FN(get_ns_current_pid_tgid),	\
+	FN(xdp_output),			\
+	FN(get_netns_cookie),		\
+	FN(get_current_ancestor_cgroup_id),	\
+	FN(sk_assign),			\
+	FN(ktime_get_boot_ns),		\
+	FN(seq_printf),			\
+	FN(seq_write),			\
+	FN(sk_cgroup_id),		\
+	FN(sk_ancestor_cgroup_id),	\
+	FN(ringbuf_output),		\
+	FN(ringbuf_reserve),		\
+	FN(ringbuf_submit),		\
+	FN(ringbuf_discard),		\
+	FN(ringbuf_query),		\
+	FN(csum_level),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

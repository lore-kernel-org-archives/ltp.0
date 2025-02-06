Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D6C02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 21:25:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C9593C92CB
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 22:25:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307343C6BFE
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 22:24:49 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E4F4A102118A
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 22:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738877087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oe7BpYmOH3rnLkc4+DZeNaQm2FjAtuRoHSoGNRUocJE=;
 b=hTDjoKDtq0nWAtDUrc2i1yNKwoxyVH+SF62ynF3NZl4gMsuD3x/Bw1UdK3kj0WFLasJtCV
 6dVGgf4TfjHvzSP7Q/zl0zEOhMbk+qaVDRrQxMLX2Dg268dbmQ3Qhk1RfEnBRxXXwxATrn
 TRPW+Ait8ozuci7L4gw3PHmGNQsGz/0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-mvNmCeTFP_ermLxLs3KXbg-1; Thu,
 06 Feb 2025 16:24:44 -0500
X-MC-Unique: mvNmCeTFP_ermLxLs3KXbg-1
X-Mimecast-MFC-AGG-ID: mvNmCeTFP_ermLxLs3KXbg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C027B1800874
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 21:24:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.64])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E180519560AB
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 21:24:42 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 22:23:44 +0100
Message-ID: <0c8f014b5a9092bb1f6cc3dca6d1946c5e9cac39.1738876985.git.jstancek@redhat.com>
In-Reply-To: <Z6TCWQIediqqUUVW@yuki.lan>
References: <Z6TCWQIediqqUUVW@yuki.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZunDjuiHx1iRBApMOT_dy062D6abGxfVDT6VBB9zm9A_1738877084
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/bpf: zero-initialize bpf_attr including
 padding bits
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

gcc 15 stopped zero-initializing padding bits:
  https://gcc.gnu.org/gcc-15/changes.html

However kernel bpf syscall checks that all unused fields for a command
are set to zero in CHECK_ATTR() macro, which causes tests to fail with
EINVAL.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
v2 changes:
- Use slightly better version suggested by Cyril

 testcases/kernel/syscalls/bpf/bpf_common.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index 95b5bc12eaa4..9148b0437279 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -49,7 +49,10 @@ int bpf_map_create(union bpf_attr *const attr)
 
 int bpf_map_array_create(const uint32_t max_entries)
 {
-	union bpf_attr map_attr = {
+	/* zero-initialize entire struct including padding bits */
+	union bpf_attr map_attr = {};
+
+	map_attr = (union bpf_attr) {
 		.map_type = BPF_MAP_TYPE_ARRAY,
 		.key_size = 4,
 		.value_size = 8,
@@ -64,13 +67,18 @@ void bpf_map_array_get(const int map_fd,
 		       const uint32_t *const array_indx,
 		       uint64_t *const array_val)
 {
-	union bpf_attr elem_attr = {
+	/* zero-initialize entire struct including padding bits */
+	union bpf_attr elem_attr = {};
+	int ret;
+
+	elem_attr = (union bpf_attr) {
 		.map_fd = map_fd,
 		.key = ptr_to_u64(array_indx),
 		.value = ptr_to_u64(array_val),
 		.flags = 0
 	};
-	const int ret = bpf(BPF_MAP_LOOKUP_ELEM, &elem_attr, sizeof(elem_attr));
+
+	ret = bpf(BPF_MAP_LOOKUP_ELEM, &elem_attr, sizeof(elem_attr));
 
 	if (ret) {
 		tst_brk(TBROK | TTERRNO,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

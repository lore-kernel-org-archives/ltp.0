Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601E2C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787911067; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=06tr5bVlDDreo4b6U9ob8/5Guq5pHPWNjw9q+Xe+XN4=;
 b=O83AgnOcfNZlSQt+gWjdO3t/eQxjmpnZqXrOJjExKrZpY1ZK0CATfq8w7L+NdDetCodIK
 QiEidmD4ErwiG6MHapGQcctMQutOSVJPuz/XlExUgCIvENAmLMaUx7tulp1LD8m/auV6dw/
 MAIyV3giiCaY/0MtSPCMc9+6zrygRU4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8A083E2FC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:57:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35DA93C5542
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:57:27 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98AE91000A51
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:57:26 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso5548815e9.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787911046; x=1788515846; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5fVzEpdAF4m5Uyh7VX840n78g5HN5yDLhsJ55T8HRPI=;
 b=C8rF0EZIMJ/liP6hc4d8H94RjiFyZEz+b1mHXxyfyiW85aYm7LXXFUnjZJK++ghxMn
 Usw0lS7IsMZDBKYUXt7vJWjW6L7ogDL+t/N308HJ4INOk1IWSPc+bWS5M3EW8i1ZJZ47
 LcVIMP2P2mSyj7/zRrh+lV7EWGgKHUoSg+K979lhAODxPOx2wCTAPy4tJZyCPzf6fP2o
 0VzF2liRpKW/KPm/rsLhKhnffbJqnqMdeFmertg9u/OMDThNkqobdE09tnzil6wiHonF
 k3OAlDa+zF0Kjn/9b9TU2Ffva5Ncjk924umyyope28Ixh4FiACecHBEA/pwIqiv/fI/7
 udCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787911046; x=1788515846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5fVzEpdAF4m5Uyh7VX840n78g5HN5yDLhsJ55T8HRPI=;
 b=dAbO/FDL5ilbMqkmgEvpnFUkiR/35MMYgXv54qAA2BvetAdtGy80FzXAK1Phd1UM5l
 dSegwYtVA5nQFVND3a8TLB70dAv+7G9K04LQVr4VBnhJx5UGGeLocH+ZcH31aEMHifu9
 +LxmJf+QHwG/zB4rOlAZb4DMlqafDSXP+F/MeDKA2CsQ9eWk+kU/G5pWspe+lS+p9OBO
 7Y4HKKCFL3Ko5sM5DDaND0mEM24FfmLMcHIeRRC2hX/hf7l2X2yGb8W4jMAVODdq425D
 t2dpySwrP4J8D+J0wZvjErc3HfT2LQzWSojztOp7LKS4wZNp5c/+EYozMDnAxv0+lpRX
 CjJg==
X-Gm-Message-State: AFuF++k1xjnE5LCGfa0kbwA0P/WBOQJL0gOiYNrGtsEOa4qcoV6JWQxv
 sJT99xOXbRLNAsBLZHqL0wGyYq0sfab2X0EEZBj1waQOFeAOXsnFFSbx347nK25JYZ0rtTkclPj
 /ZfqO0cA=
X-Gm-Gg: AR+sD13pA5D0sqXyWRGgyTTl5W1tcPofTzuJtLkWG1ZuQDk7esUCZhhsUlb8IWu2eIQ
 qB6BUEvpAsGuRXakj4tOnbFPebdcbjCKJlt/zfJYZ3hqHdpCoV0oVhz8w1yXVEHdN8e1SX/GZU4
 8Dd992qcuJVtQ6h0DtvY9WhvNrStCeroETfWuvw18z1pO4yPH/QoiJ7TaELiyh0zUCCQKbdoCYq
 csLVFt1DaB0ZB8YQ7X71HaIGItcTSbWJ0H9xp1L4luYNNT6s4OTysd4ZfFf7TrnXkyiD6p6Pi4/
 oBB99ZRXCj9uiSmDDOxJzb7Ov5sYOmvELnALTVHyp+CScF/3Oa+LgXXHjUixf/XHb4t9ECn9Q3X
 ITsvgTOPaHc+OHm8601o9ZfzTB9aAJLt9ggyy5IxgDb8qWP5BE+GFNqsUe3mY71am1QqmDAvPxw
 ty4ybysl3896Qa+KgUIosAEhgcCW95siPwe8aoOzvNf79pgA==
X-Received: by 2002:a05:600c:c490:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-49b91c17294mr81524475e9.1.1787911045274; 
 Fri, 28 Aug 2026 02:57:25 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c321184sm149926645e9.11.2026.08.28.02.57.24
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 02:57:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 28 Aug 2026 11:57:23 +0200
Message-ID: <20260828095724.194900-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setsockopt08: Handle EPERM from disabled compat
 xtables in userns
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Since kernel commit ec1806a730a1 ("netfilter: x_tables: disable
32bit compat interface in user namespaces"), the compat xtables ABI
returns EPERM when called from inside a non-init user namespace,
regardless of privileges held there. Since the test isolates itself
with tst_setup_netns(), it always hits this path on 32-bit/compat
runs and can no longer reach the CVE-2021-22555 code path

setsockopt08.c:139: TFAIL: setsockopt(3, IPPROTO_IP, IPT_SO_SET_REPLACE, 0xf7f0c800, 1): EPERM (1)

So treat EPERM as TCONF instead of TFAIL.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt08.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 37051512517a..3d1838f6ed73 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -82,6 +82,13 @@
  *  * the kernel will insert four bytes of padding
  *    after the match and target entries each.
  *  * sizeof(struct xt_entry_target) = 32
+ *
+ * Since kernel commit ec1806a730a1 ("netfilter: x_tables: disable
+ * 32bit compat interface in user namespaces") in v7.2, the compat
+ * xtables ABI is rejected with EPERM inside a non-init user namespace.
+ * As this test runs isolated via tst_setup_netns(), it can no longer
+ * reach the vulnerable code path on such kernels and reports TCONF
+ * instead.
  */
 
 #include <netinet/in.h>
@@ -135,6 +142,11 @@ void run(void)
 	if (TST_RET == -1 && TST_ERR == ENOPROTOOPT)
 		tst_brk(TCONF | TTERRNO, res_fmt_str, fd, buffer);
 
+	if (TST_RET == -1 && TST_ERR == EPERM  && tst_is_compat_mode()) {
+		tst_res(TINFO, "32bit compat xtables interface is disabled in user namespaces since commit ec1806a730a1");
+		tst_brk(TCONF | TTERRNO, res_fmt_str, fd, buffer);
+	}
+
 	result = (TST_RET == -1 && TST_ERR == EINVAL) ? TPASS : TFAIL;
 	tst_res(result | TTERRNO, res_fmt_str, fd, buffer);
 
@@ -163,6 +175,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b29c457a6511435960115c0f548c4360d5f4801d"},
+		{"linux-git", "ec1806a730a1c0b3d68a7f9afe81514fb0dd7991"},
 		{"CVE", "2021-22555"},
 		{}
 	}
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

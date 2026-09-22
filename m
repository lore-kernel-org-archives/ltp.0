Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB29C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790091508; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ltxLw0qNGb7q9DMeKQzh1wud7g/KpaEtYvQkji9cQiQ=;
 b=IIqADy2F3WFZFtiu6Rgnig1s6U5yIzhz9QE2AcIfztk8h013pISBp04aicL/3lK0S5CzS
 dztAYX3DRWjsbWritOyf7sOdNaOpVrTjLrT32okkrfvXBDZX8J/OCCoDNtk/8AaTnrM/HCi
 7roQdFz/pzux7SkWJrzJGUZOa7FbTGk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECE663E6CEF
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 17:38:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 018BC3E65D1
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 17:38:06 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E8DD14004E1
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 17:38:06 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so32300325e9.0
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790091485; x=1790696285; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l0AR++E99akRvILbgaFPQ3qN2cq6Zhe62/zOh1jyiQA=;
 b=IOmVL8M2NrzOFScBOFFAY4iqO8yn2rV0Wq+rwIXGFjMdPpZxq5is7nLtOMyr0R0dtx
 9aUvCgXstR2p+ons8PloYvhDVUdNN1OpU+Ow22kZBo0hxtYsSMpHvYOO1s3upjXCFZev
 xbDBBd8XBw1GS60FKqGadm9/yTFZB9+vx4005jdLzhX5ilH1Uy+Tuo9y4w8nwYeXzSwe
 q3vZYeNuXpuYEBqpjDzpBiDv50ktl6nd363kynTgRZZ8jgN/F/A5uXvHd3w3L+wu0cJ1
 6Wx0KsqX0VlVborbYPP5T/EOllDH2MMOTQRxFN69+q3vpw8ibfChsMrKnYqcYWRDFIbC
 +AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790091485; x=1790696285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l0AR++E99akRvILbgaFPQ3qN2cq6Zhe62/zOh1jyiQA=;
 b=k86YP2Cxx+qizfTMCRpOCtx1cAe60EyB/9lVtEaaFmLGejHQIH1exPqmIjTAttnKF7
 XWcLA0+YeOzCZ88BzL61YfI0kJjTwbqDvx3wesWGggohWbMksaP67FhmUbXJ1edzdGiu
 30cQljq2PZudktiCB2749yYMDaStBiwvEaFL6zNNB8vPOj2GB5sNMH8x0+jB0mqMy3Yo
 NfUcS4jkWcuTCvzCVbHivTxBRKJN70jywTqE+lSLtnR96xEZQTLyQ2zuqLyFrRUw/ZWF
 D7jPwiHu54y6Tdee++0wATCRbN4feRmGtktoIBz44bkoXMf4NpSDGxszLYq5zh5V7TTl
 PyiQ==
X-Gm-Message-State: AFuF++k68gKHvFtR+5jt7pyuJAgTRkbA03kxX+q05ltadqPMe56zOQTB
 JEVhio3LvrzbUZwwI1o5q5xfnu5+vA065Z49ZTI1xix/VLazpD1pJcxhiAz98E08veyNMf6x56C
 PoYmrL0M=
X-Gm-Gg: AYBFou27ijL9NHo78xAPW+BTesv/5Dc/uLVWX8WIehuUI6oWholdX9+BqRz80hhScAQ
 vDXJowgdc+zgVCEyJK1eQBtTsxVp7tQngPocshHnczL2ozji7YFBlR9J8pqKkA01vBTNc0F8KhW
 i9OM6o8MR2iKLHr9qOqq+Tz4X0i8DurhPE32tZ7VSVDoIkjCh5RyBJ/8Ujtx4+UCiORvLgCxMbJ
 oYR4ZQ8IMeAdieRHn4Ve1ev3oiHn2C1mkF38qWDMgTRR7yWc1TkmvPeGNigAZrkBtLGBg1FUSlj
 R6ly9w4GP6XvmfPwcaioy1Jd3NW50tw1FLNQVFCxIUoehcb1bfQpeiEBBlkrpBEU6cd6Ho3ygaB
 fJKptfh1+X0BATjiPHQu9QDf6SUP5iHTYafpeyaG/88tn3J6BO/+vDa4AhwZ6ltU75FRqXI3fnB
 3F649tQiY2a3vl8KzsRm2mCGtrzCPEG/nlfo/LwgQoHG3sOfCQpccLT4+b
X-Received: by 2002:a05:600c:8b88:b0:49b:96a0:5c00 with SMTP id
 5b1f17b1804b1-49fd7854842mr60610195e9.13.1790091485448; 
 Tue, 22 Sep 2026 08:38:05 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1001])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaec8ebsm55914795e9.2.2026.09.22.08.38.04
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:38:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 17:37:59 +0200
Message-ID: <20260922153803.257734-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] bpf_map01: Fix inverted condition for array map
 lookup pass
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

The check "if (i < VAL_SZ)" after the zero-value scan loop is
backwards: it fires TPASS only when the loop broke early (i.e.
a non-zero byte was found and TFAIL already reported), and stays
silent when the loop completes normally with all zeros as expected.
Report TPASS when i == VAL_SZ instead.

Fixes: b51732825077 ("BPF: Sanity check creating and updating maps")

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/bpf/bpf_map01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
index 7fcf8e00fe4e..97cebf6bf6f3 100644
--- a/testcases/kernel/syscalls/bpf/bpf_map01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -82,7 +82,7 @@ void run(unsigned int n)
 					break;
 				}
 			}
-			if (i < VAL_SZ)
+			if (i == VAL_SZ)
 				tst_res(TPASS, "Preallocated array map lookup");
 		} else {
 			tst_res(TFAIL | TTERRNO, "Prellocated array map lookup");
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

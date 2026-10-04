Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9FDCA5FF0
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 21:17:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 946B63E4E73
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 23:16:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4323E4E73
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:55 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6213140004E
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:54 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a1706a2b24so2790835e9.1
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 14:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791148554; x=1791753354; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZocAnfHvf7+dUmLuQVBrp5wWHjUloZlWgXA/iv9cUo=;
 b=JfMS/vnpyEVpUSKiRhGfIQnJ14BgcuQDA9kvZ41QApenmsvnhW/eNimNdaMQd/nOzt
 vBmFW75g/vrUkUFzr9UuqoghhCjeOYE9Ar/suzXRPxjSv0JHSvQxk9oUxaIAHwHAqOUI
 3OneN7kUKLtqD+NLNREB83b4eXX8rPowOvKsyeL6N+PHjveqK5OFBT86OBwEf822fqQs
 AyTQDkr7XMiJnnbzqBeN2SejXQFYd4mKxFQSgUX80c8e+z/5LiaF9kYjH8jEs+TRuUYI
 k8ouWEVbs3KuXyW9IkVD5j94io5oxfy9p7P0jmhSSSUDsnycaO7LN4QOGg3v9G18OopD
 GfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791148554; x=1791753354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mZocAnfHvf7+dUmLuQVBrp5wWHjUloZlWgXA/iv9cUo=;
 b=rLb1+5LTrMNT0wKujUhIazYURipiuGV+10ODon4sF8syh+bFjMu8J53fKnQYqpZlcz
 UZYCp2pmDTI+/2KYIO6c+pTlX0y07b1kRYBHCDZrpA97vDKGdy1EFc8Z4pN3/eUrldf4
 YIutYXQM+hklUpz54jmbsf+XbGMnTGBSwCyLHU4VGZC229O8tkP8CfhokeOZ5uDWcNRc
 vTf8i2EpcooYnvFPAPCGdaqvfu6ps9EAQmikSa2itoUiHzUROCLzSbRgn4eQdHn0jb7b
 rNeaHsTgHdhPeB5ADifmIfKeJpQ6KLv0jt0ktVNOOSdmDHDBs/Q9GZchGA3U5j+dkT0f
 lORA==
X-Gm-Message-State: AFuF++mcEoL/my7PnkL1GOdv6BHrzLmV0luz37P3OzQ1tIcmKEh0UGau
 tcxXqpf/hLRXZmeV4vRuZq8hSfMd3olBCN4B71UBBnN5OJYIyVTpUGWNdlfH7pVJ4xc=
X-Gm-Gg: AYBFou1+5R48XzfA+M6JLLD8dfXLoHnSsjZzwhRDZQHDrY99pvgiY9tL3UbHJ4lcv/c
 utV6ApJSHUWW2EnG4qXSPaQfsCaSjgnISPtd+jLI/VUqSMN8+ugVdkWFM3485eotvDUB6fSZ4Fv
 jFkj9YjS3qClBPTjuZbwcO1lSagPbNNRtdHRGInC3ExqEkB/5Z0wTuCOgBcIXLURh+3/BT9KDgb
 JhEhk2H3KfqjEsjhZ3SaBJuH4xgq94UgZf/bw3qeBxWdHHBnkECjg8oWR6n6/K3sW/u7gYCqCSi
 k5P9giGStaS8RZBsqIsJwFvRXVO7QE0JrSyRb8t+rqTN9PDZ6rej9JmvWwQgbxrfNOFtr/RB+XF
 3bp/AfS+2MwKQ+Eqgp/4I1Ycs+3t845hFKawhftBe3JJMeMUZoA9RNjG2uFzlzef4Z3NdPK8gSo
 C5i2G/HL+rxcQCJHT0EMzXyFwC2wuUnfnvtPP44Cc99xZuWCU0Mxw7PtD3sHtPX8VAVMt8qaeww
 7wiTF3WXtGjRDXQ+oVe9zkQqfdPJ/9MgpsphDybB1/D5xCcA4ZXkR7cE8NcgmSt+Hy8+9ALkTtx
 3bE15xUAvOUfBazGkm/RCE0=
X-Received: by 2002:a05:600c:6092:b0:49e:6778:c2bd with SMTP id
 5b1f17b1804b1-4a027543095mr135728095e9.6.1791148554032; 
 Sun, 04 Oct 2026 14:15:54 -0700 (PDT)
Received: from pradeep-susarla-LTP.tail3351fa.ts.net
 (cmbg-20-b2-v4wan-174372-cust280.vm17.cable.virginm.net. [80.3.67.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03950375dsm115151725e9.1.2026.10.04.14.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 14:15:53 -0700 (PDT)
From: Pradeep Susarla <pradeep.susarla@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  4 Oct 2026 22:15:35 +0100
Message-ID: <20261004211535.7307-4-pradeep.susarla@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004211535.7307-1-pradeep.susarla@gmail.com>
References: <20261004211535.7307-1-pradeep.susarla@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] numa: Fix out-of-bounds write in
 gather_node_cpus()
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
Cc: Li Wang <liwang@redhat.com>, pradeep.susarla@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The trailing-comma removal

	cpus[strlen(cpus) - 1] = '\0';

runs unconditionally after the CPU scan. When the node has no online
CPUs (e.g. a memory-only NUMA node, a case write_node_cpusets()
explicitly anticipates), the cpus buffer stays empty, strlen() returns 0
and the unsigned subtraction wraps around, writing a NUL byte out of
bounds. Only strip the comma when at least one CPU was appended.

The bug predates the move from testcases/kernel/lib/numa_cpuset.c and
was spotted during review of the libs/ migration.

Signed-off-by: Pradeep Susarla <pradeep.susarla@gmail.com>
---
 libs/numa/tse_numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libs/numa/tse_numa.c b/libs/numa/tse_numa.c
index 3852e0c..5a25227 100644
--- a/libs/numa/tse_numa.c
+++ b/libs/numa/tse_numa.c
@@ -255,8 +255,9 @@ static void gather_node_cpus(char *cpus, long nd)
 			strcat(cpus, buf);
 		}
 	}
-	/* Remove the trailing comma. */
-	cpus[strlen(cpus) - 1] = '\0';
+	/* Remove the trailing comma, if any CPU was found. */
+	if (strlen(cpus) > 0)
+		cpus[strlen(cpus) - 1] = '\0';
 }
 
 void write_node_cpusets(const struct tst_cg_group *cg, long nd)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C12C36010
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 18:14:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C0283CB341
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 20:14:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48A613CAD8B
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 20:14:28 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.223.166;
 helo=silver.cherry.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from silver.cherry.relay.mailchannels.net
 (silver.cherry.relay.mailchannels.net [23.83.223.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E61760090B
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 20:14:26 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 280157826FE
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 18:14:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a298.dreamhost.com
 (100-126-123-60.trex-nlb.outbound.svc.cluster.local [100.126.123.60])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id CFCDE78271F
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 18:14:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743790464; a=rsa-sha256;
 cv=none;
 b=S5xZAJMC3D6L/nqI9F7MHyne0TxIS2nkYVI6pCvh1S1pBhsCMkt2Ftm8fcnEps1mXdfkP7
 a5h1pHbzcrWGf5JMs9msS2p1DkucF8OueJB3QvTSWYVDNQ/qMEJ8Qc5RWnTIpr2wwao3an
 Z8VB0jZHb2DyPpcdbwBL8NH/PmDSxKzzjRMdoX77LxKXEWrVV3TE/Vf4XJ56Q2eskNYUfA
 l3cWxwulNUBMJ4ra8/aDrf2e1MbPl9ZrXNVR5+srLlB8TzGfahJOQK4JMYM7b6wT7ADLdx
 z252fbn1PTBPZbNbmFj6Zso1FOyzo/EX1l457UiAaNYl7K9qnr0QT8T6rZ7jiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1743790464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=b6s3tZ4AEdGrD0yS09FNf10FfpN993f6YVdDseSnIjQ=;
 b=+L5nF/8q2BVqvXq0W5JOdAl/pRgNbzzbIqcdNdoy5BOtGayouGiDmUUjS1viAL2/h9EI+Z
 O/M6FGL6qoJLtEbOCD4sIrA6YNY5DPA/rJ3o7VWmREUpJxOfcWK9yZ0e6k3lvX+cpl8sLI
 kJrS/LpncKzH41vPBVxLu/A18KwhQWA6A9KVhY/eIJZse5uAFOH8Y7clG45q7rzWMaMPPN
 qM6p2q0GpRHRV15A+Lafa9/+igfvxKXUCfYO+s//nedH2P1eQjPHwJtswKdD6+S9QsOFj6
 gsH9yKIRDyikfjVmsFSLa77XeB+QgAvjdHRhgRY2oxxUGFF6XYIH5ZB2mQA7bg==
ARC-Authentication-Results: i=1; rspamd-6c88b8f79f-thj5h;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Illustrious: 5df2d7d163f38df1_1743790465052_1052954860
X-MC-Loop-Signature: 1743790465052:2040200311
X-MC-Ingress-Time: 1743790465052
Received: from pdx1-sub0-mail-a298.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.126.123.60 (trex/7.0.3); Fri, 04 Apr 2025 18:14:25 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a298.dreamhost.com (Postfix) with ESMTPSA id 4ZTmw02qSFz9G
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1743790464;
 bh=b6s3tZ4AEdGrD0yS09FNf10FfpN993f6YVdDseSnIjQ=;
 h=From:To:Subject:Date:Content-Transfer-Encoding;
 b=D8mOQMeAccr08CzQ7203yhCW6ex+plRgmsPH+Tmy7yC38tWG4ewRS/p80YRWEkFWs
 ijMR8GZdQ1NF6TViwfAaRYYsDWwZhFo/I2HdzhX4lU6B5zcarqebBZIUpdwLkxsOaj
 0dlslF37rJzPOR0MKgPD0/X3PDoj0ivG6URIE30rJz/99tE7HouXdDEP4lD/qyv+LV
 mVhLQ9fKqkwey4FI1R5HcdT4Qka9KlB/mEbR9PM+f1Psn3Bhm9tsDeGQ21BX95WbpL
 O4z0MlpC3ZL5dXAu0dpolJkx1ey08yJznqS7kvxgUhKby3tPejHmQYD/939h9AQQ8S
 G47mf6IKQoG4g==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: ltp@lists.linux.it
Date: Fri,  4 Apr 2025 14:14:06 -0400
Message-ID: <20250404181406.2385612-3-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404181406.2385612-1-siddhesh@gotplt.org>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250404181406.2385612-1-siddhesh@gotplt.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Add centos10 to test matrix
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

gcc on CentOS 10 is configured to build with AVX on by default
(specifically, -march=x86-64-v3), unlike other compilers, so it should
be a useful addition to the test matrix.

cve-2015-3290 for example fails to build on this without `-mno-avx` in
the build flags.

Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
---
 .github/workflows/ci-docker-build.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 44dcca055..310d8c3a3 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -67,6 +67,11 @@ jobs:
               CC: gcc
               TREE: out
 
+          - container: "quay.io/centos/centos:stream10"
+            env:
+              CC: gcc
+              TREE: out
+
           - container: "debian:testing"
             env:
               CC: gcc
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

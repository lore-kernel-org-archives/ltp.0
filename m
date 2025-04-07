Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98236C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 10:25:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1032E3CADFF
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:25:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 741AA3C264A
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:24:56 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.210.30;
 helo=caracal.cedar.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from caracal.cedar.relay.mailchannels.net
 (caracal.cedar.relay.mailchannels.net [23.83.210.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 773211000966
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:24:54 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C120543AE1
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 10:24:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com
 (trex-0.trex.outbound.svc.cluster.local [100.101.70.132])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 76CFE4418D
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 10:24:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744021492; a=rsa-sha256;
 cv=none;
 b=hD9nJM2WjRSH2zfeaJYTzfhOpnuBR2jhH6SCrNwqQG9xSFN+VYFJMvfGtxDBmWGaWdgN7R
 6rdiq1hYbevP/oCQk2fMfMHHaujEcHriTqFovIHXtApv+nzm+51NyCw1MrGcNHrh+hSzWK
 xjtCl6g0gV4fdYr//4alAmRmZFqFHCVzxyTHZkEUe3Gb8miHJi1k8MdxlpmZ4UvVuXao0b
 i9uSz7cE26QmhZ1rJ27pggXDMKnQMS2knRTHNgftd2TsrnB3J2BkbzKf0XZ+efYGjivvaT
 cbk9/iG/nKKrY1YlmAbQLLbPuCOuWRSN1tVs6vSvAjx5fzjUwd2FSgd/fKqgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1744021492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=b6s3tZ4AEdGrD0yS09FNf10FfpN993f6YVdDseSnIjQ=;
 b=Vcrl3Mr5SPExAMmB1wqFFYWhX2uuMfklDqviiwQVDCRQxY4fVZYDOsNRbpu7r+gNfqzeGJ
 TCw5+Iok+b2QM2+9rQZ9ZZRJSZemL/aQ90TODw19BdXSVuVS8MkwAZJtXNunamqABctL41
 kYW+4jEAtN2t+wUjWoqmnGWytbAonDrmCydlyhgHafs1LmnE5h5jq5mxgyfwP0A/IJWwAx
 y/PD3rJQCLpjbEU4bnV1CX4JehncwlCzm9IA79/QLpeLqsgvZ2aX4rU0glIg+v7xPiEPfn
 9INQYi9BAJTgmcxGoW07SA6j/Xzs/H0yqDtPr1xJTr3234NFUHM4WqC0n10TaA==
ARC-Authentication-Results: i=1; rspamd-7dd6dcd7db-p645v;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Arch: 1c3336da6ba8f07d_1744021492689_2563659619
X-MC-Loop-Signature: 1744021492689:45463701
X-MC-Ingress-Time: 1744021492689
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.70.132 (trex/7.0.3); Mon, 07 Apr 2025 10:24:52 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4ZWQLr0W8MzQr
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1744021492;
 bh=b6s3tZ4AEdGrD0yS09FNf10FfpN993f6YVdDseSnIjQ=;
 h=From:To:Subject:Date:Content-Transfer-Encoding;
 b=eO1bBYHJvEvTzeCGhECjI2/pNM+uEnGIsN3eDCE7FZYYbkWU5kqGqB28RdNUfgnWN
 OmzixnovT6gKzN5tQCmhxaIZqv5Lov+679Sde3lRJ1ate3O9Q7QUVsRHyLDy8zw0nJ
 bN9HQogAe8MEt0QHMI8dHJLv36BkcuCKzNtMrc36K0DEJDoAvXIbqRNYUVEGWLxeGD
 qzDNRQDlfsptbgPq5YBGPGJ3QjLiVbjP3QwbzT8cjWlERBDZJUsGErHBc0YF6zige6
 n2oHS/U+frd2okWAzYA73gXuX6j6+wyiuDyi5VQk/kp6APlGJ1lxMkeSOVfWmAVwas
 BG0G+jcGViDjg==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 06:24:48 -0400
Message-ID: <20250407102448.2605506-3-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407102448.2605506-1-siddhesh@gotplt.org>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250407102448.2605506-1-siddhesh@gotplt.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add centos10 to test matrix
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

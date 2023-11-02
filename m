Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E69C4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 07:20:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61C553CC841
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 08:20:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FAC43CC841
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 08:20:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A64491000A04
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 08:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698909639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SOcS1EWRPawqmXV98P/kT6gqmz6Ix46w7iKi7UQ/+98=;
 b=TbRYM0FqI8KKB7b+ILYTpO5VszZw/mM8UHaBr9/6ERpX8HALys7G9JYkLFRsVlmuljKn5s
 x/ZZuRkGKTbMBCGzh0Q7B49rFTgCAnknaAkeAmRlqnrlYCWL0UGThuBYARIbts61BqP1qy
 dQjIKSzilt8XAlxHRTUwlgq+E5YwtsQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-C04JD_jNNAiJe3twwaA0WQ-1; Thu,
 02 Nov 2023 03:20:36 -0400
X-MC-Unique: C04JD_jNNAiJe3twwaA0WQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93BBB2825E95;
 Thu,  2 Nov 2023 07:20:36 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC821121308;
 Thu,  2 Nov 2023 07:20:34 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  2 Nov 2023 15:20:30 +0800
Message-Id: <20231102072030.1800796-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: add centos stream support
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
Cc: Chao Ye <cye@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is base on Peter's patch:
  CI: ReAplace CentOS 7 with openSUSE Leap 42.2, Ubuntu xenial

Ci: https://github.com/wangli5665/ltp/actions/runs/6729379565
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Chao Ye <cye@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml     | 12 ++++++++++++
 ci/{centos.sh => quay.io.sh} |  0
 2 files changed, 12 insertions(+)
 rename ci/{centos.sh => quay.io.sh} (100%)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 9a8a66b6d..27cc5fd72 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -69,6 +69,18 @@ jobs:
               METADATA: asciidoc-pdf
               TREE: out
 
+          - container: "quay.io/centos/centos:stream8"
+            env:
+              CC: gcc
+              METADATA: asciidoc-pdf
+              TREE: out
+
+          - container: "quay.io/centos/centos:stream9"
+            env:
+              CC: gcc
+              METADATA: asciidoc-pdf
+              TREE: out
+
           - container: "debian:testing"
             env:
               CC: gcc
diff --git a/ci/centos.sh b/ci/quay.io.sh
similarity index 100%
rename from ci/centos.sh
rename to ci/quay.io.sh
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

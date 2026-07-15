Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951C6C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784120759; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cOPgFoUT0Mx1O+UOAmC6lIX8TJ9cziZBFNzC15FP63w=;
 b=i7bmid1NXuq/pnxYzlg+E93JZ/fwuMBWM6Sd3O6Rexssbr7WoGNIZR+scGg1MXCVQJOiG
 Ko50bcmNzakFZycXLg5UnegPerhm6L1SSO2ZGdysOmnhvJQVoFjYm9tWOST6kjkKdPSGwMD
 JYH5PpRNeenYGUwZRd7JyfxjBNDBK+8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0A9E3E569E
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 15:05:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F50D3E5692
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 15:05:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6FC311400BF1
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 15:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784120702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwWnCpq/6dv9wemihEgUy9W7q1EpJ8aBkSJGaCQMWqM=;
 b=VpsSjk6cAY1tTRlm+EpnuL7JK2sjyWjvqXoWxs/9dQnhDsEFkSnLq688+vnphzM0Xmdm/+
 GeQxZq4uc0czlDFk0+zKNgYUNhmqNZD2Fq2z/v6dWnaHYsUKQjbpQmJPyJ34uwhI1gU5vm
 efLif5cSwuE/FCS0brJ1Qn7AUP457L8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-BcmYiqOPMBmq3HWxYQLjkA-1; Wed,
 15 Jul 2026 09:05:00 -0400
X-MC-Unique: BcmYiqOPMBmq3HWxYQLjkA-1
X-Mimecast-MFC-AGG-ID: BcmYiqOPMBmq3HWxYQLjkA_1784120699
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92CCA1955F78
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:04:59 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.csb (unknown [10.43.3.29])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0294141C
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:04:58 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 15:04:47 +0200
Message-ID: <47d2af729827099ee39179ac27f283f6e989921f.1784119861.git.tdzik@redhat.com>
In-Reply-To: <cover.1784119861.git.tdzik@redhat.com>
References: <cover.1784119861.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nB4m_t4jKKjNC0AgBV37kbbTfRPXiDMFV8v5-txBtdA_1784120699
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] Add some checks for malloc() returning NULL
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
From: Tomas Dzik via ltp <ltp@lists.linux.it>
Reply-To: Tomas Dzik <tdzik@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Current code in directory testcases/misc/math/float/ does not check
if malloc() returns NULL. Because it was a contributing factor to observed
core dump I am adding these checks to make debugging failures easier.

Signed-off-by: Tomas Dzik <tdzik@redhat.com>
---
 testcases/misc/math/float/exp_log/genexp_log.c | 3 +++
 testcases/misc/math/float/iperb/geniperb.c     | 2 ++
 testcases/misc/math/float/power/genpower.c     | 3 +++
 testcases/misc/math/float/trigo/gentrigo.c     | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/testcases/misc/math/float/exp_log/genexp_log.c b/testcases/misc/math/float/exp_log/genexp_log.c
index 7f26945ec..e02d0d344 100644
--- a/testcases/misc/math/float/exp_log/genexp_log.c
+++ b/testcases/misc/math/float/exp_log/genexp_log.c
@@ -30,6 +30,7 @@
 #include 	<stdlib.h>
 #include 	<string.h>
 #include 	<errno.h>
+#include	<err.h>
 #include        <limits.h>
 #include        <unistd.h>
 #include        <fcntl.h>
@@ -76,6 +77,8 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
+	if (funct == NULL)
+		err(1, "malloc failed");
 	sprintf(funct, "%s/genexp", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
diff --git a/testcases/misc/math/float/iperb/geniperb.c b/testcases/misc/math/float/iperb/geniperb.c
index f7bf55c84..98a6a380a 100644
--- a/testcases/misc/math/float/iperb/geniperb.c
+++ b/testcases/misc/math/float/iperb/geniperb.c
@@ -78,6 +78,8 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
+	if (funct == NULL)
+		err(1, "malloc failed");
 	sprintf(funct, "%s/gencosh", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
diff --git a/testcases/misc/math/float/power/genpower.c b/testcases/misc/math/float/power/genpower.c
index 44f7af934..8a8f753a7 100644
--- a/testcases/misc/math/float/power/genpower.c
+++ b/testcases/misc/math/float/power/genpower.c
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <err.h>
 #include <sys/signal.h>
 #include <math.h>
 
@@ -76,6 +77,8 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
+	if (funct == NULL)
+		err(1, "malloc failed");
 	sprintf(funct, "%s/genceil", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
diff --git a/testcases/misc/math/float/trigo/gentrigo.c b/testcases/misc/math/float/trigo/gentrigo.c
index 5f7e0cbc7..4908d0435 100644
--- a/testcases/misc/math/float/trigo/gentrigo.c
+++ b/testcases/misc/math/float/trigo/gentrigo.c
@@ -34,6 +34,7 @@
 #include        <unistd.h>
 #include        <fcntl.h>
 #include        <errno.h>
+#include	<err.h>
 #include        <sys/signal.h>
 #include        <math.h>
 
@@ -77,6 +78,8 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
+	if (funct == NULL)
+		err(1, "malloc failed");
 	sprintf(funct, "%s/gencos", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

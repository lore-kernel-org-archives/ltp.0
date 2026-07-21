Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8DCC44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 08:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784622546; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cOPgFoUT0Mx1O+UOAmC6lIX8TJ9cziZBFNzC15FP63w=;
 b=gV1DYGFcthvPip8JwqfHflznUC1B91FgqAj55NjYwg+hKx6HMC40oi9P5IK5EUzffJxqX
 PnPq8Umvbvunwvb9EmUm/ch6JLEjyT4Jp3vSTlX67krnPvup51y1koHJ4WlJ+PmnGnZ+QaS
 1kEGQgq70H2XUNAXMYjAXPQUTA+VJ1A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 456223E61EA
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 10:29:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEFD13E203E
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:28:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 422966007B7
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784622488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwWnCpq/6dv9wemihEgUy9W7q1EpJ8aBkSJGaCQMWqM=;
 b=LbZgE5NFDhvyL9qb07ZPkH7s3PnoM6G1iyrjKXj9p7db2m8W78hXQQMypdny0BoBUejngs
 zHZ7BVCUF9s+N/60a/uhbb9P6yneGwYw45+S6KnNEaGsQQNIWLhqqtKfQyDbX2+YLlZ+7S
 GP420M3b4BV0oKBEQcvFA5b/axaUxAk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-Ph-_vlsgNUGmI0B9S5CHCA-1; Tue,
 21 Jul 2026 04:28:07 -0400
X-MC-Unique: Ph-_vlsgNUGmI0B9S5CHCA-1
X-Mimecast-MFC-AGG-ID: Ph-_vlsgNUGmI0B9S5CHCA_1784622486
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75BBC1809C8E
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 08:28:06 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.csb (unknown [10.43.3.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9BF6195604D
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 08:28:05 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 10:27:51 +0200
Message-ID: <ea36651f29d0bb5decd84adeca7183b1c1613832.1784183478.git.tdzik@redhat.com>
In-Reply-To: <cover.1784183478.git.tdzik@redhat.com>
References: <cover.1784183478.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Suyl3o70Vynh6cfzTafX5IhLaC4QT57NXfWqSkWTPw_1784622486
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/3] float: add malloc() NULL check in gen* data
 generator tools
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
Message-ID: <20260721082751.oIQzI05OOQANmXhVoYwHKDr6ukD5wZ00EDXplQ-KAj8@z>

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

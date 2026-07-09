Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333FDC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783612117; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=U+f/uS4CetLaWbzUep8WaW2PHP56qV+xi00M3gSsISg=;
 b=eb85d/A+RnpZPyig9S6ynxGFU3SL9fSVYWo4izQgDyTUjkmIF4x/uWdhsy6hywbdVFKTC
 qSm/DmpJUVLxBJ9+WSrDY8ESe+nMFnL+rqtpuyM6Z8WppyhiAN/pzT6i23sHK6EiOgz88gP
 SaVKhyTmiPWWC4o2FQ8sb8zVBG0TtjM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A306E3E68E2
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:48:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05803E5C9D
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 66EFE10009F5
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783611626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYDMplTgxWHB7GNGJEiS8R967OlCdNwa5wSO4YTQQaY=;
 b=PAf75RXa2bqD4X4f7E+WRc4/cXh53GfPYb0m2VflCjtK+KRLEteD/I0SWaQCka1Y0ruMNC
 5s8svcDcxXy+4tGbW+X/Uo39OabZcceQQ+QaBrdsk2htH3y3cSOzCffydpOBb4zmcVqMIa
 jJIHVkJLDEn1yVHzVxuXzWCqEabIIX0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-aGPeAqcKPAq6qwFsPir4lg-1; Thu,
 09 Jul 2026 11:40:23 -0400
X-MC-Unique: aGPeAqcKPAq6qwFsPir4lg-1
X-Mimecast-MFC-AGG-ID: aGPeAqcKPAq6qwFsPir4lg_1783611621
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912B11800260
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:21 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.com (unknown [10.44.49.228])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E357A3000C14
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:20 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 17:40:05 +0200
Message-ID: <968d6e9521f63e11931bc80439e38c72903360dc.1783610933.git.tdzik@redhat.com>
In-Reply-To: <cover.1783610933.git.tdzik@redhat.com>
References: <cover.1783610933.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ujak4CcNwPisH3xWaxecLDwAzLSH_EJt2xlyZLQbUuw_1783611621
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 09 Jul 2026 17:47:41 +0200
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
if malloc() returns NULL. Because it was contributing factor to observed
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

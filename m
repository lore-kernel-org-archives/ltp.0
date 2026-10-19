Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9354CCF2E3
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792413311; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=4qNbZCooBMAZUT5MPUXs0lV4JlSvmRhcVaZ9K0/Etho=;
 b=nKqCY2GNrZwrIWJGlXAlSfGhcksNye+qpFfR45xr0l5lvw9J/TgU+6vDv2hDieypN3ReA
 J20hKlbmH81HCTjNNudti+g+mMavrjd2JFba8Igx0qaNy/N4oWE16QCthvZmVD5NDWMajk+
 5Tt5MCJWxphtLNgVK+qGLUEUVxD3tCg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 154DF3EA654
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 14:35:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 822643E9E12
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 14:34:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 367781A002F3
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 14:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792413288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HT/zW3YeBUe17JIwY/ewMQWmOJ5xDhSze49ljMRQfkw=;
 b=Cogs/0JZ+ZChLfHsd09+GHuFlfluozVhWlrTRJUaRAFKqwyI6gJ7CUCqkhnqReL30N79SY
 u+Xu1hc/DE25foMW9Vc0nfVZK+wOHT2ZYsQRTBf6mCYxykcorQhObHDYG23OGt0ReYYlFc
 r+ZdJbyk713+Zk9IJPQ4OoLpTDMtneE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-8xR4-lsdPCW2rSo_J86avA-1; Mon,
 19 Oct 2026 12:34:46 +0000
X-MC-Unique: 8xR4-lsdPCW2rSo_J86avA-1
X-Mimecast-MFC-AGG-ID: 8xR4-lsdPCW2rSo_J86avA_1792413286
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB181955DB7
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:34:45 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFEB01800446
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:34:44 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 19 Oct 2026 14:34:42 +0200
Message-ID: <dc45087f4a5dd1700aae6df3a8181ae349f2bdfe.1792413269.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Kitp8nyHgIc5evHmjg1s-9RgB6rwWYf_5nYvBrzhBk_1792413286
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] float_trigo: Fix acos/asin/atan input generation
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

genacos, genasin and genatan compute the step between input values as
2 / nbVal with both operands int, which evaluates to 0. Every one of the
20000 generated inputs is therefore exactly -1.0 and float_trigo only
ever checks acos(), asin() and atan() at a single point.

Use 2.0 / nbVal so the inputs are spread over [-1, 1) as intended.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/misc/math/float/trigo/genacos.c | 4 ++--
 testcases/misc/math/float/trigo/genasin.c | 4 ++--
 testcases/misc/math/float/trigo/genatan.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/misc/math/float/trigo/genacos.c b/testcases/misc/math/float/trigo/genacos.c
index 2ad051d26c1c..b15c44d8ff32 100644
--- a/testcases/misc/math/float/trigo/genacos.c
+++ b/testcases/misc/math/float/trigo/genacos.c
@@ -48,7 +48,7 @@ static int create_Result_file(void)
 	F_name = "racos";
 	nbVal = 20000;
 
-	Inc = 2 / nbVal;
+	Inc = 2.0 / nbVal;
 
 	for (i = 0; i < nbVal; i++)
 		tabRacos[i] = acos((Inc * i) - 1);
@@ -78,7 +78,7 @@ static int create_Data_file(void)
 	F_name = "dacos";
 	nbVal = 20000;
 
-	Inc = 2 / nbVal;
+	Inc = 2.0 / nbVal;
 
 	for (i = 0; i < nbVal; i++)
 		tabDacos[i] = -1 + (Inc * i);
diff --git a/testcases/misc/math/float/trigo/genasin.c b/testcases/misc/math/float/trigo/genasin.c
index 4614180e8cca..586bd22d72eb 100644
--- a/testcases/misc/math/float/trigo/genasin.c
+++ b/testcases/misc/math/float/trigo/genasin.c
@@ -48,7 +48,7 @@ static int create_Result_file(void)
 	F_name = "rasin";
 	nbVal = 20000;
 
-	Inc = 2 / nbVal;
+	Inc = 2.0 / nbVal;
 
 	for (i = 0; i < nbVal; i++)
 		tabRasin[i] = asin((Inc * i) - 1);
@@ -78,7 +78,7 @@ static int create_Data_file(void)
 	F_name = "dasin";
 	nbVal = 20000;
 
-	Inc = 2 / nbVal;
+	Inc = 2.0 / nbVal;
 
 	for (i = 0; i < nbVal; i++)
 		tabDasin[i] = (Inc * i) - 1;
diff --git a/testcases/misc/math/float/trigo/genatan.c b/testcases/misc/math/float/trigo/genatan.c
index 959b605bb884..94707c5ffd5a 100644
--- a/testcases/misc/math/float/trigo/genatan.c
+++ b/testcases/misc/math/float/trigo/genatan.c
@@ -48,7 +48,7 @@ static int create_Result_file(void)
 	F_name = "ratan";
 	nbVal = 20000;
 
-	Inc = 2 / nbVal;
+	Inc = 2.0 / nbVal;
 
 	for (i = 0; i < nbVal; i++)
 		tabRatan[i] = atan((Inc * i) - 1);
@@ -78,7 +78,7 @@ static int create_Data_file(void)
 	F_name = "datan";
 	nbVal = 20000;
 
-	Inc = 2 / nbVal;
+	Inc = 2.0 / nbVal;
 
 	for (i = 0; i < nbVal; i++)
 		tabDatan[i] = (Inc * i) - 1;
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

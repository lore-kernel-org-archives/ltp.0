Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F47CD343F
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 03:29:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A04903C73EB
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 05:29:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 924213C7495
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:28:37 +0200 (CEST)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [95.215.58.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB92E2005C3
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:28:36 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779334116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VeXiuxcs6/gIyeBerBQu+tDRKptuQSNG/mrd6/pnLc=;
 b=cYT5toJI4HJxVI5dDHzLUfrNtDD26C/huTxTGTJMTl9NEktLB5jChwCyfSyfwtMGfezWXM
 LovozI/WCw5fXP46Rj1c2Q1soPid9mbo1OGNJBY1m62vdJgy+OD/nKduz/WVUiEZO0ncPO
 oqjZVyXkzAwIcFmowDZ86DpRrrwxPig=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu, 21 May 2026 11:27:59 +0800
Message-ID: <20260521032759.18727-2-li.wang@linux.dev>
In-Reply-To: <20260521032759.18727-1-li.wang@linux.dev>
References: <20260521032759.18727-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] metaparse: Explicitly parse essential headers
 for macros
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

The metadata parser misses important path definition macros located in
tst_path_defs.h. This occurs because the file is included via
tst_test.h, which is intentionally ignored by the skip_includes[]
array to reduce parsing overhead. As a result, the dependency chain
is broken, and the underlying macros are never extracted.

To fix this without parsing the entirety of tst_test.h, this patch
introduces a must_includes[] array and a parse_must_files() function.
This allows the parser to explicitly locate and extract '#define' macros
from specific foundational headers directly from the include paths.

This data driven approach keeps the logic clean and provides an easily
extensible way to handle future headers that might face the same
include-skip issue.

Fixes: da3088183a ("metadata: metaparse: Implement recursive include")
Signed-off-by: Li Wang <li.wang@linux.dev>
---
 metadata/metaparse.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index c495d2eb5..6d50919c3 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -968,6 +968,33 @@ static struct data_node *parse_file(const char *fname)
 	return res;
 }
 
+static const char *must_includes[] = {
+       "tst_path_defs.h",
+       NULL
+};
+
+static void parse_must_files(void)
+{
+       unsigned int i, j;
+       FILE *f;
+       const char *token;
+
+       for (i = 0; must_includes[i]; i++) {
+               for (j = 0; j < cmdline_includepaths; j++) {
+                       f = open_file(cmdline_includepath[j], must_includes[i]);
+                       if (!f)
+                               continue;
+
+                       while ((token = next_token(f, NULL))) {
+                               if (!strcmp(token, "define"))
+                                       parse_macro(f);
+                       }
+                       fclose(f);
+                       break;
+               }
+       }
+}
+
 struct typemap {
 	const char *id;
 	enum data_type type;
@@ -1176,6 +1203,8 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	parse_must_files();
+
 	res = parse_file(argv[optind]);
 	if (!res)
 		return 0;
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

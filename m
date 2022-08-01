Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D876C00144
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 23:36:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 971D73C91F0
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 01:35:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAB403C3090
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 01:35:48 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C6AD200977
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 01:35:48 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-3230031a80fso95725947b3.5
 for <ltp@lists.linux.it>; Mon, 01 Aug 2022 16:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=8q17uUpjvJ3njI6qGZ0e4FiRSSMszINS5MZ2nqml4io=;
 b=ENZychkFVl8ND2i6EPh6EjzLwd3Mai2kw4bx7k5IlDo7CIZMyo9Ohp3RuUtlLOT0f4
 bns6vnNQgdOBJBhH4BJtm6q1P+gHItIOjcqKubw0ApTLehSGYlzIFNQ88PyxrftVj115
 tacbMElEoruCWhUyZ0ZK0rchG4we0NQysl5ajCrBOCUiUTFy/EmlNsBMHDIxhKHtSv/+
 8BwGutWwXrwICJUf6c+27K1rL4BTagpKDvup0P5wgpb5PK66oF0aLoljOK1pLIB5lEDc
 lbUEwVG7KFrnXk5IGxJIfYATFqsmGdfUkW3clL63ZB/9BLcUE52xhLFkeDxxDUGRc7QK
 iRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=8q17uUpjvJ3njI6qGZ0e4FiRSSMszINS5MZ2nqml4io=;
 b=mei6DLGFavwzXIgUDylWTFnMr7GPEmQZBgIrdQVDCSdoeH2QveYyBIEpTsQdtyMoBZ
 8QfM5l60Oewei8HQNRKAaodsTat6MR29WTQuruo8r2q+OHJwcf1gS2EohB48qxhepfHd
 e3ztopj+SO1brMOiL/IBeFEh9R8Aie8ae/qmGU3VyK4Ys3U85412EzZ1ks/iFCdCA9Ax
 4WI2yXvoLjtMc4kPL2GAZn0PPSwc5UKeZ8GDuh00rNqOp+ADgpKVCytgmIkgaq3JtlXU
 hRFCKmWYdLfn2+oPPKWoVY0bUwCL7OHpzrY3X1xHeDbEjzMXNAjEUkdqFFDUdEIAutXG
 j/Qg==
X-Gm-Message-State: ACgBeo15JnQdTZIDq3cd3ccjg6Khtg1v4rIIltR7GT7CQk14EGQYlUDW
 iqvn5tFVlmE6L5B8yLdEhtXdRNEenK+1bNSrKuMO7nbNJjOxgc6d2DB2p8QAVZ5iWQ0nVOTtDWM
 Tgvg1whLTBDY9G86CZOdBumYpxCxlM8S9Zw8H/8SO0C4jfQY3QgATZ9lf
X-Google-Smtp-Source: AA6agR7p6PczMOB6e03mXcR+otgA/YizDyfD2ynlzgEmmhJVxf/e+Vfc0QJbYHC3P+WcdT1NP4Hml6gUi+k=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4be])
 (user=edliaw job=sendgmr) by 2002:a81:8145:0:b0:323:26f5:2c8a with
 SMTP id
 r66-20020a818145000000b0032326f52c8amr15613419ywf.261.1659396946912; Mon, 01
 Aug 2022 16:35:46 -0700 (PDT)
Date: Mon,  1 Aug 2022 23:35:40 +0000
Message-Id: <20220801233540.368009-1-edliaw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscalls/pread02_64: format string for 64-bit
 offset
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When compiling as 32-bit with _FILE_OFFSET_BITS=64, the format string
needs to be specified as 64-bit long (%lld).

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/pread/pread02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index fda5fd190..5fa011ef2 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -42,7 +42,7 @@ static void verify_pread(unsigned int n)
 	char buf[K1];
 
 	TST_EXP_FAIL2(pread(*tc->fd, &buf, tc->nb, tc->offst), tc->exp_errno,
-		"pread(%d, %zu, %ld) %s", *tc->fd, tc->nb, tc->offst, tc->desc);
+		"pread(%d, %zu, %lld) %s", *tc->fd, tc->nb, (long long)tc->offst, tc->desc);
 }
 
 static void setup(void)
-- 
2.37.1.455.g008518b4e5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0766C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 13:23:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 043123D0EB1
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 15:23:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DDA83D0E66
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:23:12 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 655E51402FA7
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 15:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718976189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p24WDtziGdbRFjGuz21alRw3rNYY+eEB1F43egA0xM=;
 b=TCEKP5cdY83vwrAc55OGppUhjM++GQd+M69GcyXHZ/57ACdO/e3nHmizYCscjoDlLB3TsA
 luc8odidJSDZ9q652SyDcTTwGROujTO8Inda9SoKOKBv5/HuOBgZHUonKg1L34UiV0JYTP
 8WITc9A3Xvaq67rh8Y+Vi1khueqhFak=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-ojIkWBE2On2dtIDSJ9XKaQ-1; Fri, 21 Jun 2024 09:23:07 -0400
X-MC-Unique: ojIkWBE2On2dtIDSJ9XKaQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7064777603fso1768178b3a.1
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 06:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718976186; x=1719580986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/p24WDtziGdbRFjGuz21alRw3rNYY+eEB1F43egA0xM=;
 b=CcFIPprDBfVj+H0QW2qWAnR2Q/iIj/YUbL3/Xm8/rOoT5aPdzqVkSEUxRrsvrQjcCW
 zf966DsU8iKBFfobNnvROAkvsSIzQxMJQuvzKsPdFIpjwRd+zwFZmwagqqxGDmWgA1B8
 GmxpgtqeaoOJY7VVqROt2YzbUlCMdaQ33T9szzYAAGyHAkQDsX+6OKgL7zjTVfXBxKf6
 HTlcseZehEs6S0HAMZMYAnUN6xAkIKliwIBjWgtnDHqyuxX4tB8iWuy5mrJh3Ks4eYzw
 eok6DlvGblgFWID8uWKVDZ62fAJxEV89wWWamybnLphsQwXaAw/1laCuIonafbVcB/jM
 jJ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt84P+6RrzkdMuSYzYFD5IBUz2UFZdQcJgAigWZaXPABHLTi3USOn7yrSecWBJ9Beeny0m3DUlIgaSdG+9Hg8s/Uk=
X-Gm-Message-State: AOJu0YztSZu6ha9IpCP5jzqfC9WcyLcQD2evZAs1kfSHi8Lg83iwHPYQ
 YMMNseQK89eUiD4jbcrJ/upU/ixdQbOklRmUuk1MCPF1VQUsvhYVK98LVD7346urJhDKYVpFU9c
 sZE9SAHsmyJKS2qGLuEMyYLaUpfym+FPVOoTakLnYH8HQjBxk8r4TJbliYr4aCErZYMcpUq9/1C
 bBeiuUKHEdxGL/VWDNN7tRh3gYyJyEiOl6P7fE
X-Received: by 2002:a05:6a20:1a84:b0:1b7:dd1f:b801 with SMTP id
 adf61e73a8af0-1bcbb58096emr8333703637.17.1718976185886; 
 Fri, 21 Jun 2024 06:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm9EZaMNc6ZmlmeZgOxjLntmWOTO8gtWMGVB3WTHm887cvGL2jNhL2rarJByq/7WrbkFSNLChfI/Hmy4b3s24=
X-Received: by 2002:a05:6a20:1a84:b0:1b7:dd1f:b801 with SMTP id
 adf61e73a8af0-1bcbb58096emr8333687637.17.1718976185493; Fri, 21 Jun 2024
 06:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240527222947.374475-1-pvorel@suse.cz>
 <37603272-8ea2-4828-96df-4b6381cc26ad@suse.com>
 <ZldFa-3CXXbVKmVW@yuki> <20240620053618.GD537887@pevik>
 <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
In-Reply-To: <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Jun 2024 21:22:53 +0800
Message-ID: <CAEemH2dVaMfNPP2m8_nEb235=9Q5bo4H1WtQbpFgrcmyyVESfw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

I come up with a way to define simple macros for all LTP print, especially
for TFAIL
we could make use of the GET_MACRO to select a specific macro implementation
based on the number of arguments provided to a variadic macro.

Something partly like:

--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -368,4 +368,28 @@ const char *tst_errno_names(char *buf, const int
*exp_errs, int exp_errs_cnt);
 #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
                TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")

+/*TST_RES*/
+#define TST_RES_TINFO(MESSAGE) \
+       tst_res(TINFO, MESSAGE);
+
+#define TST_RES_TWARN(MESSAGE) \
+       tst_res(TINFO, "WARNING "MESSAGE);
+
+#define TST_RES_TCONF(MESSAGE) \
+       tst_res(TCONF, MESSAGE);
+
+#define TST_RES_TPASS(MESSAGE) \
+       tst_res(TPASS, MESSAGE);
+
+#define TST_RES_TFAIL(...) \
+           GET_MACRO(__VA_ARGS__, TST_RES_FAIL2,
TST_RES_FAIL1)(__VA_ARGS__)
+
+#define GET_MACRO(_1, _2, NAME, ...) NAME
+
+#define TST_RES_FAIL1(MESSAGE) \
+           tst_res(TFAIL, MESSAGE)
+
+#define TST_RES_FAIL2(flag, MESSAGE) \
+           tst_res(TFAIL | flag, MESSAGE)
+
 #endif /* TST_TEST_MACROS_H__ */
diff --git a/lib/newlib_tests/tst_res_macros.c
b/lib/newlib_tests/tst_res_macros.c
new file mode 100644
index 000000000..e16f3cbba
--- /dev/null
+++ b/lib/newlib_tests/tst_res_macros.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Li Wang <liwang@redhat.com>
+ */
+
+#include "tst_test.h"
+#include "tst_res_flags.h"
+#include "tst_test_macros.h"
+
+static void do_test(unsigned int i)
+{
+       TST_RES_TINFO("message");
+       TST_RES_TPASS("message");
+       TST_RES_TWARN("message");
+       TST_RES_TFAIL("message");
+       TST_RES_TFAIL(TERRNO, "message");
+       TST_RES_TFAIL(TTERRNO, "message");
+}
+
+static struct tst_test test = {
+       .test_all = do_test,
+};

>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

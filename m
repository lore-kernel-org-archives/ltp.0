Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A465C433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:23:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 773763CADC4
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:23:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0200B3CAE01
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:30 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8915D1A01100
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:29 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 h1-20020a62b401000000b0056161cd284fso4340092pfn.16
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=sQ3K3r5hjqhLaUUz3ZNbDvyjCO2m/Rb68WINFoRE5mw=;
 b=ZXfHOjutvMkQ1xFkEPQMP6AsIVtgBTNIug/UXQWUfm3m7cJWgqoQQrLhZUuwfzfaiz
 i2iNzAgkPA/TF9xMKJbdjoFJNKdOL4NYUm4uEb2yOi9vwPw3ob44EJsOts6EUCrKFX3Y
 mAHKnftVlJtYsq8itVzRT7BQZdOrDxtNizJg8XrEMfAl/M6zfXUA5v1G8QQ0w4r6KTrg
 MYD+VUrqE+JSDlvcVKgnpXzdOvtP2smh+X6SJ96Ui4UtCncZJ9sMR3cfJjuMQpvjzzcp
 3OR4AyQ08tizQFvw78XXs1KYlNmXEBAUHRlMVMEosP1Jv7GcpfyvY+R02KA2M3fZLzOG
 CK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=sQ3K3r5hjqhLaUUz3ZNbDvyjCO2m/Rb68WINFoRE5mw=;
 b=mlXFlFXr+TqiCFwa79w6nAta8676U9v7I1wFUKbpmLjK1C1vJM/EUCTFxuSdOTG6Ks
 X6VjCc4CL5olgxc4AhoRDLe5FGFKPpRM18rFchNReW0Hf/cjO51bfYegbQFy6IOWkhMq
 jQS39ZOk3JSbcil2ZVV3Z2GawWSRC83Qin7MtXvp/B+EhIZTDoxIKtHn9w61fxIjOi2/
 V/ttutw/4bOiCtpPfOd46whmLaDGOU0jHcqlEveYAV9+pDoLyOyH7Zeku0w5FPi/OnHT
 hMB7dzdRpFcttgZ4+MUVO2GYpDGnPl1FhEqOkybv/9cl8Twz43B7zyISWN1ZMxKLI9mB
 wA+Q==
X-Gm-Message-State: ACrzQf1wi3snabUT2T4jIvux9ZMpDDlXM9j6ZZ6bu5cW8HM/e4f9ZpKR
 Mr7nSxbDP1tFR+tyBdna9MG4zhj2zyFcg3HGOKEzUowlyMUD6FLh5tW9vMI033XbatB0CCcWEwY
 JpunaZHRFxUub4AUpW20FHjLkdSoNFps9F5kcKjiBv8bkeDDWlRKjG0V0
X-Google-Smtp-Source: AMsMyM4/5HBzgPBw8azTkKcSoquIvr3upoid+j6G9plcVnLzX5E5kyQNHXuPzr/aQl+o2aLzUl3ZFU6hMis=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:768c:b0:17a:ec9:51da with SMTP id
 m12-20020a170902768c00b0017a0ec951damr28568136pll.159.1664907687892; Tue, 04
 Oct 2022 11:21:27 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:39 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-9-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 8/9] mmapstress01: update license
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

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/mem/mmapstress/mmapstress01.c      | 25 ++++---------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 99ab0d64e..9eced3526 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -1,25 +1,10 @@
-/* IBM Corporation */
-/* 01/02/2003	Port to LTP avenkat@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2003
- *
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2003
+ * 01/02/2003	Port to LTP avenkat@us.ibm.com
+ * 06/30/2001	Port to Linux	nsharoff@us.ibm.com
+ * 10/03/2022	Refactor to LTP framework	edliaw@google.com
  */
-
 /*
  *  This test stresses mmaps, without dealing with fragments or anything!
  *  It forks a specified number of children,
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

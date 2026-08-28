Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FF6C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787911289; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=oimW4DE5QsqhU5t/vICKpIMo2WHiLdUDMDus16H9jY8=;
 b=L/HnTMgdlLed6R0EN8fu6gXkhOoE2I+iXQ1NtY57BRLBv31Twca5FHWniww4NlY7pKOIk
 9yqO1nCkM3B/NzLJKIktRmke4eh617/mFbrFYftqxY5wYgv7AqX3IdhwTR8zqXtiWQyjREo
 m83OcjBQpLerIaCT15vQlVVpqMtHUxQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ABB83E1739
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 12:01:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEBA53C6F42
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 12:01:08 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63C792009C3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 12:01:08 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-482db627cd8so525046f8f.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787911268; x=1788516068; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wpKvyzNLbuFbGjpj9N1tj3xvnXGhLv3RCiYA8OIVU6g=;
 b=Y4df5atLHt6HJClFTFgNh0dXpNIhJbu/T0OYP9dnaeJVSX+u2a7NBrGFSapOUh/fYD
 nUCA9x8TIr8oDxb5ZwlqTj0Tqy8HUKj23rHlzM67hi3mG7qrnI0IsjI/bGW7UBDpfo07
 6Ip7tCx9dHoFiZHQK2dVy3ltKbuNyfcEGaXXvGMk9q9mVGbV4Bm3oFMh/cNW913tRm1o
 rcBhXMNGsX4RcY9w9Qy+nj8roFrgbp5BXhDc1Z0HNCXb1OJVYPW75EtTEKk4Ej/bSj/L
 qW4VUn8IkKohSfWyWyG7UvmgmYiVeAcDInP9o7Ss9RCZsobuyu3/mpLwmU0cPQUeLR6z
 om9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787911268; x=1788516068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wpKvyzNLbuFbGjpj9N1tj3xvnXGhLv3RCiYA8OIVU6g=;
 b=a30lLOMuSK9KLuNYv+HeRRQ98YieafpVokpt/wUFYjUVD/Ga584N9aT+EaZ6tJsdqh
 IyN+GTXhDUNOEWy64rchyVRPx+8NroZDeSoeiqau7BUgQI03dKSlrLDxoa7Dm3Nfl4r7
 ssJNXcfF0YkLqsBIwrdPfl6ctYBscFL36+uH721UVCGzlHlgMuSwSntSRcLZcduxNS2v
 1XtasK6OY7SFozWhmSrOJ5MtvU+i1t2Wrebq/a/4U/OAhQS9tj5NRrYEHQYqekSynhml
 jOvpykuaC0pme+sv8XZCJCeuxbM3k6SmzDsFHP8aNFzfT8QHnG+RqIJoEQjGCtAW9yqD
 tGqQ==
X-Gm-Message-State: AFuF++mAUWQ1NsXVK4P969LUxP0UA9GG1MY5Y/NMFWW8rU9a5HBrSzlk
 GcHJql1BNmiLlvvqrS0PrQhNuAqAzF5828AFtKikz9pJ8CFnHOY3aDUxMIaLRQ2DvqKSopCVhs+
 ixIgHVHU=
X-Gm-Gg: AR+sD13TUI87ueaVpYmgE/UhYC4lMDpdgiOHebuoRb8kmsAdmwg/I1H2GaI50PkUkkV
 3U7F/n7NGnyo8IG0rLxcTFHQSzjKs00Hsvl8oCy0X/5bSWm15Y0Mv7rmo7yeEMbEgEP6wvBHO+p
 d8cUyC7nwuXHXP/vPmneFEJl8hgWXM6keIq9hYef5riET4kYDxkmlMv+kJfuzO7Pm3dDkJy8ZU3
 3IEv6j0lLF5EY8xOLzoKZzLR4a2f9oqrBOkZsf90swIeR1gwOLswNBjBeqlMsYfkOfRS2sWiQ+y
 4U2fi0snIlu26KUCE4g/mwIOYMcRuJEIcAevW904wvbOQvw81jbD8PZ0kMgFV9DSfDTyDvHaI3X
 3pZ7K2uRBUp57M2OnP2PqjJ6EuHavlTFgdPMfe3nUKgJsh6MGjkyYNC0tBoGOB20b1SGWJZFDQL
 1pqjzmDz23tgRF9y/PFyCexKG1BXCtIixesUhNfHPWUaKL4w==
X-Received: by 2002:a05:6000:18a6:b0:482:ea08:8c97 with SMTP id
 ffacd0b85a97d-482f79cb828mr7003138f8f.2.1787911266860; 
 Fri, 28 Aug 2026 03:01:06 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3fdbsm2560847f8f.6.2026.08.28.03.01.06
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:01:06 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 28 Aug 2026 12:01:03 +0200
Message-ID: <20260828100105.195974-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setsockopt08: make check fixes
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

- correct misspelled 'layed'
- remove space after a cast
- make setup() and run() static

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt08.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 3d1838f6ed73..c0be2f02489d 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -68,7 +68,7 @@
  *
  * That is, the padding gets inserted unconditionally during the transformation,
  * independent of the actual values of ->u.user.match_size or
- * ->u.user.target_size and the result ends up getting layed out with proper
+ * ->u.user.target_size and the result ends up getting laid out with proper
  * alignment only if said values match the expectations.
  *
  * That's not a problem in itself, but this unconditional insertion of padding
@@ -99,7 +99,7 @@
 
 static void *buffer;
 
-void setup(void)
+static void setup(void)
 {
 	if (!tst_is_compat_mode())
 		tst_res(TINFO, "The vulnerability was only present in 32-bit compat mode");
@@ -107,7 +107,7 @@ void setup(void)
 	tst_setup_netns();
 }
 
-void run(void)
+static void run(void)
 {
 	const char *const res_fmt_str =
 		"setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)";
@@ -118,7 +118,7 @@ void run(void)
 	const size_t tgt_size = 32;
 	const size_t match_size = 1024 - 64 - 112 - 4 - tgt_size - 4;
 	struct xt_entry_target *xt_entry_tgt =
-		((struct xt_entry_target *) (&ipt_entry->elems[0] + match_size));
+		((struct xt_entry_target *)(&ipt_entry->elems[0] + match_size));
 	int fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
 	int result;
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

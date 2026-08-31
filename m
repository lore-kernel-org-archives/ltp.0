Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD64FC61DE4
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 02:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788141673; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zMh3klSfENv8airrMs1Dk8ZUq18s4mnULAKDbqbuakE=;
 b=ZWmwfF8ogc/A8FsiD3m4nd/9qzbxANB9WrpOEy7Vn7oNoa3PB2CbmAuhI1dBds5BkCksF
 nfaFL+DuWGEP7XTifZSscSjyDV3bR9faJgcsOU5ULGqNGKobyBu7kvAi5QDYu7lEptSrQ6P
 rHkYV2FIBDK9PkwjVT+CuRX9PoWukbE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 960833C74FD
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 04:01:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED3F73E1B1F
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:00:34 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8A70560049C
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:00:34 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1737364f8f.0
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 19:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788141634; x=1788746434; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vsaaJRkw1M1c/UiBi6h7+aLXYWvE2z+q8SXeVpGiC9I=;
 b=Xswt7s/02wfyqqX9dPlrx+NdPGTKYdIhPXAFzkJCPnVuD0Ij3wwOcj0BWEA6nLGSgF
 3v3bOCtDIbdwB1PaSylJUyQJmye4603f46jP2YZUHxNaPIkreclmkjk7uttaonE6GRee
 Pg0dwa4Dx/hCEoYpOHluDplWc0KYs9Lp506Aza+lcGDR3MEeude6Syw/saTUk71R/IrI
 r8Chq//30ZlOXrBBD0E2TNcJmDkqyA/G3z22/ojE9lVQtwWTgOMQ7ngw4asg2psS2uFN
 BapOj0MPTpEBIAGJoMYi4PWCt3zUy2KJOd4NQRq28Xl57+XzRxU3H2LsmG7sUX8vG8cr
 jEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788141634; x=1788746434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vsaaJRkw1M1c/UiBi6h7+aLXYWvE2z+q8SXeVpGiC9I=;
 b=TjyQzlofNzzaIhnO1HHlw2wL2Ff6SPTdUBhfOmUCoPPM6YPeAgPL3kIgOLhq+79Tr5
 A1U64aYtxwZHImaHqPBsZOg1WWB8R9EuunBEU+nWBu7LVz7BkcyswXGboc+3RqoKH+SQ
 tA6WDu5ugsU+bQEhWfCnH52DgjHSx2ZdQciWpxY9eRLfYXCvINAcjgfhx6Pw03huhfzc
 T2dBOESfQXDm5cHpi0U3CY0RCtpFIetf/qHLZFyB6+pdcMx2uS/qOtT9GTPY9U/yaZKj
 o7w94AdvyyHZO17e/bb/CKrlGPsygcaNp7bXIJeWxzHQKbqX0+Wi4lg4nCMigLCIHJkj
 nHIw==
X-Gm-Message-State: AFuF++lPOfuQksU2uAHN+19OYYUhHlUGY5vdORz3MTqAcBXhYmg5uWEM
 RWvjeMlimQK0rz8oh32udBSNK/UD9bYDLw4A4WLyK57BoRsBq8bXw8XUAX+WxGQCkoTaRs+9U+y
 V/JQ=
X-Gm-Gg: AYBFou2CHmIaJeEPJP9M0uAiRmDT9SLgPHIEPl44+DN+f5X45yiqv/XxOhFz1npn3rN
 OCC9hj+cqDN5Xlp5WJZLnBnMnTPZqvfP19qhBJydNbPcdH+3ei2ndbQwNx57KtstHGr6cIXAgD7
 dKFK0xZOg4lpolUdGcTyH0Ts0E02hGGB4uwxCwbAl82jZU/3Z473v/mPaMVkCfShR0SlAe216+v
 7OCFe4vlx0NSgN8jNdbgtFMe9Lx4cEl6pQ7bCFEN/yoTEhSbTwzca0XfxyZZZGWwNaQY+PxI5h+
 uGMVLjImUovzmrTOz9ao3fvwkyG23fV7+GMbB2/Vjk5W7ertOpoavVtsZ4lq1zZvGig9nQ1Pgw2
 zrhOn5/2WLfZNQ4lakoNYW8QWaMF+NYFAIIMIXu7Ukfir+wsQ9VUG0WJ07m2Zd1lX3Imf8qwlN+
 rZSETk/UJ5Hp4qrqihmm3MQVuCNn1Y21xfyjWYbCgHekJCvsFixTIjKDgJnnARDOVGtsvWc2PDu
 MiibKoxzVQ3JcNSWBREtlILSSCEuE1j
X-Received: by 2002:adf:e194:0:b0:482:f270:65c5 with SMTP id
 ffacd0b85a97d-482f799aa37mr38061045f8f.9.1788141634049; 
 Sun, 30 Aug 2026 19:00:34 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-482fbab3fdbsm17084568f8f.6.2026.08.30.19.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:00:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 01:59:45 +0000
Message-ID: <20260831020028.19193-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831020028.19193-1-wegao@suse.com>
References: <20260831020028.19193-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_get_free_gid_() prints the found GID when it succeeds, but it
incorrectly includes TERRNO in tst_res_(). This prints whatever value
happens to be in errno (often 0 or a stale value) which is confusing in
a success path.

Remove the spurious TERRNO flag from the tst_res_() success message.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_uid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index af4ef8cf7..b0b087362 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -24,7 +24,7 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 			continue;
 
 		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
-			tst_res_(file, lineno, TINFO | TERRNO,
+			tst_res_(file, lineno, TINFO,
 				"Found unused GID %d", (int)ret);
 			return ret;
 		}
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649D8C982DE
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789782871; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5qtnuKnCQTzr6ShBxN6KMUZj9UxTLkwlk/NJBhohUbw=;
 b=jsX73J5+dtrhzXC310cczzq3rjBm+gk38MqmEH+qmHT9Bfeh21a6AUIBOAWm1PTfbgY4h
 bFh9zo9y4eO2+JyD9JTT+7KRi31W+3hGD3dQKwiiBAJWOdJ0gmV29qukRfpuRXbmBvW4i7R
 it0y55t8WK7HDaQ1nh+HGxaOQ4+yzQE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BF303EAE15
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 03:54:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D5533EAE20
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:37 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D2AF200CE9
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:34 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso9395985e9.2
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789782814; x=1790387614; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9mgGcZIQV7NNvzZOppzgUjpxTwumwRj4EqpZ4Z0ye6U=;
 b=ea2mQz9KVD2WGk9QE84g9BepR027gstJWasowaFcmQvQzLIODqAiXLG19LBaVnJnkg
 JmcOxpE7JpzA4HqamTq+awh9zs6UMgt2cPNDXETW0SFtowIUMRU9iH/GNs+O7a5g+tiJ
 6V5X0VTbTkI5hq407TRDIThDaSGKKIZMyng5lKNxWaBg6SpfJwSVVp1Nb4GnplMwYNAJ
 Kp5y5jvyvP2GR57spTG0SMMm4YFC280AEwbgGf6MRZAjpgxv8n7EpREYHdoIqdVhuC5O
 KVyr9nm7lU9vvX1Z1Sfv88uhtb7j6/Ypmc83MeyFPsNQgQcJbroyZP7R2C8hoZPqlHaM
 z0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789782814; x=1790387614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9mgGcZIQV7NNvzZOppzgUjpxTwumwRj4EqpZ4Z0ye6U=;
 b=BMHiBrT/gkxmSQe3DsaS/xXRZeU4Y4em73WSLH9wgFTDpJn/sqZfbasdwDhiQ6hI1E
 ZtK7O8wtSmUyXb4m82kORFHa0gs9/ur4Q9caSsDxQTNm8002V1D6GxRLe4gefr8b1JXx
 xRJiTr2SztReHeAhSu+B5PZ3yQwjb4ux/e4IkjxPKXhpv9LKjoGjoce5GovP/nPJ5dtB
 xE8vVJ/C8kIsYM/mpkm+1IVpGPeQvNkSSWrueYI7z+oGvAnaQNYiCWMqDB+xAEtBK6Hn
 cKVWBFMzFAIAy76F25BdsWbUMKrSLsCPdWpHs4g2+iDqbveaGfq19TIqsL248UnbHnEi
 qKhg==
X-Gm-Message-State: AFuF++lc1KVaa7/CsvSDhYJRNnK/YhFmu74SqYq+91aElQLkXQxY/o6U
 5DbFc1gtKyIVFLHXYa/8eU5nnadcYqZ9CxjF4SFVUWx5tVwiYxeNp6v0I7XWnC+azgnTyepKOBq
 Kg64=
X-Gm-Gg: AYBFou3SyzNmg6Cz0S9LPTZxJo2jOCBvwasCtzJ31Bl4ksM1G654tP7NWZ8k/Ng3bT5
 hXtQK0ffN8/R2lyzamUx1uX+Vt9D1z/y5M3SGa3n/PM79F8ctrq6RZvDkYEvH1Mhu0SAIL07DQm
 ELn5T+r+4GMZ0jW2GK9kKsq6mWPukpiilJUzz7YsrRkf25xkN44uVAlGGZI9RPcSmGXirGqQRu+
 SOvft0HX5TWOlztoPG7mNe8kIlsAHDbkqjs0IJ+pVDv+pxf743Qx0fb20mHDz8J2Mo05NvhLM2X
 jBlDW8koKP4bNotXPKMsq7dekOL1NbARa+lYXa2ECdGNx6sL09B39ChYaFIIK1GLBcdlwxWOXl0
 trnPaMSQahB1lzTbkzQnx0dB1SLad/FrKv+zKHjER0HiJ9iwV0kOWUMjGuspQ5ZcxAM07nZCD+D
 SckJc/1QtOQTB7XZdBYAtzdap6Z+ua96SAOm8bZ5C44APSZ7BhQeh4JG/4gZf599d3Pyw4qu2I1
 36K7isp+SL1rBA4KSAYKQ9sxkwoWlwgYh9Gt1nwnpU=
X-Received: by 2002:a05:600c:8b61:b0:49e:69ff:c6b1 with SMTP id
 5b1f17b1804b1-49fc5749edemr65578515e9.31.1789782814044; 
 Fri, 18 Sep 2026 18:53:34 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fcd0874c3sm48966845e9.14.2026.09.18.18.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 18:53:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat, 19 Sep 2026 01:53:19 +0000
Message-ID: <20260919015329.22042-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919015329.22042-1-wegao@suse.com>
References: <20260919015329.22042-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15 1/3] lib/tst_uid: Remove spurious TERRNO from
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
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
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

Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2979606A326
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWCpJoIX
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 759543D00F9
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 19:36:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB1ED3CEC24
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 19:35:54 +0100 (CET)
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 80E6A140042A
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 19:35:54 +0100 (CET)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-462dec1c4c5so402827fac.0
 for <ltp@lists.linux.it>; Fri, 06 Nov 2026 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793990153; x=1794594953; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aMbStiqxNQiDA5FnfeoKMAhOkQDejkvcJBB4OuStnd8=;
 b=TWCpJoIXSq5umluw9Al7KbG2b0a//l+M0B6oZ09AusOQrGRexvi0VEIUdUO/z5zgg6
 N1+FlmBzgqnIgNCXb7xDZfMWoyn+P878G9J5USQW5dk0xa1a6nRFXUZlboIKTVpssdKF
 irQpCzXhoy522/L7jMtdtfkTmy9DAyde0wNcm5I61JI2CnyrCbjaujHGwnZnF8Kqln6n
 H5ec/Rf2GJMtnWbcM0lGPc8Epax4ocvTVvsysDUBkMnJq3ucb2JeGuIigd5SY6pOPMnu
 ovu6PayIHkXGi+C62rJ/3KDItdvoyU5xqHmSPgzQRSqUKIldyarERO8PtZOZG4wDQSy5
 Q72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793990153; x=1794594953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aMbStiqxNQiDA5FnfeoKMAhOkQDejkvcJBB4OuStnd8=;
 b=K/pRzOv+I2728eq+cn16gHw1mGZ9td+lvSzxucLw5deZ3sDlM9L5aLL1r/zdjX/din
 iRCzWFp5ZptSIqEAsKtSMAI+fjj2QHE3dmR7z8Ecb2xAGW9KvPkbvI//tWlOb/Zjf7xC
 xnW/reHQGNpqz7hRo4qg1ijbL/9eJsUJEUQ4PJ5k1K4ydJU+B5FCbhu7mnOJ6UrYroht
 aVeak+5HyMN5XUwAFCewk5RdcXwkJWGM0BTUdPKgA/6tnBcJ6GzG7GhztRv9JHRDCBhN
 jr2IofHgKY4jBQ4hLiTtBj1iGxBrtSZymnNBPYaIUhya2YSRgp1oZD7/0LbOMVeKphL2
 OGWQ==
X-Gm-Message-State: APuU4Z9atxsZwr2lZNqRuwaQbKh3bGz8MkBSUGvU4rVqKIkJEYQizves
 UE8bWxqCcX9XsGbRrcfFHEhH/LqQFtyLE1sOHDPuTtkNlxH/O97iTMGH
X-Gm-Gg: AYBFou3y24Bl4gipfBkaUTz+ExOkntCbZdOZe1/wxOSQRKLcoq6RauT7W8MKC0hCGOL
 xklEmy7OohxoOGZOpOUClAneymOScUpyGmMnv5anZVZeA61x/RaxEhxYHL97DxJSmyGdo9Bwse9
 Z7/loAnvmy3SxJgJY1s7P0gTq6rqzHPJyV4WB/40Tr0gWw2l5apDWvwN0R87gS3KivOHNQH8sPf
 Mu7EcmObHqfeDE8cDvzFraEAoD4E689WZNt3JjwB7Tl1H5a5D0j060NgM8BKjDaupcg9Ao0IoGM
 gyiKXjYcTdpmkCrK4Z9YqYH/7stFvhQaB/lk2xjnW8tjkW9DRUndndwbQ0LHyTeB2GKK6tYbt7G
 PX4xZOtooZwmXRFtD/uu2wsgXAUdz/wbN+IoHHKBnTfIgQMJnCIpgNamIOSCxc5soVCNKOvEjpZ
 wQZSp4k14M6VDprS8SCKX1cZZoaowxkrVAPMhoUURv/FBmDrbBJHIAxo9Ce+usRkOFOsPQ4sg9v
 eCBAY1jZsuc8UFvGRrApL3+m1gkvF+u6ebQiB2WbOQgbFZLZ6pF3sCrU1cnjEAYHszLeCxZa9mP
 x+munMGShP4gV6Az7tQe0yfxszMxfaEzIBwBMrtJtuKfBCfxGUdtYr91LhqTnonskL9svKnKqZ0
 n6xUs8xipfsD/lnuumkDZL3Jk87ZVTNej68pZZEE=
X-Received: by 2002:a05:6870:46a9:b0:48f:e0f6:bd58 with SMTP id
 586e51a60fabf-4ad98bc0b4dmr2485954fac.41.1793990152804; 
 Fri, 06 Nov 2026 10:35:52 -0800 (PST)
Received: from
 runnervmwuk1x.a2sagkdsppgujfcxiysh5jie3a.gx.internal.cloudapp.net
 ([20.83.53.60]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad979e0afasm2556385fac.8.2026.11.06.10.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:35:52 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Nov 2026 18:35:50 +0000
Message-ID: <20261106183550.6166-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106164105.615423-1-pvorel@suse.cz>
References: <20261106164105.615423-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] zram01.sh: Rewrite to run by single filesystem
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2026-11-06, Petr Vorel <pvorel@suse.cz> wrote:
> zram01.sh: Rewrite to run by single filesystem

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

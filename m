Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1F2C982D2
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 07:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789718001; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5qtnuKnCQTzr6ShBxN6KMUZj9UxTLkwlk/NJBhohUbw=;
 b=N9qrVa+uzXek6o/LIf8Pi8AKi/nGpG20L2aIzcQB5v73/4RUX30BseHTcTD03igYQEK4X
 B321dqN40z/ui70RgnBsikV+Ot3IYtuMWc0Cb9EbJgUgivUZmimEvsS3MxT6J/2dFVWWRp8
 ByWz51W5iXOLyTs8gWSfb4/iPjzoTn8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC6E23E73E7
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 09:53:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ADA93E729F
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:42 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 34C33600B9C
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:42 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48434392b02so269495f8f.3
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789717961; x=1790322761; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9mgGcZIQV7NNvzZOppzgUjpxTwumwRj4EqpZ4Z0ye6U=;
 b=Feftp7AZR4sPBX7hqmf3th2JMwKwf7tMzVRAxRRgZQrM6U1e6mCLTUcMiSpYRuMC/T
 PgOKgueTY/pJaTR7UMyACDg7OYZ3/KeOaipu6geE84RVRW/O1wZ01wMPTqyCjd6B3Cp5
 Io3aF/BvwiPm3Utvxy4hyaPBfX8RhHgKu0qPYhsRYB/MfhUL7/b1lksS5bQy9QSD1NoE
 GjD4nkCbMMmfebILy5MDog4LLsjyk9rpN3nzoqBUoVTil80ErgXZx2boBy9xkDhV+IgE
 8xtQFRfQYhPpvZ4qnBsUZ9IzZh70AkzulmtBuRSmL9i5YR4Bqw6oME56tVLhOY1LQd3K
 y6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789717961; x=1790322761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9mgGcZIQV7NNvzZOppzgUjpxTwumwRj4EqpZ4Z0ye6U=;
 b=vMWwj4wNvgCdQL5XbaCGBb3Uf9QI94taQhTTWKqBXmPQKFfjmxhvnLvpmE/jBLZ8qT
 jBJbVo9BwQX1UKY2Mt6X4POOMuFY1UMwRwzClKTT1hj3UMVcCITWBXlj5KcMkW8oEbXS
 +6PELTxOm5sHYb6LpxIE0cEguEvNox1DkbXlii3DXHlCrNQKf7RFqrzCKA3UAQDUm59T
 pTEE3uhgAFaW37aguT1nFNndDN8SjR7Ub1aTgcvcbRh1ecrPfD8RLET/sP7qRdpveinr
 iqJoludMLeA29VdpmIVEIP75siYUdaNSBNl9wzVf53KYqcGmNvoNgguZ3I3NJi1mmlg1
 wyGg==
X-Gm-Message-State: AFuF++nV2hqQHPbqqr+NCgD1Uk4qivvRBfUuR6S4v4MdaJ0q1J5nhJ+O
 e+69JbB2a59oqMXCzMCZEyIlLUNxY2+lBUPlxrsudTBnA7uzctxuXnvW06qbHtdZLFdeRcb0HRs
 6zkw=
X-Gm-Gg: AYBFou3TVrWqAfRgSrNCpUueOyAkhYSYYrGNOE7R/qzf3yc8OlVZRKNCYRhflS6Uj4i
 gloAOf6ISc+RSH0NA/E6FCiDcCieQuAH/bQPyqTIIuipWTjzhfpiVhSaytDHdNpNZ1OqebiFykT
 Az/GSArnF07wgBsLFkAg+l5FYjtv39eglnTDIu8+FB+FS33/C2BBV++rXcMVqIoRkBao9CeCjPC
 xz5dMLIc8Tv1DoldCc7At0JtLes82G82/2lpiQDeXyd7hLFIIVCZRb/0J8LIktHvx6UgshbNPlv
 X9vKcswAerHnHPHkC+YazGTfQHv/FNkgObkTUkc4d66untXTDxm3IaJ0N4iuFNxwHCz/10pdas7
 gV8UaLEh/t/eRh/hGOp045MpYxTVnmeT7fSToUr6tiSlLLz26gke5/4oZPXGc/R0Q/7xZx+G9Dh
 rXWEFx1Ht/EeLLbkhY/kvVc5bdXODoElY3y+JmWJCWXH3pdfWBv6LGFfMuv/GdAzXci3l+NGuXq
 C1dGyK3Iz6LAdv++Rj/vt59ti2bkeNR903Rb+CvikM=
X-Received: by 2002:a05:6000:4021:b0:484:3314:eff6 with SMTP id
 ffacd0b85a97d-4871e3941f5mr3528613f8f.28.1789717961353; 
 Fri, 18 Sep 2026 00:52:41 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4872008678bsm2206894f8f.35.2026.09.18.00.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:52:41 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 18 Sep 2026 07:52:21 +0000
Message-ID: <20260918075228.21423-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918075228.21423-1-wegao@suse.com>
References: <20260918075228.21423-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 1/3] lib/tst_uid: Remove spurious TERRNO from
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

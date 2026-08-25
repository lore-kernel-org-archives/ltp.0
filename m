Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A347C5DF9C
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 03:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DB253C9D1D
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 05:00:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EBBE3C2C93
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 05:00:27 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E2391400B9D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 05:00:27 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 af79cd13be357-93688f1172fso128114985a.0
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 20:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787626826; x=1788231626; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lS0RrzMOV2saZbKlUHrUUf5mZn8D8zM8njKh8XYSVvo=;
 b=qALaPrJG3yeMlN0yFbpjjbed8EVrTK2jGhNvS2O600IHcIpJmzs/ewsmpHc0yP3Uen
 dgZTCt/Q4AJs+WSP4VQK8XKocvjF6iZYqdj/KKhdbsHpmnVqCs9u7Q6pCubcgr9vHHxu
 JewLPgJcdxqsy9ZyUXiOuBhFBxCTZ4cvSDVXS9KARWrqTAzXmvxa8xGr1RvxjnxQZ02p
 SxGKSLW0MGyG8tnw9tlszNVBkNgjIh85LgjAKy3sCGr2b9fjXET84ptxtQygsc8FCmeL
 SKYPPp4E5cdohJLJZg5PohZvTieJSnhQp3XvMfh2MkDPu0nU42aBPmLcGnBSUuIMHI2N
 CURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787626826; x=1788231626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lS0RrzMOV2saZbKlUHrUUf5mZn8D8zM8njKh8XYSVvo=;
 b=Gi1O/iP5an/fPrhxVQEoLkJikNe5+QcgI800SIBc7do9CUXw7xfktw+wFXE4wDl2mK
 3xHO1R/UxUgb6dILn8ssj3oW3H/VfXvtM+vHH0Eo/g9MCr8k5WX/nPzt2xpME4U4aibe
 zARCuC685eWfAj2K9SMwWM8r8dtgpNoFq7AhkYv399ugcrhAS/rbRKVjiGb+vn9qWk74
 t+OMIooP7X34F6DkeyjBMtxfqLdOJA6wR9VD8VVPNFmgJRMXpfOKaKHeY0/xrbopRSFc
 XW88xRUA0NrB1qhuYFKunPoIORqbH+isedObSJ1FpiPfj74I1xZY6w3olwyKx24v9aPW
 NE1g==
X-Gm-Message-State: AFuF++nkaIa+1rrvzRasHzq/2fLSCHdTbe3qeeGjjP6i8dZLe/hL/k+X
 xSOhFvSp5kgBJrP5Qci87k+NnTrUyqBAbbpyXTke9XqSGkRFjQR0qsgq
X-Gm-Gg: AR+sD111oU8y9br3f+irEteFpUO9XYsM0hmVd4NvaU1mcyBJU9il7Jzd88QBGMC04yT
 wjzhIm3F6fQjrZsi2T6NOP/fxrfnCGbXl3O173hEfYdOEpY8ijnuOd4sP7UPyiQ2BEpryjRNm7i
 8yuyYxXRV+/HtFlhJAo/zqfe05A85pn/5jIW0Hm5hnWxPLWC7kXGa7++9jSouxosZ5W+mjRWkL0
 uWPwVjHm4qyaYspY4Cw984iv5EyVReri5ssBcWgPdKcrdCtdrhZTWrEDCokhjQUpa9iwtXKdyHR
 VUkViDOFjuKJorJIRHx1ajZS85d22MhX9Xl80tOv3Ak+KUNs+besyt8dJPWS32EOCg8akyRIpye
 7TA6iOZmfoCmTkr54mnFyMofbIvQ1gzr/37WPxEOp2X+7IlYejDfj2KbR3ZUGiWHCaRNApK9WLP
 a9un/y31Pk0vvR9CeSmfbbRKr1kx0Svk8JlE2s/Nep2OmxgNmR65/J1J5HaY+FKl5S4fctdfrfg
 zwtekbU0gWUVRXGST3PFhboFIcGz7A32HnUqFkigvLekdmeaowuKGbtjsXoINTxihnYm7Zy8JuG
 HQ==
X-Received: by 2002:a05:620a:20d8:b0:937:3c82:299e with SMTP id
 af79cd13be357-9376fab47acmr301368685a.38.1787626825484; 
 Mon, 24 Aug 2026 20:00:25 -0700 (PDT)
Received: from
 runnervm76f27.wzbkwdbpglyu3opx21frospznb.bx.internal.cloudapp.net
 ([48.217.251.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749d91ec0sm638387885a.26.2026.08.24.20.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 20:00:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 25 Aug 2026 03:00:23 +0000
Message-ID: <20260825030023.9054-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825022926.9649-1-wegao@suse.com>
References: <20260825022926.9649-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Rate limit page-dirtying loop to prevent
 MemCG OOM-kills
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

Hi Wei,

On Tue, Aug 25, 2026, Wei Gao wrote:
> mmapstress06: Rate limit page-dirtying loop to prevent MemCG OOM-kills

> +		/*
> +		 * Yield periodically to space out allocation spikes and allow
> +		 * asynchronous swap writeback to catch up on slower VM disks.
> +		 */
>  		for (size_t i = 0; i < map_size; i += page_size) {
>  			mmapaddr[i] = 'a';
> -			if ((i % (2 * 1024 * 1024)) == 0)
> -				usleep(1000);
> +			if ((i % (64 * 1024)) == 0)
> +				usleep(200);

Could this avoid using a fixed sleep to synchronize with asynchronous swap
writeback? The 7.2 cgroup documentation says memory.max invokes the cgroup OOM
killer when reclaim cannot reduce usage, while the delay here is unrelated to
actual reclaim progress. A swap device slower than the chosen dirtying rate
can therefore still OOM-kill the child and make the test fail for
environmental timing reasons. Please use reclaim throttling or poll observable
progress with backoff instead of tuning a fixed delay.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

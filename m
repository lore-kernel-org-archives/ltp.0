Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA60CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778073389; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=9egouD9+LTA6SA4I4poGuZUxIZ2OMkksfQ6Es9hP8Uc=;
 b=foRkxTzTdrtN8jzsaj63RPAJFwxyjchjv/tycs60MwiqhSw9KvaOM+VBEWpMBtm9fnIh6
 lirlxX8k6yOXe8qj9kzuQ+c4n1YiQhy5RVY0WfacvxctTJi8eDlJAT/VM6BKNk7HNlDEO8u
 q8eb4V60xXXWtRgTgx3YbRPWBWaCzP4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25823E615B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:16:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCD713E6158
 for <ltp@lists.linux.it>; Wed,  6 May 2026 15:16:05 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2BC232001D6
 for <ltp@lists.linux.it>; Wed,  6 May 2026 15:16:05 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67bce1840f1so7503171a12.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778073364; x=1778678164; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2jvjnMtDuK/PMq4TT21ikwDGM0Jt0LxURbTwXWbGiJU=;
 b=GYFlNbd8YczyjzY1JdasMg7vK6QehcEFyxgGl2N0X84zivTjBqfYavQcsqNDiTMX0t
 Mubl83JCHDV0mrWSsa1/8bb2EiaHInksqJIXHw/3MKqHxMN8kiAlNT7McQlPCo0LUU8I
 /Kujaih/orGWrZm+nCHNDCXPaoMKMy2jo4WykavEJ67Qs2b+pAE/oeNgcl9IakRLcMXH
 sS2F3Ons8nXTbs9Cv1tbg+RoouZJl5FyQ5zsPueaBB6ami74RO7MAER9ChCJFGxQyk4x
 U82ge9zNCi7Gcf/6oTUMFwy+Yl9NatnptSKaD5ocBV128wtRbzVGJXau1S1K8ElbPOG4
 AlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778073364; x=1778678164;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jvjnMtDuK/PMq4TT21ikwDGM0Jt0LxURbTwXWbGiJU=;
 b=lvQXqiJy9IIIJPxdjeqN1pGPaazEWdTg2HOhIAUgG3jnfCKl5NRI2fdgt+OGbr150k
 cky/NRBe6SIjgrAKsm4JLPSBb3COsrF27uvNy74leFURb0N4a4+MeXq4uqZaJnshOJUA
 1HzuiVGEprrl9nDjAXZdiTOsoW7UAcgHhJGlTkKXlNcPtkHQ+hmd6A913gP3hyaT8OZq
 hA+mmA8GOkDfz6RnVQ5IXY6QHv9aNrn2EIuJBGhxM6fDcUCA+EKlZePgFsD1HEGFKceh
 9O10DKtd1XDyy7/w0ED98nKEuyPn1XGLO9MvFjQieIhYxFaivJQ/FsPM4EqZvvdFtarC
 cc/g==
X-Gm-Message-State: AOJu0YzDoRBJvotPG08d7ptALkdoWme+qEXKl9iyjSTMwwpQRYRGq3Hn
 EPCJiBRV3FkEpSXghb25pXVHc0gccMfvQTQYScmXETJx5EPAfHLSw12Di44wKwdj5jY=
X-Gm-Gg: AeBDiet7gl2VCQvAjXF677nGB7dv4+oj8HKqFibYq+oA1Qrv5qY1zt0RC+ZjpiNS7yX
 dzCvoWg4OZIS3ZxutKLCp3M7k3VcpIClAmdVcOmCMamXxuwk8wQpymu0yEL40beDMyEKKa6Ruzd
 kUcrA37UtYc34cplwBgUjSfEvgtIaiVn27PXV/pmj+MEMKpdIj+HVkO67x3RPq2ww8vFBV88K87
 08Au4t26yh6gShCxZhCr6NVlSb3+cr8VT7RamnISLrLlram4Pow0dnpTMP4z3Oysmoucr38QEja
 gpzD5xqxEBP5UUjT9kdv/KOOM+ZI/jG5l9+YryAyw8DhLAm7rpjl/qAPMzW5ci/gFFOChahDg1M
 nraPKjQKULFoPZbDCIlzDXCrqbinzmQ+q2oI3AjXoBqqQwaDe0bh1U+4x2aw6y9GgXR+hWpoHoo
 iquysMrvw2i5KYyWTB0b0DXtp5BjjcimWFJastXdP28G+UtqDCzYeHIXTkFiSneWoXZ+LEfEQY/
 TrzkNSRwP9HVVoDVuMR8tIbrS64RltRzS7HBKMLSSKsOE75esM9RNjANuUeIRhmdWplrxuO8ti0
 Y/dqmqbtDP7d
X-Received: by 2002:a17:907:3e84:b0:bc1:5d96:78f9 with SMTP id
 a640c23a62f3a-bc56aa422f9mr168287766b.5.1778073364050; 
 Wed, 06 May 2026 06:16:04 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02802sm12593620f8f.17.2026.05.06.06.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 06:16:03 -0700 (PDT)
Message-ID: <69fb3f13.5d0a0220.d655e.1133@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260416005603.22427-3-wegao@suse.com>
Date: Wed, 06 May 2026 13:16:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/2] open16: allow restricted O_CREAT of FIFOs
 and regular files
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> +
> +	if (n == 2) {
> +		SAFE_CHOWN(DIR, -1, gid1);
> +		SAFE_CHMOD(DIR, 0030 | S_ISVTX);
> +	} else {
> +		SAFE_CHOWN(DIR, 0, 0);
> +		SAFE_CHMOD(DIR, 0777 | S_ISVTX);
> +	}

This is not convincing me. We should probably add these values inside the
tcase struct and use a canary value for excluding SAFE_CHOWN/CHMOD from
being used.

Regards,

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

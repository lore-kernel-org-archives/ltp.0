Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71516606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvODNmIO
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 178D83CC570
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 15:41:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00EDF3CADF5
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 15:40:53 +0200 (CEST)
Received: from mail-qv2-x0a.google.com (mail-qv2-x0a.google.com
 [IPv6:2607:f8b0:4864:33::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7DECD1400DB6
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 15:40:53 +0200 (CEST)
Received: by mail-qv2-x0a.google.com with SMTP id
 6a1803df08f44-91438935506so4764186d6.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792590052; x=1793194852; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x7U2en63nJVG0MEvRG98pn4AoxtlxVplozQFRyZRv6M=;
 b=gvODNmIObqWLhjZyIE473FYBMWC12zWIROKqmlu92z7pRwFVpQnVR4DeFJl0dYrtE1
 gJi4EIir3C2fY7XgYcwGcuncgTQXnerDqtxIDRr4jaUMQH+gBQMvOzRcotYZsiVQWrWT
 T/+aIRNxoK5ICa2GvnAYdHp5fx8ubo/BpgOVVJK1D15rKAncxRap6B4fOHPfgssnEOOV
 KFbcYgUA9zzZZolg9Mhx5C3Yp60xRURr+lhi2QUBOVATuF+5zY8Gd0NZUYmlZ+OYe2WY
 IMMGCE+j4l6tcloX/uWE1iYyGK17w04E9/5dxDc+XVdbRGVuIxeunJz/yIMGA3OALuaO
 y1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792590052; x=1793194852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x7U2en63nJVG0MEvRG98pn4AoxtlxVplozQFRyZRv6M=;
 b=UCCPy4ekS6eDWalx5xQdslFDebKowhFaU6LwxyZaI/iuHOoJAt1XVz7eDgweTzfnks
 FF/HTfEyBkq0MXePKhoLmf/sISEyq1hlGuHaYKub/pSfsLYkgL5LR9ZDGP5FBt+Wm36o
 iXEsq4hLq3MtjHlWEdkCWbn1HAV4gIpmYRt0b6J5y6t7qsWl68wD6dFfYXjfrKzAY+uV
 T/+IpxekCA3DzC3oQqiPHvSecBhjD5JwKMhpLw4A8eU5xVnb0hoGoVyVri1Kk/C7QIQK
 cZiM3U+DmS6CwoNAiSKeVTY+LJ6AsB3Kkr8rT+ciQDarNPlgNguhwIpTIlylPD0Y/9YM
 afvw==
X-Gm-Message-State: AFq9FYKc53ILBKbAqRwS/Mp8WpGE/84b5mxbAtyuCGHs4VvuvHmtvn78
 +rQxqr89WVX2bIEPQChgP/JhDqTEOa45p5gVcsqAk3wwhkTentCpLk43
X-Gm-Gg: AYBFou1JwjY5MsRCUgPvFPr4KJp6d7RNgsYH809zr39HxYDAlwd6+vgTtyTY3YyPjWm
 bUkb2XfaiJTfxbkKhZ8MCclrqCKhkQH1Tbo6TmUjAoFStZy8FJcJJV89umVZEpY/Y0WqQ3Q8MnL
 bpOWQ2n5CBFa7pycCIcg+MG+Tnxx3gRndxuDrSTc3CbUgRVNyI3x+Rpm7ORJiVeSaVXWUfuwsh+
 JjVgSSvEJ1VNuDfFhJs5wEtkTA3/B4OTU+RBP1uVc904beOYMVIprsYCOJ5sL33l1wQoNoTZ0xm
 y7pekh3NTJa73/F3LmPDqu94WQFCz1ELEKZuPWA/3V06Qcr3H1JJwX42smhsKqcG6DRPlJ20NnU
 cr8uPTRAe1cPvKiOauBRAX1CbBmPhQXhrhu1ibiH6uR6dkuD61LlfK7QkRUl2RVvhzLA5N8eDJV
 KiR+f4cWKEELKDl4dEbqxay5PHZe7pshQeCNVQx+gJlAQmo/HUEzg1hwtNG+CtR7UtxnPYe7QkB
 DMMGYXZMKMGlWfCuHFyBx80cXRk0o7M+PW4uy03lkSURrgbvy/2jgjDjCn7gb6pXqAaStpSUmE5
 IoRXmoWMKear7zYDT35eG97MCVSskJb9XeSY3CvyZNa+XkXVuItpMnu4NeXHLr06Ku7XlQ==
X-Received: by 2002:a05:6214:2b05:b0:91b:907b:2fc7 with SMTP id
 6a1803df08f44-91c12ed9035mr34886576d6.31.1792590052032; 
 Wed, 21 Oct 2026 06:40:52 -0700 (PDT)
Received: from
 runnervmxehtw.xmbyooma5y2ebo5dustatj5sdc.cx.internal.cloudapp.net
 ([145.132.103.21]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10b72c02sm25231696d6.11.2026.10.21.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:40:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 21 Oct 2026 13:40:50 +0000
Message-ID: <20261021134051.78448-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021-build_system_optimize-v3-1-71a3c4c6f937@suse.com>
References: <20261021-build_system_optimize-v3-1-71a3c4c6f937@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] build: Fix library prerequisites in testcases.mk
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

Hi Andrea,

On Wed, 21 Oct 2026, Andrea Cervesato wrote:
> build: Fix library prerequisites in testcases.mk

--- [PATCH 3/3] ---

> diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
> +$(addsuffix -all,$(SUBDIRS)): trunk-all | $(SUBDIRS) $(MAKE_DEPS)

Medium severity: make -C testcases/kernel/syscalls -j4 SUBDIRS=getuid
now exits 2 because the shared-library sub-make inherits SUBDIRS=getuid
and looks for libs/getuid/Makefile. The same command succeeds before this
patch; keep the test-directory selection out of shared-library sub-makes.

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

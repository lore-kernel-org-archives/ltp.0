Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D9CA5FD4
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 13:43:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B28B13E11F4
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 15:43:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDC7C3E11F4
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:42:49 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A1B0600701
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:42:49 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-534a42fc445so4492621cf.1
 for <ltp@lists.linux.it>; Fri, 02 Oct 2026 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790948568; x=1791553368; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xYsQlWKMZOu3FsxAwpsiqkBul9D00ygybDwuZ0tueLY=;
 b=RCGAdAp0p18ep/4LiauUajIV1nPszwts4x+VVDFc5pb+j6syN1ZMsbPlH0PKO271/Y
 guucZpxXPgU6ZVOOMCPFmwsFr3sX2v61he/caV5TILPtVeIvyEk1ZiwucFNduvjqbEDA
 /EwWo2YNcGHjeyMFW1handib1Eeo5dP8k2tmdwNMskFSUbIFyTnTNKWk4G9nUO0kib4V
 hhCB86819wv6zQTi71T1GqtwdmIbnHDVMRSyj3dUAtYYwDavHtMKvcES6vgb0QIsflet
 PtyEQmo7GJTUWTwq0uboQ0Y9ZrtvOdf73/1aArQuS3eaTJCc1br1kofu0k5W23msHVBw
 grNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948568; x=1791553368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xYsQlWKMZOu3FsxAwpsiqkBul9D00ygybDwuZ0tueLY=;
 b=we3RXNBiSxPKAXAhoqqbFoo0Tz7eIaQdWCTfqztYVsKaexTPbCz1BcFOiiyubsfEVP
 7agP9EreUKxE9Rqu6V+PPrrt5LdkFtJmkXRgW2FJzzk8VwpksvR6qcR2ekDSYefPNVnX
 lNzmItGndiR4D5lOFjmaHNgcIVvHxj6lYDk8M18nyA1VSsutjYnj6ziwylpPQr+8rEVR
 ErXy255c+jEkf/QSIUFNFU64/lleJVd2i2YDWCDicuIwobBDFqMqpOqh+nfxufhGaLBI
 lZaWx40WetSPoxf2A0BzmLSA6zrGkUVvWHCgWlT7CdQMNT+2X1SYG4CfJuZWlDudLaU/
 WNDQ==
X-Gm-Message-State: AFq9FYK4vUqBK9N2s8ekDjIlZVk9flhMdr+S1MPGMY8YpyNUCT8A+Lna
 rdizT22jsyWdTzlLV/f5c7pB6rwH+STpOZpi4BxdbWQjoX+9SKsNboWL
X-Gm-Gg: AYBFou2J7Se2reuo3nFUViV1UvbuAFu7miATjg0FYB0seerkUD/gmP8neaD4qv4EN4J
 AX+SrTKGHzlVa3mp4+LZblbx7K+cf0FZrpETZB0zBQN1N0pKUnSAFw7T6Bp1m1W81y0X3BSE90s
 Ns35aa/knRVrVnVjxfq0udypyJVITeVEFIeXnPSYQga9Umeh9FRd2hEfnvA5Kz9PFAp0hcnKMNu
 e9N7q//BOpJ33obZvryyds1yE4nho0kc18s97di3Sk4/Z/DhUcgq/1EmZNbjOPWQ+j2LdMkqPDG
 chPCYNGet31Q79/gOx4Ec5qHU6BxCQwFypfdygSTyNIkdWDXJtWMNY7WABvKoIqs6IE1kiUOqxd
 x8C5Y8W1YghoZz1bOSBeVwNqnUicBVJZolJkyr91Oya4MzZpSxHmiYtz9VlYO3TP/kyMsscziQx
 29vetk3cR3u8Ne29Pxqew4m7tyWtbhq2LAt7Yt42xe1W0EqDod7BT5ARXr0BRmxP99AUXzJ4lj3
 wQKpnEn0eG8bKqvU57HawmUUajYJU61fkBwZvesR/JRgEbbWrG2k2OSLEXxVrQWodNirPDp8GYt
 y1qfkb85qGkx
X-Received: by 2002:a05:6214:491:b0:914:47db:4640 with SMTP id
 6a1803df08f44-917c011902dmr57464436d6.19.1790948567814; 
 Fri, 02 Oct 2026 06:42:47 -0700 (PDT)
Received: from
 runnervm8df0l.530sfc1j1x4exldi14v4jjn2ng.cx.internal.cloudapp.net
 ([20.109.95.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917d565489dsm20116466d6.0.2026.10.02.06.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:42:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri,  2 Oct 2026 13:42:46 +0000
Message-ID: <20261002134246.9378-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002130556.1236937-1-wakel@google.com>
References: <20261002130556.1236937-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/procfs.h: Add elf_prstatus and elf_prpsinfo fallbacks
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

Hi Wake,

On 2026-10-02, Wake Liu wrote:
> lapi/procfs.h: Add elf_prstatus and elf_prpsinfo fallbacks

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

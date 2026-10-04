Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F78CA5FE4
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 04:31:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B1453C2C00
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 06:31:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 340F23E6A90
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 06:31:13 +0200 (CEST)
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DE2C26002DA
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 06:31:12 +0200 (CEST)
Received: by mail-oo2-x00.google.com with SMTP id
 46e09a7af769-8235d03de17so428508a34.1
 for <ltp@lists.linux.it>; Sat, 03 Oct 2026 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791088271; x=1791693071; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zs0n8e9kfOVUNOh4lK3DEGBgLuoJBUXWFx/dCeGi724=;
 b=OY+dh6R40S/YzDCxR8CiviNBCOMEc790coBAa88OXK/rY1yVrw/6DvkT2+gjdJ2ixA
 3KjzibB4r4kfQCccu3fODIKdTXLX1FKSPCyfDE0DyUG0g9enpjOezbcjRHaYkQqlFWLS
 //KIk7CPmesSR2X2VNF9qMPZG7oPXuZwV8qmlUAgyPrCyx2TS3EEbwrX4IqMJTrzKADM
 yD86LBdncEbNGEozCsWrSyVSfvYCZMrpaIv5Sn1SdqlkcYCyvK4PU9eoBSo8qz3u3r/G
 NYYfTrPDa70+zxfa6pWMJ1n1YLZJ7EW5YFe7O7A7CtZmgHzSZ+v2u7smkVEAT0xoH+7e
 2Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791088271; x=1791693071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zs0n8e9kfOVUNOh4lK3DEGBgLuoJBUXWFx/dCeGi724=;
 b=egLIggs53URzPcxHK1AKD/Y9KRqmB8K7kgiBCeEsft91BtjMwGNdC9XuvKa2lSNQkP
 cRRuzBfTjHvHXkLu643iw/R6j+UG74/n4Lq6EEVcS2OCCjY0OGM3HdpNnTfelrWx3pVM
 Lexl6PayXHv/NIXacnkKp0h3/dkK9HYk0j0Z27pGzC5Ru8w0nZsa/gBzLpIvZfpNh7eC
 rHTHFQUmsg8AKeD5qXBs/xzbUykjGyAjLBp1994E6EgbufZmbJUmrU+9sU7GDViiaQUK
 ha4zyJLNfzlnYw01BXi/UkRw/irt5EhlJ97NIOg4xuhr0IgA9OHy6Mp+s/rzeEYXIJ3a
 R2ww==
X-Gm-Message-State: AFuF++npWjpj/sEl7e0ChSVbmuUBiZ0/ZnbcsmgxWysXPtwdgQiduMc1
 BjkOwbVdmaLjMPF32l7fYARnYotvY8Z8zJk07/FeaS5g3PFHLfgG5BDv
X-Gm-Gg: AYBFou3Syy82nCl06L82DSE7g+yfp1M9P9O+OKA8QDtx8XpWYfkzSVKS6YBQ+fIugTn
 NYqN2yzZe1t6IBYSyxX4ONTX7iWuLVyVU02867+wL8S2coq+UH1Js+vROVMWCNNLYpIkA1u8140
 DfZNboOnBhQDRhOhCWghbxPI1MUWoQF2TyDYdhQ1kFNI2MccTpaHK0wDCAgEp/5F43Pnk6kz6zk
 Zvin6fTbHPxEV6Tz/7wh4v1e4yU/j8w5mUW94ZGLp1lRp3iN4zzD6broh/BHQNHlphpQzghRSXi
 Uegz1aQlXTIuwBSAAZRo6nu9RMPMC7tFSA+vnhyoPyldgx2T4lripGYn+YqZps7Npv/XtsoJMJ+
 D7WOy0cX2l7+TZLUifDMHubj/C+Gth/cnZqqiwuIN6KUGvVZgUawgWV41JpeJ+o5HCWXY6nyClN
 QODDfEMzFszOkGVn/me3FBiouiH9ZTYZLo3SivNOnWjRNT4CnXp00hbRlsNEwo20mS2+mIB6mta
 HcM/ft4TUWH07XFBR8yc8fyfXHiiV/78dIphSoFnat3Xfs3YLVPN2tU8s2bSx7wLUITS5/04vaZ
 jf6VTjpMaLt4ZWdXWea3tYM=
X-Received: by 2002:a05:6830:926:b0:81c:e293:7d66 with SMTP id
 46e09a7af769-82282d72729mr7663546a34.21.1791088271501; 
 Sat, 03 Oct 2026 21:31:11 -0700 (PDT)
Received: from
 runnervm8df0l.oq3xicayfjpu1o1gnuwmpwcacd.gx.internal.cloudapp.net
 ([135.119.86.106]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-822793967f7sm7408191a34.8.2026.10.03.21.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 21:31:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Sun,  4 Oct 2026 04:31:09 +0000
Message-ID: <20261004043109.9291-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004015344.2862110-1-wakel@google.com>
References: <20261004015344.2862110-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] epoll_pwait04: Use raw syscalls to avoid SIGSEGV on
 32-bit Bionic
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

On Sun, 4 Oct 2026, Wake Liu wrote:
> epoll_pwait04: Use raw syscalls to avoid SIGSEGV on 32-bit Bionic

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

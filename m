Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E342606A31F
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NpwGXtPC
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D1AA3EA670
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 21:05:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 075143EA67D
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:05:29 +0200 (CEST)
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3598600325
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:05:28 +0200 (CEST)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-82757b1535eso1206581a34.0
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792436727; x=1793041527; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ywk315xHZU5wSpVsUT82atObC5XD/k7l3hQ4mB+q/Uo=;
 b=NpwGXtPCNYpuEWaTwSt1OloW+5lFDvlnChxIG7UsCTXnwo2Ne/UB8yHPM3P1Iap+hH
 Y5qxNwGxPmPFBKmQWn6/dqUqUCfrp5PwWMu4ltcya6097DCIDyDjo8WiGAL8rG+OKBE6
 r4IVO392irxerZSmoRBKunxxhF6x4mq7ZGabdzZ50hXC4opVdadP6PFLC/a3jrZbCy/F
 EBomnF3Lj+rNj4rTzh8AjBLncRakzpH8zcRllPiDlhHs7pYzcGo4u+UAJDzBFDyqRjcL
 w44EvadsGmNKV86FsY5X9g7XZpDMV9oIGwCPdwOEtpHWVJhU5+HaxcWlicO70Cc8H6cJ
 i9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792436727; x=1793041527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ywk315xHZU5wSpVsUT82atObC5XD/k7l3hQ4mB+q/Uo=;
 b=VwcfwDaqwyoUyI/AT86CX1n/Yzl5vGEBCOw2tv0rws2NMln3bhCGhMjTMvNwaWIrKH
 Y+l/SSYF6ewaQ4LnwgfGmXrC3AzSKZZmGZFeL40Py3KF0Dy6RuhqMWq2GEZSR6wg6r+F
 rsvBRYolQ9B9PUgXb6sjKrsbFvfJa7WwUp4+nfrZAOcm0P+z+5h/3gZ90628qtkc+40q
 c0oSewhgL/Mwh0pH/2I+kpO2OBkMIoWCOg5CwHCw21VX99ES8g54XlBqgvPD9HHaTG2Z
 BYWm+lhl0D1rM344M8mDW8e4LPhCrBsVcSyNEqYL7rLNsMm4FzqVOW99g9whCA6oX/R/
 O2ug==
X-Gm-Message-State: AFq9FYKAmu9DMJ5UdqroNyUoIdXe9RdYDj9ZesoUlJZb8ZXGTkFAxl/v
 +hR53WCOPyfDUdMw0F8YtZG5Zbbm8+BZ/GJiY75nf8O2igwU4IVhvWxh
X-Gm-Gg: AYBFou2voPe95RCTwQ5d1bS9/svgVwfiG/bHz+oIU5EYi+WcIBfGvtqppHTLFW5JVRF
 rjFd08YIA1U6G3x//TbsdjbOEI4P+DGFFCL4PqpvCEM45uf+aunWWouOxXoVMD3HHP0sheYB1nD
 U5oMEwt/d6NQ4jOwkuWf2HrVCQv8SoqtOatqBZ4gZU2aoej399aOfJ1BuBZSCvrU/ZrvFhLrI35
 Iock2yjWN5VtxWA4azjR1ZxDmSHtCMYwPxLYKLVHqsHVwCzH5c+z4htTKxyCbvyrb4jauZrUHEb
 GNMldGV0PNuzGtkVZoJicArlXAXQDtzaFhF1G0wIBRGKf+xKmk0B6Ab+A/Ju3R+d250myx0MBgb
 QflYswavR7DdzJzLc4EBzTBsQXxZzGB451WNdoSFtPt1Vn+nsmHDJTz7r7t7io++OihwFnyKZ9G
 hRUOx9/6VRIxzSegO1WB7IIst83gWNFXoLhZntv4WqEB0ET5d7LRCK2MaR0uLWoiQhBwfyXcsGH
 i0HAByPvBMHGMNr/S9rcwnYSI1He9EbC9denMIGjN5ZRYHYn65t8TGCuUNfHQZw5F+CVduTlygs
 pkXeCbxdbVjZJw==
X-Received: by 2002:a05:6808:10d6:b0:4d6:90f4:48b4 with SMTP id
 5614622812f47-53cd1ca7192mr8797412b6e.54.1792436727135; 
 Mon, 19 Oct 2026 12:05:27 -0700 (PDT)
Received: from
 runnervm8k3b6.2ei03m0ezsputoembsqrc0hkbb.gx.internal.cloudapp.net
 ([132.196.35.138]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-54481784097sm3403725b6e.3.2026.10.19.12.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:05:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Oct 2026 19:05:25 +0000
Message-ID: <20261019190525.3963-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <dc45087f4a5dd1700aae6df3a8181ae349f2bdfe.1792413269.git.jstancek@redhat.com>
References: <dc45087f4a5dd1700aae6df3a8181ae349f2bdfe.1792413269.git.jstancek@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] float_trigo: Fix acos/asin/atan input generation
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

Hi Jan,

On Mon, 19 Oct 2026, Jan Stancek via ltp wrote:
> float_trigo: Fix acos/asin/atan input generation

Verdict - Reviewed

Pre-existing issue (low severity; separate follow-up):

In genacos.c, genasin.c and genatan.c, both create_*_file() functions
test open() with if (!fp) and ignore write() failures. An output path
that is a directory therefore makes either mode report success and exit
0 without producing data, both before and after this patch. Check
fp < 0, handle write() failures and propagate failure from main().

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

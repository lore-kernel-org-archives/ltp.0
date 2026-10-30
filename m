Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA0606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=00K/TyVJ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 966373EA3C2
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 01:31:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F30593E5255
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 01:31:32 +0100 (CET)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 62117200062
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 01:31:32 +0100 (CET)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-369fd8abd71so167678eec.1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793320291; x=1793925091; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/iL5lMoQS6mkrpMzlswif/Ju4gY2n0p8pZopyO1Cg9M=;
 b=00K/TyVJ2dd6EKpSzj0bYWZ65A0ksYQQNzyjVygr7YPF9r15vbFdQEIZQ1T/404plg
 5LC+Cynf5inHAyaK9jV2DzTRg4Z0zpEIhrMTZgSVntLkQEhlMQv6c0p9T/Z7FmOMBtL9
 57E12yWvCuSnp5elFVr+s5oSqaFtrsdRfPCvus6yVVmQ19GSBqkEn1XGVJ4G15NeRaCW
 FRCoR7K1UzulDdOtjRgnSI9tBCE0UbGT8ul3iMpJFkYKddEDu6qY1OZszKTxIFyaG4vC
 t8cO2635IiyDIhWIPRT6v4M/R0K4Y2dTWjWEwzIxNJMfkKKysadiOu40kjJD+AC0ZFbS
 EKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793320291; x=1793925091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/iL5lMoQS6mkrpMzlswif/Ju4gY2n0p8pZopyO1Cg9M=;
 b=uZ81LyLXtHqqQVbK5i/SXdJXrg5VlsUoJKme60jFaAWYUxsQJ0J0Q4Z7OgVlndkQii
 Ap1m7sryKBK1YcajVoqxgslqLh4AvDK6Y1uYgHmZVSGV2yoJfjt/qdZfWoZ2ebCdB0nQ
 bGM/eTBy5NcCcRL4oCLgw4Bktlx9KxhvnROb/pGfr4EvkUspjjhpHkHfKI/Mg1Z/uf4/
 1Zl++boYjbOkvvQWRHmf0ve/o3IYOF5U/iEJg3t5WXM+CO5sWN9owfslDSG9ggAzwgFF
 TX76EKJDUxhH7EC+30XblR+ldLcQRBreLLVnuFqjyvRch9Kv0DYHKkkx0LRPa6SEbLzX
 cfKg==
X-Gm-Message-State: AFq9FYIMRF9wrhLYtT0GiayIpedjlkCS1+oFiajIlvwzDr9Ps0FKktwc
 nOE+517Lf2IBmevcxP367UQPdPTkkXVTJys/REJCewmxcMVsTauhKwEOYin01KcO+A8=
X-Gm-Gg: AYBFou2RpZg1c5uDFgDRbXzPCEv16qEXBN0EC03nVO+hvkm+7TkY/Qgb1g2Lw8JOS/u
 UH5g7+VKGE76pzmiKA8PcG2Z0r/STSRVbq3AJpK4r4In8QEvEVKsfQCkJtKgWut51C4PJOJy+jD
 lVQW9WT6S1ftlIDMe/pVJu2YtCZKNvw42shNNJngj6VIUVHHc6XRKwo+VLMtM0JVW72dw0w5mR+
 Nw40iMgdzbBAMfVJJ4DCQGu4/NaDgXPnju0Qm5gqWJ6mwHR0yHI0YeVO2UyHwn6pRIjyhXfUtg7
 8IlhLNwc2E6PiWwXCyJNoz7eZllsTLCeq7yu3RcgkPprB6sPzuhm5UoM/Br5rbTVn2yoeZcmFcW
 9WsLTAPlXXiRO80Whr49ILDi0NCpjdPdiX+6fSzXM8HwHijQuz2F47amyHeKdqkWUmIRlTHHl/q
 qxKAn0azSCLpYAN9UFt+fErinFuy2hI/q+DdQzyIRWKHFSsLi1KwJSsYIKI5Pguo1c/Y0qWjw7D
 2JEhj19fjSxc9OG14OFq3o2M2Mf1kTxOkIGHcwyD/iRo/sogrCYFc1QdXvP0gpiNrXIlocygCCL
 2YIWWrESsHLuDic92rifVCdL95Niz6UXB+CDAjHa9GJEVSo2bYQtdp7zffLfBxJbwwf+hKjfa00
 DTUxd1CJF21g+MCaHKn1xhPjm+cqJFioL244G1CuV
X-Received: by 2002:a05:7022:3f04:b0:181:ccdd:ed2a with SMTP id
 a92af1059eb24-1ac5d5aaeb1mr959571c88.43.1793320290610; 
 Thu, 29 Oct 2026 17:31:30 -0700 (PDT)
Received: from
 runnervmnwato.vxwubsvclilezgs3f1xfxeaexc.yx.internal.cloudapp.net
 ([52.161.51.69]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a9e2ed3sm1976486c88.19.2026.10.29.17.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 17:31:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 30 Oct 2026 00:31:28 +0000
Message-ID: <20261030003128.3782-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029210701.80050-1-dennylin0707@gmail.com>
References: <20261029210701.80050-1-dennylin0707@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inotify13: check rename cookie pairing after adjacent
 moves
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

Hi Hungyu,

On Thu Oct 29, 2026, Hungyu Lin <dennylin0707@gmail.com> wrote:
> inotify13: check rename cookie pairing after adjacent moves

> +/*\
> + * Verify that two IN_MOVED_FROM events that differ only in their rename
> + * cookie are not coalesced.
> + *
> + * inotify(7) allows coalescing only of events with identical wd, mask,

Use :manpage:`inotify(7)` in the RST doc comment so that the test catalog
renders a link to the man page.

> +static void cleanup(void)
> +{
> +	if (fd_notify >= 0)
> +		SAFE_CLOSE(fd_notify);
> +}

Use "if (fd_notify != -1)" to check file descriptor validity in cleanup(),
matching the -1 initialization convention.

> +static struct tst_test test = {
> +	.test = verify_inotify,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};

Since this is a kernel regression test, add .tags with the "linux-git" fix
commit hash in struct tst_test once the kernel fix is merged.

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

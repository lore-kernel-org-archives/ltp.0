Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94123606A31A
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INcpc2md
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6B613E982D
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 20:38:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FF0D3CFDCC
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 20:37:49 +0100 (CET)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E70531400332
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 20:37:48 +0100 (CET)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-93e5da88874so51212385a.1
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793475468; x=1794080268; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFBupJ7zpdF1CZt77XaWTTM5VZs1TMZu10tQh8xNEEo=;
 b=INcpc2mdsKiAFmeTB1FDjsIQj/Qo9zTf9PQnv6I+iJMFUThxRJWWHZf2dKnKUrQecd
 FNlw+Wce5EGDho23CubdegDBrBbzNehDpIo/CHC6eFgVvUshuno4pfpu73LHr4E0P7su
 cQwGRb2BqUe8C147BW5plD8illJ0H0ohTYFzDPGetf+dcqrxxN27B344hvqm1OXfjttx
 OTqDRHLOUO+BHVlcUkRsu4xx405qPU+XN51fxmXkpPhPNZRboLK4QSe3bpJ+D/L7sq6k
 0wthQmpAeY4BfFozafcg9Fk5upL4tTAhW/aeNTCXzdNHoHWkBCB7wYmJ8+TTPSmuOzZh
 9etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793475468; x=1794080268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kFBupJ7zpdF1CZt77XaWTTM5VZs1TMZu10tQh8xNEEo=;
 b=Nh6HpjcSf4rOcU6fZeX/Dx7RuehroWvF3i8U0wFPZd4fe9wfUFj/mwnThiq1HwVhDZ
 OrQEcy3NBnmJXDW7Z+8QtI8HUX10GzMf1+B8aONDQkWR/A968s4xYW1BbHzKchUq2Lun
 W80BbzZCOZi/cbzm38ECDgszzAtl9wxPDdkawcyZHL5e+rUsTcFSpgM3/RiaPr2hf836
 FMDNkRP6Qet1efoYi6fCxome66tROMKt31+pO7dXvzF608UGzyiJRRkkMEAETaHpAta3
 R3pIMmumlifD6JpNqKp80jRrhNS6zPzqa9QABtKFTvOAuDeEvCZxaX29/tNtTN+IjiZw
 9fMQ==
X-Gm-Message-State: AFq9FYJT8iDiPf/e5OQXSMSgeV6da71IBl3QmDBxg25bHJqVePD/WXu+
 K/OT11aAfX/kS4iZwsQVXrPG0VTAV23or4ML2CS3Y5NRyfK2Bv8+kz/H
X-Gm-Gg: AYBFou2dIeYPGJA2JmeHvfufeR5Q0LjsuiYBjS/Hs5ryHZWA8L6nUSJqbM2m3Unjjhe
 TCDmB+aB6uaZj6UEzlRFfRZQQ3hlFc50R9t2YGFhgeDV2JJTKykSU6PyPLB0lY60w/SPjG6VWvc
 0STSwRkoKkals7RTwC33vfk+WawULYsxh5zcvjOYgFZTaoGfhkJoulTqXG1HQFzfdDO3BqgJM/h
 NXIJ/yeVjvJmg7HyAkWRcyZI+JWCidNNUwVSTK+klR7N/KbCkI1TYSo1rOREyMn8xaCFo77fdek
 K0m7z49dXspqYKVNgwhbGf3UEDCNGrk+p2jtoEVVnusS9d+Dyr4ae16mQKMSzc/zsgM4GQE6hAx
 ffN/xq4eEhZDAKWmw4faCmaSiV0MlspJj60IAbxzlV+EQ1F3JQcB77cNLzgQwifYmTVpQnfdtEC
 d35RN3VoOJT7UvOgVzskrZN9HySCmizQFk9pVAEb8CtqMbFgvfaYfUutFh9WVGKsUL3U5XdkVhR
 MEDdxDLXjZftmR00VfPRPuchH2W8Xvse48DDkYzMb65jpuHS6A/TorIhS+YeyDOrnal2TUg7aVG
 9Yu0vv2cvzld+bCIYEDw422IIg6oc3O67E7GHqPJrIaxMqbd8Wx+DXqCCmLYX+VBlQKVfBH2GBg
 IPXnByxvqofoOnp8TtYymaqVVI3hLFbwH01lHF6/q1I0=
X-Received: by 2002:a05:620a:40d5:b0:93e:c12c:fbd7 with SMTP id
 af79cd13be357-944217dc222mr935021585a.83.1793475467491; 
 Sat, 31 Oct 2026 12:37:47 -0700 (PDT)
Received: from
 runnervmnwato.e5y4ld35i51udkqy5fdit0hc5g.bx.internal.cloudapp.net
 ([48.217.228.129]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425ac6bddsm445781285a.37.2026.10.31.12.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 12:37:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Edvard Conrad <edvard@tuta.io>
Date: Sat, 31 Oct 2026 19:37:46 +0000
Message-ID: <20261031193746.6322-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <P5I00QE--F-9@tuta.io>
References: <P5I00QE--F-9@tuta.io>
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
Subject: Re: [LTP] syscalls/fanotify26: Move from staging to syscalls
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

Hi Edvard,

On Sat Oct 31 18:31:21 2026 +0100, Edvard Conrad <edvard@tuta.io> wrote:
> syscalls/fanotify26: Move from staging to syscalls

> diff --git a/runtest/staging b/runtest/staging
> index 2ce76b119..ef1cdea15 100644
> --- a/runtest/staging
> +++ b/runtest/staging
> @@ -1,2 +1 @@
>  # Tests for features that are not yet in the stable kernel ABI
> -fanotify26 fanotify26
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ff3de1b15..23d3e21ef 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -703,6 +703,7 @@ fanotify22 fanotify22
>  fanotify23 fanotify23
>  fanotify24 fanotify24
>  fanotify25 fanotify25
> +fanotify26 fanotify26

Kernel commit c3d355f427ce targets v7.4-rc1, while the latest stable
kernel release is v7.3. Tests that depend on kernel changes not yet in a
finalized mainline release must remain in runtest/staging until v7.4 is
released. Keep fanotify26 in runtest/staging until v7.4 is out, or split
the linux-git tag addition into its own patch if needed now.

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

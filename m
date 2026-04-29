Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F7FF887E
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 15:18:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3131D3E4A73
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 17:18:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F7653C66CA
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 17:18:37 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8BE251400C7B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 17:18:36 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8d4f78fc9f6so1375887085a.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777475915; x=1778080715; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sI3T+tOdHYSfX/QLc1kI372D5l6V38DZKOH5QmUQk5Q=;
 b=rx5Tlwnx4d0plptJ3Qz85btNf+zp5Seyp3KrWosyEA7RRBNQn1oqERHy6KOcaskeEp
 me8kTbUKhraLwz6OPjAas56m+8nVIL1zi5Q4R7DzxRGsCwOlAp/IZWFhXPbJrKxMJwa1
 UK0ynOFRhUTXny2ou5uQ9bNyJXgHmxNhoCxWm/zwgmbtbwp9oqgQ5Raidn5OXp9SG3cL
 uSLENxcZ/hkg9w4gqA+9IxUzlL6NEeicWNj6gyUtsoODfdXCgAq9nT9DlMNMrW7GtKU1
 fBolPbRU7LAak9s9FvOZeyYScW8z+LJtxgMR00V+n3uLJqY4gTapYxbYX+pH3f8xLefk
 Lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777475915; x=1778080715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sI3T+tOdHYSfX/QLc1kI372D5l6V38DZKOH5QmUQk5Q=;
 b=E4nX4uxWYaTpjXGuF3pZEgquEYrPJH5zdtnvmfgnfVohw/CvVAqzYX0Opa4n2S3E7B
 1AACXuwpIdNyWXQKmxsqknkNVst03J8ncaic9TBGcZfZJI9+rZCLYebZKhvovh/ts3A9
 DmBQvFliME+BHG/JaAADmysx4iMNcn102ErXTaj902hV3dNbnfKryYkvUZDRGlmZZc7u
 QlidodDM658jf0tjwKTLUkdk2wt/wUYiKCShnpwCSdTR0OlvmPXisUReQcKNYCDg/D//
 H130WOgc746NxgqluWI4aoiagHM85zhN4YROo7LriZjtvcLpaEAVnPbuDUtK7QsC1VKB
 a1xQ==
X-Gm-Message-State: AOJu0YynR7lssyM0SZH3GlkBrzzqi1q3xamhV9O2hqNAkaMUsnBqbjxp
 ST88xS8onXGjL16Rf5BWEALR1ujazfibeIHHkKoaB4bI7tfSJSQqMRzl
X-Gm-Gg: AeBDiet9Lkc3Lhlzh3/II7++NAAcCqPdMqot9W1QZuFg085oC0/NuSa5ICRT1yWw/+i
 HMOaUIxHWAi9nB6wuj7793K9Nv9577c6bY2zbUm+a9sJ8h9zVk8x5NEPMtjCQnGL4Czd1O37tzf
 Rb0atZ1VPfj4RgquCgjrmyY0pVzil5Sao31D9oHgqsssnlzmIuQA0KWT2M2OMhVAK+ZeE/h3Xde
 xjrxy+IZqSbLnRvPfmE4j7h9Iq3p8zuivqZfw0VUz9ffU4CQKfvWyhLyNb2oCbBtmCOWBzm7qaS
 NoALaIawxswkvlSwaV4Y3CMROAjbaHpce66M0ZEAqVrPF+1N5OMr8OEzzL98O0SsRzx6+Vc9EV5
 l7jJQHE8XbfLGRut8XuPdrZIHvbuQEcju/T89oj3eQS4BvlNFTACWxAj8U2IumCpvGZi6Zc2yts
 7sQ1XIUTC944Sn674kbN5JNXL5vtr/aaKUNWpu7YrECZgd4V8qgLBvER+AGVByEy9sMCQWmLpNd
 SHseUrTEFVRHq+BR28/AahNGz2rgyysufDG2c9ht+K8hGLT7k3X
X-Received: by 2002:a05:620a:28d6:b0:8ef:dcb7:59a5 with SMTP id
 af79cd13be357-8f7d920262bmr1088037285a.30.1777475915058; 
 Wed, 29 Apr 2026 08:18:35 -0700 (PDT)
Received: from
 runnervmeorf1.huximawhmwiu1p2xc5qsgb550a.bx.internal.cloudapp.net
 ([172.203.253.214]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f940536e87sm198344785a.45.2026.04.29.08.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:18:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Wed, 29 Apr 2026 15:18:34 +0000
Message-ID: <20260429151834.3982-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429142016.1483-1-always.starving0@gmail.com>
References: <20260429142016.1483-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] close02: add test for double close EBADF
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

Hi Jinseok,

On 2026-04-29, Jinseok Kim wrote:
> close02: add test for double close EBADF

> +static void setup(void)
> +{
> +	fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
> +	SAFE_CLOSE(fd_closed);
> +}

SAFE_CLOSE(fd_closed) resets fd_closed to -1 (the macro does `fd = -1`
after the close), so both test cases end up calling close(-1). The second
case never exercises the double-close path. Use a local variable to
preserve the fd value:

    int fd = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
    fd_closed = fd;
    SAFE_CLOSE(fd);

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

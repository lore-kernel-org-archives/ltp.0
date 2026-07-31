Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0FDC55173
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 20:21:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E8303E71E2
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 22:21:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 238F13E286A
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 22:21:04 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B8B581A0081F
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 22:21:03 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8ef118ead8eso8107546d6.0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785529262; x=1786134062; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RI40csf5Pkvj4SSv9sVBdJCeWNr3iCYMhc4gfFZtW50=;
 b=PGQtqa7li5+ckpoEgHft20XFDaoP6OzQVDg62qlWVdw4xkK/w41frCKthFVkkwFUQZ
 uvM1mRn2Jr75N560q29ZW/jIhmmPshmZXiLbKiuC8JJqyusVkswRjdlPFpuw6iClMjIg
 QC5GqWT4fy+W0tyg89oevkn12ZIsV4MyCeoC/K4ikm9ixj3ZGIFnzfNUBNcvwiyeKt3D
 Kabr45Us4XaMn9NlhiG4ApqANmhrAU6KBhU7XP7oEtKukDzBSp40ah/4RDsq7HAQunnF
 Vk2hOGT6W51pv1f6gPSU83YwIyrbKkXSICXlnzFisKIyF0ymeuDCkRKlecpw1VWHF63e
 N5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785529262; x=1786134062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RI40csf5Pkvj4SSv9sVBdJCeWNr3iCYMhc4gfFZtW50=;
 b=a5sjo6G0egmiDN/0DvcMwvBJ3LRHfwfy3dNjpccESu5tyjByHLugWj7PELsGeMoZsK
 xaRK+r52ZP58BjVgHVTKRg7WNn/Tk1bpdZ2QDkD0pqil+aXnJoS2OLyC6jSW0JRxukWx
 MbgAOhzEVIVuN0mk/xH4kww1UGpkphmqVZLbWSnzfb1KhugNhu4rBUu6jWHxBH/INhyd
 Yp4IS7Gc+QGG2KokaEFLNeKh9777CavvE73OmXtHzbBjCHMR3WZfKwArbH8yAUsG4ZAD
 y1KTtyLBfUOI9Xn1wDbUk20UEWjdUJrrxqHSpopiBIEYSZ7RRafM3L+8+dfuhpISvicb
 TywQ==
X-Gm-Message-State: AOJu0Yx7FrMXaJwQQGDVJCLqboE0tBNZXc5NH2sEDxCFMAyXDgwnD7mG
 bKyyHOPLZqnbhcvgbRUBXjczaTnkgLG2/GTTQGL6iPc0hxCCYaSqc7BD
X-Gm-Gg: AR+sD11fjupusF2/JE/gfdA/ajLR1EN6BEkqEOufx15GmhP48pE0oq7tGlw5GAotykl
 m/a5y325zUnv7Puv3h5Lm+YmDjIXVL2ZeO8ig5RmKY3GrFzJkC2uqzXdIiMoJA9XAV4JpYmJCu5
 2J+nKA/08nLRX7pO99D5kXXB7xP4m+B7pgPsMuF/Z1NREeoaYn8vDOot62s18J+Y8uWssJzRs9x
 8R7AY9ICeFei9WYEb4UaNCv6uB1n2vS1vwnppBsPoaQj+rDZw2+x7PJXCyE12KIuuB4dyvJR+/u
 P7iKnZ4vEYFwIwGHazf49QpcoXZI/VS0TiBwS+lCG40c0NIs+FfgrzXCtTevtj02fkMt+tq8u4Z
 oJHMjrGu95RoMX3iJgbHrmR4PFzUPQ9pCkbNVnwgpbQ1OZla8Iehy63uNe+FbqxNaRqsveoC4ZI
 +WULVqKBvWA0y53LmKbgFmSpxSMULWOZrk2YpWYH50XZhnOr9RGQOQF1pdr4TJEKE+ksIYpXBI9
 HRuoTPW+kLJQ8WG0szPHGD3CJnzvcqnQK5nrB5TLeSXFi5bSHpMSDmbQEBch9CsJd9bRj3cIQ==
X-Received: by 2002:a05:6214:4993:b0:907:94e6:f8bc with SMTP id
 6a1803df08f44-908496403b6mr27441246d6.15.1785529262180; 
 Fri, 31 Jul 2026 13:21:02 -0700 (PDT)
Received: from
 runnervmvrwv9.iqcvtop1gtletd22nby4u5jplg.bx.internal.cloudapp.net
 ([4.246.135.6]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9084a8386a3sm3812906d6.15.2026.07.31.13.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:21:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri, 31 Jul 2026 20:21:00 +0000
Message-ID: <20260731202101.3942-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731200322.161590-1-avinesh.kumar@suse.com>
References: <20260731200322.161590-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] network: Remove outdated DNS stress tests
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

Hi Avinesh,

On July 31, 2026, Avinesh Kumar wrote:
> network: Remove outdated DNS stress tests

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

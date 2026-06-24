Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B262FCDE002
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 16:24:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C83373E914B
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 18:24:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCBDB3C01A4
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 18:24:14 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3B1141400DA6
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 18:24:14 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8e5be46f663so5372076d6.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782318253; x=1782923053; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FgsbL+vy1fvScXyl9RYyjl3HsrAXUwIuElkjg+2v6w=;
 b=fGpAbtbtn/RsiZvT0OZ0uMIlLmfEJvrH+BCj9lFF/oVngxl0X/Y5vrYBr62Ufvvx1m
 fIOMcIzHcaLn6ArWN2cK5OwNoum5erRYPYJKuTFEzXNCwG2RXy1Sy/6iRDPeYVxIuTvr
 KARv6wUou+tXRb6vPVdRLSfLq5NMnceorSyA2xsEtB6ZgZ7bTC8H26tbuT899Es2dI7P
 zYhDPjl/UZi2Qg7gqMG6yidNhWLyIjv2ZSWbe0pDSkMC6lWeP5FBE4mHGlmNj7w1L5Os
 ek/n2vr+NIXEnzl1gn1jH5iQg6IrewiYAp/G/r5kJDQXC5y0SnBZkCyI2t71SjBbfPzO
 jzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782318253; x=1782923053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0FgsbL+vy1fvScXyl9RYyjl3HsrAXUwIuElkjg+2v6w=;
 b=gy7xd+u11mNwWj8huS+VoWCkZE+cJp7mC4cdyjIcKflEbgePu3/gF7K2gPQDAM/42e
 NMISoEl3QU+6irgAdLDDLbwoOdnzgpPdu/OKunzJxg7GtHc6pi79aJq02Y/b8k68eSFn
 Dh/XhWy738hOI+kmftd8T49rRz0s+vn5/4uY20G5VKYy7kZS549iKYHFOmnTNrtCgZ9p
 QR+H+yuFEnALVtz16bSPbWUfXf6rd4jSG5qqKsCgA9T2m/1l9p56WZR7W6Mfg1th/nXA
 2rL8/oxnXsQAUuN7l4wA/0KltafEt0q0ddCGxjrNS/EIyXmQ4JdLwdPkJuqjTGQ4AMrN
 Wx+w==
X-Gm-Message-State: AOJu0YyTERnbR3v+WOFXPImxOAe7L+dELvpFldsg2r2gMhdR2vWi9mxq
 NMke0BuoqQ4wzQJF6jcc0H5iFMUSVnL5bl76xocrbSRGQFgQbz/UGX9+
X-Gm-Gg: AfdE7cnPgbadb8bFDwdXSaps3O+s4t+3w/f5lylbkOXJoFko/IFrjAUQIobYNRUsKPo
 EDY19gGv6MrPNu4+lPUiPhP+mlk7PzCGV6DT472NNx0d4o1ZypBAiBQGR2KUSBp0mnkw2JYpM0L
 PqlYjIz6Q/fQoqgm3zt3vZArfk0XGqj+AugJsMJzEAG2XOIWkLK6A2m75XtCbn07oD9uSW+EcOE
 xA1X5oJK/lmMyCYjn+3E7hPaVudRqBSTHAn128B+/0+za2fl1jwa/X+OaF8pDrGgRP7Y6bVucpz
 bG2+tLQ6q8tprQjRo/+T8aYS8GWLSB6b5LO9sSZ61028fYJtSqzbcMAwGQND2KQJFu+S8QpOvOQ
 GCP1aldP1KJrDZADWvk4Gz2P6p+emCov7D3RGNxjFUoaWcsc/wV8zZZrZTkQKnrpUajsaK4Ymcp
 GwB17t5oljJ9MPQyJiDYZYg/4rFuttbuAbFQiDEL466CbbZd7MJRLUHQh0BVM4fYf9VasUePbpw
 D+QqplizI57pNe4LfWC3PQlaGNolA==
X-Received: by 2002:a05:620a:4710:b0:922:92b1:9dfc with SMTP id
 af79cd13be357-92781e031c4mr634278285a.14.1782318252631; 
 Wed, 24 Jun 2026 09:24:12 -0700 (PDT)
Received: from
 runnervm7b5n9.asza5amywjqudnrwvdv2p0ydkb.bx.internal.cloudapp.net
 ([20.172.192.249]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fda626adsm590033785a.12.2026.06.24.09.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 09:24:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 24 Jun 2026 16:24:11 +0000
Message-ID: <20260624162411.3943-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624-metadata_linter-v1-1-3d9506169aad@suse.com>
References: <20260624-metadata_linter-v1-1-3d9506169aad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] metadata: add linter for JSON file
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

Hi Andrea,

On Wed, 24 Jun 2026 16:27:21 +0200, Andrea Cervesato wrote:
> metadata: add linter for JSON file

> +    parser.add_argument(
> +        "--check-cve-online",
> +        action="store_true",
> +        help="verify CVE existence against the online CVE database",
> +    )
> +    args = parser.parse_args()

> +    errors: List[str] = lint_tests(tests, args.check_cve_exists)

argparse stores --check-cve-online as check_cve_online, but the code
reads check_cve_exists. This raises AttributeError every time main()
runs, even when the flag is not passed (the attribute simply does not
exist on the Namespace object).

Should this be args.check_cve_online?

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

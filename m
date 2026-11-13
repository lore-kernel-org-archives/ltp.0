Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC261606A31C
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1Ln+7TW
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D05A33EB521
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 03:13:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 987683C2026
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 03:13:36 +0100 (CET)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CEBD71A00FFA
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 03:13:35 +0100 (CET)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-930f7b1eb68so47061585a.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 18:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794536014; x=1795140814; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yh9Tobt/+bhTk/LiMnT+FqKLfGd8zoBtoixU5QDl+Ic=;
 b=Y1Ln+7TWDI/mD+bGEzPYQMorAxM+WXyUhI3klz+l2pg8K5xj4TJl77Eg3sT+Dk9tgc
 W1YY/M6IjS296z/se9YpowKX1zSNCmcFdqmeG0cZ9g6hYcLvcXRNnwrczPmRbPW5JVKG
 yrJmK5jyVSZTXAuVvmcKYIIB/NfqIILgIMe6Zt+i8tzuCZX/Z28LyqyY5UmVTWiWNN6N
 O4dIfSZPNkS4jErGPxYWeMIkhez9jT1Irq3mVxumy+b4c/vKBuy3dZgtQJE9f8CRZSBU
 Yc5jLByidABA894jgG0XS7NRyNPPo/hO5fxORXEEyF83ndienbZlVdtGncM3bbWPTagn
 LhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794536014; x=1795140814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yh9Tobt/+bhTk/LiMnT+FqKLfGd8zoBtoixU5QDl+Ic=;
 b=s8VgKRn+m5PxD0EHuMeOA6PNTrrWjD6RgzRPOGdQVd37RALP+9jt0mk7wDj+m6gbnm
 9kBPuH7eBQXOK9Iapk8tRONf0oHVP5m0C3cX/AQ8xfuQY7FaAdviXZzxrAtadgYfX6lp
 4KKd6jfeBMZ90LcsAxhxeL4KKrYqYtw5+HEqjmV2iW8d2IXxLqm09WOF85rA/ihuEf8X
 KmhqfeGTsXyexumv+BuWg0WXqRbbQhlUtuRpR/TB9zlU6l5am/M/mnzUjxNgteTz6KWf
 czTK77VU516dP0/BYqTfckOPFWdUQls1mtGjl0+nwAl6tk1+sg4Nz4+5w2VX23OWX+LT
 foig==
X-Gm-Message-State: APuU4Z/JtDmkItkl0kWZzScUo0K1jdaX2dYfG8Qa2f+akgrvHDeY1coP
 yN+9Yq8GalKST3Mu8dvM2b9srXFMjXgoqTjKXDvP1+6AIKmtAa6id3+N
X-Gm-Gg: AYBFou2Mzp8Zp/DQyknDrM1xAv/UQKLcd1VdNqPXF1TJplt/xHj8LyqGNRv3MANSjAL
 VC5146BNKbL4cgdavG6adEamhaNEABih5/jEeR0HEEKkGto7uyiUc/u+1ruW/x8KCcxrwFXLVnD
 mSL3pEXQTG6zOzQz+EYvuxBAWJFBYf00jdq3uD/fzAhuVOYO+9EDaerflPBH4n1XH7g+i/pfTRB
 f2rWJhrnqtfS2N3ZyKkPN+b3yrJq9Staif/yz0Jr8P2gFoLkhfnxFOTsArZTKt7MmnLCK7tb6Gp
 hztX5O04tTLO1wWv6z79faieRU5p4vz0ygdGxERqIirvzBpQiVmXFH3DT1IVqWxKqBXSBVITDHL
 DVlm8NBX9QVa7ecVQvjMNfuQK2tWCULZjdXwT411ljujPlcdXsPKezIbBJGaeaJ2JccrljI1AfN
 e6tvaqNKjMQDR2yY1z/0WatWAH5aa+Js0FKUGl0lOjIC7MR4uMdJPA4mYDZDY3toAg/Kt3vs+ic
 AyoI/LxWmHjcf12yX1oj/MA+X34gx7NL+PK9W0qzvfxWrjaleffi4jTBcv2SNBTeMtXpclqyI7q
 jLveB3UmRjogPss31Ms5FCpk0bT+dkn6IrTTgvN180D8ei+5n5NtcAGZwkQpuRJ3AW33Nsos615
 jKjjzT6diPHyJwJT217+ipOdzQBOwdo5HkPAMEpS9wQ==
X-Received: by 2002:a05:620a:17a2:b0:945:f5c0:a63f with SMTP id
 af79cd13be357-9494b9c59c6mr222655685a.5.1794536014328; 
 Thu, 12 Nov 2026 18:13:34 -0800 (PST)
Received: from
 runnervmccnms.rbvbdlov45kutln3wjst01zbxa.bx.internal.cloudapp.net
 ([20.62.254.163]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c870f31sm75830585a.27.2026.11.12.18.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 18:13:33 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri, 13 Nov 2026 02:13:32 +0000
Message-ID: <20261113021332.4140-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112214931.442129-1-avinesh.kumar@suse.com>
References: <20261112214931.442129-1-avinesh.kumar@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: pthread_join/speculative/6-1: Fix race with
 detached thread exit
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

Hi Avinesh,

On Thu Nov 12 22:49:30 2026 +0100, Avinesh Kumar <avinesh.kumar@suse.com> wrote:
> openposix: pthread_join/speculative/6-1: Fix race with detached thread exit

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

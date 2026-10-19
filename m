Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00E606A31F
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I+/I6RkM
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86CE23EA64B
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 21:05:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 164FE3E1721
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:05:16 +0200 (CEST)
Received: from mail-dy2-x09.google.com (mail-dy2-x09.google.com
 [IPv6:2607:f8b0:4864:36::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61B821A0088E
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:05:16 +0200 (CEST)
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-35adc681e1aso5002591eec.0
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792436715; x=1793041515; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b7ODS4YSCXWyBtRX69RPIlg1Q7G4k8hfYjW99WljT4Q=;
 b=I+/I6RkMD3jfVYtuEhvxM7Curl6fpvYmScen4WAYlSLIAvyXlA02nD3vup/F7OHnXt
 gY66MIYlIr1DJLYHQhS72nVvLTtIVDdVgDqgQNJHVtMBDixNOQ/hU5Y/fR3/Kw08iS6y
 8SyhxqkgoGeY0wuz3o4NgYpXD1ENa5nx+0+zo8E8WlcdNyOq86y9m8t8j6O99MyFjSqq
 FQO/Mpjl/5UqJHB4+4CF2GiqCgJXpNvQT4lpuH8N4LXKf7h1GX2qhahKnt/v//3Claht
 gU1ha0WPZm9qR75gJVQ/wbKyS91zD4iEt27fX6x2dBTdlhsd0TXBaJQ28k3M8Maft6o+
 y0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792436715; x=1793041515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b7ODS4YSCXWyBtRX69RPIlg1Q7G4k8hfYjW99WljT4Q=;
 b=b47CUe8C+2wogCxarnwSevhrc8bZIxIe5bz8nthxNj0BoKv/lcIA2nz0SN2fJfK1GM
 tja2mSVhK/4utWWLQi5Ps9PrBuUmE7/Bt/AL8gJdIFX5fnv25m5jnflDVFAQONm7jG/v
 DTIbIWfzgrLrZbsR5YvBh0S9NNlN/pe7n7/Pkxxz5gz6JOhaew66Bf6ljoVyLUKM2RP1
 G4TDQSinY99u8K3xPE7+4O4rS3JHigixF1XZWAqSIDF1AHEy5P36bx+1pKmQc97DbKh6
 VSlOEm5Jgt4vziYLMYKRJWqBxr/+kFe9swuMiso/+okkIBExBssUt2dMJp76heGHlYAA
 Yy4A==
X-Gm-Message-State: AFq9FYLVeJM/mEDKcrUwJw5s3hkNKOR+43aVuxa0yUtPM3HGxCv5ZUri
 CNfJGXBWGOnpFfkC+SlKcNpyNH7DNMzBS2od47J4pexB1kTjN07bwMQx
X-Gm-Gg: AYBFou01WmGQslVIkrGghP2xSTFGkT7prrD4XzYBM0A7PnGV4WpyCszRoGulDD8JOsW
 zEiVH0r+28sxSDpacTO9lIHbgQJLVXZyquBPdFyO6g3Rgz7CgEdHAIfiFenhTVXF+7FVnXSqIao
 AIu1FjfuWVfuyIqtsdYruiVHl0wwcx7OpHv7q/8+4i90b4neWwGxbD+6promdsQQe80NABVr34J
 +YtisBKOfhbh4rmRkO5WE4xDWKaE/1ZBP3E81X4jlL+6JLRJhGMHO/UMciHNNqP2B3fjWp/HiBp
 Bzy8phIOTOYuwC50GWKZTm3RkkKwTbRf7OQZFlB6scgZEJH6RrqRWH+VSaMa+avm9ilsQfVU39I
 /+XlgmTOt/6VYIOgW3YR8tcfyZ5Fp9JeZJasY2cOThOmZjzzyQOlt1BSH05rsOVKnizjq2QqIHg
 kFseLg7EVpETZ+JU0bWYMhjZqZE1wrJoUDp9M5N1a9hm11OLqhsgudUa0Wc0xrk2YoFlLvRWa33
 VbKVPTO2Sh0fKahJaBh4D7R5VUqw+m1KCcYyacc7mTTWrfVgNnE8BYHyG4cEdPw+dBkVhgRJtce
 jP6yYOhVYNmK
X-Received: by 2002:a05:693c:638e:20b0:351:7416:5f28 with SMTP id
 5a478bee46e88-361a2b3823cmr12537496eec.27.1792436714460; 
 Mon, 19 Oct 2026 12:05:14 -0700 (PDT)
Received: from
 runnervm8k3b6.3r1mpnublirulcpvpppf41b0ed.phxx.internal.cloudapp.net
 ([20.169.69.129]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082b8573dsm34140433eec.25.2026.10.19.12.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:05:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Oct 2026 19:05:12 +0000
Message-ID: <20261019190513.3897-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <07c4ad10a95faf9318de23aa0fceafac1bc44bd6.1792413241.git.jstancek@redhat.com>
References: <07c4ad10a95faf9318de23aa0fceafac1bc44bd6.1792413241.git.jstancek@redhat.com>
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
Subject: Re: [LTP] float_exp_log: Fix ldexp exponents written by genldexp
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

On Mon, 19 Oct 2026, Jan Stancek wrote:
> float_exp_log: Fix ldexp exponents written by genldexp

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

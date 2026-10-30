Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2F606A323
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6w7WXCV
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 239DC3E55DE
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 14:41:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03C723E4C15
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 14:41:00 +0100 (CET)
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64CB5600873
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 14:41:00 +0100 (CET)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f4cc0bd537so57606eaf.1
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793367659; x=1793972459; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FznLxMnfoF3jMk6RfKZ1+N4W14iYTNeGb1aO90pczCo=;
 b=r6w7WXCVS90vsNBafoHTtZHGNq+LtmjXPNY26Qa7yMzcHw8mJ52gGCf9Z5vGfvqOyT
 EWk1fi/JNP4xAgV6CwM5mPAAzLtqXc5qCpDhneDW4rKghhOdeh7y5blygpHA+ny06Dkv
 /Nayqb1U6I3Bg/3pvgxeGPXzHMHUZEdniV+MSXhAxj+6MohxB5ToHFBfpLgWJ3IKXgxt
 Dpw7XmGkfVH2BhcvalmulW37hWZqvwpI1aLDN5XBVV4JogPuCyFw+su+JlKlOOfVmMgb
 yaHwP1P6ieAhMuRrjc8DGBKYLU9+lBAxb7Fw0kCXfayqSNNXXTRq9qnS28+h9hW9en5I
 BKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367659; x=1793972459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FznLxMnfoF3jMk6RfKZ1+N4W14iYTNeGb1aO90pczCo=;
 b=nwjMZ6Rz+WyBRdc+k/4wcqPTPSgjaalsbzUt78/DbQoalqBMyT+I6RluNng0tBTAaU
 9AO+hMD2COHG8fkvS5U6e3XB9TguU3WOL+GbR3+IDRygL6flVtsFVz4R2Hk7NN67hUSw
 7QM0tI3Ejhw+LIw0Wy4xwPjS2lYULFXkGwttTI79E//YPmmUDMBkGYhfsASiY6ycrnEK
 dKV/ihZL5jJS0PYh4+WonV5f1Mp4Sduhudv4zxC/U8foM3wj1WPHupotAqvWF3HMIJ9Q
 ZdYJWb0O6JyNoFcsElvyV7BbCM1/elsdA+bRUHCFuR+5xsdlMJpIdb53M6YHx4sOvSU8
 AwMQ==
X-Gm-Message-State: AFq9FYJGzGs63LmekPrfVrs6XYvqBFQH4KZjBK0yHZixuBNpzt0cVBFa
 kShoDQ1SkGIhhpwlndp8elZiThCczzFn0kV1wxTM/x8ZBI+GSL7mMtkp
X-Gm-Gg: AYBFou0rySXVp2k8xdiyh1iWUOc09GLiXh5uLBqzkDc/A+kWOwoIKJ9XjCvOwfzvR/N
 e3PESjejI/vvUrHXxQE/KP2mdSc7edO6dBRLO0KFyGkT1Vh/Ezwa05c6rPVpTXjFAoFu0yx/PmC
 9EcSwdlRN676FdK/XDui64WOaNTkKLbom11KYtHAhqLf4aGaWxWQKRLzBQiAb4Q3KAe7ekvS6Qu
 lOifjvDUOgPbEtZV6VYi0JjPcTNZYsjopDYP8f4y2vFhZIcSoO76HWnhGTmT4ZuhJzA4vaYKFjG
 89DzyJ1WPBnM2DugKjAQUqRdYb25qKjriQPfFtixx0kdZTQjLN/hyRQ3XP7k5TusMIrH2IkzNww
 Y6cyeC0FHhmp13WAxD4OQ9rCJs70FGLOLNAQAfVLfigxj7JVCKuL/MabDJLCgM9K6vGIcMYAZFq
 wibgxUMLVKONCtSmDaRy7hPIRHal3NK3hsRctx65sDpYHcQlb6bf4XEYB8QDef+jvfBaSEifrDo
 GLPrju251zGuUrjYqA4V/J5fxsvrGiYfpyth8gMQ3uhIFncDQflgzCFeWx1zDp80i1avF4Cyw3P
 5yhHigqQXigUGrFZUFs48k6v3yr4lT5gbpqisGVKXIsdWm8mZGgJjX7UYlgoNd/6RNmzzxYFw39
 37xPurYsuN5jbaHkEYJP24N6PKSNCLkUjt0d8D0g=
X-Received: by 2002:a05:6870:3341:b0:475:a112:126d with SMTP id
 586e51a60fabf-4a90767186fmr1369259fac.26.1793367658878; 
 Fri, 30 Oct 2026 06:40:58 -0700 (PDT)
Received: from
 runnervmnwato.d42dy02qlyzefb0mhnu3tfa5hb.gx.internal.cloudapp.net
 ([20.29.53.23]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90af55fd7sm1885397fac.14.2026.10.30.06.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:40:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wenyuan Li <2063309626@qq.com>
Date: Fri, 30 Oct 2026 13:40:56 +0000
Message-ID: <20261030134056.3925-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <tencent_B786C5458553D16AB70F62E3AAC3C5C9B306@qq.com>
References: <tencent_B786C5458553D16AB70F62E3AAC3C5C9B306@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/madvise: Check DONTNEED across an unmapped hole
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

Hi Wenyuan,

On Fri, Oct 30, 2026 at 08:41:55PM +0800, Wenyuan Li wrote:
> syscalls/madvise: Check DONTNEED across an unmapped hole

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

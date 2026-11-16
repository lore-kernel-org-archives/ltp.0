Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113B606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KxkMlX0P
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18B1D3EBB35
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 23:36:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27E003C0960
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 23:36:32 +0100 (CET)
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A49710008FE
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 23:36:32 +0100 (CET)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-53c4858eb76so1619434b6e.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794868591; x=1795473391; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFbA49TbBkrN27OKCHFmrnZ+t/C+Fun23O5IDkFbVUc=;
 b=KxkMlX0PVSvSzihbWqgtjYf8V8blWraykEUEfrXb8sOtDBbVfmjphUykaWGUllv0mB
 mSGxtMpSl8/sBmzcfYE5EZAKxhaAM6wATOYIK6/f0iJZHA3j7sxPdvi4kWaS/Z+oOITt
 5g/5o5SdKl1s+zWvbicaNjtfAckkZC1deVxB52D/ZiIvcPmGP6jbBE5kWKNRBabd6hAz
 JOkxE2QgkBr6QWNWMZ+0jWioLY69CqRKmBUYfMncy+l+oR2VDGAGAQAgjUIJBqK6BTfx
 Z0d72k0RIrwi1zfmy5osWk5X27Q8CS5jLe2plfstlnZTGoiUAEqh2p11kZSvoybQUIWu
 EEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868591; x=1795473391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFbA49TbBkrN27OKCHFmrnZ+t/C+Fun23O5IDkFbVUc=;
 b=Rm2cc4cjrQGp4yGOyxgnv3OvGzKuoLmiALhZUU25j4v9qPgSCrdDetY7KxY52bw/G0
 qXLKK8EIfXSwTYJQpPJoM7jI5V9LsaTSm5iAgBLr8885yFSSnOCvT79mLmLkRcW9aRnn
 EYzYjpXZPyywDTcLOl7PY6fsaribP5xDmbgd0fZ2t3afn9z7/QGYWWiDCth+BhxHD3OE
 PZFVmCz+domt8DK6vazXMR79XBgm+NamgH7yklId54QPWv8YyGEAWrVoXcoFkpWTQLRx
 XL+aLPYZfnPB48MjHtksfQIsejqzZ1+5sgYNobwQ2M8mei2309YhBg6Wx0amgzrpk9ys
 w+Ng==
X-Gm-Message-State: APuU4Z84Xc7sR87Zj8XxSSM2buX/yx19/g9jsb/Q1j1miJuYgLnHLhce
 Tw0wrgptRWCjksmKOZ0FN36eBuvNc4A8TKEkhZonF+v1ezK/xlOLwUMx
X-Gm-Gg: AYBFou0YWhWp5n4sA65LraJAvnkMpBO1n5VzpMemVewtX4Mt34T5OUy3RTZk7vJp3/g
 mB1+4VEeH/jCDxZDvTFuUBH5Tpa4TGio45Thi4piOkGX/13eJeuOpB/ZQUpDDLTSeNmz60Hz+an
 DREgJD+vq3uGdQI9V1GNoSv2ETgvtgF29P9RMPlylrHir69LWUszq5DhM95E8NTp7ghzH93Rdj7
 H254S0xqeoBgJUqdQNABE4oan3ida2TQyjIJbp8MJaU85ReGXwvJiKategvvGS8hQsHmVgMBCje
 L/eZxQ74ng8cRUFWPkrMRIyPrd72MlTXh6B2sklxpmBlNCLrtlQYs0mAqXNgOlDXLTecYgzQDLo
 6DYSPrtq2QZ2FJ0AU3OVvac71iZvYOZgInwRt51o8572uB4Z6Wu0rbzPcI+37V71s6AyEg0Hdmf
 PybAkIOoJIwSGV3kTtk1+e9D6zWGsnfuV0VqKn6CAdKETO6Ig1oyfdaBc6BUBGse+u+lYseHCCR
 RIoI/5mfGbQgdV9zchY4RqKj20VpCtQ4sWYU6mZip27Hjb8H75XXJT91WFaMxZH0nw+h3ugP8jw
 09izLSoNi6rtDvaBrnmweaZGDz3T+K9HduShiq2Qj26qO4cW9wwOfwU3mG4NTwmQeIHami2u16R
 S4zLmKeSEorIi12zfgvMwNk4NrXTegCtGzWllO+e4Q2mMeYRkBmu4xKHj9kL69lHU
X-Received: by 2002:a05:6809:113:20b0:571:58db:418f with SMTP id
 5614622812f47-57158db6d35mr5485877b6e.67.1794868591186; 
 Mon, 16 Nov 2026 14:36:31 -0800 (PST)
Received: from
 runnervmccnms.c1md41fx3vye5lb1u32o3jr1ac.gx.internal.cloudapp.net
 ([172.202.53.214]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70243e1bsm11152757b6e.7.2026.11.16.14.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:36:30 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 16 Nov 2026 22:36:29 +0000
Message-ID: <20261116223629.3836-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116142206.3151308-2-wakel@google.com>
References: <20261116142206.3151308-2-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] epoll_wait06,
 fcntl35: Don't assume a pipe buffer is getpagesize()
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

Hi Wake,

On Mon Nov 16 14:22:03 2026 +0000, Wake Liu <wakel@google.com> wrote:
> epoll_wait06, fcntl35: Don't assume a pipe buffer is getpagesize()

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

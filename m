Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94069FF8850
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 02:27:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9423CEB8F
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 04:27:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CC4D3CB935
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 04:27:12 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0219C600150
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 04:27:12 +0200 (CEST)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8d4f78fc9f6so1074875885a.3
 for <ltp@lists.linux.it>; Sun, 26 Apr 2026 19:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777256831; cv=none;
 d=google.com; s=arc-20240605;
 b=bT8RRF6JrmsK7ujTkOCRL8+e8rzbiH2ADL/GIsxLVXRaeMw8irhDfGmr2OkyG+LFVQ
 MZG+73Wm+oK5HFmcx42uoCAJav8b/Oe14xUgZLKGOj7Hgwaxt4m8gsbipzy3ztNtfXxP
 OIiJB+FYomGOxiJ0wIrM5PgdSNWkY36P5p1LHHyUKwy+1ATOms2RalsMLtNnEKCO4DGK
 5zFqtzngoC30/RvC0+ujAOVsOvwyt4cULG61PZt2Mrhw+8NEozoWv41UdEBUX9XiMAzp
 JnhiHBj/thWhQef3sRkBHn6Y5oj3xFzx+4sq54hq8qjeC/bSAJDjm18D7GdLBryS7Yr8
 Mssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MxMtqUVYKjTYMP3v1FzETkEY37dtjVfkGCMSzjhVynA=;
 fh=ZK5UWqme6OcmJjZLc+Lm5eXIPexJJTn41AGL5po6xJ8=;
 b=E7Y8z/pMlGSg8toa6r/3jceyjadw1bwDRxgPFNtl8+icBz2bMNNOTTuUpK4MHiuIJT
 wrQ5vTLLjk9HxIDH+JkY7bzbZ6pFI9v+EMTf8vY8+tALRETomFse1H8h4di7DvIBDZAg
 QbEZuRTQyaqvXrWH62z+F1x+dMklJogyx+WLSV8QBdsM5rBPy3RsyN79Eo7ghOyAS1Yi
 0CJ2xjRCSI52MG5BSq8W+MsA3OtEnI2hpaTRY7l3VB6RnFzHwnwacQWZ3YoSjyPlDCBZ
 O62uyK8bBhQVyXz4KAl5xJGfcvkPo56Ji5ApzcPArYNGjiHmCnKWhDI/Hl5ae5/OP7xR
 XTPQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777256830; x=1777861630; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxMtqUVYKjTYMP3v1FzETkEY37dtjVfkGCMSzjhVynA=;
 b=Zk/9EBrud8rNX8sf2X+0gdlA1fyVA72jfNNyLQJBwSagr/4TxIbrRdezh66144O9SJ
 5O2jd6rx9Nti9997jhAUkvFOxx9C646erzC8MjL1/FnlXHOFjXhRpQwrOkpT/jHiEFHh
 HfAzy5WuMOSRyUbQHPfCIsxyTzBaEHXuVtJDWhPCcSwb0AgVexK8YCHC+M3S5IPX00tG
 vtrKRlfP0KDBIYxWmxf/fkPfbbxNGgvL9+Odv5SGdV7+/mW5jph4P4c14d3RejoZqrJy
 E0zcRgTjnWe9vFR70Yt7oy0xlzS57TX4BnMBpbxe4dd96EibDjhgoPR5X//IfNo4rq0F
 c+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777256831; x=1777861631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxMtqUVYKjTYMP3v1FzETkEY37dtjVfkGCMSzjhVynA=;
 b=hdKLIc+IShBZAH92gIhGlUMN8no8J5sKECG8QXSqiWtw9cyzKG6mAX05HWV2qiVzcB
 YXK2Xf36MdVxLYn2Jo768fX6Qxdk1phNcK8B2eefbPiLVd3IDHl1BlntDoXk/vV6pa48
 Xq8HvcoXBZVWgBhf48voW6vtkIpuAaHh90Qww7jhpAIXaH66Bqsnt8/qQKGBgmlHPfjS
 T/jcybElGWrAzS1OFUiYZIbTe+gXBUnJU4b13ZwG7msqItCPX0VVd7NAh+Zkde6cDtvT
 OSIT6CgNUOTOoCfiHQ8Bt+OSF8y8/CbxmTQ+d5eW11tIhjCapVWM+7kHmnN65e/rsJIi
 mfbQ==
X-Gm-Message-State: AOJu0YwW0P8jgCnhNh/OvXbZenhQz10frbOTGWjxnD9Nel8dtAsO+QHv
 0fxhN5wbVP3zWxCdAk0biElSnqxN5oq81sQrGCTCyKwLNnIsZhAALECFnV7mUViqsOFvnOTnsTj
 Mg7xiYsvf9EmtXNAwVaruvijoJm+YsQ==
X-Gm-Gg: AeBDieufueCsWX3BshLMFDmFqoQ/gZ5fsKByyp/NpKY7rYaKRiA5jv/qwzFeQqqaQ5F
 I/5Pz6NmduVFQAuL6fRfU52nTJLp9qfx8zq/updqVvMTq5ascbgGI5lVAnZaYZ0ZIeVpJ7pFCVh
 3wON1iYyB7fbaESqO2Y/E5KCMvceqQIk8nllxqUkJYssrQ71N3N9mWKavt4PyTN1TJYjvn3/bY5
 qr73alvNIaQZFcyzYwi1xwL5PK83kH9j5917o7LtJ+rxQrrPomIYyhbQCt9n0MhECBuAVuKASa0
 4VdMzSuL2lMGIUz6gQ==
X-Received: by 2002:a05:622a:64d:b0:50f:ae24:ecdb with SMTP id
 d75a77b69052e-50fae24f0dcmr425631991cf.37.1777256830600; Sun, 26 Apr 2026
 19:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260423120309.18049-1-chrubis@suse.cz>
 <20260423120309.18049-5-chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-5-chrubis@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Mon, 27 Apr 2026 10:26:59 +0800
X-Gm-Features: AQROBzAbGMYpI26FsptuiYQtnvvm-pieKU3xmYIAWBiEy_ZW8dEPo8Zfyz0igLQ
Message-ID: <CANgNiRyye2YofYLN8-Mic9foPxqTKY+Ws5AfWhiS1xdVakW7SQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] syscalls: Add epoll_ctl06
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

Cyril Hrubis <chrubis@suse.cz> wrote:

> +static int exp_errno(enum tst_fd_type type)
> +{
> +       switch (type) {
> +       case TST_FD_FILE:
> +       case TST_FD_DIR:
> +       case TST_FD_DEV_ZERO:
> +       case TST_FD_PROC_MAPS:
> +       case TST_FD_MEMFD:
> +       case TST_FD_MEMFD_SECRET:
> +               return EPERM;
> +       case TST_FD_PATH:
> +       case TST_FD_OPEN_TREE:

> +       case TST_FD_FSOPEN:
> +       case TST_FD_FSPICK:
> +               return EBADF;

Looks like these two fs epoll verifying return EPERM:

epoll_ctl06.c:55: TFAIL: epoll_ctl() on fsopen expected EBADF: EPERM (1)
epoll_ctl06.c:55: TFAIL: epoll_ctl() on fspick expected EBADF: EPERM (1)


--
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

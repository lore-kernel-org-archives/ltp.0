Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7786C352A1
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 16:23:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72ACA3CC149
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 17:23:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E372D3CC0C1
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 17:22:49 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DA70560085F
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 17:22:48 +0100 (CET)
Received: by mail-io1-xd2e.google.com with SMTP id h6so6306719iof.9
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bn9I9xV79fJUCgoxsa3ub+uGmmlj3Tv0J26ZcN9So2c=;
 b=oktSzxAShr3BHoD72bP4RFPVPK2PQ9754FcMwUZLSN4JtDJnGYSSmZWOGHv94kk8p2
 hRwss1tlAVG7p8Av2GnMo81SayC6jYcGxuvgfQjOmrGY3anuIuUmHTnrOwK4bjFlrHLH
 8X2zXyi3q6BymHi1hN9CxD5+hoxVUb4cv+kVB+LerzeBetWY4WfSZ5+f327qAreMbIrn
 68t4pMOeqqBpF9HLmnL9+4GnvtxCjB6tGckAQYSJQEdBSt77fS7PfaRqOq6S74eXp1OI
 HyGz4pZzTJh8yNYLubKPUaRkK+fiekioy/q9ElL9E6hHGOMvjaC1n0ZrZ+A9RVFAaNNK
 rmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bn9I9xV79fJUCgoxsa3ub+uGmmlj3Tv0J26ZcN9So2c=;
 b=cSlTEvx3eqNc+e96DsoYaogy6gSN5iXryyW6wKbXx9+ZhR7eGmEL3x5yKoDpNpD/NT
 uR5VhFZ2itziaSUN9bZyUkRozOUnmkeSFSRC5FpUYUsnkb+OGq1S6edlMz2VMoY8sZBn
 Tx3DhrhIMzF5JHH6k7RLoaAgTJ4iU1tlPipTxrfjj/Sav+mJqqKh50oVZl1Ofj1VHolX
 X4Uecs8sR/2b8WwrEaDiNnhK/uJ19HasuUJMTTiuvZ0QHQO89WGvPH3NPouvsqyJdWMd
 Wjohne6VL4Tka2msDudzqYbpI7ajIkY+3TKhzYnK8Hw3GxR2J4QyPrz6crFk00QXY3JU
 FxxA==
X-Gm-Message-State: ANoB5plEL5sXz27ExCc22sbGpDEliwB66EEnEod/sHh6alkupBDopkQk
 Ty8jiFdCW0Fy4C7R4vaV70OMew==
X-Google-Smtp-Source: AA0mqf4ybGl8vC1UVIEO3y/JfQbgJP/6fnnH7vd2PgBXxTLGzha4ra0sC3Q2OFIDuj9XNhFK1cMt4Q==
X-Received: by 2002:a02:334d:0:b0:376:22fe:5e7c with SMTP id
 k13-20020a02334d000000b0037622fe5e7cmr43131407jak.126.1670430167275; 
 Wed, 07 Dec 2022 08:22:47 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a056e0206cc00b00302f958e71dsm7202366ils.49.2022.12.07.08.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Dec 2022 08:22:46 -0800 (PST)
Message-ID: <b7d8193c-7e15-f5cd-08d4-8ef788d9bb36@kernel.dk>
Date: Wed, 7 Dec 2022 09:22:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
References: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: LTP: syscalls: epoll_clt() if fd is an invalid fd
 expected EBADF: EINVAL (22)
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
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 12/7/22 8:58?AM, Naresh Kamboju wrote:
> LTP syscalls epoll_ctl02 is failing on Linux next master.
> The reported problem is always reproducible and starts from next-20221205.
> 
> GOOD tag: next-20221202
> BAD tag: next-20221205
> 
> tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if epfd is an invalid fd : EBADF (9)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd does not support epoll : EPERM (1)
> epoll_ctl02.c:87: TFAIL: epoll_clt(...) if fd is an invalid fd
> expected EBADF: EINVAL (22)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if op is not supported : EINVAL (22)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is the same as epfd : EINVAL (22)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if events is NULL : EFAULT (14)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
> EPOLL_CTL_DEL : ENOENT (2)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
> EPOLL_CTL_MOD : ENOENT (2)
> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is already registered
> with EPOLL_CTL_ADD : EEXIST (17)

This should fix it:


diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ec7ffce8265a..de9c551e1993 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2195,6 +2195,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	}
 
 	/* Get the "struct file *" for the target file */
+	error = -EBADF;
 	tf = fdget(fd);
 	if (!tf.file)
 		goto error_fput;

-- 
Jens Axboe

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

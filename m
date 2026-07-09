Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2833CC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783615410; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=PGeosO5hPGGBOrPkQAOwnNJ1dQzhy0PaqhNFT/dmZ80=;
 b=Q5PZPhqSQbujJFp7O/SBSGKCT/0Oz4wP7PwfbEY38B/Pd4J9IGZsRDiHQ23Y8jjnI67+n
 ZL45B57szMBBTvJG/+iY/s/RVvAKks4Oh+UZWsyvghL+avLOHsn8xoE4vv1qgSGCFivk7SU
 J3OzzQXrS6eWoqf/3CAZuuWwiWIza68=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A18363D8739
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EAB83C7525
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:43:10 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C9E1010009F5
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:43:09 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so47725f8f.2
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783615389; x=1784220189; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JxBz9Kig3aOMUUiP8rZvnqDbTxjE36SYFKSy1A8kYfo=;
 b=gLA/zs5B62xFOvibw+oo5+NQOtc/f+VSdkzh+vSkn6R2GuajfVEOLCPwWIDJHTLrBy
 /9+X1shoXFeRs/7oRZxeD9eCPPysaEMxIQzkecW/nHYGUeP3Ix5rOAfyKySr9X0g2tCU
 NSdFZlcSql07XS8T7vCr5EikNJUNkqPflzykPJmusuVus7qfW+RLHY7+eSkSgytt93Vz
 t9zukgvtcqjGLsE6KWhSF2romdb9hHtaKLmloXTilJ+2foYM6gaaB1RpjAH1e+ri11wt
 DjQehT9jxyS1Ss4c3bleAuagwbDhjgL1cnY0rzQ1WJZEnqki4Qg88phK3rKDm9CcN7WR
 8iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615389; x=1784220189;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JxBz9Kig3aOMUUiP8rZvnqDbTxjE36SYFKSy1A8kYfo=;
 b=JbwhTHNTfNq7oHzgNL5attsRKefAcgRrj1A4n/Fc+9HzG7sIglfhPIVT0y8rrmlPPB
 lSPSui4SWJzIOFAV/tn4KVe7+y3DTaSGEnBtlY2ikc4RMVvZl+cSBLxLjFB28CoTKPxg
 ivbP521KAw+rSNaF7uwr+Pzy8zUfmUYo7aS9B/tQirlFNsCI2zIhWXNH1syCjJCgT0Sg
 uQQ7CmnrB9rc9MvBkgQhSomjywhoFfD2sMhzFKJMqDNFheH5Nx1bkdqZu5Sgc0cRG5Qm
 X3l41cFcJDZZYm4Bh2tIsHKvHHVYLYYDugjzw3iGaQk1cUc4mQxpRppQfPzlx/TTJGIR
 XM5Q==
X-Gm-Message-State: AOJu0YzZrO3fe9px8SEtK6OeeiLlnWDBzNa9MF21uiyc9jSoboiUnUh4
 W6n7tL8mo4cx8/KZCBunZKsCltZ8/DguFqaJMCAk4I2aj+D7B6Z0bQ+9JFlTeHNU6aVX/3qe3uC
 5Vyv98qE=
X-Gm-Gg: AfdE7clQAdC80ig7F/YTWB+0CTu06QesowquXlGTe83yuP4l2/ppHK3XB7dGGXkkjUR
 EK69JOFEyrcefVmc9QPQ+lwLPbSTHkP13GbeIK+WSOs2uGWtO0i8kVU/e7MXwzViEjYdzdXKGLV
 063S9oeznCpcF+kIiZGa/13gBsJBkhVAEXSzjkutfrJevBf23p9nvle5TYun+QIkzPKsvbEvTNz
 Bu23X9ZEiwP+eAofKMeyj7HIJtv+P6Xrw4YBTsDjjxjWPtvjNd07AC5wYyH0iI7wB9NaXJDPip6
 RbaxzvHeJwJsR0O0CkdxFPtvEQjZ/Y267SYOtLXJwuxAFr8hCR+kyS7ePkMUBlNE0bpK+NTBdiW
 zF09iCfRNtV75AyOI1Mr2t5k0OOEV5AYi+ourR/1ug30WmkI/wdWpEUOQnME3xZ6PnLJujZvs98
 tM2W+1c4/IO7oU9vmySg5SjGkrE/GY7eAd
X-Received: by 2002:a05:6000:290f:b0:47d:ef38:260 with SMTP id
 ffacd0b85a97d-47df0760675mr8692775f8f.27.1783615388990; 
 Thu, 09 Jul 2026 09:43:08 -0700 (PDT)
Received: from localhost.localdomain ([37.162.206.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm51929701f8f.28.2026.07.09.09.43.08
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:43:08 -0700 (PDT)
Message-ID: <6a4fcf9c.795e137c.249a98.9ebd@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260706234000.23719-1-wegao@suse.com>
Date: Thu, 09 Jul 2026 16:43:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9] connect03: New test case for EPROTOTYPE and
 EACCES errors
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

we can remove privileged user needs for this test.

> +static int sys_connect(int sockfd, const struct sockaddr *addr,
> +		       socklen_t addrlen)
> +{
> +	return tst_syscall(__NR_connect, sockfd, addr, addrlen);
> +}

we should probably use connect() here instead of raw syscall.

> +
> +static void setup(void)
> +{
> +	sock_un.sun_family = AF_UNIX;
> +	strncpy(sock_un.sun_path, SOCK_FILE, sizeof(sock_un.sun_path));
> +
> +	fd_unix_server = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> +	SAFE_BIND(fd_unix_server, (struct sockaddr *)&sock_un, sizeof(sock_un));
> +	SAFE_CHMOD(SOCK_FILE, 0700);
> +	SAFE_LISTEN(fd_unix_server, 5);
> +
> +	fd_unix_dgram = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
> +	fd_unix_stream = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> +
> +	pw = SAFE_GETPWNAM("nobody");

we only need this to trigger EACCES, so probably chmod(0500) is enough.
Read below.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_unix_dgram != -1)
> +		SAFE_CLOSE(fd_unix_dgram);
> +	if (fd_unix_stream != -1)
> +		SAFE_CLOSE(fd_unix_stream);
> +	if (fd_unix_server != -1)
> +		SAFE_CLOSE(fd_unix_server);
> +}
> +
> +static void verify_connect(unsigned int i)
> +{
> +	struct test_case_t *tc = &tcases[i];
> +
> +	if (tc->exp_errno == EACCES) {
> +		if (!SAFE_FORK()) {
> +			SAFE_SETUID(pw->pw_uid);
> +			TST_EXP_FAIL(sys_connect(*tc->fd, (const struct sockaddr *)tc->addr, tc->salen),
> +				     tc->exp_errno, "%s", tc->desc);
> +			exit(0);
> +		}
> +		tst_reap_children();
> +	} else {
> +		TST_EXP_FAIL(sys_connect(*tc->fd, (const struct sockaddr *)tc->addr, tc->salen),
> +			     tc->exp_errno, "%s", tc->desc);
> +	}

This can easily become:

	SAFE_CHMOD(SOCK_FILE, tc->mode);

	TST_EXP_FAIL(connect(*tc->fd, (struct sockaddr *)&sock_un, sizeof(sock_un)),
		     tc->exp_errno, "%s", tc->desc);

To make it works, we need a mode attribute in the tcase struct:

- 0700 for EPROTOTYPE
- 0500 for EACCES

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_connect,
> +	.forks_child = 1,

this is not needed anymore.

> +	.needs_root = 1,

And root can go away.

> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.54.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

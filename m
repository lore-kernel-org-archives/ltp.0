Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97CCC021A6
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740394223; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1diQmMNNi165j0n1vRw/46Tnh5eYMDqInZNJuM3yxZg=;
 b=h4xpiOOfScbFZSTH2Q9VURX9mxgWbZHvr6cY8464nfzU69vfs7zqBOVHvvB8FkOtasAj9
 dBtuZj6g4aDqKPpYD6253cbRL2PMIpEX9EvZYCkFduwqGF7b12EsSUlkmX3gYEnM8fiU6tn
 AGnVGmYeWOyri9UN5dffAZ8aLkDK58w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50F113C9879
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 11:50:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CB6F3C090A
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:49:59 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 254AC1BD8F6E
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:49:58 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abb8045c3f3so522417366b.2
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 02:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740394197; x=1740998997; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qyvP7E/erXRfkJQkTyhgz14TWqjZaN90YOB9/cRw1g=;
 b=WUlyIpdUvVubo128t1yRL5GGr0xwS+eRCZIigYVOgpjWkH7+Qr1azFgLoEyQED4kWE
 0ljNXEEEWmQvsmWtWwV8cjZjlfnp8CW7ey43oVTKoT5s0AADNJ5Qag6VzJNyQSXd8AJE
 w4JVbz/nuWveTTHrRCLe0Vq4E830jQFoLxUD6gwIl8x99LVfgoVKgLs1MAIoUTLjQ1FS
 4cIMaUai38+bzGR+ZgAa01dj3y2J2fxnmoGA1E+6cbqLKUMffNXvGrZxWOjfLZAOkb2A
 L6fWKl6O78cxkjOhU3RcpiBSI2UFTCmI8sneVGJbj4oLiEbHDDJhXW3wrt5MvIP9d5Cf
 DOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740394197; x=1740998997;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7qyvP7E/erXRfkJQkTyhgz14TWqjZaN90YOB9/cRw1g=;
 b=kfJUTvqkGE26ojhFRHHPBBJ92p5IY9K+DGOBovBYfg//v7vid08XYV3I3zBzJHfJzG
 CE5qMi96JEBdISmXs4UTjYRd4NcSztX6WPZy0Zf5QlyFhmdaW8dnQIOpLUUMB//WxG9e
 B837uAxzC0rIAeTvTabonfduioZjinQRTIN1UYu25uly2r/xP/dfegs4+P6OCbiy+sYT
 NIdfP6XmBsSThU2VA7Rc56NZedJtDoscEuzbRqFJyZrNLemt8jTq7suqwE9YWjykfr0m
 wDznrlxDIHI7X9w8qNPFNtEloWXbkJ0dYRSV0eCj0ZOqRo3ESuYRcVvI3S7jRuubONUv
 cALQ==
X-Gm-Message-State: AOJu0YzSLoosBzpSiSW/USLdv0fH6Qgg66nwNt44fT3CX1uNTF8lSu1b
 AW2zfVUHbPS1UQ4zUAk5AKEpjNLiIUgXoVGohHQbUWlpmocrYwecZSkIJzZoFyRrd1wyoWu3Ln5
 C
X-Gm-Gg: ASbGncurdl+zY7fZSo4e0USZi69Qo+aFZuGLA85QdS6BmxBDGUZOBHF4ODE5UJQt/mO
 +u2xegDp0YvSzLWAIi+2BKVxd7QX4kELr4G9dmVfv1PMydAe21q/dslMHCrZSp4mjxxllSAJxQv
 zQnNmxR+Zw9NoZVioL26ijLqVSN2HCmyjbZdI/Ot4u5u7vvkWx+UTOtkPqqLTS23e9jIxa9slZt
 9v3HpnmJWus4UAdc5C43UKu74d6CP6/lNumGtftMr0OJ8vWCiyOV3lmUSV0uWPLJd30i8CR2xF2
 D5IEF4jxHgVh1cg=
X-Google-Smtp-Source: AGHT+IHCl3/3w8rgqT4dkw5g5NjV7KYSsESKWURTAR7G4pRqNZ2Ucs7qMIRnNPlGY1pGG0rU68qRqg==
X-Received: by 2002:a17:907:3f1d:b0:ab7:f0fa:1340 with SMTP id
 a640c23a62f3a-abc09c28b79mr1228907366b.50.1740394197525; 
 Mon, 24 Feb 2025 02:49:57 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-220d545d453sm174173525ad.115.2025.02.24.02.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 02:49:57 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 24 Feb 2025 07:49:54 -0300
Message-Id: <D80M935MYRBS.29I55Z1ZG6OWT@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.20.1
References: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
 <20250218-conversions-pause-v2-2-8c72960fe1ec@suse.com>
 <Z7hX6iJN6hDSUgUZ@yuki.lan>
In-Reply-To: <Z7hX6iJN6hDSUgUZ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] syscalls/pause02: Refactor into new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Cyril,

On Fri Feb 21, 2025 at 7:39 AM -03, Cyril Hrubis wrote:
> Hi!
> This is the same as pause01.c there is no point in having two tests that
> do the same.
>
> So rather than rewriting this test we should add a check to the
> pause01.c that the process resumed after the signal. Which should be as
> easy as:
>
> diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
> index adce0ddcf..74a7e514e 100644
> --- a/testcases/kernel/syscalls/pause/pause01.c
> +++ b/testcases/kernel/syscalls/pause/pause01.c
> @@ -20,6 +20,8 @@ static void do_child(void)
>         SAFE_SIGNAL(SIGINT, sig_handler);
>         TST_EXP_FAIL(pause(), EINTR);
>         TST_CHECKPOINT_WAKE(0);
> +
> +       tst_res(TPASS, "Process resumed from pause()");
>  }
>
>
> And it would also make sense to add more coverage to pause01 in a
> subsequent patch. Currently it tests only a single signal, we should
> iterate over all signals instead (minus the SIGKILL that is covered by
> pause03).

Thanks for the review and explanations! I'll address your points in the
next revision.

-    Ricardo.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D65910BA455
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774602474; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=xCgIiqnstHPItCpeAaUkLnBlNWjm9+rP/HZypgy6MEQ=;
 b=QPPXw4xCyckWfnSUIjo5TRHy+2c+/8ZSbc4vfS2hTX0PkVw7A2ftW99IYZUBIQX1u95JQ
 Qk6J/EkT7N45CLS89JdBZMZJ6+lQkhF4J58LuB7nKiNew2RhM5SR+S6nR6t9RKcsSniPBaL
 RS6ajwN9sdQ6Ybiyvv4pXer/LzMZZbg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC5B53CBE25
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 10:07:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 589853C2AF4
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 10:07:31 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C7771A01099
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 10:07:30 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4870206f73bso10736925e9.3
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774602450; x=1775207250; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hJrw9+kswKxAnV2xyDuNWf8Dohjva/DyiNBJSBm0CWU=;
 b=MnChQB7rAfqtjRv9VEgOF3ZIQVZio2os3p6Y978Pw1r78LcBAOKL43kT9PhHWnw2RM
 w9LDxPTMkWp4UcSKayfPaIxT6in095hc5LK7Qr6C6LWJCTjkGg7HtBH5GFdEiXNqjjTI
 T0gRM/7XqY+n8yYlyqn6sjBxFZcJG3LiYy3URidJB02Esm+inBc+AtITa9PpXr3tfGKi
 sGr2xcCltSIezPkXgPu1coCBTGoCFPS2NDtmsEclm2O/nel91/VKvh++Xz/9Vr514O/y
 FSb+NRD6BZsnjtEkya71l5OCXLC2tsjgaN1o+iVciJ0Z8zVZaE4k0vm9wQlBZL2+XBAw
 eecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774602450; x=1775207250;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJrw9+kswKxAnV2xyDuNWf8Dohjva/DyiNBJSBm0CWU=;
 b=ehSWJz+8rKTv+SBHCYy+nWV1qlwfuAdt7BR+k/ir9yyLHMHXEPG3kpaGo9dLMg3vue
 bBB+lE1fp6f0iBe1hORfVh6TKD7o76wXss78xkxlFj14pAByWl6kp4/zsM/v1pxHxxWo
 epl+3NZZlqtMZmLpUx+2Xbs8y5RT5na+hdBsoqVRVlmcX4TCJ9am41Obuz5zydPNY9M6
 OALXwclzYYnFz5vghk3EoOTjFofJou/wBLjcD3MH/bihBd/tr0y/buJZsJdvqvSFiyfc
 IY0Iuc2A3PfVuBqKmeIeDefBRM2z1PWyGMnubtGDzgZSW64OVp4uiaVrfghKoUxY7b04
 z6ow==
X-Gm-Message-State: AOJu0Ywwc8ML+di0qULzzzOJhRbNzfaclKadicElOEih+Dzc94mTL5Kh
 KSCOkp3S/iopEtVPiQbBPaxqiWhcCF8XW9IrCcHBV6LuU6nDF/g40GS3OotFxEtTuZQ=
X-Gm-Gg: ATEYQzxbO57VdUIz01fqixA+gWMzV7BREMHjFNTIy4jjlaVkcU5+0xdantw4eRCtuGo
 IDsaWsduhq1bA2Wbd/KmTISCXQAiUXXCEwCcQ0BPekGN0D4cCwHzsNeZW4Cq2qGTYDU6iPr7iSk
 mdQjpTA7SlA5Ujm8jB7WbubmZx/KBn0JUrODyLNyGYNikQGhTZi4dp7hyIjeu8VSIODot//SGnp
 rsH9Qtz+33R/KLxUk0uW1fipVjJ8dNqQDYCdRVhqT3pgvCvCsUXxYzMkT2zAKBXf0ue00xUqGbf
 yuRjNep9KOdUDKmVVzh5CXRm1Jp9Q6iVfkHtRUIdnHUKTeBOG/eTtsbtRMcirLT6RXXuFoRvK0H
 CmROqloauRjdk281vof2O99zyu7Ka+odQ5Jrq27yWXytZw+4eO3hKYU3fzWqRboMcOx6jn3hmQ/
 AjKBMPT6mp5iOSUjKnutMdV+yEltNEI6YvU8iTgaquUd5woSXPWUUqtR7Idfnhp/JGAdeslg2S7
 CFE4I3iDMLYhbeaCawfrisb+ojOA5LGLtPF+u+8m6k034ALvAGhs+waxWIIP0d9cLfphA9e7JoK
 qQ==
X-Received: by 2002:a05:600c:6814:b0:486:f8d6:5dea with SMTP id
 5b1f17b1804b1-48727f7bd78mr27075145e9.19.1774602449248; 
 Fri, 27 Mar 2026 02:07:29 -0700 (PDT)
Received: from p200300ef2f4fc90094f4c5ce75c4603f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722fa8dc6sm143304265e9.1.2026.03.27.02.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 02:07:28 -0700 (PDT)
Message-ID: <69c648d0.050a0220.2ca52b.c494@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260327045536.7852-1-wegao@suse.com>
Date: Fri, 27 Mar 2026 09:07:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Since the introduction of the asynchronous fserror reporting framework
> (kernel commit 81d2e13a57c9), fanotify22 has encountered sporadic failures
> due to the non-deterministic nature of event delivery and merging:
> 
> 1) tcase3 failure: A race condition occurs when the test reads the
>    notification fd between two events. uses a poll() and read() loop to wait
>    until the expected.

This sentence is truncated at expected. Maybe the meaning was "Use a poll()
and read() loop to wait until the expected event".

> +
> +	while (accumulated_count < tcase->error_count) {
> +		if (poll(&pfd, 1, 5000) <= 0) {
> +			tst_res(TFAIL, "%s: Timeout waiting for events", tcase->name);
> +			goto out;
> +		}
> +
> +		if (read_len >= BUF_SIZE)
> +			tst_brk(TBROK, "Event buffer full");
> +
> +		char *current_pos = event_buf + read_len;
> +		ssize_t ret = read(fd_notify, current_pos, BUF_SIZE - read_len);
> +
> +		if (ret < 0) {
> +			tst_brk(TBROK | TERRNO, "%s: read failed", tcase->name);
> +		}

This is a bit weird. We have SAFE_READ() which is handling already the
read() syscalls errors, so we should use it. The reason why we are manually
handling the error is to show the tcase->name I guess. In this case, we
don't really need this: we usually have

    tst_res(TINFO, "Test case: %s", tcase->name);

at the beginning of the do_test() function, so everything that comes later
will be related to it. At that point, also poll() TFAIL message should be
updated accordingly.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

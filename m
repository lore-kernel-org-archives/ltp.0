Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F4BCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:27:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCE8F3E5F59
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:27:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF37A3E2497
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:26:48 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6CF9A200905
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:26:48 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2ee1054627bso1415726eec.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778142407; x=1778747207; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zyNhHcNTpbynldF+7SHKXWnRQUeve0ZZ4ZWYyfLxXE=;
 b=faobUqmUZ97MnhFT9dZFihGC1kVGZjbRpFd5qNeNtuBDdsUeu7yFXreyM9/o0jZhPZ
 OtbWLfTDkXemIWi+lGJddDYLAmtByuU8WsdLiZhGo5YDfRTXc9rusrTuxLVGWSwsTVM4
 4vSwg9QDAsKIjS+joS5gZmRjQ6hQYpXtTNxRvlQ/Z/WU+RIqMBhz7LoLDX8OB1i6HNK/
 BNS4nonWuqiaaovHWgf59j12mPyinHbqbIFlOY4vr/HvYZYboVa5jy0wxUvPkOsKT0Fs
 Pa6fIPGVpb9tpapVvr61zH1tNpJU3pMo7E5UQfTO+HVoiUm3uc3k11001Ad0ETBLS/8x
 KZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142407; x=1778747207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/zyNhHcNTpbynldF+7SHKXWnRQUeve0ZZ4ZWYyfLxXE=;
 b=QfIKxgcvXM2cTDdlmCKWCqvGPeHMFKPw/HaB1HO2UiKNLVnGbhyOLcuHqzWwJPLY18
 haUOL0cIjSp4C9SYNg1TfNSNadmRrQI1fGk7YUYkhzQtPEeQB8zmEcC0LhAuS+R2Paki
 73SO4JZhVs35SAnpKp58qp+B7H0jUMPNEtgqksKlezXH00N/jUFSH/HuANoQ6mJT6G7q
 vfdMellwYlHcchHv7OMIplhohhJy+otBIJT6K3gA5RphFTiZ6r+bMlOUGf8PIxrV26gt
 nxJKUGL+gJcjNO35T1SHgF15g4ZX9DmpN6juT/0ZocEsgnX9QV2OMbt56misxhHY8PeD
 8xDg==
X-Gm-Message-State: AOJu0Yxxaop2wdLodajXoGhFdMOg3QzUTVk4jHm6r2rHG+3cEEfhZouc
 0OijEUGkgxkCK0L5S0y8HK0MFBnoIpUAqvoP4ZunVjuntU27f0CuX93fwJ/1i2IlwJ4=
X-Gm-Gg: AeBDiesi+gy2kfYaoRPtfjxh9eNIkLhd5H3XPBIJxrP5NHhSoWikIx56uSAe/H1LAf7
 nc8lM2aI7XBKGTj/avRian52NeW/l6TR7kwqWvSZpCKiAyHIsdoXtyrG3sfeE8/cxGPK3D3vmvf
 xjIazEiXjo5h5h4OioCeWx/Ub4ammiKxzpay/nRteirp/bgvd7KeyOp+ZJQRLIrCwsYgxv9/rtJ
 OfMv+ulFf7Od/NzznTIPWZQUb5ePqa5BZ0ej62qIjk37ZVuTFs//xICE7M1BANHtzoEUyP/SUqz
 nX24YBrDLQSd5cxGhx+Z1Mq4+8M13dO+ewPWdBTuB6NgFv4gVXnPbmynpFbUO2YIx+olQmXekbz
 1hpiVHf0M8Z2ZivcLEHynTo1vV0irD5Hx+Jaw1jYSvmraCKM6VOhV+Fs8tEo6itg1QwFhDwwhDU
 lT0MllXUee6965GJsxqiG4RlbQuX2crv2GYwAWh2A8TUDTxNDs/9unl8UCrgjmeyL4QjsfWTsth
 +evUC3uItH7g5SKXuZWX38vRjE+Y5oWDjFJxh6BK6hNB6lwl7aIsX5Dttkajg==
X-Received: by 2002:a05:7300:b58b:b0:2f0:ee2:f6c6 with SMTP id
 5a478bee46e88-2f6e4a6d89amr654361eec.19.1778142406530; 
 Thu, 07 May 2026 01:26:46 -0700 (PDT)
Received: from
 runnervmeorf1.c4h5hvxtyf2evdunsv3xosusuf.phxx.internal.cloudapp.net
 ([20.169.50.34]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56cec763fsm7152610eec.4.2026.05.07.01.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 01:26:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  7 May 2026 08:26:45 +0000
Message-ID: <20260507082645.3925-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507075006.8690-2-chrubis@suse.cz>
References: <20260507075006.8690-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: safe_file_ops: Add SAFE_FILE_READ_STR()
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

Hi Cyril,

--- [PATCH 1/2] ---

On Thu, 7 May 2026, Cyril Hrubis wrote:
> lib: safe_file_ops: Add SAFE_FILE_READ_STR()

> +	if (!fgets(buf, buf_size, f))
> +		buf[0] = 0;
> +
> +	size_t len = strlen(buf);

Move `size_t len` to the top of the function alongside `FILE *f`; mixed
declarations after executable statements violate kernel coding style.

--- [PATCH 2/2] ---

On Thu, 7 May 2026, Cyril Hrubis wrote:
> syscalls: newuname01: Fix fail on empty domainname

> Fixes: https://github.com/linux-test-project/ltp/issues/1304

`Fixes:` must reference a git commit hash in the form
`Fixes: <hash> ("<subject>")`. Use `Closes:` to reference GitHub issues.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F6FC9830E
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:24:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E50F3E6575
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 15:24:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D61813E5DDE
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 15:24:11 +0200 (CEST)
Received: from mail-qk2-x06.google.com (mail-qk2-x06.google.com
 [IPv6:2607:f8b0:4864:34::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26A77600967
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 15:24:11 +0200 (CEST)
Received: by mail-qk2-x06.google.com with SMTP id
 af79cd13be357-938feece332so108984785a.1
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790256250; x=1790861050; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o2yWTcsr5hQnqSwE9q00P44dOvZr9cyG06Q8doHTHns=;
 b=X+8szwyDz3uBUBkAdQPI9XqAP/j84MbERd01ndqA2JTOLPA51B1oGZpbyL5+j+7HPW
 pxEbjTPbergWv03xdASz0Qlb0+1/2PfJ5wInK+sUnQvXgh/hCJqBqLYX9sI+Axn1e3WX
 r4ANVmJiEwAsAJD3kCWFkBqk0kxj1xkDNBD+rCthUtZzrTR6YawzpUDSN5hyt8Q7JSYP
 taTTS5opzdvXVARymBT7sWFthnY0E+fl8sw0G0pAoTfTk+Nl4btDUaAoOdtFYYXvcbtT
 A52hI0uZoiKqYM+qQIdnCwb6KVASdXFUbpLOoWqbW5MQfcluTMYgXz22hgQh8tVV+/RZ
 tz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256250; x=1790861050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o2yWTcsr5hQnqSwE9q00P44dOvZr9cyG06Q8doHTHns=;
 b=kF5qaJsPj5//LSmzF4iK+HzJ7qbj1y6M55KOfo6zvzhLsRaloltOCiHp09eZFhjOdl
 Q/EqyDppM/lJy8pM8bfqmIXs+5tpx1djACg3J3qFH+22/R5vNBT1MD1tfhBwmDah6S3W
 T0ZWDsxwiCPRdKQ1LbQRqu9gMF4v5SzsY5ZsrmZiMgVUIRxq8bqgWABoVSw1nvGis8u1
 bx8KUPW++mF3cEBEwJJVv6C1veRHdnuWF6jbh//GoO/afy4B7sLcHTNgkIsvnDdnrSGn
 VztGlNn5TWP3YZfZig++32yo75Nikl964SwrVkW9WojdNeMZ8YjUbVBYxRJlgS5PyFmN
 PmcA==
X-Gm-Message-State: AFuF++m+k6T7lWXu3YofDFRjvcBuZXrNrRamH9aYESy3mY07NTSi1ifc
 AOOiCqSC0j+8SEF/ZaNxyjUoe/w1C5q/gc1rds9WgxufJlXLgvFiRHdy6ElIKRzV
X-Gm-Gg: AYBFou1P4yY/jDpKmvxztbX+GCsLda3KHRT29RB/FU6L5PwtKxuqB8K9oMvMgwvIyH+
 g9FCvhdVNO4lrEvSuXXbtZJjIEZqnPRjIbiSGBCd3f5N43mkRrQhpzNVmwZ3+dPLtkE7IIjqu9y
 FSLqgb6jdI0kaGYEUvbAgp2R36gfwDc5nqXeZEiYcfUSzsEFkhx4y38ZRkQZInrfuyPXKAvt/qZ
 eaM1xU9q9x4S7D3MN9F/4wxx36XR/nnq2in3ww8HLi7sMewifXmkCY3t/Z2IZnC6gCI+Ia/TUMh
 gUPPcyrfpxSbEbRG3L9HeyitK5lRaNuaKO6LyNQrcUSNj8XX/Vqnc7N1bQDKtH5yy9yD7Gk9U5I
 9yG2a9x2l1VIk4iPwD4inPA2RU30xYb0Nn78wuEeq0psdvGcySfm2/HkpYWgQLTsjTnH/rZXuDa
 Kz79yMJRIfxs8jBFGcx3CHLCXrmA9k1faKb6meCQ87tWra+yulX7eFKlnggIj0yOx0RnwDxL08o
 Uy8LAkWx+fzSZlDac4WvepnEy7oc4eXPfs45Ebk4NllOf0tkMJ9NyS4IPGig3ganIEtjEKqTasq
 rpS0CKRgLv1qPg==
X-Received: by 2002:a05:620a:2951:b0:939:a6eb:735d with SMTP id
 af79cd13be357-93c3624c7acmr299809085a.10.1790256249724; 
 Thu, 24 Sep 2026 06:24:09 -0700 (PDT)
Received: from
 runnervmlun5p.akelbcx354lezf21v2ik45greg.bx.internal.cloudapp.net
 ([172.174.165.227]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c2488b5d8sm456904885a.28.2026.09.24.06.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:24:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Sep 2026 13:24:08 +0000
Message-ID: <20260924132408.4225-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924112514.2375626-2-pvorel@suse.cz>
References: <20260924112514.2375626-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_assert: Use 'long long' to fix 32bit compat mode
 truncation
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

Hi Andrea,

On Thu, 24 Sep 2026 13:25:12 +0200, Andrea Cervesato wrote:
> [PATCH 1/3] tst_assert: Use 'long long' to fix 32bit compat mode truncation

--- [PATCH 1/3] ---

> @@ -25,16 +25,17 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
>  
>  void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
>  {
> -	unsigned long sys_val;
> +	unsigned long long sys_val;
>  
> -	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
> +	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);
>  
> -	if (val == sys_val) {
> +	if (val == (unsigned long)sys_val) {
>  		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
>  		return;
>  	}
>  
> -	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
> +	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
> +		path, val, (unsigned long)sys_val);
>  }

Casting sys_val to (unsigned long) truncates values exceeding ULONG_MAX on
32-bit systems, causing false passes when (sys_val & 0xFFFFFFFF) == val and
printing a truncated value on failure. Compare values without truncation
using (unsigned long long)val == sys_val, and print sys_val with %llu on
mismatch. Handling of 32-bit compat truncation for /proc/sys/kernel/shmall
should be done in shmctl03.c instead of altering generic library assertions.

--- [PATCH 2/3] ---

> @@ -30,7 +30,14 @@ static void verify_ipcinfo(void)
>  	else
>  		tst_res(TPASS, "shmmin = 1");
>  
> -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> +	if (tst_is_compat_mode() && info.shmmax == INT_MAX) {
> +		unsigned long long shmmax;
> +		SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%llu", &shmmax);
> +		TST_EXP_LE_LU(INT_MAX, shmmax);
> +	} else {
> +		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> +	}
> +

Branching on info.shmmax == INT_MAX conditions on the result of the syscall
under test, and TST_EXP_LE_LU(INT_MAX, shmmax) only asserts that the sysctl
file is >= INT_MAX rather than verifying that info.shmmax was clamped.
Read PATH_KERN_SHMMAX into shmmax first, and if in compat mode with
shmmax >= INT_MAX, assert TST_EXP_EQ_LU(info.shmmax, (unsigned long)INT_MAX);
otherwise assert info.shmmax == shmmax.

--- [PATCH 3/3] ---

> +	safe_shmctl(__FILE__, __LINE__, 0, IPC_INFO, ((struct shmid_ds *)&info));

Because shmctl() is the syscall under test, replacing TEST(shmctl(...)) with
safe_shmctl() turns a syscall failure into TBROK instead of TFAIL. In
addition, tests must not call safe_*() functions directly. Keep
TEST(shmctl(...)) or use TST_EXP_PASS(shmctl(0, IPC_INFO, ...)).

> +	TST_EXP_LE_LU(info.shmmin, 1);

TST_EXP_LE_LU() checks info.shmmin <= 1, which incorrectly allows 0 to pass.
The kernel SHMMIN constant is 1 and requires equality. Use
TST_EXP_EQ_LU(info.shmmin, 1).

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

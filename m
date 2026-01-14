Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9466CD31A28
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768379774; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TuB6pfnidNlnPJ+zPP71a6pW1HvQ0PG+KyGhJn+oqaA=;
 b=lwwDwJPzN1UXS1LDImZM8fRBYiWQyPo6EbtVN/HFAGWsqV9C1we5sxNiW9Hvs7SQBwjX5
 hyxETtoE5qLEa69q3pb/8nL7zJ2zq/zjvdx9nvY4HUMjF9OCf89c9e/DKMNVk1UZyEI7PDR
 b1DB34TUZMsrweWOgy3TP14AZeQ5P5A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E1A63C98AB
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 09:36:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CA633C4C92
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 09:35:51 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 586DC1A0080F
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 09:35:50 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b876bf5277dso37366266b.0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 00:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768379749; x=1768984549; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPPloNl7llTdagSQiWBgrN0JSa6mGncDJ/7BeD2LLwI=;
 b=JhcEsyegV47w5bjVhtjIvpBMIP+0yy83tSIw4x0bG39iuQZZkqHDh00RK1S22XR26u
 v2CKYOdj311XdY6VZy6wRItSY/SAN08qMTKXm5Dzt//HxzOtVAWzAStgEDgwdp4LSzM9
 UVE8xaVCL8r/febjYqTPVhIF3ps5m8MViFj09HnxoMPrK4CGHfRwKlYFjf4Lbryu8HqE
 XPSKfzkBc8SYwCCzeGjWhvDdhMcHtvX1kZQ4fcHG5+PeJMBGtiv9gfcN/gAzF75HFCqo
 G17dx7x3c0X9LMivP6hWyZpGRcGe1646DOt6baMgApgKLLP50d3EUX/tepl2MaZ4e+Y8
 R6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379749; x=1768984549;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XPPloNl7llTdagSQiWBgrN0JSa6mGncDJ/7BeD2LLwI=;
 b=b4t6KaKWf08tcVooPKw9404DnzUYtGnHTr4gS5OOK/dtjPNG5kgvrbo5CgbZJCNurk
 sPm+uNPrXwJbMLKFapnZsZjXuKsBocOWOgLowAJL33raoUo8WPOIG/0pkDXaPs7pXp4R
 7vH9kVyuPoyd1/EvyhlVxfFN5TiC/6nt4zB3oQGvlj7Q6Spw4PlZmKhi20fceRg5kksH
 FC5uo4w31Z6cTt+5YGQqa+7+GjMS01hr7sQ2ksVs+PHAgkL63SxiXC2JI19nunwR6eNm
 +hfBb5PeoD8tAeNC8M8H+9r65RjWHb6z9Yf34d2DswwEApCFazij8Nk9RDAv3A3Mz8AK
 TJZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyBm2Y+nhkGgMt9Ab5mXGHq1yTatanNRD054p4eze4zSMF9yawBdh174ukUYn0TWFsyEA=@lists.linux.it
X-Gm-Message-State: AOJu0YzDxiHK5p7HN6Ewj+hhEAakpgRDSyuv3Uu+mC5R4pwKsu6Y1WZL
 hcEHvxpOBEHtXOX/AfjwUeTxp/JDxv7ncg86Wm5rfa/YBVZOP0wWL9AZbAjJMQZwc0A=
X-Gm-Gg: AY/fxX5hl1abMaveh1wmB5rXwdxtW77Y4hEega/xZ+ogwpCzOKyRel16B543meiXFMd
 wwB3+Rcjm73v96F9DOKMSRNnYtH7rMJUEX61WYOaBgnZtDplRRQvzLrSiEH1yemw1q5HxNPV2e4
 B7PSkXw5LB6pFnLqOZu0WRYGpxh2anFcr8knZbB24VqA8hKm3ewYJjh7MRoD9OHuA9qK5FM4Plb
 TnntITfBQ61y68gttsR0bGjBAqxRSp0CuYhnUMaQNSzboiwt3Msgb3o8yY98ukw0Sn9Taok0PB5
 550f8Vvi2PUv/gjLwvoBRi0IWWQyIPZVff5KL6fVJuNLYl7nEiMCgzmEdV8rPd3OJ2wRSVUrfoq
 PznQc1FF4UPU5n5zwgEQ+trxOpuVY/diFA5a2es7wPlsk1S/AqENr99iju/ruu7Lg6EK6TAvEMg
 usJqtT2QVXYuvi9b2+AxZDCbfdA6lN65T8Ng+KsAlJGa7Xb8VpeIoyhnblZ4lcQQ5631rcyNgot
 lmX/Ik=
X-Received: by 2002:a17:907:6d17:b0:b87:2abc:4a2a with SMTP id
 a640c23a62f3a-b8761be4dc8mr132227166b.1.1768379749303; 
 Wed, 14 Jan 2026 00:35:49 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56c547sm2437958966b.69.2026.01.14.00.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 00:35:48 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 09:35:48 +0100
Message-Id: <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
To: "Al Viro" <viro@zeniv.linux.org.uk>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260113194936.GQ3634291@ZenIV>
In-Reply-To: <20260113194936.GQ3634291@ZenIV>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
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
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Tue Jan 13, 2026 at 8:49 PM CET, Al Viro wrote:
> 	There are different causes of ENAMETOOLONG.  It might come from
> filesystem rejecting an excessively long pathname component, but there's
> also "pathname is longer than PATH_MAX bytes, including terminating NUL"
> and that doesn't get checked anywhere.
>
> 	Ran into that when a braino in kernel patch broke that logics
> (ending up with cutoff too low) and that didn't get caught by LTP run.
>
> 	Patch below adds the checks to one of the tests that do deal
> with the other source of ENAMETOOLONG; it almost certainly not the
> right use of infrastructure, though.

The description is not well formatted, spaces at the beginning of the
phrases should be removed.

Also, we can make it slightly more clear, by saying that error can be
caused by a path name that is bigger than NAME_MAX, if relative, or
bigger than PATH_MAX, if absolute (when we use '/').

In this test we only verifies if relative paths are longer than
NAME_MAX (we give 273 bytes instead of 255 max), but we don't test if
path name is bigger than PATH_MAX.

We should correctly distinguish these two cases inside the test with
proper names as well. Check below..

>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
> index 6e53b7fef..e8dd5121d 100644
> --- a/testcases/kernel/syscalls/chdir/chdir04.c
> +++ b/testcases/kernel/syscalls/chdir/chdir04.c
> @@ -11,6 +11,8 @@
>  #include "tst_test.h"
>  
>  static char long_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> +static char long_path[PATH_MAX+1];
> +static char shorter_path[PATH_MAX];
>  static char noexist_dir[] = "noexistdir";

When it comes to syscall testing, it's better to use guarded buffers.
This is easy to do: please check tst_test.bufs usage in here:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers-introduction

Many old tests are not using these buffers, but it's better to
introduce them when a test is refactored or fixed, like in this case.

You need to define:

static char *long_rel_path;
static char *long_abs_path;

...

static void setup(void) {
	..
	// initialize long_rel_path content
	// initialize long_abs_path content
}

static struct tst_test test = {
	..
	.bufs = (struct tst_buffer []) {
		{&long_rel_path, .size = NAME_MAX + 10},
		{&long_abs_path, .size = PATH_MAX + 10},
		{}
	}
};

>  
>  static struct tcase {
> @@ -20,16 +22,23 @@ static struct tcase {
>  	{long_dir, ENAMETOOLONG},
>  	{noexist_dir, ENOENT},
>  	{0, EFAULT}, // bad_addr
> +	{long_path, ENAMETOOLONG},
> +	{shorter_path, 0},
>  };
>  
>  static void verify_chdir(unsigned int i)
>  {
> -	TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> +	if (tcases[i].exp_errno)
> +		TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> +	else
> +		TST_EXP_PASS(chdir(tcases[i].dir), "chdir()");

In this test we only verify errors, so TST_EXP_PASS is not needed.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

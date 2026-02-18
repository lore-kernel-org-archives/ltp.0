Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE06E9A047
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771421699; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=AcVXQse90NYZKjhMfbjpai3C5CK5WHpujpNlAvKqDLw=;
 b=UMfSWZrzK5Y9AqknVc4IFMr/1OTAwnjUOYEiGhi7Z0nstWDxPtVolAnT1XgE6xPwz8+VT
 fpxp78SwY1o86TbIbCSlFmM0CKlPGwBrjcKxGzU/5iJtYHi86gR1s4WHHesBCuvSnDF4/RK
 dW5Mh/tMLkq0aC9rV4rseoS72euimIo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CC9D3D0706
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 14:34:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D93F73CC7E6
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 14:34:36 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7617B6009D3
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 14:34:35 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso8321395e9.0
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771421675; x=1772026475; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDe7pwy+TDfX2CMDLIcpQc6GT+4HNkpUGcRKLevpa/I=;
 b=YymQlR3l0+nJ/RzAZA87CvXsSBZYgWztm/mOplodCFhNIpMooqrf8sQBWy4LAPl1/p
 X+3wisqUmcAylsTqgO3ZXd8lzvYbcehFSk/Fcyr4skrrGQcpwvQXjRkqK59+EzALY+Di
 kUuwSzV8FqMYBqVbW1aFgQkXGhncG7rLraGmagjnX+8X+xjsHhcCz2cVr2yvYii4nvxy
 lhhgYIPOJeBX2EhBlIbW5slsYDJ1bWfL/wbt5c2farmgdKJ2VqS2h6dEoI+TBJKJMiCh
 RUAk06CLWqxGHrhJjltNmTnU86/I1A8VyQ7m8wu7zEckSjEchmhOkZarpbZr1lpaovno
 ow5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421675; x=1772026475;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NDe7pwy+TDfX2CMDLIcpQc6GT+4HNkpUGcRKLevpa/I=;
 b=kKVoZ9YzOkKj5bBGwKVGo612r/MgP296dcQ7Cm4VzYKfWmCocZ7PJY5ZoBH7HJJUKE
 jnQerr6QnW7llbXDmbS8jSS2Fl0PZXwHnWpXlA4Ww488p3UJd1urbqnfm3NSe/Vjycao
 PcdVgAXwjB2FcPIT+h3A654jbmJ+QWJzSKn48K/KkJgRbaPHtVnqTzcubwJWPiROVT05
 YDeZazSzb0qmthQk25qDiDAPtrGyXAaZRH+XeBiMiTtB/Gt0QULQC0jIN+lonvtGguKu
 rpivCv4MBJyMt+RfEFkfFRZiKuLE5v12rowb3KRxWTJG23ZN5UesiWKbegii3/9eqoF6
 t2uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVpg2JInRjR9b5w+l6lsiBNe/6UTiul9s1p0N4kBwJivY7oE6TKNqAEKJ1va9lS60doSc=@lists.linux.it
X-Gm-Message-State: AOJu0YzPs7z8c3f0uzmpRw1zDDqdThnyyCEJe8ll5YVQ98BfvXycnHKT
 6U9cBeH26t1sJsJzfy6sDj1IOMfcMKleLZRK6wgNaLMltbojBlqoqwYcUGGekyVqx/2ce3L622M
 YIHc5WWA=
X-Gm-Gg: AZuq6aKw6OiaDpgq5z1p4n0Oy8EOLSUbmf535mLSEa9S2RHr0iwVP7PE3ctqm3NASoO
 /I5C1617dezuf24P9Q/IO9frfV+ARtDzEGDfK1p8Y1/qi/j5eR/dZz0D36kvbDCm4MBWNSPOwwb
 TlAc2PWoX1cxxpkVER/mhFVhYWyx2TrN3Q1ftKwBdRN3w5VDdmxOPqh1I6f23wRKs+kCPaGpk1m
 i7Ui6CV/vxAo7eTOJ8lki/PKB73qzPjQKq151r4ejBSl+rfHi/NIUuRPRYuZNQl4wxhW5roB7iY
 R1t0ZTu5NHVdqk+3+hEmoz2/7h/Ud3I3th64WDlRgngoA4WAC+nlPD/2Dx+aApl0J8GnToxQiGK
 vui4Q/+F1TKXnMvX6tGnoMtbzFfMD2Npe7nKNYgmhqhdAetjyehaD6w52cNNIr6JVF+g3CxDTpd
 mKa588niQZD1GPX8mTAT0yt+Bfc/rl/pGpD4FOQE08j8YIsXiKP7ImjJySMVxGy2SjomzSgtIi1
 qMK/X4MmjfTAzWp0qM=
X-Received: by 2002:a05:600c:34c3:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-48398c59da5mr35336795e9.4.1771421674709; 
 Wed, 18 Feb 2026 05:34:34 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839731e101sm24274395e9.6.2026.02.18.05.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 05:34:34 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 14:34:33 +0100
Message-Id: <DGI4KQCXESV5.5PGMWF4DXPA3@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260128002828.424-1-wegao@suse.com>
In-Reply-To: <20260128002828.424-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mseal02: Handle multiple errnos for 32-bit
 compat mode
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Wed Jan 28, 2026 at 1:28 AM CET, Wei Gao via ltp wrote:
> In 32-bit compat mode, the overflow_size (calculated using a 32-bit ULONG_MAX)
> does not cause a 64-bit integer wrap-around when added to the start address.
> Consequently, the kernel see valid range that points to unmapped space, returning
> ENOMEM instead of the expected EINVAL.
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/mseal/mseal02.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mseal/mseal02.c b/testcases/kernel/syscalls/mseal/mseal02.c
> index e11d7dbf4..d941f6c40 100644
> --- a/testcases/kernel/syscalls/mseal/mseal02.c
> +++ b/testcases/kernel/syscalls/mseal/mseal02.c
> @@ -21,6 +21,8 @@
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> +#define MAX_ERRNOS 5
> +
>  static void *start_addr, *unaligned_start_addr, *unallocated_start_addr, *unallocated_end_addr;
>  static size_t page_size, twopages_size, fourpages_size, overflow_size;
>  
> @@ -28,22 +30,22 @@ static struct tcase {
>  	void **addr;
>  	size_t *len;
>  	unsigned long flags;
> -	int exp_err;
> +	int exp_errs[MAX_ERRNOS];
>  } tcases[] = {
> -	{&start_addr, &page_size, ULONG_MAX, EINVAL},
> -	{&unaligned_start_addr, &page_size, 0, EINVAL},
> -	{&start_addr, &overflow_size, 0, EINVAL},
> -	{&unallocated_start_addr, &twopages_size, 0, ENOMEM},
> -	{&unallocated_end_addr, &twopages_size, 0, ENOMEM},
> -	{&start_addr, &fourpages_size, 0, ENOMEM},
> +	{&start_addr, &page_size, ULONG_MAX, {EINVAL}},
> +	{&unaligned_start_addr, &page_size, 0, {EINVAL}},
> +	{&start_addr, &overflow_size, 0, {EINVAL, ENOMEM}},
> +	{&unallocated_start_addr, &twopages_size, 0, {ENOMEM}},
> +	{&unallocated_end_addr, &twopages_size, 0, {ENOMEM}},
> +	{&start_addr, &fourpages_size, 0, {ENOMEM}},
>  };
>  
>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  
> -	TST_EXP_FAIL(tst_syscall(__NR_mseal, *tc->addr, *tc->len, tc->flags), tc->exp_err,
> -		"mseal(%p, %lu, %lu)", *tc->addr, *tc->len, tc->flags);
> +	TST_EXP_FAIL2_ARR(tst_syscall(__NR_mseal, *tc->addr, *tc->len, tc->flags),
> +		tc->exp_errs, MAX_ERRNOS, "mseal(%p, %lu, %lu)", *tc->addr, *tc->len, tc->flags);
>  }
>  
>  static void setup(void)

Instead of checking multiple errno, you should pass the right type
according to the architecture.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

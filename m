Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D61FC02188
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737107109; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=jLdBHdcRKU5oI3f7eIQ6hCqUQZwb7I+sZ3Ly7+/GgxE=;
 b=U+9RqaXhl35I+48IT7802fuVaaFsFo1Exbc7GtbHaSsuMnuDJLp7qRfcnZlOiP6yGB3aQ
 CfwWRVh19n4R/Z2+wR6cQXeuBKfP+16zwboqcQH2VB8EwtO1UcLomgUTqUkewimjXhWhvHB
 c2Wgmu0ro3MlVNjYnSVKWSlMJhL6XPw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5A603C7C12
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:45:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADA453C1117
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:44:47 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CBB4322C39B
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:44:46 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso12004195e9.0
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 01:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737107086; x=1737711886; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKjcsIaLfeYW3u3L10ufl1RI8CKCv+Deq+f0SvYqJjw=;
 b=TlMr+wyFuuYMoebh5R54QmYck8brJW00Hd/F1i3AWB43GIAYSdo1CPTVN7HO36YA2X
 P0ubPEU0rHwahxdcEm19I+X9W0Q6lcuq9d2Umr0r03Zde2OGsjMi82rJlexOmOOrWrqd
 OQRu6Q2VTuwHZGhJ0fw8jic85tc32WrHY49MjRhcVNUAB/H4Hf+EjyK8NWQKzpxasvIn
 gQRBogRRkHPaYk9p3XFY3ARtmfDy4C0xOrZ8sk6Q0SUTQhsDIKVKIlMMW/9q7fmMVVW/
 qLomP1bop9D+9f4wkYTTBQyPTFj8F0r3/aIj5UP9WnvZbWSpoXvFLc6YI6a8bR5v0QOn
 iJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737107086; x=1737711886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HKjcsIaLfeYW3u3L10ufl1RI8CKCv+Deq+f0SvYqJjw=;
 b=CHj0CVoA0AapuLdaPVZPXRtVKjKU0+jQaRkyfJTh42ftPhZJum/SJlBs5LmFsFWq0H
 qhtfEkH9XPLufbSdfUAIwoXM6g0RY5+bebNpsqjvkN0HssJiZyUDDXhk0ziEAmW9kW+O
 527IWquFWbgg4+quNaznJHiYnVBfpPwaqchDmkQaedqcDrlfR/B1jsC7FYWCZhsEk3fV
 Wi7Q4N/z4aAOje8IJHNboIgVHlWc0gSzLT9cDcdCnz8un638zha0ZjmbrShqNiNAtg6U
 9XCgaNo84OwH9Bux1FSUkq/tzN+AxrM8tZoG2j38xvxcrHtwGobIeemutVgxlIwXod82
 C2CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWghM5oZdbhyu7bpnRDdJB8mp9KiZNlDNy8yL+C+5iF5H9aNX78h9aBc3xDWtZWQiBS4I=@lists.linux.it
X-Gm-Message-State: AOJu0YwZ+0JFA+Uect6Dhm6silEGzgae5EnvxnmN6cSy5jnsT0mUVNaa
 6AqR+XkIfOk4407KfE5sTz854NQC2XS5doFaxAySMBGErzHT1tTX2KHSZf+QGtIxUrAJ9P3nCn9
 CnwUWVVGL
X-Gm-Gg: ASbGncv47sYX9V2z21yf/1K7E3s/YtsQoTmOWKXEcqnM8wCPjtY/DqKx15U8TDy9wKX
 sPf/RASosa023TXYfCDEoHkJZTDtIbVkmyS8d872CwxONUnxQ+Z528PDPUv56y6UztDpY7xdnFc
 1w/JCpPvnB+sQetGxp6rZASRqp1BY2ljVtWv/o82VJs9zzjxV44SzHx9cWoPI6TeTNbfWK3DwMt
 6WEyfE5W1MdB7lHOqIZnO31J/0KurJY3qDQ2RCmEgV2oMRJV+HizteR97vFhFEdjCtEq5G5y9kX
 PgE5znpzleWQCUkJnuQIbaddL732jKH/zySrqA66NCIn/nsXI0BpQj+45rE+ahs4pauIgb+NmWf
 rGYg+2Ky5HYtEjDlVFt4=
X-Google-Smtp-Source: AGHT+IEfd7o2+WOFzcvMDMRGsV5YbRoKLaHbBPl8YciL4eKu43m1l7qPpR1GGp3rS8OBHl4TV4NkGw==
X-Received: by 2002:a05:6000:1acc:b0:386:4a16:dad7 with SMTP id
 ffacd0b85a97d-38bf566e605mr1762603f8f.10.1737107086031; 
 Fri, 17 Jan 2025 01:44:46 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327574asm2045659f8f.68.2025.01.17.01.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:44:45 -0800 (PST)
Message-ID: <36bd622b-6be7-4b32-8068-5ca768315293@suse.com>
Date: Fri, 17 Jan 2025 10:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
 <20250116-fix_setsid_tests-v4-3-910f062a7235@suse.com>
Content-Language: en-US
In-Reply-To: <20250116-fix_setsid_tests-v4-3-910f062a7235@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 03/12] Refactor ptem01 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pushed a patch to fix this test compiling on Alpine:

426d78f62 ptem01: fix compiling on alpine

Andrea

On 1/16/25 12:36, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Fix test failure when running inside a new session via setsid() and
> start spliting its internal tests cases implementations into multiple
> files.
>
> Fixes: https://github.com/linux-test-project/kirk/issues/28
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/kernel/pty/common.h |  68 +++++++
>   testcases/kernel/pty/ptem01.c | 456 ++++--------------------------------------
>   2 files changed, 105 insertions(+), 419 deletions(-)
>
> diff --git a/testcases/kernel/pty/common.h b/testcases/kernel/pty/common.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..51760b1d39fa0518f3e7c4ece2281286e056cc48
> --- /dev/null
> +++ b/testcases/kernel/pty/common.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef PTEM_H
> +#define PTEM_H
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +
> +#define MASTERCLONE "/dev/ptmx"
> +
> +static inline int open_master(void)
> +{
> +	int masterfd;
> +
> +	if (access(MASTERCLONE, F_OK))
> +		tst_brk(TCONF, "%s device doesn't exist", MASTERCLONE);
> +
> +	tst_res(TINFO, "opening master %s", MASTERCLONE);
> +
> +	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
> +
> +	if (grantpt(masterfd) == -1)
> +		tst_brk(TBROK | TERRNO, "grantpt() error");
> +
> +	if (unlockpt(masterfd) == -1)
> +		tst_brk(TBROK | TERRNO, "unlockpt() error");
> +
> +	return masterfd;
> +}
> +
> +static inline int open_slave(const int masterfd)
> +{
> +	int slavefd;
> +	char *slavename;
> +
> +	slavename = SAFE_PTSNAME(masterfd);
> +
> +	tst_res(TINFO, "opening slave %s", slavename);
> +
> +#ifndef __BIONIC__
> +	/* grantpt() is a no-op in bionic. */
> +	struct stat st;
> +
> +	SAFE_STAT(slavename, &st);
> +
> +	uid_t uid = getuid();
> +
> +	if (st.st_uid != uid) {
> +		tst_brk(TBROK, "uid mismatch st.st_uid(%d) != getuid(%d)",
> +			st.st_uid, uid);
> +	}
> +
> +	if (st.st_mode != (S_IFCHR | 0620)) {
> +		tst_brk(TBROK, "unexpected slave device permission: %o",
> +			st.st_mode);
> +	}
> +#endif
> +
> +	slavefd = SAFE_OPEN(slavename, O_RDWR);
> +
> +	return slavefd;
> +}
> +
> +#endif
> diff --git a/testcases/kernel/pty/ptem01.c b/testcases/kernel/pty/ptem01.c
> index 20ef5d0a739a55262c1c32ec03e57885dfe09787..b14e247c8ba53e098d44a3904621f8f2ec21fd1a 100644
> --- a/testcases/kernel/pty/ptem01.c
> +++ b/testcases/kernel/pty/ptem01.c
> @@ -1,441 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *   Copyright (c) International Business Machines  Corp., 2002
> - *   Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2002
> + * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>    */
>   
> -/* 12/23/2002   Port to LTP     robbiew@us.ibm.com */
> -/* 06/30/2001   Port to Linux   nsharoff@us.ibm.com */
> +/*\
> + * [Description]
> + *
> + * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
> + * slave device and configure termos/termios ioctls.
> + */
>   
>   #define _GNU_SOURCE
> -#include <errno.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <stdio.h>
> -#include <termios.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <sys/poll.h>
> -#include <sys/types.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/ioctl.h"
>   
> -char *TCID = "ptem01";		/* Test program identifier.    */
> -int TST_TOTAL = 6;		/* Total number of test cases. */
> -/**************/
> -
> -/*
> - * pty master clone device
> - */
> -#define MASTERCLONE "/dev/ptmx"
> +#include <termio.h>
> +#include <termios.h>
> +#include "common.h"
>   
> -#define BUFSZ 4096
> +static int masterfd = -1;
>   
> -/*
> - * test termio/termios ioctls
> - */
> -int test1(void)
> +static void run(void)
>   {
> -	int masterfd, slavefd;
> -	char *slavename;
> +	int slavefd;
>   	struct termio termio;
>   	struct termios termios;
>   
> -	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
> -
> -	slavename = ptsname(masterfd);
> -	if (slavename == NULL) {
> -		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
> -	}
> -
> -	if (grantpt(masterfd) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
> -	}
> -
> -	if (unlockpt(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -	}
> -
> -	if ((slavefd = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TFAIL, NULL, "Could not open %s", slavename);
> -	}
> -
> -	if (ioctl(slavefd, TCGETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCGETS");
> -	}
> -
> -	if (ioctl(slavefd, TCSETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETS");
> -	}
> -
> -	if (ioctl(slavefd, TCSETSW, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETSW");
> -	}
> -
> -	if (ioctl(slavefd, TCSETSF, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETSF");
> -	}
> -
> -	if (ioctl(slavefd, TCSETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETS");
> -	}
> -
> -	if (ioctl(slavefd, TCGETA, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCGETA");
> -	}
> -
> -	if (ioctl(slavefd, TCSETA, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETA");
> -	}
> -
> -	if (ioctl(slavefd, TCSETAW, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETAW");
> -	}
> -
> -	if (ioctl(slavefd, TCSETAF, &termio) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCSETAF");
> -	}
> -
> -	if (close(slavefd) != 0) {
> -		tst_brkm(TBROK, NULL, "close slave");
> -	}
> -
> -	if (close(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "close master");
> -	}
> -	tst_resm(TPASS, "test1");
> -
> -	/** NOT REACHED **/
> -	return 0;
> -}
> -
> -/*
> - * test window size setting and getting
> - */
> -int test2(void)
> -{
> -	int masterfd, slavefd;
> -	char *slavename;
> -	struct winsize wsz;
> -	struct winsize wsz1 = { 24, 80, 5, 10 };
> -	struct winsize wsz2 = { 60, 100, 11, 777 };
> -
> -	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
> -
> -	slavename = ptsname(masterfd);
> -	if (slavename == NULL) {
> -		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
> -	}
> -
> -	if (grantpt(masterfd) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
> -	}
> -
> -	if (unlockpt(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -	}
> -
> -	if ((slavefd = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
> -	}
> -
> -	if (ioctl(masterfd, TIOCSWINSZ, &wsz1) != 0) {
> -		tst_brkm(TFAIL, NULL, "TIOCSWINSZ");
> -	}
> -
> -	if (ioctl(slavefd, TIOCGWINSZ, &wsz) != 0) {
> -		tst_brkm(TFAIL, NULL, "TIOCGWINSZ");
> -	}
> -
> -	if (wsz.ws_row != wsz1.ws_row || wsz.ws_col != wsz1.ws_col ||
> -	    wsz.ws_xpixel != wsz1.ws_xpixel ||
> -	    wsz.ws_ypixel != wsz1.ws_ypixel) {
> -		tst_brkm(TFAIL, NULL, "unexpected window size returned");
> -	}
> -
> -	if (ioctl(masterfd, TIOCGWINSZ, &wsz) != 0) {
> -		tst_brkm(TFAIL, NULL, "TIOCGWINSZ");
> -	}
> -
> -	if (wsz.ws_row != wsz1.ws_row || wsz.ws_col != wsz1.ws_col ||
> -	    wsz.ws_xpixel != wsz1.ws_xpixel ||
> -	    wsz.ws_ypixel != wsz1.ws_ypixel) {
> -		tst_brkm(TFAIL, NULL, "unexpected window size returned");
> -	}
> -
> -	if (ioctl(slavefd, TIOCSWINSZ, &wsz2) != 0) {
> -		tst_brkm(TFAIL, NULL, "TIOCSWINSZ");
> -	}
> -
> -	if (ioctl(slavefd, TIOCGWINSZ, &wsz) != 0) {
> -		tst_brkm(TFAIL, NULL, "TIOCGWINSZ");
> -	}
> -
> -	if (wsz.ws_row != wsz2.ws_row || wsz.ws_col != wsz2.ws_col ||
> -	    wsz.ws_xpixel != wsz2.ws_xpixel ||
> -	    wsz.ws_ypixel != wsz2.ws_ypixel) {
> -		tst_brkm(TFAIL, NULL, "unexpected window size returned");
> -	}
> -
> -	if (close(slavefd) != 0) {
> -		tst_brkm(TBROK, NULL, "close");
> -	}
> -
> -	if (close(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "close");
> -	}
> -	tst_resm(TPASS, "test2");
> -
> -	/** NOT REACHED **/
> -	return 0;
> -}
> -
> -/*
> - * test sending a break
> - */
> -int test3(void)
> -{
> -	int masterfd, slavefd;
> -	char *slavename;
> -
> -	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
> -
> -	slavename = ptsname(masterfd);
> -	if (slavename == NULL) {
> -		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
> -	}
> -
> -	if (grantpt(masterfd) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
> -	}
> -
> -	if (unlockpt(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -	}
> -
> -	if ((slavefd = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
> -	}
> -
> -	if (tcsendbreak(masterfd, 10) != 0) {
> -		tst_brkm(TFAIL, NULL, "tcsendbreak");
> -	}
> -
> -	if (tcsendbreak(slavefd, 10) != 0) {
> -		tst_brkm(TFAIL, NULL, "tcsendbreak");
> -	}
> -
> -	if (close(slavefd) != 0) {
> -		tst_brkm(TBROK, NULL, "close slave");
> -	}
> -
> -	if (close(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "close master");
> -	}
> -	tst_resm(TPASS, "test3");
> -
> -	/** NOT REACHED **/
> -	return 0;
> -}
> -
> -/*
> - * test multiple opens of slave side
> - */
> -int test4(void)
> -{
> -	int masterfd, slavefd, slavefd2, slavefd3;
> -	char *slavename;
> -
> -	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
> -
> -	slavename = ptsname(masterfd);
> -	if (slavename == NULL) {
> -		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
> -	}
> +	slavefd = open_slave(masterfd);
>   
> -	if (grantpt(masterfd) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
> -	}
> +	TST_EXP_PASS(ioctl(slavefd, TCGETS, &termios));
> +	TST_EXP_PASS(ioctl(slavefd, TCSETS, &termios));
> +	TST_EXP_PASS(ioctl(slavefd, TCSETSW, &termios));
> +	TST_EXP_PASS(ioctl(slavefd, TCSETSF, &termios));
> +	TST_EXP_PASS(ioctl(slavefd, TCSETS, &termios));
> +	TST_EXP_PASS(ioctl(slavefd, TCGETA, &termio));
> +	TST_EXP_PASS(ioctl(slavefd, TCSETA, &termio));
> +	TST_EXP_PASS(ioctl(slavefd, TCSETAW, &termio));
> +	TST_EXP_PASS(ioctl(slavefd, TCSETAF, &termio));
>   
> -	if (unlockpt(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -	}
> -
> -	if ((slavefd = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
> -	}
> -
> -	if ((slavefd2 = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TFAIL, NULL, "Could not open %s (again)", slavename);
> -	}
> -
> -	if ((slavefd3 = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TFAIL, NULL, "Could not open %s (once more)",
> -			 slavename);
> -	}
> -
> -	if (close(slavefd) != 0) {
> -		tst_brkm(TBROK, NULL, "close slave");
> -	}
> -	if (close(slavefd2) != 0) {
> -		tst_brkm(TBROK, NULL, "close slave again");
> -	}
> -	if (close(slavefd3) != 0) {
> -		tst_brkm(TBROK, NULL, "close slave once more");
> -	}
> -	if (close(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "close master");
> -	}
> -	tst_resm(TPASS, "test4");
> -
> -	/** NOT REACHED **/
> -	return 0;
> +	SAFE_CLOSE(slavefd);
>   }
>   
> -#define NUMOPENS 6
> -
> -/*
> - * test several simultaneous opens
> - */
> -int test5(void)
> +static void setup(void)
>   {
> -	static int masterfd[NUMOPENS];
> -	static int slavefd[NUMOPENS];
> -	char *slavename;
> -	int i;
> -
> -	for (i = 0; i < NUMOPENS; ++i) {
> -		masterfd[i] = open(MASTERCLONE, O_RDWR);
> -		if (masterfd[i] < 0) {
> -			tst_resm(TBROK, "%s", MASTERCLONE);
> -			tst_resm(TBROK, "out of ptys");
> -			for (i = 0; i < NUMOPENS; ++i) {
> -				if (masterfd[i] != 0) {
> -					(void)close(masterfd[i]);
> -				}
> -				if (slavefd[i] != 0) {
> -					(void)close(slavefd[i]);
> -				}
> -			}
> -			tst_exit();
> -		}
> -
> -		slavename = ptsname(masterfd[i]);
> -		if (slavename == NULL) {
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "ptsname() call failed");
> -		}
> -
> -		if (grantpt(masterfd[i]) != 0) {
> -			tst_brkm(TBROK | TERRNO, NULL,
> -				 "grantpt() call failed");
> -		}
> -
> -		if (unlockpt(masterfd[i]) != 0) {
> -			tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -		}
> -
> -		if ((slavefd[i] = open(slavename, O_RDWR)) < 0) {
> -			tst_brkm(TFAIL, NULL,
> -				 "Iteration %d: Could not open %s", i,
> -				 slavename);
> -		}
> -
> -	}
> -
> -	for (i = 0; i < NUMOPENS; ++i) {
> -		if (close(slavefd[i]) != 0) {
> -			tst_brkm(TBROK, NULL, "Iteration %d: close slave", i);
> -		}
> -		if (close(masterfd[i]) != 0) {
> -			tst_brkm(TBROK, NULL, "close master");
> -		}
> -	}
> -	tst_resm(TPASS, "test5");
> -
> -	/** NOT REACHED **/
> -	return 0;
> +	masterfd = open_master();
>   }
>   
> -/*
> - * test hangup semantics
> - */
> -int test6(void)
> +static void cleanup(void)
>   {
> -	static int masterfd;
> -	static int slavefd;
> -	char *slavename;
> -	struct termios termios;
> -
> -	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
> -
> -	slavename = ptsname(masterfd);
> -	if (slavename == NULL) {
> -		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
> -	}
> -
> -	if (grantpt(masterfd) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
> -	}
> -
> -	if (unlockpt(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "unlockpt() call failed");
> -	}
> -
> -	if ((slavefd = open(slavename, O_RDWR)) < 0) {
> -		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
> -	}
> -
> -	if (ioctl(slavefd, TCGETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCGETS");
> -	}
> -
> -	termios.c_cflag &= ~CBAUD;
> -	termios.c_cflag |= B0 & CBAUD;
> -	if (ioctl(slavefd, TCSETS, &termios) != 0) {
> -		tst_brkm(TFAIL, NULL, "TCGETS");
> -	}
> -
> -	if (close(slavefd) != 0) {
> -		tst_brkm(TBROK, NULL, "close");
> -	}
> -	if (close(masterfd) != 0) {
> -		tst_brkm(TBROK, NULL, "close");
> -	}
> -	tst_resm(TPASS, "test6");
> -
> -	/** NOT REACHED **/
> -	return 0;
> +	if (masterfd != -1)
> +		SAFE_CLOSE(masterfd);
>   }
>   
> -/*
> - * main test driver
> - */
> -int main(void)
> -{
> -	test1();
> -	test2();
> -	test3();
> -	test4();
> -	test5();
> -	test6();
> -	/*
> -	 * all done
> -	 */
> -	tst_exit();
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

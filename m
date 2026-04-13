Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE088E9380E
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 04:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70A643E1DD9
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 06:33:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 571B13E15C3
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 06:33:23 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6A50514004F2
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 06:33:22 +0200 (CEST)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a2a70bb69eso4228735e87.2
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 21:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776054802; cv=none;
 d=google.com; s=arc-20240605;
 b=M44ALWlG0XxjGnpyqvQflEmI287+iGC/NWaneF/JqiTGaZfupeGxmy9opBuuBoz7+6
 0CY3feZuNVpQLrGaK1SuydamQqV6BCdvH5RyG8NRkf3JbgzQNEj4mjgK2IqhHdWk6Wig
 lIqLKRbxPccXC/EuRuyxQ+zUCPXAP5J+YJfxzMEb0r4xivsn1vHeAAapWbgOSeNrlrmV
 MN81AjxCGwoie9FlbFV9I3Ave55p15KAUvCNgGX0k2E6XT7exbdeH5evIq2hy5EFkt2n
 cD0cFFHIIzEmh5AKONDUsqC8bAn7gKUcn9aZXHu0Tb65Mefk4CieXwu12eiwHVb/Ln5i
 vRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=42QKOwF2VhtmlHqv4KOEHpoDlH0dJue2rtT5Erh0hYs=;
 fh=h9+9WWpZyzfNxB9Z98HjDio77S+i5y7sPLnTVbM5VuQ=;
 b=RP/96UKcxwYhn2FllidUQHAoHXIXHGu5CyZw23y34gH9tGixKWI6kf7yWgdjNQurrp
 puyHGGy0TjELgaeeQyz2SLoRTdlnyWCIekH9mlx3ejuxD5sLWDJNQZWHV19a/1wmpnRB
 knE329ccbJWbsTkeHHoX/QkUxfHVtVP/I/x9FFP0DOm3NCp+23RQuo2YT0WsDyN70VWe
 B+ljRBP1R/tYn/0QGDOtf70l9am6uVwYSmn1s/OKDyt7TDCOCRCFgNHciecq194QsfWs
 pNwSkY9RtVBtVqLKJ2V1sipwsqXKXY5D5bA7iMpWYaWpXKy0GsX2rF1XavF/pwyiYRND
 tvwA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776054802; x=1776659602; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=42QKOwF2VhtmlHqv4KOEHpoDlH0dJue2rtT5Erh0hYs=;
 b=qrkCTpmjuECI3EGWg9uA/0AF0LjsDEPqbTI8KVMNUu8XQn8mj0kWqGn2rrBunbQRzo
 TZeG2kMqPfzgxPs2GV6UpZdHryb5LaVcvnLsHA9jWvWGUui50qbKR/IVQ/pWU7D//eta
 uf/GkL10j9HANOghzSDik2JM9gyAay8TIBffnExKUpxBv/IrNUv5CGPsmNVFgRJE1UGs
 HyVMxaYHlU2YgcBkpLadyAnbp7oT1Uza5xRodKRa/nR0bocts7bN97RNNECbx5NJXovQ
 d1Nx495Ry1HZg7pb1bdHkOi+HZeLWMYSczqnNOvNky7Wp0owR6wlbHx8K/a8xXvrPsIK
 qbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776054802; x=1776659602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42QKOwF2VhtmlHqv4KOEHpoDlH0dJue2rtT5Erh0hYs=;
 b=Do/Z82rwcuN1IocubBkDs9MMeGoc0T8nx65szgdATo0d5qCtE505YyK9Sh135AXLmg
 f44QN3LIQxwB2rb5qzL9sGvVOXvANFca86HkhREcdVABoOiG+ZPbBExzq2z934UVAvhM
 +a+WOINotqJvOsbvpqa0BpsHHXpv0NJYXarMvkR05G17DfSVpAqhmzw8vDWN92jZLHLf
 M31jEmicev/BJ8ePJcAssB54M5VcdDx4h3ogkQMNATdZLnAaRBfVwUMUycKyvwubUWtx
 jVah6tOloP6hfCsoULqnbC6B0Jz2IQxy77O05SiUsWXGiGvVlm1hEnbWHG1MGRIXCeVy
 BiCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ93FyXKcvpwjCMGPMDnOAzQG12K/J+vBb0ItA1KyatRqfFh/QXUtFWswn/uz2yb0zLohmE=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/8t9CZvC09ByNWEIv3l+Qx/qqXdDTOwdpAmecQQZRb4sl6XMN
 J2qcUW/OlV7hvepZ+RIqOcSggANZTjWuRH8O9ClCaMjPpSAYdKtsBfEYRutZLtsvOphzlpXoR3A
 zUPrqKM6ylZkPYhuK3hoFph/7PRBuIMw=
X-Gm-Gg: AeBDieuMsJBfIHr5HkYE7id4jdGhibHoiY5zDsZfzwc/gMYEnnK7O4uIJ9J5z7RTZRd
 8JtgeJLdyg5Ymx3DoY0g8pKhr0pYWlLcer+zuGJDFi5Y5oYNyIVhIDV/CI6HOewY3y4IVSTTIdm
 L8Y6uH9WWcgmEaZwF5yt/mNSH8avU7T1JJkr2grbvp3ryEquo0mE0WeZBoOYQ+eleHOBdiM+WDR
 xhFpaynYd6YrK90Og5DwnHd/YV7Xxo9NCs6qlmfuwXtVQGa76ij+lArGmNj+c8acehnjtUQsTpK
 pnU2O5p4agZQLg8fTw==
X-Received: by 2002:a05:6512:b86:b0:5a2:b582:2431 with SMTP id
 2adb3069b0e04-5a3efea0c28mr3316381e87.40.1776054801276; Sun, 12 Apr 2026
 21:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260409081546.GB96667@pevik>
 <20260411110405.7330-1-always.starving0@gmail.com>
In-Reply-To: <20260411110405.7330-1-always.starving0@gmail.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Mon, 13 Apr 2026 12:33:08 +0800
X-Gm-Features: AQROBzCQrB2-BxYXzicRzSVGBtzM2E-bxth4Q3cYMdl8BffDVxyCszQdUtkvxoY
Message-ID: <CAE1O6mgFhsT0XP33=8Ji5dJPS5d27Oz8A74wWckcDX0c4LVHxQ@mail.gmail.com>
To: Jinseok Kim <always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] close: add test for double close EBADF
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

On Sat, 11 Apr 2026 at 19:04, Jinseok Kim <always.starving0@gmail.com> wrote:
>
> Verify that calling close() on an already closed file descriptor fails
> with EBADF.
>
> This test adds coverage for a common state transition case where a
> previously valid file descriptor becomes invalid after close().
>
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
> Changes in v2:
> - Add additional test coverage to close02 instead of creating a separate
>   close03 test.
> - Link to v1: https://lore.kernel.org/ltp/20260406133134.17238-2-always.starving0@gmail.com
> ---
>  testcases/kernel/syscalls/close/close02.c | 42 ++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
> index 617c48237..768361e56 100644
> --- a/testcases/kernel/syscalls/close/close02.c
> +++ b/testcases/kernel/syscalls/close/close02.c
> @@ -5,17 +5,51 @@
>   */
>
>  /*\
> - * Call close(-1) and expects it to return EBADF.
> + * Verify :manpage:`close(2)` failure cases:
> + *
> + * 1) close(-1) returns EBADF.
> + * 2) closing the same fd twice returns EBADF on the second call.
>   */
>
>  #include <errno.h>
> +#include <fcntl.h>
> +
>  #include "tst_test.h"
>
> -static void run(void)
> +enum case_type {
> +       INVALID_FD,
> +       DOUBLE_CLOSE,
> +};
> +
> +static struct tcase {
> +       const char *desc;
> +       enum case_type type;
> +} tcases[] = {
> +       { "close(-1)", INVALID_FD },
> +       { "close same fd twice", DOUBLE_CLOSE },
> +};
> +
> +static void verify_close(unsigned int i)
>  {
> -       TST_EXP_FAIL(close(-1), EBADF);
> +       int fd;
> +       struct tcase *tc = &tcases[i];
> +
> +       switch (tc->type) {
> +       case INVALID_FD:
> +               TST_EXP_FAIL(close(-1), EBADF, "%s", tc->desc);
> +               break;
> +
> +       case DOUBLE_CLOSE:
> +               fd = SAFE_OPEN("close02", O_CREAT, 0600);

According to the open(2) man page, the flags argument must include one
of the access modes: O_RDONLY, O_WRONLY, or O_RDWR.

For example:

  fd = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);

With the flag updated to include an access mode (like O_RDWR),
it will look good to me:

Reviewed-by: Li Wang <wangli.ahau@gmail.com>

-- 
Regards,
Li Wang
Email: wangli.ahau@gmail.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

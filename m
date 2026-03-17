Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772E6F3382F
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773741297; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+E3VIeTHW8McJCAIS2+0qZtyEHNog1O2O0dLoiAhZWo=;
 b=iFXQNtX4bID2AxrTE0riZI+vg7M5zaY0GbgozCkKr77I2ZAqcbv5+sVOMJGtBF9ZokclV
 tcOco1DiBR82BzxI4i4yn9BC1BKtHUINyJxUADgrlsEZaltc3TCv0+nfEndfIjFuZ+dh/px
 j4t1Cj3zn0y3fFRNlfV6qud/cAva5Wc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ED433E484D
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:54:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D2113CDD00
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:54:32 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D1AB1000901
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:54:32 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48540355459so52946285e9.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773741272; x=1774346072; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GHgCzO8qOCPrRO81ZACiNPjQ56SM6RwwT4Jy3XGSmUk=;
 b=cVzlVsxgHQ8nAfUj9cME1Cv+DX1W3Oar3LeujgpCM3uPB+segV6Si/iSbxchVATzH8
 HfSapAFfK/Z6L4aEnoY2N63GYWFM+eyblV0iAgEXg+hvodKTjHP/3EGbM5OISsw/uEfu
 sfaj2I2vykK9AJnJOiFIPT1p3Vw4ap2bd8co47uoPjzjIZe4fyo98XBRqAPfiyDKxmnW
 3jkyk2IhsoENpTRH/6hM4YFtDMwqViujwlD1l5ZhJAJF4ooMNSeT4Od/krmo6/yqxiaz
 wfTJdbka9qjFRiYwQv767vwWDFB6OzD2oo949hw7ZGJvZ9VJw1nvyBF2I6+rvLEkcmc7
 rMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773741272; x=1774346072;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHgCzO8qOCPrRO81ZACiNPjQ56SM6RwwT4Jy3XGSmUk=;
 b=nmWVbEI51u2Cl1XvAtCHFhxVuPJePOgPxKZ4XwghtrbWWXDxUIlRFnTKFx2cec1sBA
 7rbwTJmpRvlL+5kVoSbcVArfBlJAaT0TLU3XZtxJrHJMPXgUzLZQlj9/hHkZqJQZQflC
 AWvNHAKfit5jU4bFWAirIbUeqGEpL1nxlWM+6D8efH9FN20s7l4uWpMewGE2uTWCLpC6
 0aO/qdkxlnT8wlPRKihWndLScJonuyHEwH41RoQ+Xy5ZwGanF9cHIrBC99a+Lc6tmaGE
 JaDysL/w2ILy7knu51wzt8snCChWtp+EQnS/gd/unmKa15vblDdd8ODKvEvNI69MHcyH
 CKjA==
X-Gm-Message-State: AOJu0Yyrs40wmMQoBRLKBMvANMQoKfVusGtSdGsjrvZDJcbv+y1OPQvF
 B7v6vnwZZghMUiyQvtGcFmopYD/9hbUQp/hHBU75szAh05A1AfrYhYCrBXsSoqah/yE=
X-Gm-Gg: ATEYQzwUVc4DnAIEK8F3ytL0pjviVMWeXdSsBJ6foccL+ezxsRx1PvAJyxqcWdQ6kDs
 elUCL/nYHfQJtTSS/Im/eSyLtNOGguGaqYNq/aHDWSszoiQ3KOYmB2qVU5ifT9kfwZeQwyAjPFc
 p3M4Xk+PydlO0YvJ5VbbQmdNOuZLjQCqSzrl4HEM0PJPCM1/9L9p8nTt8E8PUgVQRWPzbJL5eSf
 R3owThgMXrDueII5Y/Qd+0dSH01vcBHy22jDPPJy5kKuYmVH1BaT34zN1pVpFFOfauhTTnb0H0l
 pY+EMfMyhelIl6hZmTq03YppiUfVQxFpj9ocN3KupD2tIowL2P/UtgwOBtRsJyZmDjxSRGNMhFI
 TMH/AFTMjx/NJJMOoo4RqNbekV0yzyn9wBt465FKLvHnHTD+AkJtnD2MZf4rkwLmOJCXUvlLxxg
 Qa6XYdzKfO99ksaIy/sWuRsyDZ41DPZvmWOSto05IpGyYkY5PrrvzrVm2NWBRoMw3uNvTuYIatX
 hTy8TJfwhRYoSv8EjWQoY+gzpUUR+OEBSmdgAnOtCmHKLtLpPFj5uWRIIKBI4YgnRI01IPMGC1g
 IBiC9Is/Q2Bt
X-Received: by 2002:a05:600d:6444:20b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-485566d8d8fmr196291915e9.11.1773741271788; 
 Tue, 17 Mar 2026 02:54:31 -0700 (PDT)
Received: from p200300ef2f4fc9002549698ebd81b8fb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaffbbdsm55376885e9.15.2026.03.17.02.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:54:31 -0700 (PDT)
Message-ID: <69b924d7.050a0220.3d315b.23bd@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260317074340.589-1-wegao@suse.com>
Date: Tue, 17 Mar 2026 09:54:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] io_submit04: Add test case for RWF_NOWAIT flag
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Thanks for the patch. I have a few issues to address before this can
be merged.

> diff --git a/include/lapi/aio_abi.h b/include/lapi/aio_abi.h
> +struct iocb_fallback {
> +        uint64_t aio_data;
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +        uint32_t   aio_key;
> +        uint32_t aio_rw_flags;

The struct body uses spaces for indentation instead of tabs. Please
convert to tabs to match the kernel coding style used in other lapi
headers.

> +static void cleanup(void)
> +{
> +   if (fd[0])
> +           SAFE_CLOSE(fd[0]);
> +
> +   if (fd[1])
> +           SAFE_CLOSE(fd[1]);

fd is initialised to {-1, -1}. The check `if (fd[0])` is truthy for
-1, so if setup() aborts before SAFE_PIPE() (e.g. io_setup fails),
cleanup will call SAFE_CLOSE(-1) which fails with EBADF and triggers
a spurious TBROK. Use the standard LTP pattern:

    if (fd[0] != -1)
        SAFE_CLOSE(fd[0]);

    if (fd[1] != -1)
        SAFE_CLOSE(fd[1]);

> +   TEST(tst_syscall(__NR_io_submit, ctx, nr, iocbs));
> +
> +   if (TST_RET == -1 && errno == EOPNOTSUPP) {

After the TEST() macro, use TST_ERR instead of bare errno:

    if (TST_RET == -1 && TST_ERR == EOPNOTSUPP) {

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

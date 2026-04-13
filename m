Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957FDF34C65
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 16:18:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3403F3E4B3B
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 18:17:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B43D3DD13E
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 18:17:38 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E87A60020E
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 18:17:38 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-12c1a170a50so4330851c88.0
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776097057; x=1776701857; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUozfgMij2Ne734+O09C4AuOlj48Go1mDlYuNt7fFzY=;
 b=KK/kXYCw0jsXHa5IJS7IMYHLybH0SW/m1o+7EkdTO05DH3aOdCAvSi4eayS9u577in
 x8O/XvVk9ngU/nIfW2BrW+IXbF324Iy4q8fgSAbd7FqvAdDr/+zPQ2Kf8fT2EbbooENw
 0MwDL20dB77BUYodbHs0V9fX6hlORY09eTOPObbxR3P4dgaqK9vbk+YO4dUQSzwvXUa2
 jWAj8wXyLeRl/B270NhuTiXYM6BEBEaar5QeMFMmIubjuHJjESW5j1qmidtS9YTNvi53
 Ihxtq35iCiPscpM8O01HUUn8PwotS36K/nXxAllOdpLAEVH2Ad3/VMm93KcouzvUW7Fn
 n+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776097057; x=1776701857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qUozfgMij2Ne734+O09C4AuOlj48Go1mDlYuNt7fFzY=;
 b=Maxs05O2kWWW31SDtTJLoNH6QcEjKPZHWibsgqTqkDHL6Wym3qmEGEHENLgm5qYmm2
 dBGbjnwmZeO1Fi6JYv9Eg12LECSxGgBoSgqRVGpSQWJTHpF6qJuqORSYciPDu0Tzw65Q
 v4JAkH86TUbuqsf39OjZV5LW30ynyqohH6lVk7VwguKZUwnDVrHVf/gG7UEhM1nvS8yi
 x4eqNEkdfImGndcujuqrZ902+lk9Z+h40WUqPheZVmOjfxTxHTD3N/2ZkmgNJTEymSRO
 tswP0vX/NrsWrRqeAeput5n5r5v7KS/dv8t08ablYbP27VNgTjgPBPHZbepAKb6bOLDA
 8tTg==
X-Gm-Message-State: AOJu0Yzc8x9pG4h8Dn1DSL5elIXPERJzr75f2BeJI/QieP3fzUPRhBLg
 XSHdcAvsA0ljD8AJhZVLTeGX/DL/YMboKsVXgZ6nvlgbzP+e5DXQIUxX
X-Gm-Gg: AeBDietaDjnuoErlpoQzqODnExHb/zyloiFottjuCZL09RVR++08OMSeWz10mzIPk5h
 p7x7HT0jsptwsmbUiV/lUg9sw4wRl8t9pFyWoXq7qYh4auqpC48zyB08eBJemgZndi2BzN7U/u6
 uEbQAXHiCsHy9cr5BIGRHZ2eCMwoKnrCedPCS+HnE0j9yi/5pKW4ny0sJJYOwdLthAqOdenAf3c
 3i3iGZrXh6SDGtc+wRBGsnpHNRXIPJk/HfeUdL7mV8aIMQtcvVqsiYiwz/eZxBOmyGldrG/Qe1U
 pn8eDmAnUtnt9B0dd4B+YxGHBAQty2oGOrYZ5hTpO9wRQDfFjZQBAPftdoAsExmEiqY6L6JijeE
 6Bz+Hy2IjG6aNo+4YqXs1f6YQdzdtNH2jJLnNa3hd5/N9IZ2PAeL9NxpaPot54Yw8J8oX6/p6BH
 BIvO1tGfcvl51uSilz/MG1FL9XBxemXCwgaG5VbW3BeWjo3cK24xF1LeVuPfEhBdyuQMlVPj6Cy
 1QvapHHSvtVdORhVwGMJul00KT9pRTc4nx0
X-Received: by 2002:a05:7022:6894:b0:128:cf5c:5356 with SMTP id
 a92af1059eb24-12c34e68d6amr8173988c88.5.1776097056535; 
 Mon, 13 Apr 2026 09:17:36 -0700 (PDT)
Received: from
 runnervm35a4x.wipwsgxeb1ru5pjoslepaynzca.dx.internal.cloudapp.net
 ([52.159.225.196]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55faab010sm17309250eec.12.2026.04.13.09.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:17:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Cermak <mcermak@redhat.com>
Date: Mon, 13 Apr 2026 16:17:34 +0000
Message-ID: <20260413161734.3903-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155730.fnnhbyzqmmrxgfur@lida.tpb.lab.eng.brq.redhat.com>
References: <20260413155730.fnnhbyzqmmrxgfur@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Avoid Syscall param clock_settime(tp) points to
 uninitialised byte(s)
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

Hi Martin,

our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

On Mon, 13 Apr 2026, Martin Cermak wrote:
> Subject: [PATCH] Avoid Syscall param clock_settime(tp) points to uninitialised byte(s)

The subject copies the valgrind error message verbatim. Please use
the standard LTP format:

  lib/tst_clocks: fix uninitialized memory in syscall_supported_by_kernel

> -       struct __kernel_timespec foo;
> +       struct __kernel_timespec foo = { 0, };

Fix itself looks correct.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16578D609AE
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 08:22:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7611D3DB54A
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 09:22:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F86A3D91BB
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 09:22:02 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 446CB1BDB708
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 09:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732695719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gC+GzwjYtBRUcBq1qaGLeDm/I1AVQbcqDOiIEtm0qXE=;
 b=EbsjRZSwhyXyApH+ryUxngk83sP/Qh813plvq1HQV0l3QUmSQzZM6Vhaau6hNauYbDsicH
 LrVj3J+Y2kWCge1fRzofEJkDVkaDE65jb1OmUkJWkCV1sAuRaCqarovRC6kUOK3LXlM3XE
 372U+Ln1tw9CUtsT5vSvbEhw8DmuxeA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-K8-m_vi0OHeqmVW_Lc5vUw-1; Wed, 27 Nov 2024 03:21:57 -0500
X-MC-Unique: K8-m_vi0OHeqmVW_Lc5vUw-1
X-Mimecast-MFC-AGG-ID: K8-m_vi0OHeqmVW_Lc5vUw
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ea42039766so6303266a91.3
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 00:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732695715; x=1733300515;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gC+GzwjYtBRUcBq1qaGLeDm/I1AVQbcqDOiIEtm0qXE=;
 b=Cu1hV07InEyd7+oe312d7OCcsqSAAs7Iw4tQUJH0nY2keHR8kgTVTvCVbZnSEjDriW
 6tw8s3AXY3FyGLzD38VjRfF6824WsfcE+CHszdfOdwTMsP1vkyEd6EKwyv1X013O6X1P
 FvASUQJ9r5MHiT+S7sDoGH1WKpVudyvlqarDvslqdu1IgVk913JGMbzWC0RSBUo/gZXF
 n84MNK/0HYpScH1O+MixOo9oxkAKl00fTaOB37UMqKG8L5F4aKSAPLVYrhw4/hF3lKv3
 WQ9IaXG48X/0I8qVjBM2CDhBlyKdM2siFuX+9BU73EZvG9vUrRsJkUM+Eytctxn+TTfQ
 oLtQ==
X-Gm-Message-State: AOJu0YzVWEX8wrjMnxL54LbqUwUT0hGOXHCwLrQA6rVpjfzmRGmBD2v/
 gyKLafuUlMIkQcp15xOLyF452gWEdcNV+t9xUPladwpDQX4SaeLP66Mc2GdlnWu5UePy6aGOqFb
 FVjAE6Eu8V+yCzQIQxFL3K4aZPzYWe6IFbcpMEwb5dYs4HxibL+fRTi7Yb4SxFGHWIiS5DtVF3f
 3AKvP2GYR6wrgUjvfE1wVB8Nqvb2TKIow2+e7H
X-Gm-Gg: ASbGnctAAOduPqe38jo9FAjsj9CsCKuihah7W4Wn35uPkRt/5K/sgfklOuAYJT9qkBh
 IrNGZdmGHpnXPrsFv8KahgDN0dk52NWOF
X-Received: by 2002:a17:90b:4b88:b0:2ea:95ac:54d1 with SMTP id
 98e67ed59e1d1-2ee08ec82c8mr2822557a91.19.1732695714815; 
 Wed, 27 Nov 2024 00:21:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRykg1HoYu2jpQ4Do1kW0wsopEEf5V4vpSwicxfi+nQaF8iHAqr8lwhd5TVBbyJ/jBg7PQTdwmUGFqXCMrvnA=
X-Received: by 2002:a17:90b:4b88:b0:2ea:95ac:54d1 with SMTP id
 98e67ed59e1d1-2ee08ec82c8mr2822541a91.19.1732695714414; Wed, 27 Nov 2024
 00:21:54 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2e3H0w52LKXs+UURdg5dq2bP5dXokWYb98DxHu5qcsOQg@mail.gmail.com>
 <20241127074813.10322-1-liwang@redhat.com>
In-Reply-To: <20241127074813.10322-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Nov 2024 16:21:42 +0800
Message-ID: <CAEemH2eouKe0dzY4Reyhw8xGSJO8Z53oMAK_YvMAErqWyWVUpA@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8alITMVrh05Og_PnerZcX0sMcf8dhHSMC5lTVP5QvBI_1732695716
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Draft PATCH] lib: add TST_DYNAMICAL_RUNTIME option
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Modify starvation.c by adding ".max_runtime = TST_DYNAMICAL_RUNTIME".

Test on general kernel:

# ./starvation
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_stanNtz1s as tmpdir (xfs filesystem)
tst_test.c:1894: TINFO: LTP version: 20240930
tst_test.c:1898: TINFO: Tested kernel: 6.12.0-30.el10.ppc64le #1 SMP Tue
Nov 19 13:50:01 EST 2024 ppc64le
tst_test.c:1718: TINFO: Timeout is decided in running time
../include/tst_timer.h:1102: TINFO: CPU did 120000000 loops in 61797us
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.12.0-30.el10.ppc64le/config'
tst_kconfig.c:531: TINFO: Constraint 'CONFIG_PROVE_LOCKING=y' not satisfied!
tst_kconfig.c:477: TINFO: Variables:
tst_kconfig.c:495: TINFO:  CONFIG_PROVE_LOCKING=n
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.12.0-30.el10.ppc64le/config'
tst_kconfig.c:531: TINFO: Constraint 'CONFIG_LOCKDEP=y' not satisfied!
tst_kconfig.c:477: TINFO: Variables:
tst_kconfig.c:486: TINFO:  CONFIG_LOCKDEP Undefined
...
tst_test.c:1729: TINFO: Timeout per run is 0h 01m 31s
starvation.c:98: TINFO: Setting affinity to CPU 0
starvation.c:146: TPASS: Haven't reproduced scheduler starvation.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

Test on debug-kernel:

# ./starvation
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staVKoH2k as tmpdir (xfs filesystem)
tst_test.c:1898: TINFO: LTP version: 20240930
tst_test.c:1902: TINFO: Tested kernel: 6.12.0-30.el10.ppc64le+debug #1 SMP
Tue Nov 19 13:41:20 EST 2024 ppc64le
tst_test.c:1718: TINFO: Timeout is decided in running time
../include/tst_timer.h:1102: TINFO: CPU did 120000000 loops in 68663us
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.12.0-30.el10.ppc64le+debug/config'
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.12.0-30.el10.ppc64le+debug/config'
...
tst_test.c:1733: TINFO: Timeout per run is 0h 18m 38s
starvation.c:71: TINFO: Setting affinity to CPU 0
starvation.c:116: TPASS: Haven't reproduced scheduler starvation.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0


Li Wang <liwang@redhat.com> wrote:


> +static inline int tst_kconfig_debug_matches(void)
> +{
> +       int i, num = 1;
> +
> +       for (i = 0; tst_kconf_debug_options[i][0] != NULL; i++)
> +               num += tst_kconfig_check(tst_kconf_debug_options[i]);
>

This should be: num += !tst_kconfig_check(tst_kconf_debug_options[i]);


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

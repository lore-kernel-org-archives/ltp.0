Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323E1C9830C
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 03:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768791650; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+g4GDd+CQcTLulPnTd/C7Uhw7eFi/AOMJdFwDQWY1RE=;
 b=CjMIYJmAMFwlb2j+vubnZxRlnTcIhzyPHdV5KTh/PVVZFW8q0WAGRZtF9/r1dkVUPBemQ
 UfMtMwlfnXTODY2clkPAqVCr+UvHVpZJavzanTKQY9LwvMOlJz07MHaE5aqiUp+zpUMlK6e
 QuujAdYmNR8bQ1Ye1nWtfeed0lBZxnE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44E4C3C61C5
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 04:00:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98EC43C2EC4
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 04:00:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 090AA600673
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 04:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768791624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T1f2KBos8LC/ZJh7E9aWKe23Hu+IMFssken2sLnEpqw=;
 b=RzigR/U4tL6teDryUZx2ZP32FlJppDKapLmX7IA7TgSg03/Z8qWUGIrZyqgFmKFMZ55dI5
 sVN/HvBu3EZzfF6TnL0hUsoptDkvzsfEGqEBG3dk+TPwskJAOB4iBBslvhGLMu022U/7OE
 eusxFcP3jo2sEMMjRLedpHLOv6xo0Vg=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-UDInHGTTNoish4RBGcelRA-1; Sun, 18 Jan 2026 22:00:21 -0500
X-MC-Unique: UDInHGTTNoish4RBGcelRA-1
X-Mimecast-MFC-AGG-ID: UDInHGTTNoish4RBGcelRA_1768791620
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b6ad399cd8so1548350eec.1
 for <ltp@lists.linux.it>; Sun, 18 Jan 2026 19:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768791620; x=1769396420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1f2KBos8LC/ZJh7E9aWKe23Hu+IMFssken2sLnEpqw=;
 b=Sx1nP2ukPtRG6caVF9YGS1Pkghb+NR9gHy9lA/a4w9i/CwFdycd6gHC1V6cH9ID4rT
 3puPJZlgA7v0px+5h+GE/u5SxQsPkyNfp3c8AUU/iSU2Ax/dlst/GZN3sKNxPiSanMeS
 GmN3+1FmGqbLo8NtlQZcp1QUvywnqcvMi0Bbx7pc2BVoGLzdhP2+s81pW8B2obvvKVbn
 pCL8kY5e/Iei/pnbg/Rp8YetfLC7/pyRrCPgKUMksNVwloQRpy9Jzh9p5JL7oucBjkhh
 1fQZkZo1p9AASRiHZTL5LUzcDVZwsPStg6btgC9Bb6YeiMwSZ6y9AI3j017PI26T3lap
 N27g==
X-Gm-Message-State: AOJu0YwPJprXPozqTVKqO+k7S0wtiRvQZxNp3xXleAMvtGq99w8wwuJf
 MFhf/SO+VOvfzZ6FCeiP0EZVJnqYghM0rwGEKPuhpKJ/SKckLLIMWYT3X9KqwNFI3fqKXmKH8yj
 ch0vmdPiAcwQuBWuciYDcGjdFKJYcqMZjUxWfjeKXzXg0wcdrrFlHvP+NIRwdioH7jD/Q/uHEjo
 6msHk53T7Na1vUYSaEHgqXorf4MrM=
X-Gm-Gg: AY/fxX76oqq5Nh1iMzXo4G+vzlBThNKkf463iailGGJr8ITKQsgr1qNJgtgUsxz/3NX
 lqcuOgcBpv7KLheL/1EWrgsB/JlPAUZ01cmzt7IoCY/gMLSlC8CXBZkXakZYPA+8mL+PnNVh4D0
 WV/QE0qjBtL+7hVathuHTdqTLwI5ohanSu9Am9jHYTmuPW23Lip6LZKKfjAzJ7nxVdtQU=
X-Received: by 2002:a05:7300:541:b0:2b0:57ec:d1a6 with SMTP id
 5a478bee46e88-2b6b4e2863emr6594387eec.8.1768791620045; 
 Sun, 18 Jan 2026 19:00:20 -0800 (PST)
X-Received: by 2002:a05:7300:541:b0:2b0:57ec:d1a6 with SMTP id
 5a478bee46e88-2b6b4e2863emr6594372eec.8.1768791619427; Sun, 18 Jan 2026
 19:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-4-wegao@suse.com>
 <CAEemH2eS1guKHV+MSSuCb5KPWRe7km_u0rYr99gEUybXdeJFpA@mail.gmail.com>
 <aWuLke3rmststr0n@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aWuLke3rmststr0n@autotest-wegao.qe.prg2.suse.org>
Date: Mon, 19 Jan 2026 11:00:07 +0800
X-Gm-Features: AZwV_QgbwYcMOLQO9vnzL5D9CZX228r8zhj_q24zVhkb8BoQSuDNQHtiD4ejguE
Message-ID: <CAEemH2f2s+LyRk_viTEhra989Ko5aeeHEUM5vULopyZE0bMvVw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: THJ2xHcCW4YnAw39NjeNj1x-T59CLfCfXB5FmORis5g_1768791620
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 3/4] ioctl_loop01.c: Add new support .needs_cmds
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao <wegao@suse.com> wrote:


>
> > Can we just reuse the 'tst_test->needs_cmds.present' result?
> >
> You cannot access tst_test->needs_cmds.present directly as if it were a
> single variable,
> because needs_cmds is an array (a list) of structures. To get the status
> of a specific command
> like "parted", you must iterate through that list to find the entry
> matching that name.
>

So how about using:  tst_test->needs_cmds[0].present?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

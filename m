Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BBBC369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745935799; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5IBcUuYNU6inITaScO0nw6fd4Na3GGPT3OBVYxADhY0=;
 b=ecwGu8Z5l0dOXMc9M1oaGXanXXv1FBHG1I71TdUgyYzEYJQH2Tv4LaXW9t4p6dL8QGBZ/
 Y+AB0zpPCrPYzct+DlGZFrtsp+w6IyalEQElhjrZtWoVfNqyh0Aqz1ChHJ9/gOQCrGqdsy5
 rOK+Qde3fWQfQNZ4iDwiw3n4eLF39ho=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3ABE3CBC1D
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 16:09:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FD2A3CA6C9
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 16:09:35 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 595F01A00CA9
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 16:09:33 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso26827645e9.0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745935773; x=1746540573; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MySOF1WUkvU2+CB+o8lSn7eE85MHba1b/bxinFdngLk=;
 b=dyiIc6RnA5PbcMhbtKt1q5stzZIjwqqhKu9WcvsQDd9eICt3xKqgvVe+LTP0FtfjQi
 52FVqXBBw+hK+70rj7MphuP/8G5XPmMUeP3oqxamdUYUGDqqYtDm3XEaYKaerkIeLA4Y
 xlP6iiMxCzOQDAztQivASk3xwRl6SHPXhn66DvKMJd3cevhWj4q7YLIiIbpGGSUFTbDJ
 nF2Sa4/WcR1OxtDVKpDw/m78bih8jqn0Lj7+xI1EGgZlrrWUE7Bh8EJ0l0t/F6Hro0QE
 Z0kG9F0uauiwWc6kMFFJzSB0Czo3N7mTfU+G1fkTMVZZ4S/0MwMlcEXEsWtk5dNTgjVm
 um3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935773; x=1746540573;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MySOF1WUkvU2+CB+o8lSn7eE85MHba1b/bxinFdngLk=;
 b=HuW1r33BeL/dDt8QQ4kbMFghOqpBBa4RclxO9solkQoVykaPQ21ktYk3+g13O7ZlqN
 lBaE2JlPeU1yflhHTaej2pVNknWmXH8K/qd3wJxDksadKvvMsNkHWGjao1/2ES9ZEaxj
 K0Uw7lugY/v6Mtp6Da7UDNRenfcpMEzTOfgcaxumK8xAILMUjNxoDkW8lPTpZHzqFxfw
 dpWDPsgLaEVaD9xxC80jWqM0iha8A13deMKfJlBKPbuoHCGH1TdeYfKoctJi3RVygPcO
 UEXP+igAbsAFKhLKoNi5WwDILsuy1gaUQ//ter45/3fcaxYwjWgE4EU3gQrBF6k2ZIMy
 GdKA==
X-Gm-Message-State: AOJu0YxIuKkWhv4TtZ3HavquwM5hea+qPfFQkIEmM1rS7MXhmcYK4Hcm
 PLKR8/mPpzapXYLm9U5yuM1kUcPOIqjQ4EcHM70imntWrm9wwdGrLvvwTBapBmQ=
X-Gm-Gg: ASbGnctsrbXVZ6UgJ19vVUkVVTkCvqgunx8TAFcI98KZyXH3zs9Wd+IR9U92qcb5lSa
 Q1pdm/78PD9Ksk7TwEDqCcYwmGWdnEQbNvP8qPIrXtyDr86u8xcWmyZJDP5t30x/gIiKN0LSbCb
 k12ITgvAdUfNTZuXey7SNYvcSAuNugmNSeY8W/O+3A16uUTrr4RKMVL576eK9Hl+jgIcqipk5FG
 k7zxUlIBPKRx33wX1XRVc2dSEv2mtio+vljRs9X9wzBsWUDh7E4FEPg0E5TFoq2/BZnvUNbGHoa
 3JYBKi3M29monHhijmIGrQpJX1xmjw==
X-Google-Smtp-Source: AGHT+IH7UjMCY4XlkQl03XDCMpvBvImsbJYWbb/N9/kRrJD1G4vIUkDYTcPmNq7Ks/v5Wf1LRTMUBg==
X-Received: by 2002:a5d:64a3:0:b0:3a0:8429:a2e2 with SMTP id
 ffacd0b85a97d-3a08a370f14mr2674468f8f.32.1745935772656; 
 Tue, 29 Apr 2025 07:09:32 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db50e7a56sm102386795ad.121.2025.04.29.07.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 07:09:32 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 29 Apr 2025 11:09:27 -0300
Message-Id: <D9J6KR1AW3OF.18BAD4S0DNZZJ@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250408-conversions-modify_ldt-v8-0-7bdba108f64a@suse.com>
 <20250408-conversions-modify_ldt-v8-2-7bdba108f64a@suse.com>
 <aBDbX26nPXWU3G-r@yuki.lan>
In-Reply-To: <aBDbX26nPXWU3G-r@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/3] syscalls/modify_ldt02: Refactor into new
 API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Apr 29, 2025 at 10:59 AM -03, Cyril Hrubis wrote:
> Hi!
> The patch looks good, however for the sake of metadata I would like to
> get my patch to the test library merged:
>
> http://patchwork.ozlabs.org/project/ltp/patch/20250429135542.19680-1-chrubis@suse.cz/
>
> And then use the pattern described in the patch example to disable the
> test on non x86 hardware.
>
> And the same applies to the second patch.
>
> Also no need to resend, I will fix that before applying these patches
> if my patch gets in.

Understood, but please note I sent a v9 already.

Thank you!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73536FF885E
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777290653; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=zmlB86c1FFMUdiR/r6wqZ8PyeB3o5TgY+D/xcihfZVM=;
 b=cSetP+yI9Xt0H8MMIw/cBIbzNbHz/rKOvwOIUtEjlE4rjB5zR5SqjH4ZuXYl4lR4XJ9tq
 DirH2PXoGUdW2N7Ujoi1FC4oVtgRqM2fc1q56hNvO7oiawAIHSw3GgFL3vAqSf53RcC3xdn
 B5pM9RDZyjupOXqSuaecD6YUV7ULfQo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8894F3D0F4D
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 13:50:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 708BF3C9F01
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 13:50:30 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DABDF2001CB
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 13:50:29 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so9990160f8f.0
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777290629; x=1777895429; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KPjeo64y9L8sibaFmjq0AYxM60A25AMHeArPEYzTges=;
 b=ACbMVQqPQfzvN7V1OqtcUOSxRQHqfuRXazouzupB4TXCh4tnjNY/AOSfdxTnlLI6r4
 lZycVmz4fQxRJD+t4nFiBDhZTBlmW4Q90c9THoUE/2lRtP2XIwFtSGssrrdLXnVe+FLi
 MoYzMo8Zw6B4u6b04Oq9NECFFdKq2sgtKBt3ygaSjAVJHeXqPq5h9v7losCak64bUEMp
 w32ycTSlL99wuKmt49BDqy4AZ71MNF2R/JPogaw361Xtr7b2g6Ii49qirPZuL2j7fKlm
 hPduztJ4le+FVLG5HeDbIpYrzOdxyOEkdS/Y86dekaL10pFk7hcnPrqq8fncUJLsIhcb
 dshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777290629; x=1777895429;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPjeo64y9L8sibaFmjq0AYxM60A25AMHeArPEYzTges=;
 b=Ul4gLrOCMYtaNN30KLgtzIkfHa8Vr1i8wz58Y/OaFM3rr2PyvBxKOP7g4781SF36PH
 WOfIhORC11D/nkc/u1QqGD7dG0fOxKrFZ5DEaRxNStLiswP4jmpPp2QvMDaomfZ9YwHR
 VmfKIpBjSig7v9q4em6bCjz/pj8Bz08uiUSU7aU8Ru3CqQXWBupOhm2qGqppGnH6aJBa
 68yW6ANZjilNpsLatDSzVmCi4KchdJSzgMgIFohpWpXnSzClApLfp+HN4yRDDhXo41ri
 P0N2McknsKcnhLgruGeiU8Nqpa8YeSG1TAs+wXgbY0SMB360t/vSPZiG4tmzLGysLCqH
 VS8w==
X-Gm-Message-State: AOJu0YzazJJpeTnKhFufxdNRURO3wy2G5E9Jhhlk4lsTKzKo/B9AWodO
 8xV7uRpfzsV+zaQHSW2yx0QBNBCBmnxRgdPbGaDbXKxX5fQCnsiQdzscBfDATlXK9kI=
X-Gm-Gg: AeBDieuw1cg2E9ht2XjcwSsQyZQhtrmv6SH/ez5ACmgpXvtB99rxlKfFYr1bp/ycRyC
 xSpQ8xOwW2gRrDvBemi0K6PnopFsEMxCn4Xoj6joj12NVFoNGEV0SiLb28Bs7OklvsVF4eJIQOq
 5X/VhWwnXa1Ce4UDYD/Hij7nuEYLFupTzbHXvQw2s1JWTEYQdqLLS9UYsEAak26aqRqalgwdSXk
 BhLVR25mN1PbeC4s+XD1llPUoXJze1LPLIGR6K0yisFubwzVxY2f3Wn37qUHKM8dhebmRJ1cQ1K
 rRi2QnCkgy1Bz+mQSCZqqid0FYtjefnxQxui50Ff/KFHhU2GtwxxszOKP/xrQsDGz5Tc1ZqMYtl
 yBVkNBl5GXdLRbpsZ5U4yC3JaySgz+gz/6cZvEIb5QCdEIrZaiOh2rU9TPa6Rb9O8k6JaC0oy/V
 hevH7Q2vIjlJSz7CyQ1kADC77spitsSf78E2vvDorZqeJLqEHIymbOFzEGfA==
X-Received: by 2002:a05:6000:22c5:b0:43c:ef4f:79dc with SMTP id
 ffacd0b85a97d-43fe3db9b0emr65074660f8f.8.1777290629174; 
 Mon, 27 Apr 2026 04:50:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4daf2sm77691514f8f.33.2026.04.27.04.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 04:50:28 -0700 (PDT)
Message-ID: <69ef4d84.5d0a0220.3bf6a8.26b0@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260408132728.653586-2-piotr.kubaj@intel.com>
Date: Mon, 27 Apr 2026 11:50:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> +				interrupts[i] = strtoull(ptr, &endptr, 10);
> +
> +				if (ptr == endptr)
> +					tst_brk(TBROK, "CPU %d: interrupt not found", nproc);
> +
> +				if (errno == ERANGE)
> +					tst_brk(TBROK, "CPU %d: interrupt out of range", nproc);

`nproc` inside tst_brk() is wrong, we should use `i`, otherwise we see
a wrong error message.

> +static void run(void)
> +{
> +	for (int i = 0; i < tz_counter; i++) {
> +		if (x86_pkg_temp_tz[i]) {
> +			read_interrupts(interrupt_init);
> +			test_zone(i);
> +			read_interrupts(interrupt_later);
> +			for (int j = 0; j < nproc; j++) {
> +				if (interrupt_later[j] < interrupt_init[j])
> +					tst_res(TFAIL, "CPU %d interrupt counter: %" PRIu64 " (previous: %" PRIu64 ")",
> +						j, interrupt_later[j], interrupt_init[j]);
> +			}
> +			if (temp <= temp_high)
> +				tst_res(TFAIL, "Zone temperature is not rising as expected");
> +			else
> +				tst_res(TPASS, "x86 package thermal interrupt triggered");

The interrupt check only flags TFAIL when counters decrease (< ), but
never verifies they actually increased. If no new interrupts were
triggered (counters stay the same), the test still passes as long as
temperature rose. The condition should use <= to catch the "no increase"
case, and the TPASS should reflect that interrupts were verified, not
just temperature.

The rest LGTM.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

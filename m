Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6DA606A31C
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Occ8J54b;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m41qr9s5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795007914; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rVP4y/Fyj1kr2YQcP6OJqTxRgRTSSxRNyuQpta8nvlY=;
 b=Occ8J54bSgzqqeRdHOSo3YL5a8z6OCaM7Jd976CgZ2Xpiw56pWrdzbMwKmXvz4MNRwdDA
 DZhSNAD3YhuZ1I5dzezSoR2YedUs9BP05d97WrCZYTnEXUuAZuNlpaPkxc+SwGOKSyaT/ou
 pUT7T9vQi1iK0yQ4IcH+ZGw0siY+oEM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BD693C0960
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 14:18:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4B493E9332
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 14:18:13 +0100 (CET)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FA37200245
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 14:18:13 +0100 (CET)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-8a065e2933fso1241638b3a.3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 05:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795007891; x=1795612691; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lHgPNr+CGt2oXh535tsKAkUlt/th1dyW2Of2XybCAyE=;
 b=m41qr9s5eOnoty3RywMj9aRz/saeOQ66N380pe+HkD5/NWZCGgtT9opMT+omaolu4s
 W89li+neT6UHZwqBb+pz6bIpacvqGXE+D7iobEkNw+8CzW4dVRc7RCYEUATTv0CHi+mx
 8NSWeFdmeyEl1PhmVsqpPVERrjUkHoz0u/zXe1KVDzEfnDIgACxTsOYaDbkfaUXnOd7F
 pmTo6Xj4xK8+Rz1GSPeImlhGbJP9H223sprE/d6t59nMqrsxaSlRAftfqu0XsUp23sZX
 NK3+YSZ+GnVmPwc9shS6Um+X6s8SSdI2RijQ71NUaHVOtJu+2Ik80mwal2ajXNLC+smH
 X3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007891; x=1795612691;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHgPNr+CGt2oXh535tsKAkUlt/th1dyW2Of2XybCAyE=;
 b=kF+u8nzzl1EKUGPD3/BhUcreruFwwIfTfk23+qN8nUNm54MKIsuJArBizyZO/Xj/pk
 uJ0gWTp4To/+q/9/ISmlxYDiwl/nZvoRPvpnlUJw8j1n7hcNmZbBQt660YYRX4ujEbWE
 ND+o8DnI4ixoUt0boEIcy9NB9E7iV9mVA3A/NNnyQIQUOtUbDh56uRi9HRbw4cEwULC3
 YMmM2mDNRhnjCLWgNsuV+m45WUUyg6EkbMjYKfbpJ9ZQ2ZiZad/B/wNqsAoawjQdWM9X
 EgQkaTf5D389P6D4V3QMYPDctRUyAI+He6n2Jk4oDn7A6DnzIZ2yBjZgoS28k4cJlmcE
 e+Uw==
X-Gm-Message-State: APuU4Z+iDywnQy9BZWNapgW1Oi8rhu1nWpAFK1Ai4discWTzmQV/j5EC
 EHMp3jKGuifMQWZK9NyKvu0vgNW9sbtJHUyNxYfXH4HrdIc19DQP3dmf6GU7d+jKXWhyKOFV/dI
 cLQ==
X-Received: from pffm11-n1.prod.google.com
 ([2002:a05:6a00:c30b:10b0:8c5:614:d2c8])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a244:b0:892:e080:4ed8
 with SMTP id d2e1a72fcca58-8c5d48d82b8mr2286130b3a.47.1795007890954; Wed, 18
 Nov 2026 05:18:10 -0800 (PST)
Date: Wed, 18 Nov 2026 13:18:08 +0000
In-Reply-To: <av16AqIo5sj10FEv@yuki.lan>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117235848.2975548-1-wakel@google.com>
 <20261118044914.3815-1-linuxtestproject.agent@gmail.com>
 <av16AqIo5sj10FEv@yuki.lan>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118131808.682117-1-wakel@google.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sys_rtc01: Report TCONF on system time mismatch when
 STA_UNSYNC is set
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hmm, I guess that the logic should be the other way, if STA_UNSYNC is
> not set the clock was modified by NTP and the test should be skipped:

I think the logic in 3d11e5dd622e as applied is the right way around;
inverting it would bring back the failure this patch fixes.

In kernel/time/ntp.c, the kernel writes the system time back to the RTC
only while STA_UNSYNC is clear: sync_hw_clock() returns early if
!ntp_synced(), and do_adjtimex() queues sync_work via
ntp_notify_cmos_timer() once an NTP daemon clears STA_UNSYNC. With
CONFIG_RTC_SYSTOHC=y on a writable RTC, the NTP-corrected time is
written to the RTC within a few seconds and then every 11 minutes, so
since_epoch is expected to match system time. (That is also how
leapsec01 ended up writing its fake 23:59:58 into rtc0 when it cleared
STA_UNSYNC [1].)

Conversely, STA_UNSYNC set is the state where nothing keeps the RTC in
sync: it is set at boot, and every clock_settime(), settimeofday(), or
ADJ_SETOFFSET sets it again via ntp_clear(). On Android test devices,
for example, the harness sets the clock with date(1) after boot and no
NTP daemon clears STA_UNSYNC, so rtc0 stays at its boot-time offset
("diff 24441s > slack 10s"). chronyd without rtcsync behaves the same
way: it disciplines the system clock while leaving STA_UNSYNC set. With
the inverted check, all of these would hit TFAIL again, while systems
actively syncing the RTC via SYSTOHC would report TCONF.

The reviewer is right on two limitations:
1. When STA_UNSYNC is set, userspace cannot tell a broken RTC apart
   from a system clock stepped after boot, though the since_epoch vs
   date/time check still runs on all systems.
2. When STA_UNSYNC is clear, the RTC can still diverge if
   CONFIG_RTC_SYSTOHC is disabled (or points to a different RTC), or if
   the RTC driver is read-only / does not support set_time.

Do you think it is worth sending a follow-up to also check
CONFIG_RTC_SYSTOHC / CONFIG_RTC_SYSTOHC_DEVICE (when kernel config is
available), or would you prefer to keep 3d11e5dd622e as-is and just
note the read-only / non-SYSTOHC case in the comment?

[1] https://lore.kernel.org/ltp/20261116064205.2360040-1-wakel@google.com/

Best regards,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

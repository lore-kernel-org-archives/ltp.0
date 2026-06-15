Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB30DCD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:07:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4E373E5F8C
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:07:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 993143E2037
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:50 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 352941400069
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:50 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-307631dbfedso7842428eec.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546808; x=1782151608; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9f+qVTk0zv9sP3F0+XsS5kCFy3r4atfveCx7QBixd8Y=;
 b=LufsBJZRa0GoJfkbZy0brSxEjG7j2+wPvi6vhC2atWq/uICTqHpcgJ/UnpdkgbJ7G9
 pKiWI5qyRIDKRdoUSlIoQ6hT7+WxZlLUbPsJ38uqYpVXDLTwLWLMhWctk3RuPl7zAz2j
 4s5IzAVg633C3X5Yj1j5UyJmcSD16aPTocCnH7uM+bvBsPabP9IZHugXjdGluEnVv/8e
 cyJzUaOFSL0jKopkKuqHUPi04C8eW3m+Vvwr4YanI9TgovNS46mhgT4qfMdA1OUls9oC
 39ifeC2Jbwp/9zzRwHUfiTzZZAWmrv0P8XuBSVV9P0S/VWJAN6FzA6p/aGCRQp1adgoi
 9AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546808; x=1782151608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9f+qVTk0zv9sP3F0+XsS5kCFy3r4atfveCx7QBixd8Y=;
 b=ZzUa8WBecHPm0vmAaxBvRF6MiJUdHfp5h6MyF3G1hLt0iZ/tSPCex3kiCgfYiNcM+8
 S+B2PhEX4SLshVclictFU4RyOFfZIFuCW8AC1AG3pinDQaz40Ynx12nmM9rRl+zlnc6i
 FyPMM45z0AK3zKf9zL72wUAgMKf0lRCkqLNs+BiNrvwnVdiDH3UTDwJAtG+RUf7ZFTlz
 vKAdwTF3m4ppY70lssBSGzDeoRTs15oQbWw8vbjmfZVTG6IKHKrAaBVUS8mOYll0n4uQ
 3zv0udr0comSJjtpt/+pFiBlnafOmn8olQq5SYWTWiYBAQB7zGwkLk606iqffgEzRYZt
 rJ3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Wjo4kIHfnBDeXRmjgx/k37RZnh5OZZbTMRghbOjndoHhDMO0l/ihoKLs8Q4/QkMTrhT8=@lists.linux.it
X-Gm-Message-State: AOJu0Yyyzdwvj+0GljFPWaLiMrSAYYWq80wa5vCLkjhGsJkpXzbb0nIJ
 B6CFDCzwLAaPpE5MeiTm5OL+XLMgmTM8xghxp2OyWdGAebA+E1AzBkXc
X-Gm-Gg: Acq92OFHvHuLG8FBBUQTkhrMSGPWss+pJmtwR4V3OReIlJ3PNwiW3eIN0/sFKQ1eyFq
 2//y9dDLhK0yq4LPi/JdoYFxWZITAqbg09TanpOJ9+twdfqo1KfO2obu8vo5RC/d05sH+I0fe4y
 PHX8BWixsj+V6DZyAWAHjTVqf/OyC4AMOqi6xigavT6vE8YBsp92WEu4vSp8Mf7Fyk4PjpEiKmq
 3vbdz4WTKx6zYePUQRpvB7bU8McaK7VhfKhHhSluLIMOGJN8D1wX1oBGI3zyWCJuiYEPuJUD+7H
 fo6cC6zQ4SaTqI1BSEEfgYdgdgFMb1saOdsPTKdGKjDOI1aKM2S7aoe/hDxU5DC9hjnYYmb0xp5
 hFowoKa3qjk2Du66xdMWUEXK+MguzU+G+EqJuvmHVCr7tUM3d7ee/JBqYlZ4I65W1r8le0Ypmwd
 FYRbYlZ5MsYxE5XFy5
X-Received: by 2002:a05:7301:4b03:b0:30b:6181:4749 with SMTP id
 5a478bee46e88-30ba5f6515bmr182294eec.16.1781546808373; 
 Mon, 15 Jun 2026 11:06:48 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea4f7a0sm14352840eec.24.2026.06.15.11.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:06:48 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Tue, 16 Jun 2026 02:06:24 +0800
Message-ID: <20260615180629.7148-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] fanotify: update pidfd tests for FAN_REPORT_TID
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch set updates fanotify pidfd tests for the kernel change that
adds FAN_REPORT_PIDFD support together with FAN_REPORT_TID.

Link: https://lore.kernel.org/lkml/20260607003343.425939-1-anonymemeow@gmail.com/

---

Sorry for the late reply, I accidentally broke my system last week,
so I was busy repairing it. And I may not be able to respond in time
due to final exams this week, sorry.

---

AnonymeMeow (5):
  fanotify20: Allow FAN_REPORT_PIDFD with FAN_REPORT_TID on v7.2+
  fanotify21: Stop relying on exited child for pidfd error
  fanotify21: Simplify read_pidfd_fdinfo()
  fanotify21: Add test variants for FAN_REPORT_TID
  fanotify21: Add FAN_REPORT_TID pidfd coverage

 include/lapi/pidfd.h                          |   4 +
 .../kernel/syscalls/fanotify/fanotify20.c     |  19 +-
 .../kernel/syscalls/fanotify/fanotify21.c     | 191 +++++++++++-------
 3 files changed, 136 insertions(+), 78 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

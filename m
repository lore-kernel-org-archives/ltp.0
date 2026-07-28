Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D00AC53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785245580; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+DN61LRo4HYnEhsieJWevbJIFDSZUo2j6yfIt5EaQkc=;
 b=L/5njdxgVoexEjpsWSphjRKWsWDDRoKQgx53RhsPWtUKWXIhDH8H4Sktf1xJUGsA38qTY
 wXoppzGhIaR7tSxI6m5x+Hum96Y0f/q7wQJm5w48sdRkobvJ1oeIt0G5G9rB1MT/QDnHLG+
 /R9rCpr7jH99cwhD15q6SR+2YP5MpXo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 446693E749D
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:33:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE56B3C0169
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:32:38 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BECDF6005C1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:32:35 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47362928f65so3672481f8f.2
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785245555; x=1785850355; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jdGQZoXhv0ZE/PhTQDrs5hWJ7QGBBuQ8LUfsAeTKXqs=;
 b=Z6QEcsEwfzAes1RiCs1AOEPQZhLXoketKlHWy9eWOz4KO7S+pH8UIVu2uAMRob5C9r
 dksLCyziOttRPnM67cpNCrG/ucalfwGTsyN3dZ80+19OVBWPeSEW5N70ZekQQ+NtXkpC
 uD7B1ttv9ZvcxMtFNWUGXD5iFgY7RNMwML2ZPuS3m3vmakrALzxc+Aab+4/0DZwWZSe4
 L3lJEUPncKQjfwILPUZMoUKYWM/7jnZxrmEfvqN3lY2K4Q9LvTHvtX2japISUGzlxJNA
 CPrCVmcdap7ZVS8MV/rYMiSMR7SiQ7cWFm13PYXECIcSBOd3QDpQ30eMZqtv+vPOsn/I
 x6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785245555; x=1785850355;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jdGQZoXhv0ZE/PhTQDrs5hWJ7QGBBuQ8LUfsAeTKXqs=;
 b=PD+/FOj1l+3jBWCM8ZwRJWv18brgcH8kxpArROKBpFdUgFJZIxS9Xs0F1OJcjKEv4K
 IbKNFjvaQdEYVxcJqSExpq/0YaW6NlIHYyNU6qn11diWr+fWHl20ZQIJGQ4c6wvAGTYx
 3aH8u07fe7DZcL6siMS29811p9QZ1KQxwxGKKNozcMQ/ye8ZbguWYY4IYN8QnONwmTS+
 nH7f5/xLUZdhBGMDSZfyAAKKhqQ2HW1LwMjrkpaatZCOZP6w2eGgqXruxnAxmsKp5PUt
 AUOYLsEXh2/CwG200ZYhxB8CSeLk2mFcKekr/+5rUxHvTfoTtU0/K58yWwIa97UiWGw7
 EC7Q==
X-Gm-Message-State: AOJu0YyQLx+cKd93ovsjmfwkS2gGrqUhY4vRFdCuTOL0jjS19dInzhax
 CyeFYv23Lhi/E9eE+L8vkCBvOZsKj7PxLR2DViw1q/gXMpqhVBa5B8IoWyCwPAw8BAakVYjWaBv
 IF2ztjI7o5w==
X-Gm-Gg: AR+sD109VfmfSYOVhggZg/yx9X7Mdm/ONv1U0io3ikyni+dDz/rn5XxiWQ5XTpZk9gs
 8Ps6ByjAYQJly91XHo+/iVNqfBjfLnClxrUscUyZnZyHbw6Vo60f83AOYWmLqAPzQSCBS4xIgvQ
 M42+TXcxJlvcWCE7OiXuLCTPKCyntAhqzF3b8g+2Kj1v/TWJsZarKBt6aji6xArOAXQeRMTaPuG
 PWN5rTaGBLye1ZR9WYYaOgGy6v1stkbXnSPvQrr+l2L1du65vTcn7apZ++n+qWhHjWE1Wtz/Hgx
 Htvi/TOSTKBBgmttbJiTofq5Z+qxqXxVoZSvRA7yYsYstc/JOarKR4Il6YyMd9INbYh85Jzu4Sz
 ZdA7R2izI2iesRECaVYdOLI9BSGiIeu7/Qgcr6c3c2PjnsuBL7y85U3OuVLP35ZXdm0Fj0rSHsR
 T7t8r3XzJsOhI5usWy5JOiICA/Qs6URKMP
X-Received: by 2002:a5d:64e9:0:b0:47d:eee8:ec40 with SMTP id
 ffacd0b85a97d-47fb1f103f9mr2740398f8f.38.1785245555091; 
 Tue, 28 Jul 2026 06:32:35 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fa9sm60441582f8f.20.2026.07.28.06.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:32:34 -0700 (PDT)
Message-ID: <6a68af72.b682100b.f12c1.0bc9@mx.google.com>
To: "Samir Mulani" <samir@linux.ibm.com>
In-Reply-To: <20260722114047.54671-1-samir@linux.ibm.com>
Date: Tue, 28 Jul 2026 13:32:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] sched/cfs-scheduler: Fix 'make check' errors
 and warnings in hackbench.c.
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
Cc: Samir Mulani <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Samir,

> Link: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/ #v1
> Link: https://lore.kernel.org/ltp/20260412122842.1074017-1-samir@linux.ibm.com/ #v2
> Link: https://lore.kernel.org/ltp/20260602095656.404290-1-samir@linux.ibm.com/ #v3

This should never be part of the commit message, but stay in the `---`
section below.

The rest LGTM, but you have missed a couple of warnings:

CHECK testcases/kernel/sched/cfs-scheduler/hackbench.c
hackbench.c:82: WARNING: Prefer using '"%s...", __func__' to using 'fdpair', this function's name, in a string
hackbench.c:93: WARNING: Prefer using '"%s...", __func__' to using 'ready', this function's name, in a string
hackbench.c:310: WARNING: Prefer using '"%s...", __func__' to using 'main', this function's name, in a string

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

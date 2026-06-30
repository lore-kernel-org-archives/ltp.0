Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24560C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782817090; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3EzIA8AutrvmKkQjyODNJCVsQXdmZ9a5I9EI7Wpo8Q4=;
 b=Y0W5nFGKh570PnrVtQzBm0Ko8QZ+ShQBdNN4/VUvtQGRVt7UhW9Yg3uXzF6lO1Ej99ji+
 ToayIHOxkDx9ipHl9UgqVMnREHD6RgvUgsqvZj7ZLhOeDQSElRA2CrkWdoX71XNyPWjlTww
 cez/G5UeQoaDMW5Ds7BFqSiYezXiE98=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084733E4B3D
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 12:58:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06C83E4B2B
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:57:49 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D5AB1000A3E
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:57:49 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso4226274f8f.3
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782817068; x=1783421868; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=efrZ4gahRAGCcuvsAXmN03afl4mlui5Cj6BeCLFZEwA=;
 b=G0hx9hSpNBSVfD9eMtVYGC9L82Nq/DYtCVd7H821xRdV5YZ0AhVSQU9zrxcA/zu6me
 nT56bxXzb2OlkrNNJiYn7Gci3dXmWueg0hnQ7CMpvTQcep+9zokNjhWdgHWndNnihNFB
 t7tTScokgyQZH/ODb0DzyTCfwYzudSVAURUVl2kxin542lPVdyiAxfhmNGdo3eXkS2oG
 DwlKzi2729RVhEECLHKWFP8FbM0RgwoWBFt/QfETK1Ft3Wvk6iSx5evoTTOx+B0J/r0Y
 8o9Yn4RgxdKpsHD0yWLJjdM4Scg6wO7mlPggRCWV4G22G3Iz2EtVI211PMxIIpn8TGk1
 r9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782817068; x=1783421868;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efrZ4gahRAGCcuvsAXmN03afl4mlui5Cj6BeCLFZEwA=;
 b=N3+CLHBsECkO3rFNJ5POagV9xa+7b9ZbfMxTtZY7rN2L8DTJZEmrnF52pNf3ORzWm6
 i5s9wWockFMW/LizoWK0/on3zS2oiR44SB1RYBFitDBdWfDktCGUjLQnRWQzmOeT8ZYK
 8vYOXF+q2Qoa6+L8kyiWlcStMgt7ze3C8dgS95rfSwonnB2H4DxXrjMQjqiUVE1UYgQv
 wP7hG1Xq0uSo/2969H1voY9GqtGv3GN2g5P2ChsrisqBtUmnF4sx56alKOmU962KxfFr
 ArRGDAFzg4MgLTfwZR9oFJgzydTEOSD1WSzPaPvaDVxfJfoZ5KW2PVMr+KwRed5LBy6n
 ulGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr72KyUtu9IZ2S6GI9+upvgBuNZddTwwibUzMy4r43ddMQHh64pVQViiiJFYa+v/xqrCS4=@lists.linux.it
X-Gm-Message-State: AOJu0Yw7iKN+v5TNiS1I3zE4tCZ/jD1lFTYXSXCYTnE/pzE5pLnV/EQg
 8axosoyzgJrHzC4HV+QSy3XrCc1d23JLR4aladyxpsS7IwbNjl2aOC7dHNc6L8QqCcE=
X-Gm-Gg: AfdE7cl1LKN47EFjl5q8H+oOuQt6F2WXPJnKGVXFgl5ELdAgQnLk555Cg9HRGOLvG3M
 qqfpFIBQ5eSolp1MveOmV4/tuzzLDozCbnB3TBjFgh48tHZ/mYoIbrEq5dav/kIwwiZQTn2WuWq
 oPFeFQ1m+FYlZQEpPH1rkuoDPiSMSNUMAjYsO5oIefL2NjmKs0X9AZrzyzLi3Wzu247L/fQyYbw
 3JmcQFGTqHfbtJvpArnODxhW2D/nMC0eFnvay2YZH+/GBlOr/ac/YFQxnfpEo5G4RhG8kb2Xwcn
 xRB0/Czy5YkfHsqpeCPdlSH3HDR4gffrd8Pa866ylkNsnvygHjDY6EM/kW15wUev2lZgwTXIJQf
 +2FD8GYaQOkTzWk1gKzTi0HnWFHhNx2SctT9jad4+EvPghTBPBKSI/q3AN23N3s/LIs5jROAJfQ
 ICIzAJ8CgY/UgwDwsjIdv4C9Mzxb8cSxRFxNOGbHkfw5ksrTVAcH/uK+7vaZFOtA==
X-Received: by 2002:adf:e542:0:b0:473:673e:3836 with SMTP id
 ffacd0b85a97d-475524a8898mr3470994f8f.28.1782817068589; 
 Tue, 30 Jun 2026 03:57:48 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194b0sm7130777f8f.1.2026.06.30.03.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:57:48 -0700 (PDT)
Message-ID: <6a43a12c.b2781ae3.f5268.13b3@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260630102026.GB417625@pevik>
Date: Tue, 30 Jun 2026 10:57:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall02: add invalid syscall number test
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> > I suggest add two more cases check:
> > 1) -1
> > 2) __NR_syscalls +1 (Base arch/powerpc/kernel/syscall.c)
> 

that was my initial idea, but different architectures are starting
from a different value and I wanted to make it generic. I guess
the right way would be to include syscalls.h and use
__LTP__NR_INVALID_SYSCALL at this point. WDYT?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C88E8307C
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770212729; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=V734Av+AdrNZxbnpm1zQq3h0ylKBt02M+KUk4TOK8K4=;
 b=hpVYYsV8Py5Yd4rujfE6PCRGrjIt84p0jezZ4MrqIVDg3G2ines2xWGhIwp2JVBaqrDpC
 kBprdYOhHzZn9DNXM0I6S62Sp+g5GIv7Ju027kbBfv3pjawWxiJIBu1X3CiTg2568WeOMjR
 jOCNuUQk1ugnz1WzkRRXoPQPtinzUGs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6454B3CCAC3
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 14:45:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C43E23CCAC3
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:45:05 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 118A01A008B7
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:45:05 +0100 (CET)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8850aa5b56so1101083766b.2
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770212704; x=1770817504; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lQDj6kREhcVJur0+Ct8uoMW7aeV+SxuHk95d51M1u4=;
 b=AyY8pOp/vqNORm2LKjNRv7t7kXptO/Fe1WoBY5LiXhZklZVZ/iH0PpIxEwBlA+DDmr
 u33fG8k4kJCQ0T37NHcECCYxe3MnJGC294NWCuueiQzbEUyJghh6fbgt0mD0ZIvUlEz7
 RK6bJX+YBXZY5SFksL+fvUYnR7QLWrrc5fqDWmP35+NcMqpQzB9bnsd9vKQUH1paAPNu
 XVhvBQ8mdcMNtwUBxOxlTVt7LEt4kpp80gDLpPTM8iOSJVDFc4+Wn6UfIWrwvRNyZ+Oy
 UqVGCNsC38KMSf5xBPSwnKHUagHl5fo9J7pMuzMXDofTqAn6YpPSLOz+fPzbHLqlEsda
 S1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770212704; x=1770817504;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1lQDj6kREhcVJur0+Ct8uoMW7aeV+SxuHk95d51M1u4=;
 b=Od7ENHZ5WSKQIlZUob/vLCw0cC92B7q/FyiWYFS+fiwSXQLbHvV8GZJV+BbODtDmj+
 aG3EA/5XBiy/M0Y5GUmuFisTn++02/ZXHLMGTdrv8wAOnv0Hs/UzSPFkEk1xpE4ERfF3
 PoqOe9Hn5IT5ovKr9im7DIosKDVgZpxXqqI8Z/RrnxVU/umDPfWN7csJR0tBa2VbYCax
 2PmdOyYjaLk3rDqWJf3XaO+wV7LCsQVD970bvCiInUOHaxxbXB7z12bR6OaxYDH77bla
 /smmzTDh2G0r146ZAzxb4FNMkWZPL0V/0PChOfm8rawIZLIFbB/McE33pXTMQjuE0AvQ
 aCoQ==
X-Gm-Message-State: AOJu0YzDT750z9VyYmZgsaV9LjzL7GwVLDYcgqWUVTsBldEIjkDN3ixC
 YH/HDwzkaf3BTb5fAugKXqK302r61OorfHZtv235mIBXVRe5BsAszUThiVeMqhAfC6U=
X-Gm-Gg: AZuq6aIaALvNzWnoDaAYRIEpaRKEUXxOlbLKYwtuXrT0kgw8LBsd54d7+HC2dxJzoeq
 7sH4gq3BqFzM9fByQFmVJcwHZQNEmSWI2R0mM/EvaVPD7GN9Gzp8QyQ9b6jhjo5tYw7179Rd36/
 GqfZZxpq3LLgvc0AI63d8REyObKMicdIiiH185rGVPnl+WMyZYHt1Dcr6KBX11gmRCedRWGjhN6
 epnNizshr1XSH11Ol7xKvsgWy0dnVOyQzdR1PZeUFF7iaZBvrHysW7o8mLdI+wWwylb610EhpNw
 gEi6+1Y/ItBifbWsiKi5aVJ/1f21564uRqZvB5bf1uwgZE5pYn4llp8CX00BKwAos88pvQ4V5eo
 rRBjcQG2J7KlmoMyOF0KHFs88x6AjvtF6vlbTMyO/ejoUIOBIC3e1zHOz6xsb2hjkaDli+FK/h6
 ZNA7fHxdohF54=
X-Received: by 2002:a17:906:6a16:b0:b88:775c:bd6b with SMTP id
 a640c23a62f3a-b8e9f3f6a39mr207551966b.46.1770212704379; 
 Wed, 04 Feb 2026 05:45:04 -0800 (PST)
Received: from localhost ([88.128.90.5]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fcd8be3sm125348066b.10.2026.02.04.05.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 05:45:04 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 04 Feb 2026 14:45:02 +0100
Message-Id: <DG6814Q4J502.2XCN7VBF3513Q@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260204115339.224261-1-pvorel@suse.cz>
 <20260204115339.224261-5-pvorel@suse.cz>
 <DG664MTNCKXU.10ZGQ5CGF7DC9@suse.com> <20260204124640.GA244528@pevik>
In-Reply-To: <20260204124640.GA244528@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] kirk: Remove runltp-ng symlink
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> Do you agree with removing 'runltp-ng' symlink?
>

In general I would say yes. If we want to keep the `runtltp` script
name, tho, we can do something like:

	install -m 00775 $(abs_srcdir)/kirk-src/kirk $(BASE_DIR)/runltp

inside the `tools/kirk/Makefile`. In this way we keep the same structure
of the previous LTP installation, having a script name that is also more
clear for the regular user. I'm pretty sure a lot of people won't
understand what `kirk` is, inside the main installation folder.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

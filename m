Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F613C55179
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785764340; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0PzfBmRLwoQRJDhy8qT1Be7ruAgN+lBluWtZ4eDVCwc=;
 b=ARgKWZLi1O4UpARHAhs7pmYqlMxUgULwFh0hgdbsMMgDQIrh6PaBuQP27DZo1AS5SS6uh
 5AQi0DL7viGdbweZe7zjqLHwNjGYgc4mqBH/gBa0HOq0qN9Gd/5/zrh4gLyJJdDU/5K9sJv
 aV9xQmIPpge/aLe8OFfDYenk5Orrfk0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC5D13E011F
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 15:39:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586E33E2D94
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 15:38:39 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5BE71400138
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 15:38:38 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1998240f8f.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785764318; x=1786369118; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ihi/KcH1ZwELXaS4+kmd7LU3b48sSkDRH9SoLYCWJlM=;
 b=KZ2f47DY0bhScDi8R4qeRa+jTstMpEaJ6wkRDXa+S8o0KBqDOMQUXR4jY/4U5h3B5Y
 5HtBmag8l28rfAzyFgesJdIBtFrOPkqdZpTCrSDHoYWBVw9ltGAAPob2FPSxdg1Hkyhg
 RBT3SmwDg1pyd625YsZKznXw+Sob3MBDO1XbvzF09uAlLANv1lI3yzVzAAArEv5ZdOr2
 jDXhPAslrNueiKFWtYczLlsYPsal1vweI0sS4M1jiIBFEgiYhF84iEqHOJkNtr6EGvgp
 1FX7DCElREkgx8Jbko/ixnsF7LzPmcN+hIQfUjYpcpWi8EToclIO38ikKoIOUaXLyIUO
 f3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785764318; x=1786369118;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ihi/KcH1ZwELXaS4+kmd7LU3b48sSkDRH9SoLYCWJlM=;
 b=pP3Shz130wp9y8zggIsDLT+Mn/Bvf14jEHyZPJcF09jYpkCEpTINA80gXkaq+A6zTw
 VZGjfvPemU1S8HgMjLgFg9Rr1A/x0VASwp656PlBYZjAPrqYd7iD7YHUafd1zrS9k5xo
 SjyUrYmgA82FpP+zTQtsO6Zi03+JqXbwfHKAwXSh+D4Hy0C55kzacQ5mnyTZWQDPjUrW
 qESIvUTlpy5BpGeKKLv+BK6EUnU3/G+Muy/Kr4k6B/FE8woS6JimyRYyfkAzzqDuGA6w
 37hEgvXsoQaHMvemSidTmanup3EZrjBOLaKaTG3+AdbSP0/xnFB2an4s04RhG/y36EJx
 p2tQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrREvSg6MLoo7vZ2k9fC+oD8pL/4zvfBNNhf5FvK032SrBSFloBX4nHUhqOMyx8qkJYS2o=@lists.linux.it
X-Gm-Message-State: AOJu0YzeQjwdARtfvidMSwFd+SHPMr55AEBEGSV4xsGDXCwlKL6ac/wo
 QZ2/CM8Aff1yP7Ft9n6Ntaba19QEs7c6Jwq1F9PYOEpBAiNXUCGK6rZPFB9GhQMlrVf5EuAL6tF
 HAKGU/kxhXg==
X-Gm-Gg: AR+sD13nEINfE820TgIZXosHgeL7jJpFLScAYogP7s4XbbU+bJV/aZWFQd0KSz5T93J
 oOaMjDkXzD+8ivzATADFO6eIBMpBNEaGjgU2TnCUSqIDIQ6kVnBqpPsL37qmL6OExFwF6ph7IQh
 xEhJvnnwx15jPA9u8o31euhF578JVHdlskQmvZqj94jYRFTxa9VYTscXjWHIjyX3lohEWKMB72m
 I1W9eSvPyI/3lm+rMYgSn2pV9RC0wfcLWoJFnCWuM/0Y8mhwON1KdHPUdsrvpe8nFotY/7wZMRS
 Sb8Jubntw5I15LlrjSylgJCP6IC+bcdD7+yNGl1bPxZXUJ03v9H6p/0Xij4kn10Fv5qleIG6luO
 tXEzv377M8ZrVrLI8YpvsBKR5RuVPJgtcbBece+FT6TZXqS3Eu3Y6KsrWXcJ1GaLy/SKNeQ3ssZ
 rRwakqOCmm09DHEP5MxsFkh9f20YXNi+nRR/b9rJ3Z6ZApF/+NAIbUpcse8URnLuDyZD8rgjeVN
 PWpbBxIjkUkghwojODqOhv4SPrlSAB9ejjx8g==
X-Received: by 2002:a05:600c:6989:b0:495:6338:1453 with SMTP id
 5b1f17b1804b1-4980c680bd5mr260937595e9.16.1785764318312; 
 Mon, 03 Aug 2026 06:38:38 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fe742936csm2175776f8f.31.2026.08.03.06.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:38:37 -0700 (PDT)
Message-ID: <6a7099dd.c69142e7.53fee.7114@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260731024600.3976-1-linuxtestproject.agent@gmail.com>
Date: Mon, 03 Aug 2026 13:38:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/functional: fix memcg_failcnt intermittent timeout
 by disabling swap
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
Cc: Xuewen Wang <wangxuewen@kylinos.cn>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xuewen,

> > memcg/functional: fix memcg_failcnt intermittent timeout by disabling swap
> 
> > +	swapoff -a 2>/dev/null
> > +
> >  	start_memcg_process $2 -s ${MEMORY_TO_ALLOCATE}
> 
> The 2>/dev/null here hides errors from the very command that implements
> the fix. If swapoff fails, or the command is not present, swap stays
> enabled and the intermittent timeout this patch targets can recur, now
> without any diagnostic to explain it.
> 
> memcg_limit_in_bytes.sh, cited as the model for this change, runs
> swapoff -a and swapon -a without redirecting stderr. Would dropping the
> redirect (at least on swapoff) be preferable, so a failure to disable
> swap remains visible?

This is correct. If swapoff fails, we can't understand why.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

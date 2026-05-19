Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0324CD4F5E
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779202112; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=i25h2lr4NoJfW3hPNWNRN2FhvIq+CtdTkmF2GnbWnMs=;
 b=hg4vhubnFInEtsHeM8Z/JabMqELuSRUdWsURxzOb8XK+qXZVM24iED/W1ttLj34UBY5ef
 2xrzhCDnrJgmnXOq3WC/PvBMoVyjmcs84WeXDUuj3rhuT4QJQwHMCPxLCE8ll2j8b9DxcVa
 QIRXfuZPDR+QeTajd3XGazth6kU3mgw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A79A43C70AC
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 16:48:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 234403C6FEB
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:48:09 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CF7914001F4
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:48:08 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso2453399f8f.1
 for <ltp@lists.linux.it>; Tue, 19 May 2026 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779202088; x=1779806888; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=34s2XAV/bcmmhiwQk1IisyaGZwYhPEgqQec8lmTk3qA=;
 b=dw76KgvfWGyW3tyWa3YauF/ed01FQqC1iAuaIAjSethDTYR+uubkBO7nLHWLvlp5ni
 vjCqKo6Y6mr1l694vw82prCJT5LKn+otClAtWr7Pipx0hchca5YGLuEN1q8zPGpz5JCQ
 xWiBOQ4vWGVisS55oefsmbI4Wvoo/I+crcU0QCeUur7/b4Hqhsq2HU9HTejzOmz3FAaR
 hZm1II8tuCiigNr1I3ymySxy9Dr+WbgV+c1xP6/K58EcBVGmpuVHySvDa/OQu7A48UkU
 +wgaeTV5aVMLo5kO/9sYDEUoT8LfaJwgHZ6i0Wkzeai6UdEMm4pKq1dGAf6oucrHF5Zi
 iXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202088; x=1779806888;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34s2XAV/bcmmhiwQk1IisyaGZwYhPEgqQec8lmTk3qA=;
 b=kpgvKatQ8kPwVh3LBUaT5wQMo8TTIND4+PMzKRVBN4Fm8bS7nTB0bXv9ZV1J6AfLbs
 foLf3kF0StMhr0C/uRDhOTqOE8+1B6zJFnF/HbA036uWzfjxtRXtvKY7ZPE17FFh+Pr6
 9CPFjN/JakRn0LxQn5zBkK/zCX7cwACT/l9O/Yq38mMWTP2zCnAMKPJP3N6jphc+3vIC
 TqhW6puw6uRt2PGauMD5Q70q+q6Q06lQsyQ356F+6tYcPLBCpJJWgBdaOYk++ueobbtu
 /J280WjU19G1w6my9sLj7E6feywZQBWWKof5iyI1WWOProhYhM3V1ehA5NIIDPPsqwc5
 V6/A==
X-Gm-Message-State: AOJu0YyV1lRvcpcxulRyegS+IKgk7VnBnBd3F1lJeuQ6ZT5h8YtU1nkM
 JctOiJEkqTg/tSesxSaauTK73o8bNll55Z0gHDWSQZIXL0nS927qwbHofL0md6WMdIx2naOoowx
 w6YEzUDkcmg==
X-Gm-Gg: Acq92OEfaG4h3Gv38D99wadBdn5ozH2LkxSSm3yeAnbA5Takeetcnr4JQOcWPJ/p2Jk
 Q/kaZXZNIN4m6/F6vEryuH6JOcvkZi1+Q8DDfwDyoNjRLsA4a1NXnWfKIwlFOmyLGvZji8L1t71
 IArz0KByykcieGLv4ywUdMrwAEs9TyyUMUPwQ+wTsi6+/r+WNJ2FkIIK69wXIEC5qFWB/AAHhZ2
 YZ3LCjWrkwjWBbeHqUJ44KbAgMsIclCTnqo/zj/MDEHSPWAGu31a/jeX7VHcjoGb0rN5JdwLxsg
 Xajb6U1NA00+QV7EqzTy1NiAYCg5sKyrP461wBzBk0XHA4LRfg4qqi82WBnJm1O1ycsqUbl0iK3
 Pyxdf9e958cyzKM+EIoLxn+9sGUFBFC0qp9rgWkCzqQCPKwRbaeSqD2CCeY2lJHUT1NeSrei1Cq
 fFIlrgwniM7m6Nuou923AmNX6fnWugo7lfkI9/pNqEr7ChE4Av0p5g0AKQTdPGCw==
X-Received: by 2002:a05:6000:26cf:b0:449:acdb:3009 with SMTP id
 ffacd0b85a97d-45e5c35ddbcmr32419667f8f.6.1779202087774; 
 Tue, 19 May 2026 07:48:07 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm45486069f8f.17.2026.05.19.07.48.07
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:48:07 -0700 (PDT)
Message-ID: <6a0c7827.e130e254.5a81d.f6d7@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260507111809.28934-4-mmenashe@redhat.com>
Date: Tue, 19 May 2026 14:48:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] futex_wake05: Add EFAULT error coverage
 test
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

Same comments of 1/4

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

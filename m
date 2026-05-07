Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA6BCD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778142596; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hx0odn6Aa+WXfGOe47Blxd1NH4tveWirNa3Tq6xy0Dg=;
 b=Q1wuom63Q4Lb0lHd+KBQd3YI5t3PGmUkwDYiELoaccin8E4bzXrCZUHO//4MRLezGsXhJ
 SntHyTZhtZODcLIu/OV1/oS2V1sTe2K96UF1M0ZMv1eSxH6Ctm4udcFPrxqkhgQVeI88DII
 49oPukOLXOCTLpyN26Rk8+wvOTF7sBg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F4D33E2C5B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:29:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C83F23E2C32
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:29:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 32A0C6007B1
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:29:31 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso4643935e9.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778142570; x=1778747370; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=j2U7RUng7kce1L3vl2/EPVcA8OzhNFC/hp2rkEUdj1U=;
 b=ahq8dOVFfaNu4SObEtrgYN00OOtm8x7zVlAcPA/KmBonfSOKc2HzwaLshgGIsk+8kC
 GZ4Bsr1EEciXP9KHy+WpXz+MlhiyowoRaAyLXCxIqSwzSqAQkkFtNkVrWithTOlIep5Y
 tAyqJplcp4q8HShCVKcveOfDZwrsYeH+ErptjwZyI/3Dl/Km90KY3shkikUO1vBDlrLa
 0B6uo+6OyL+/W2SPGivbZS0Im9kx9Rb2uUOmCbHGhfsthG1sCziSCxzuqFMkPRzoboLP
 o9HZyWycUK65cVy/0MJBB0WHAQ4Tj4jg/UYOmsyo6pAjhW6D1AtChYhtI/dfZ0n38Vvx
 n9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142570; x=1778747370;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2U7RUng7kce1L3vl2/EPVcA8OzhNFC/hp2rkEUdj1U=;
 b=ctBTaTTJgkSOriXvtWZ5oTxMJeZaKcMagLjx9M+PH6FdF03j3hBbmPHmmyOZ4Zh1CZ
 PCEkxwtjuDkT9ryFKhfyBCQEafsnOMTcE66fX9UCUnDkZNub/HadSOAUiZt78FnYnxJN
 N8l//CC0wjysd5qnEdXzu0QrEqZHK+5U31XXIAj+Q1hxTxmCkKfP1lOVJMnBXDoUds+X
 ax2sSzaCHxdw8c0RdCWmtN7RIN6BiiUtyHD+KbxkXDysZwvt042aCPLL/wDX9tIFudmQ
 FbRCG+5KdNOuuS0XmAe08sqVJB5aBWFJmKkIvb2GrsnDVooZ7dXPAbGcDyze5yQITzh6
 co2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Hx6R+Ogf9nT7fMhkwXR7OYsIIXyYlKvZ/L2LgfJ2MPJW1U8w5/2Anliud83L/t9pa9Dw=@lists.linux.it
X-Gm-Message-State: AOJu0Yyp+F1KmVSC+TWVu5UC3wqIkKvHsW3pnak6GvDGo0x6BOr2lQK4
 t3Ie9/Ppjn1WU17h93qEG5aRMawGMtJZLKHEL6VqrRx/r5soD5mZfpOD3gJT1Qxc49pQIH0KOOr
 SJvqFa1XzyQ==
X-Gm-Gg: AeBDieueyPtsIMzSs8VJnMTtpGsxGh9QQzKl0SG+WlwxbbFv7haeYM4HgNNvkebiySE
 9Vqvz3JDEVf+E8JnhwXrdeobSytl9Ac7EV/wF24X5jUbzYiC3K8AE6sz5qryp+oYasLExGE2HwJ
 mWejd87h8vZ3xvBNqCyHQkY9foRTcax/S0JXx25NQPj3zUXDjA820jTDcztqOXxmTBv71U7fcpq
 dRMI+LfhGNs77ZhsYvbDZb9F4/wev3RnL4rSkJNWYpsdoJJDfk8QM1ZeSbDu+3xGZAH7wiIV/Dh
 hoXYc2tf4La6K9jUK4205Lt1bEQkhqCcUeA5IjxIyHnbkSmrKpumrBX0VF9HRBxryGCgb0Sosk+
 80srirb+f4JYAh3i8D9VSBzHE3siwqd6YIP4f9JOvz5gnT/W8q7kHnWw8gt/+zeqHuRimnQFf2m
 rCXPlJnfPA1ZYovCsVq7/7WakZdXwwBG1KXD0ibm+npVmiEBG0Qk3dsjZcLYLfckM/mhFHmQKNo
 wC4J87U4wq1C9hM835+nHOWiJCmKGxUK/qM4Oj9ms66bQ==
X-Received: by 2002:a05:600c:a405:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-48e51f54230mr97107225e9.26.1778142570381; 
 Thu, 07 May 2026 01:29:30 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b6e9bsm186066375e9.10.2026.05.07.01.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 01:29:30 -0700 (PDT)
Message-ID: <69fc4d6a.050a0220.3c2011.edbc@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260507082645.3925-1-linuxtestproject.agent@gmail.com>
Date: Thu, 07 May 2026 08:29:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: safe_file_ops: Add SAFE_FILE_READ_STR()
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi Cyril,
> 
> --- [PATCH 1/2] ---
> 
> On Thu, 7 May 2026, Cyril Hrubis wrote:
> > lib: safe_file_ops: Add SAFE_FILE_READ_STR()
> 
> > +	if (!fgets(buf, buf_size, f))
> > +		buf[0] = 0;
> > +
> > +	size_t len = strlen(buf);
> 
> Move `size_t len` to the top of the function alongside `FILE *f`; mixed
> declarations after executable statements violate kernel coding style.

I see this is happening again. I'm gonna add a rule for it.

> 
> --- [PATCH 2/2] ---
> 
> On Thu, 7 May 2026, Cyril Hrubis wrote:
> > syscalls: newuname01: Fix fail on empty domainname
> 
> > Fixes: https://github.com/linux-test-project/ltp/issues/1304
> 
> `Fixes:` must reference a git commit hash in the form
> `Fixes: <hash> ("<subject>")`. Use `Closes:` to reference GitHub issues.
> 

This is actually correct. I will change the Fixes to Closes
before merge.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C214F44846
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775822593; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Xbn0X2iIQ2ft8VZVFn7Bh5W5uGNQYNvRjqQzMeNmdE4=;
 b=Qo5MXhR91vJzhQvX5RwWy6OGFB9a9U0aMAZVHTPWvRaP9Slj+5a3qwuxHJAMHJvLwgjC7
 pIBCKTi5VT0/Hfmmg2ldCfQARgFVYYiQbV7eVhfGAZkaBMEmN+xT/EV7Po3+QU85IDbV0yN
 /DPAu2B2vHMeyusKoX3+vCsEF7f5mfE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D30A3E2160
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 14:03:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DDE53CE0A4
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 14:02:47 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1BD501000237
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 14:02:47 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so1884206f8f.3
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775822566; x=1776427366; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HFj1scU45xJ/V4ln27yYCoZFFqFRjHMIFgM2GDvPBxA=;
 b=ZLK0zQ2lVC8WWJQJ6676taUAhPr1lSohnJPg41NuzRKHEAYl3kD6ph4TK1ba+7HluV
 xe3L0lARogSv14/xPiIrlIrddgU4pVrnj376/LCqnZpW/KxZDDZHcvm8bMKjFQHhVLwe
 cnihy+1XlK8aWYkmbtZoNnXloPeU8XhntAwkvgo7qurhWcErnxPlI0NahR6zYVA9WWjJ
 5EVaM+rtutXUL6cuxEMsr6TOgfmM1DABd9f8PmMiuORRyrTBXlVPZJI/Tcrq7e4dXjJr
 4FemsAAiPiHYQ9mJc4TS7c00DTdvbpiTm/WXBQIW9eyPBE2QwfEtEfMK5X4kNcSk4VQP
 r8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775822566; x=1776427366;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFj1scU45xJ/V4ln27yYCoZFFqFRjHMIFgM2GDvPBxA=;
 b=fE/u+/AC70QP9FYaEVUnDSdvXTzEu111aokBGPcfmcSFbbAnEoX/BM7dTE7DFauTv4
 23fB7kIPeIKordfttnTD9NASPOEfE8vyb+KEveRt8mC7H5a4m2LF9ltR/IGzQ6B6NZYE
 +3Dlh0Gr0mCtALi/rF/T73mS05og7/35+igSDyFRr6jYlEk6vP+wvwYnpjJPlKMiTGnx
 Vd/BkOkb6vtMA/KccCTEQ42mImJ0tqlfwTJjVNggGlVSznZb7XCyD+96ZAXBGxiK6Pgo
 RTJnZXtDTYb1y+5G+VSqLlOmfUkXKbbnG9CWayu8/D3XRAfTjB2zJJ93W9cUrLyQdIGe
 Xv1w==
X-Gm-Message-State: AOJu0YztmhEltGfISOt508B1zYP3oSICxSf0/6V7KZjoKJo12TV6t9/D
 5pITEDLGW0Q5xy8vBGH2zN49mpQfosB4RHpqKaxyRgNQcDS3zbug3cl79kE0/t5jn98=
X-Gm-Gg: AeBDieveU5sKCPoG8+sVcaOyE5UJDD/s4xNCcWCxlUA7IpUitjkkyyzFK3hFLrCr00K
 6kl6j76E9kcZsro73uZB1H+1UJBD98z6qZTzPhNctpnOxhGzZlnvd7AIAn/wAOrUaWza1cW3ANU
 nBdr2e3NS8dJUtsbCldXDYRl7J+nnz7WK7pC24mEcetUz8pGKgPkR2Z8O5Dt0hmYWe42MdHP02C
 J9uuRJ721poBh8bwXSHHLSRVhqtawuzEgOWavQeEk9ONlKiZATjl9PNgM9CPN6SUqT0I5Z5eIKI
 rdv/iMSCOXqq1IQnQ5f4e0sutJf9U9JAfKrhX8ADotBOmo8I67By7sm70cZ6anvkhK38U1ZZ8LD
 TfFCGe3pbi4/cmOK9njPrxkTTsPCJ+m8Ka8panjQ62zFjKbpFG4onqCWWrJT07hP330ueEC6EcM
 7+qedUJ7IVYiQSsFj31IakFChTYp7qwZQR+xWQ9WsjgVvbOwWe41JHZr9v/NlX5kYt01PjOS8ty
 3DMEkkdDi0fCMHXSx1KJ8tiwwGsRm86T5g=
X-Received: by 2002:a05:6000:40cd:b0:43d:61d:382d with SMTP id
 ffacd0b85a97d-43d642a647bmr4213498f8f.22.1775822566392; 
 Fri, 10 Apr 2026 05:02:46 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5062fsm6520514f8f.31.2026.04.10.05.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 05:02:45 -0700 (PDT)
Message-ID: <69d8e6e5.5d0a0220.90693.5372@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260330050105.258630-1-pavrampu@linux.ibm.com>
Date: Fri, 10 Apr 2026 12:02:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix memcontrol04 test failures on PowerPC64
 architecture.
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

please take a look at this review before proceeding. I think this
patch is not needed, but at least you can try and see if other
people will spot something useful.

https://github.com/acerv/ltp-agent/actions/runs/24189485745

memcontrol0[34] have a long story of sporadic failures related to
the kernel async nature and memory management implementation, so
I believe this is not gonna fix the test in the long run.

But maybe I'm wrong. It's better if you send a v2 first, fixing
the issues, then other people can properly review it.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

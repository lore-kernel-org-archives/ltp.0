Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE600C3601B
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 21:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743715732; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=hb44s4C3JZhgrGHE9vq3ybu4+u1R7Vv86hn4AtNvmzQ=;
 b=fRyTjnOsuoa33noNSmRWV+41sfs292IfjbkymDND4cqtqbGQ+V95wuIx5gLpXLQo//a5e
 qCjEqZKvKtDyCMpFtpakN3J4BZVNPJNwuIBnhuQ9HiLQd7bPb5yYq7s1cMwv6PrY7ywpujZ
 idP2JvhX2He8GSvVQ/PZEthbXoU1r8g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFF4F3CB2CE
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 23:28:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id DE4273CA1EA
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 23:28:31 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with UTF8SMTPS id CAFAA600746
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 23:28:30 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso9833775e9.1
 for <ltp@lists.linux.it>; Thu, 03 Apr 2025 14:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715710; x=1744320510;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iUHjBDA245CmsFsasP09P1h7CpCC4kS+4LEVPebldeQ=;
 b=abvF0Km9w+hoFkwhlT5AFgAAVm4QDR4JuaQ22tcWJGAYnKDZCwZ8/SvOo+WNV8PcvU
 A09HtEIfBEblL60uhiWPbeJqtpzXGx0EoOejhDG9w3oOvDYWdkx8B1SKJ+6kzxUB+qvZ
 ZdlZqJblS3upGmHJfvK+edwTEjM9Xz8SVesajTGEzIJC752JW5Vb6W0g2YReuUlMcQ/R
 14d6Pm2FTZmiG9WOZSrUYhjo8X9nAD2oAKx0WA3nZVT4GR6BYhsVU9p52juzzAGtYQEP
 23MYX+m4MzaVaaeBD7GPYPApNY46sFLHWjYslJA9LcOhTlsbr2CMJtipUmTgCYio7XJh
 zV4A==
X-Gm-Message-State: AOJu0Yx8m3OLkU3XWy1ufyvK7ZsaNKcQrMKYuY3VQmwcVjKFwhRI2B43
 yGmRYom5n0PTasFq1rVBnAIDCxNkZ0O5v+3wgnMHzuYr3Sz/EWtAqhNIlJM4BI0=
X-Gm-Gg: ASbGncsxYN+kyF9bnj+KyXwz2Wd3NkzKQEksjBPQ3VjQMWi16tgZbxrUhcArX6RWzD0
 Y3dGrVdNZGIyzWyq4tNWOcN7UFNmF0orKZ6tsrtxHyYAHrEikHllZKSLsxhJao753c84v7QnBJi
 v/TRhEWbrvTQ6Viu/yMRBDc5OKQ1xGU8rS4puUFClMiA4QHD5s0yY0dptppbwpZlSGKWQjB4OVq
 XXaJ1i4wCHDjcK4HrKkIOz/MegB2XGpDxB8neyMdr4qJFIPA+yS5zaxlqSBrOmWVZ5f90Kqjfvu
 sLg4vqYIRFBC7EGnlE+KOUm9cMhN9R/VPNXuIYTLmPHa
X-Google-Smtp-Source: AGHT+IH+6EUMRhudNgVpluXgND16Rj60sMLfNJ9Nuay2cQrIKRb60JAXHxeN7qQRBXcEjSI2GWvJ5Q==
X-Received: by 2002:a05:6000:430d:b0:390:e5c6:920 with SMTP id
 ffacd0b85a97d-39cb3575c83mr735342f8f.3.1743715710208; 
 Thu, 03 Apr 2025 14:28:30 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc31c00csm1686441a12.20.2025.04.03.14.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:28:29 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 03 Apr 2025 18:28:24 -0300
Message-Id: <D8XBMNU7ROVE.LA0GJR3HGTSA@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.com>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250403-conversions-set_thread_area-v2-1-a177e5c2b28d@suse.com>
 <20250403135922.GA478597@pevik>
 <bf3c1a0c-e739-463f-8b19-6c3cc2f92027@suse.com>
 <20250403203230.GA510190@pevik>
In-Reply-To: <20250403203230.GA510190@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/set_thread_area01: Refactor into new
 API
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu Apr 3, 2025 at 5:32 PM -03, Petr Vorel wrote:
> Hi Andrea,
>
>> Hi Petr,
>
> ...
>> > Ah, the dependency [1] is at the end in b4 tag:
>> > > prerequisite-message-id:<20250402-conversions-modify_ldt-v6-0-2e4b0e27870e@suse.com>
>> b4 shazam command downloads the prerequisites commits inside the current
>> branch, before applying any patch, so there's no need to download patches
>> manually and to apply them before reviewing.
>
> Unfortunately most of the maintainers and reviewers don't use b4 (yet).
> Most still use patches directly from ML or from patchwork/lore. We get by with
> this, but it complicates things a bit.

No worries, next time I have the need I'll provide a public git ref.

>
> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

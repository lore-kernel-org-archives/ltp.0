Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2687C36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743518651; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=pmJyKlpzdHmIHhSPkptg4aAF+7CXiiYpChqNaAYep9g=;
 b=q3/57DNVHHqn8E2GKSGgn73gBDT6M3QTxTxmItJGLckT9cD6P0hoNAuadyCqWEZRg08Cs
 JyL/ejcuQ8qbKlUwEm1Uwt2oqD+qpqbhJvF21KZENkBUtWJlc9C0ITzLFmXBThvyXk0rLP+
 Dg0v9rrgmXSKx7Zyh1T8gLrqP+WgDz4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4325B3CB051
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 16:44:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 4E4483C98E7
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 16:43:49 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with UTF8SMTPS id 851CC600806
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 16:43:48 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so3213308f8f.3
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 07:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743518628; x=1744123428;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZWAJPbLg1U36lL/dtE7zVmwF9a//ywfUPGJoEOIaD5Y=;
 b=ivKTs8aPeUlNjKOCnmUcS8M7cdL5ykBTmMc1mdwc5bAALm/UR0Y8MAkZlsNvXCx23s
 mNuYTGa9Wym9PHvwcwRktJebBFv172BhXbB0N4tYZSRW8AUbBjtnHWbzeK1EbGVInpCV
 Kdb4MI4fa+S27/k5ZAgvNBttPSnWoHwOycfkjSMkQleASNYGtW4eVk5lAqEn0lreXzGD
 sdsmh0FakCcPuqhMH1y9yb4SsI14dOnUDsB1SjrRjIxNBfFWsWOXkB9MQMNYkiIsZiaO
 jVAo1i1DpKARA6N/xS/i0CxSlnWR0jcim9fFXSIQHs58V4vpsk4gFRj529pBqORLgXSx
 XQOw==
X-Gm-Message-State: AOJu0YyoNBISBzBNZaCZV32xm9p1NHvKdfQvX2lpTkmXJjajYjvRCs4J
 mdh1IVs15FN3/iIhdKSVk5uJpXmwK39cNKck8ejLAH031YUaTvItFiAvnPW1AnE=
X-Gm-Gg: ASbGnctk35ZfQ4LiKJCAYyoYpW/FdlzZr2J9g5b3RENeBp8+scfk85PIm3Irz2h1iw7
 1J1/FfRWnB/e8uDkVioz6CW558yHjD94Qmh38Ow+sPkjVqxlqQZV2qNmDgHMsE8V8MqxmxzoBja
 Nvr9CmbUYu1YPvaYw085X3vpevj+pMhazewbaRwvkFy9wP3qLq+3hK0K9tPcBvPXcEkN2hSJ6GC
 Ko1pQD/ZK5y/wBkE2wkWacMqnTq7bjYqs1j1xAUYe2QjkvpmGM2BG0dsGcXbIl9YTZTosFlXlLZ
 mcJO8x6rb8YapGCh5ERwKdX1wfa7lf/NDQ==
X-Google-Smtp-Source: AGHT+IEDwMG8i7wZbA2oT7+jBn3X58135EbjccuKXKxNQ265X1y1bzYvmmawWBMpC74za0MKukolrQ==
X-Received: by 2002:a05:6000:1869:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-39c120c7d01mr10237366f8f.9.1743518627997; 
 Tue, 01 Apr 2025 07:43:47 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd4ab0sm11688704a91.6.2025.04.01.07.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:43:47 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 01 Apr 2025 11:43:44 -0300
Message-Id: <D8VDRQTQRJJ7.2GET721U22NIL@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
 <20250327-fix_make_clean-v1-3-8b9ed2a8d96a@suse.com>
 <20250401074726.GE299271@pevik>
In-Reply-To: <20250401074726.GE299271@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] include/Makefile: Fix cleaning targets
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

On Tue Apr 1, 2025 at 4:47 AM -03, Petr Vorel wrote:
> Hi Ricardo,
>
>> Add ac-clean target as dependency of ac-maintainer-clean and add missing
>> files to the removal list. This way the project top level Makefile cleaning
>> targets can make use of it.
>
>> Cc: Andrea Cervesato <andrea.cervesato@suse.com>
>> Fixes: 817d8095fbfe ("Rename linux_syscall_numbers.h to lapi/syscalls.h")
>
> I did not get how this commit broke the functionality.

It did not break anything, but either that commit or the one that added
the older "linux_syscall_numbers.h" file should have also marked it for
removal. Should I drop the Fixes: tag?

>
> Change LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks,
-	Ricardo.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

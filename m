Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D1EEFB81A
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771923382; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jfaKe+S2+6V3BbtSVxVAY+4KDop4I3hjONieV5tO8rg=;
 b=caI8BynsYUkAdBmR22YaCUfsP3RFVVMp2YlXUh7zo2+DKi6Rfap/UCHIRvgs2YwUbmEd2
 HkT9eQcF2x+1CTk4etrsQlHCo3tBAPBXOUpeF2mj/hg37MRd5iWR3G8Lz56ZFqd1aQOWAPh
 W7TkltBm/QCvVK3IS4XvatMlTQotiRQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FF6A3CB958
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:56:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127383CB958
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:55:58 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6EDC4100094C
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:55:58 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so5142888f8f.1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 00:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771923358; x=1772528158; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFjU6aO6+rBHJS/WAbQM6TpkYoih87yywomVnkNYPBs=;
 b=fnK7tmdzJ3rxkQQIlbhHUL3ZqMaGOsvwgOJyYg7yT/ImQt956h4jzdGDop3PthbHyM
 sl6E+mnB/R3xUnvmwkHtunu5edJaUMdRkheCHHdZEOccUxP8AVEGV+7e0dlvpQGTJeSj
 5PrYvBLPOj4SxZY7ILxFhtbR68mBZbXjPs3NFJPMCUo1L4+S0XBVD40m5Tf+kk95y63A
 qUX/6v3zgyMeR3wPmb1oh7MRHGeozqhORkzE8PA1ppyhxvj3IYH6iyeX25XBoaRwXuIW
 Vn/2HXPXaSOZSK7hOUMhEAXkCDa2CqQl+eKPlEdBaHCjLIrAS+8ZLa5SNAvJkjIipH/X
 /GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771923358; x=1772528158;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFjU6aO6+rBHJS/WAbQM6TpkYoih87yywomVnkNYPBs=;
 b=DtQgl4On82Yf6pdnNJTxliZsZ649EQuZzS7lnfeiOWDssn3Ny3u3bRH9iAOTtrHouF
 Bmb7y2Jo/TbP1JyzpHD1gEuvrPLahqbbFUMBAgDYN2x+VOr2qosCPmfyFe2KZ7UbX8E4
 YbU8RQOW3KUC9HfdnVoOCTWVg+IKMRkOIylomBwlt7iV4F61UycGfv52DUDs3tzXFtEH
 OphGkfOdS+doZmFwqNch2ZqDEFmoEKNeaRzD0Np/cKcOKRYzrKQE+UEwaO9xRZD0EEZn
 kiD1+qRDt6UkdlF3xhmY8g1GvSJUNuJ2hHiIPESFneLvRdv2NGWCmoCdLkOJBXu/lVjX
 HfIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEl8TsFePUn2sVxH7dzHV87l8YT7ck2kvhakszu6AkQWz5Gd4fCb1k/G2mHRLwgPfaDvo=@lists.linux.it
X-Gm-Message-State: AOJu0YzZhVpFrbHcQgZSzZSpDM/oWXaJAcEqG6AlXElNrT39P45H3ihe
 0zUzpXWNwfcXx63Eh6GdGTKzFNIsvu4rMX3txPOO5Ghr7fHcMp23hUQfNZWpGAFy0hg=
X-Gm-Gg: ATEYQzy0DhndhF3I1u61iW2z8cFOlgaLLnMpz5dQoodFMCkl7oFPdR9AekKeuSpI/ba
 Lj4xYb5jRo0sPMzJcjAA8K73GMN3IyOVW7kp8PfpX1QndXhcIygstecMlrcZMijtAg8f3p5PN1g
 FXWPyFgMMZAGEiB9pNyUCL+8lEiwD1LlKkFeQ7e3LG21GqAMdDTccZjjv8l9fdCTAJNL6VJ0ckw
 wV1o+21xl+GOtiUF/SuRjtnuPv3rw1tgKdfKFfM9xxzCOORPjjBm2jR0mMy+OwdvOsVcLebMrvd
 kOGDPDY05SMAAr25qtVCtN1wVxKWsYe0Mt/mT/oCEOvrMCKkyPhdYCqga5XvNq14g6uBzbTlBNy
 MZ8X/Yl5YeIO8t0A9bc1fMa1Ivb/yYbau3sJ4H/zOINx57H9dJbGrRPsJsoiwrB/S1hUKQ6J/b8
 svAvKfRzKlNkDzzD4WzptGnKd+UVSGGpKsCIiWJXuOHS1eGk7t60Z6gRqQeZaCJOoRGg08jIj6f
 aIAkrVmYEiQp+40XTM=
X-Received: by 2002:a05:6000:2408:b0:436:1989:a1ba with SMTP id
 ffacd0b85a97d-4396f151c04mr22953553f8f.10.1771923357788; 
 Tue, 24 Feb 2026 00:55:57 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43987f3ed03sm2876243f8f.16.2026.02.24.00.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 00:55:57 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 09:55:57 +0100
Message-Id: <DGN2EOO6ZQXW.2593AWA6WTL4T@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>, "Linux Test Project" <ltp@lists.linux.it>,
 "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260224-remove_runltp-v2-1-f38862a85b97@suse.com>
 <20260224083017.GB28159@pevik> <20260224083107.GC28159@pevik>
In-Reply-To: <20260224083107.GC28159@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove runltp `scenario_groups` leftovers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Feb 24, 2026 at 9:31 AM CET, Petr Vorel wrote:
> > Hi Andrea,
>
> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > > Changes in v2:
> > > - forgot to keep runltp script
> > > - Link to v1: https://lore.kernel.org/r/20260224-remove_runltp-v1-1-7baa79b65acd@suse.com
> > > ---
> > >  scenario_groups/Makefile | 38 --------------------------------------
> > >  scenario_groups/default  | 28 ----------------------------
> > >  scenario_groups/network  | 20 --------------------
>
> > I thought people are using scenario_groups as kind of list of runtest files.
> > But maybe I'm wrong.
>
> > Also, you need to modify top level Makefile, otherwise make install/clean fails.
> > => v3 or don't forget to fix before merge.
>
> Actually also doc/developers/writing_tests.rst mentions scenario_groups.
>
> Kind regards,
> Petr
>
> > Kind regards,
> > Petr
>
> > >  3 files changed, 86 deletions(-)

I'm having some bugs in the grep utility at the moment. I guess it's not
in-sync with neovim and having issues to spot all strings inside files.

Sorry for missing this doc thingy. I will fix it on v4...



-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22035E77188
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737014033; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0VYNyjkFkvyOta7DVew50jNVI8j3FD3Sed5c8iO4nPc=;
 b=iHJ/whV79VooEBhkf1VAR4aEv9zxoBmPi1jR14jii71/WAbLOrTJ7I19tJTLU2hv4HMcf
 CRtYrSw5QOyo02Ay/x+RbFObG0WkaNrZXyi4NpOFFY5VL0HS+hTGfRA+mgZ/p7ZNojxQE5m
 0Ohv4iV6kFbiEGK/uSuU+K24J8y7FvY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 491833C7B9B
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:53:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B4763C2DF7
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 08:53:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D2F121B81F
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 08:53:31 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38637614567so295959f8f.3
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 23:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737014010; x=1737618810; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CZMTPk+iQwyJD5tbO6a3/z2tHTIIc8ZtspJszzFGTgY=;
 b=MAdLjGjUSWezYVuGkLeE5SUp1ga+YoEPJ3/IMg7PdO2iJxOq/kcSL89WYonaVnTmba
 Nv7AFdKRfj9FiHzqBxFBANBqcwwda+QeEh5T+GGnu862DeXO0K/HqIcG4qHNNp5s1zUm
 c0A/CQddFKg0cQWMLqa0wfDi5nYczZW031w8Ucvm/bhS45hHS9GKpFgNUFiyb4kHr9WX
 g9hZdx5PQ6ZzlBGwCvdFlTUFFoSYtn5y22/WBCfJ8TJ5e7UrOZtIqRirrSa0N9UJ1mIV
 0qXxcK7Eg3tRcB5tUJ1yXKAcZxh7/Vky5gHNKrMBSv5B95bcKuqacuSawC2vaOkUk6xf
 yHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737014010; x=1737618810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZMTPk+iQwyJD5tbO6a3/z2tHTIIc8ZtspJszzFGTgY=;
 b=jUVCh3muoJB7Vmd34g4HqPK0DselC+FNpcqZP3hhrCC+gymxRyk3KklVX4ajnl8i8M
 LYvlErn3whujnCzRVMpPO4KnX6qRpqtVQEvaDsb3M7rYC0seSzdEPbD23OnzCOTxN0mQ
 G3Bmivz9BbxPnN+28c9/rddqb59lzIhm4ecRHmd15RYfyvyVKUi86/eqUyvyjW+NNoRJ
 2pcP4ErRFeSbUgRYvp3XaTP2kvpnbvrJxhG4Po/f62Ac+gaRPD//mjHWtrJQNpqWL/YM
 DQkhafniFSDQeOEk4Uik7bacTLdRBA2yKpaRK6FHJcfXY6wYIYKsUMv8yEQYrgzritKi
 S9RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMwMwN9Ov2f7Tl94xBAolgPgEpyqU/MnWXwPrHAwKg2+x0sWkzvyXoNP7IJ7ZGLLkOh34=@lists.linux.it
X-Gm-Message-State: AOJu0Yz0a+q7CbQeo+eBqoDFaOAUXn6rELr1WsaN6Sid4vl9GJV12n9/
 CrtxyjC9Ipy81qG/Uo07Kfp+C1L1vLFD+tOhVZfPEraBcNcO3Qv4k6+jIKyFY5Q=
X-Gm-Gg: ASbGncuHB4tITpwQ91jMrw1ex/djX+Hf1QQQsXN/AVoB82s1DiK2jZWucJPgSTUBYY7
 Uy20CnhzUGJmEBFVJHAQkmhbTPSshv64CcgvVjAf5XymHT/LYYO46QYkjgg7+/9pfTbQq79Zq8q
 YKpfJhgsifLHPaKRS/Kgruo/M9hkfllkmMi9c9pquWTBn160u0fdSLEhN4X6Af1OGew8rDc0Jkl
 kyC3MPAqdcCIg7oLsKK5bLD7mNCRi9cW+/XR2H5Wm/t1LgaikEM4deg3SJPxb3lgxop1w==
X-Google-Smtp-Source: AGHT+IH8aE17cnsaSG/lJEJ04ZBg1qqYS0KK3RTQEWRsW7/LFznr+RGN84Vre7HWPegj2Xf82UU+wA==
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id
 ffacd0b85a97d-38a872f6915mr23743725f8f.9.1737014010648; 
 Wed, 15 Jan 2025 23:53:30 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499821sm49818225e9.2.2025.01.15.23.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 23:53:30 -0800 (PST)
Date: Thu, 16 Jan 2025 08:53:29 +0100
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4i6-WZ73FgOjvtq@tiehlicka>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik> <20250115225920.GA669149@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250115225920.GA669149@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
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
From: Michal Hocko via ltp <ltp@lists.linux.it>
Reply-To: Michal Hocko <mhocko@suse.com>
Cc: cgroups@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> Hi Harshvardhan,
> 
> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]

It is hard to decypher the output and nail down actual failure. Could
somebody do a TL;DR summary of the failure, since when it happens, is it
really v1 specific?

Thanks!

-- 
Michal Hocko
SUSE Labs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE4AD2ECF7
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768905842; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=S3mIfBX1B3eWdusqH42grOmt13snyyXFn/HYwMkZ1Sg=;
 b=GQ1F28paVCykYBYG7aSGKNmuhUHoBqQJCr60zltp6gcVXUCu6r8R/yHAStDJTCkhXqgbF
 HU+idccMeCA5Y/0unRx5FkvQLC+xqIKuB/oURD/giOxGap+MTItJc6vv74iQnAftOMwsk5A
 GQ/qi0kWQhxg5ljD9igaNxsGPJW/Z8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 803083CAE20
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 11:44:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D99FA3C4F45
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 11:43:38 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 809011400BF3
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 11:43:37 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so40617825e9.1
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768905817; x=1769510617; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zE57qfYlhVLJxPITAuX8ta+eXitnOfoGI7aIEGs81jw=;
 b=Ym0l1Mg62oVfoPiFhwo8ulo7UFdEfSARSzyVU1q8US6WmsERsfQBssE9e271GLdZae
 glT56u+dUkb+9P9wbAwAHzfNvOMH4xTCSlGg6vwRQMmIvB3C8XDtWvezCguX+TThbFMs
 7ReBU+thIhVZW/jLlQX2FRlOVF/OgjehEmvVvsKPGtj28wPRKBOobbcl/bza9nx7jo5h
 sToUsEgQRT52YOsA2ObzWdjeIG3lEN3FC8BsuRKwlHa8aao/NtQ6CaLQWKHeTqVPzP2K
 swoqU34eOrEWt+3viIGAP6L31Wvholn7h7pY4zZM+l2CGGBunkjKTklLggm2/8RSdsfb
 2+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768905817; x=1769510617;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zE57qfYlhVLJxPITAuX8ta+eXitnOfoGI7aIEGs81jw=;
 b=JRLXmMmMOz6zdeVYhNREfV5kFyRVYiNRS+/vJQwWNMlGGyMRFlL+Q6BvpENol/yjCv
 ysQjDtSOOelsOoB3LfjMfO9RpdXWm11Ia7AEPX8gCguVl+Hf2wpylUEEdJwgoHdgb21A
 uKaSWUK0el404RY9i9R7Kv13Xz3Z0fpQb9JznhfjURM3CZq7RP4D5ZvEGs9Cv4/RKYxR
 quLi5Txcf7aX1rcI5q/Sf+EWVL1NApp/5YQXtd+xr4zmXt56o91ltjXZgPK8KkIMJlMY
 dVBVXS2ao3r8t47m+HOyU0k2J34iovSijnvRs3Bk/duFEnEV0wsFWJpuXYXYPIVgmjox
 aTAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTKRr8RyLi7Kw8NI/OsVv9f6w/5Pm2LBu8/ARpBUT/yGKbNGxMavjTnQ6aAn836WWB21U=@lists.linux.it
X-Gm-Message-State: AOJu0Yz9gLR+IHkCCCkhVy6PWIjTReuPAkihpQ6VKX/1VeO091prpcu5
 At5Bf7qaWdlQ6pHSGo90uNsnEK+AlD/7zS/eXdWAS7CAoimHfEAK7CxBI0Ubm4fNFVY=
X-Gm-Gg: AY/fxX78UqJzryy5Dw5RiAKudkJ8spS+32g88nxDnt3L/skuohqcfRncqaqHRQ0R7iE
 qFA7P/vEkdrANjCSycvPCxcsEEFMMyttbowDQbRULN7IYKRXk3DLdJ+0mR41LPWGCvIKC9zd5iI
 i2BrgMH70FkQJA2PVXxldJQNC2b9iBja8GbizL7Ji5HLh84wGz6GIMjJHuWzm0O1wsThvhJrKN/
 J8kVuqq3BEozP2kAsMQCW37aGub7f9hQv7/xUztlbOc3KzijZAxhTrnEfNsCfwYkv+YfuxfKtLl
 tSb+GcavIA0FhpQ6DWS8Y5UOdmZMfBXYsf6gmnEPQNgpm5kIODjLDrfiITJSZus/pPxVOU/8j1Z
 NTux2toy5PGPVkp7aW71NfpocuMK5IXNt7Nyl54Z+5lkic6znctQ9B9pfEEOSQ+tvA6d7xSW3Ub
 EfmcuOr7yUcu4YA/Jwqb+4XulPQfa5nXMM5MxH9She/gqx2AF2csblTkzz/rg+7kzCFiXRBp8d9
 pKP
X-Received: by 2002:a05:600c:3b17:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-480409c9e89mr9383735e9.16.1768905816720; 
 Tue, 20 Jan 2026 02:43:36 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe65883sm99306545e9.15.2026.01.20.02.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 02:43:36 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 20 Jan 2026 11:43:35 +0100
Message-Id: <DFTCS1EEBMDD.21X779ISM0MTF@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com>
 <aW4mDAH6pVh_VyC2@yuki.lan> <DFSMEBM9PYDT.3TJXEU3C8W31R@suse.com>
 <20260120095945.GA27808@pevik>
In-Reply-To: <20260120095945.GA27808@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: add file_attr05 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Jan 20, 2026 at 10:59 AM CET, Petr Vorel wrote:
> Hi all,
>
> > On Mon Jan 19, 2026 at 1:39 PM CET, Cyril Hrubis wrote:
> > > Hi!
> > > > +	.filesystems = (struct tst_fs []) {
> > > > +		{.type = "vfat"},
>
> > > I wonder if we can add more filesystems here, just to make sure that we
> > > run the test even when vfat is not compiled in the kernel. Does ext2
> > > implement the file_set/getattr calls?
>
> > > > +		{}
> > > > +	},
>
> > > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> > vfat and ntfs are the only ones which don't support both file_setattr()
> > and file_getattr(), while ext family, tmpfs and btrfs don't raise
> > EOPNOTSUPP for file_getattr() only.
>
> Interesting, I would expect vfat/ntfs would not support both. (I suppose exfat
> also does not support them).
>
> > I'm wondering if that's a bug, since
> > xfs is our reference for this implementation, or this has been
> > introduced in 6.18-rc2 by 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
> > commit.
>
> Maybe ask Andrey Albershteyn (the author) and Christian Brauner (the committer)?
>
>
> > + * Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set] return
> > + * -EOPNOTSUPP".
>
> I also wonder if any of these should be mentioned in .tags (and in the text
> comment, which I find a bit redundant when we have .tags):
>
> 474b155adf392 ("fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP") # v6.17
> NOTE: got reverted by 4dd5b5ac089bb in v6.18
>
> d90ad28e8aa48 ("fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls") # v6.18
>
> Test itself LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

I re-checked the code and it's a correct behaviour. The reason is that
every file_setattr() call using FSX feature will cause a EOPNOTSUPP for
filesystems not support it.

file_getattr() syscall is different, because it fetches data from a
filesystem without setting anything to it.

About vfat, `struct inode_operations` in the vfat implementation is not
defining .fileattr_get and .fileattr_set attributes, so we have a
reason for having a EOPNOTSUPP.

I think my approach is wrong, because the test is not really
verifying if FSX features are tested or not, but verifying that vfat is
not implementing file_setattr/file_getattr. Hence I will change this
test, verifying file_setattr() syscall only, including all filesystems
and checking that XFS features are triggering EOPNOTSUPP, except for
XFS.

I will send a v3.

Thanks,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

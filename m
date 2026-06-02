Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03511CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 09:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780391846; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nQYiOLKCB8u6qBp3q3/pOxJNoGXPoW7LRl5xC+2+PIQ=;
 b=jUxaeu50p81QhXhCgjSjODdhHtmj6hGyrm+pkRwSKIdfGCHXU5QBauMWrQy6R0rN+L8hT
 +dk31zMsDUBY9J3o6yetPhL/qh0XkKpUNRHFwaciTvGQ1+bckw4zD+TjS3U3Sc+UX3GC3It
 Z5RVDrkVIpiwOBc4MY42GBr8tzIsRcg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 557863E30BF
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:17:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31D523D0861
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:17:04 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 60EA6602A04
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:17:04 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso3898525e9.3
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780391824; x=1780996624; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jYAA6NcTmO/Xa0FBZ0j83qFlxHp4P6PEP+P3BK8lEhs=;
 b=NcWKhE6QI5NiiWVcXwOGcJ0vvUouPao9G76hMxmcGPI42zp62Cfau/XiOnRUjaa+Vi
 ykn3Xps28uuiadFfXf03mIWcaY8IyL/myofoiaReKelw8+vVIh/YNl+I8kg0Q1bqBiDJ
 3Zk8NGFtabBcal9OVtO4JlkYWTdrQoHICPfXW8MrKeGltlaOojGV8Y5zUAU2bLjz9ZmH
 bQrlU4GfyX1vCPSFX6p6/NOsEoZXfWPnIJZ6ZMzFyofr8Hcprt5VgmnyRd0PXXlVxLg8
 I7BMloblC2W9nSpCcb0Vh/TxnNecutZFuIPVSIBpQT6chc1V95Qf0szodOWeIS1hvG3/
 YPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391824; x=1780996624;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYAA6NcTmO/Xa0FBZ0j83qFlxHp4P6PEP+P3BK8lEhs=;
 b=Mnim3K8357JPbOxnqIkL+is4BUwbdj/nxuo0Jbz1TgEMGBqGxOdI8b1agNvFfUVZ99
 S8aWedXoV9P1g5ePpttEXfuLAXJyCqOkAdPdHwbiPSwK24uK1JWuvwfZpWhVJj9oYwhy
 j3dHD/gvezzIRnXLGO8WpFU1Su4fAPQdpGrDX8ix4xmNEdOyM7K9o/TQ/8cYAugYZ0gm
 Y43OSbIOXzrrXxuoISN70Enoyw3/vm6tmDzvTM1keYv4IdVpm/wWxq9eHeiL+qYQT/p2
 gSpc5ScIuf9mgit12dZow4bzl/rG1/9PfdBgqa9ZWsUzFLVd011B4Vvy9+kpmilTzjoJ
 P9Mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dPEP6DQZ0iFrDPv8KmoaAaLU/L7sKxyu0NB2V/JcOAH6CrlQ52Oo3RA0RLBwTEHBQ+s0=@lists.linux.it
X-Gm-Message-State: AOJu0Yx7f5A1lps8uV+KvXZtzrNNo9cLD743v87jq7jQVRI8gAaM715B
 uILf7Z9scHhootpYkzxfFEE8kw3BiTV67UwgIATF1BLq9TY/m61b5RUsmp6Ezd8xEvI=
X-Gm-Gg: Acq92OGMLwjtqSOBfZ7wL3G8V1Idum0sf8MYReTannjZC5VzsYlZmc1mnr8EUCrkGtD
 Li/WSf1YDeTgXH26Ay/Y33VrK3UGt3JYfNXfyuypGOY4HEhWiMM1INaeV5Vukh/JMoGo06tdmkM
 BZFbA2TCdBpaeV/yZu+Dq+ipHGKoiF2aFHYGMV2SADDrd8Ui3kt1pnxPG8uKgziaXjZStoYqktE
 5H+0/PEzqNbBMGuQUt3yPQPMtuV8T04mHwlkx2vuxrnBxoZEb3bMvD+6bW3nhrPHkkrLwIhsOK+
 mPXQWz5+8mbJXb3P+8PVjBqzr0nGYzS8Ov+I4vqQR7e0z+E0mzhwwbCpVMXuOgtMsB3CVJInwwX
 yt3Xy6Pu3m2r5UYO6mT51SdwHBPW/a0urY/CqMjnfbmgl62ZS7U8z7FVsQLMfGtu2SZX0eB0+fR
 SJTH6MbIOmtxtA5GEz98bhxg3BgbMhs76Dq5JinoN6kuYOXQvE1AUhAE6DqhcEQoDzS9W8lIarb
 GeAmCgbPb3fR+9lBO0OodwBmBm/mkAvRxa5x3wqNmu+fqEp1Z7IpTTnz7jFN/yGgqHHAW4V9uE8
 nr2JfQpBqDr8
X-Received: by 2002:a05:600c:c098:b0:490:59cc:998e with SMTP id
 5b1f17b1804b1-490a2923a92mr227064955e9.3.1780391823721; 
 Tue, 02 Jun 2026 02:17:03 -0700 (PDT)
Received: from p200300ef2f13eb0055088da49ee1ea7a.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e38126sm44845715e9.14.2026.06.02.02.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:17:03 -0700 (PDT)
Message-ID: <6a1e9f8f.16c38fd9.1ba998.5c3b@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ah6csOP7O9R0L2hO@yuki.lan>
Date: Tue, 02 Jun 2026 09:16:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] include: Fix kernel-doc warnings in header
 comments
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > Downgrade kernel-doc comments to plain comments for struct tst_cmd
> > > and TST_CAP() macro to avoid name collisions with the tst_cmd()
> > > function and struct tst_cap respectively. The kernel-doc parser
> > > flattens names case-insensitively, causing 'name used several times'
> > > errors and duplicate target warnings.
> > 
> > Hm ...
> > 
> > ...
> > > +++ b/include/tst_capability.h
> > > @@ -67,7 +67,7 @@ struct tst_cap {
> > >  	char *name;
> > >  };
> > 
> > > -/**
> > > +/*
> > >   * TST_CAP() - Create a struct tst_cap entry.
> > 
> > This is the only warning I'd prefer to stay unfixed (i.e. it was kept in the
> > docs). I wonder if we shouldn't jus rename struct or macro. Because TST_CAP()
> > should be documented. Cyril @WDYT?
> 
> Looking at the resulting html pages both the structure and the function
> is documented properly there. Also as long as we use c:func: and c:type:
> in referencies everything should work. So I vote for ignoring this as
> well.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Ok so I will just ignore it as it was in the beginning and merge
the patch-set.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

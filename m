Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D597DE9A777
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 11:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774353369; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=67C2h4d8EVyVt+dp8p6G1jd7JLHFfxRs6yLlygg+zRY=;
 b=qejidQOj2H9c9qH5ih6t/sSS62yB60hI3Ef+6zLHKJyWWBVWMuwt1TLojXe4xp48St+QT
 AmlCf/hnx2AIEQTVUpDwmQNlSIfJTaOuwCWMW7YoFFOMAk7DDHAgtGutSf+jMhNIQIWWabP
 La7H39soJH7iP7EUR9ld6lOdlb35uIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 616483E4935
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 12:56:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED1203D0E17
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 12:55:45 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D986140077B
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 12:55:45 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486b96760easo10816565e9.2
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774353344; x=1774958144; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UAPdPhAdC1ualFGPDpa22sxAzqlrglNQ6K4ufyiYH+U=;
 b=Eq+xlqwgeE5yyzYtN3ZYj4u3kzhHJsbAGThe+/NRKGRlhltKFoxuPzOevcmh6TINId
 pLk5nlENoxRcNfb75iNgbuTmVKjQXboyLjeMRBO6Qq1pkX1e9uEKRRHMmxy0UGdeT3Mx
 9xg6GOvPDCNhAWVHtUlEPFAe6SInZ4G2+xDuZrDgBjspiqj8C5cMiqTV/8dBo4Bf5tlN
 2CR400P9tzA/o+0FxPhfJwBo67WKI9b6PA6BwVUFSDlhDu+QXi5YpoQ/ui5Dyrdp1Nkm
 XF+Ft4bJPlI11HcC4IV9saj1MzP2UGZgUwtgAavmxPOqCade4iTruAyCQehA8hLDD4Sr
 3hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774353344; x=1774958144;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAPdPhAdC1ualFGPDpa22sxAzqlrglNQ6K4ufyiYH+U=;
 b=iQ6IxB7pImbeYzydL6bUkNlJtAjiT32VSjaVG3Feaultn8LiWUv1BxH2B+mfQNHpeT
 Xcx4FP5mBIz4CUm9swXSq/6ZmSenjQgnEzAItH40PBMyW4H9SbplJYrzHQ4KSrL/9YjS
 hQqiFywi8u0QLEhEzG7qvtrWrpI1XBA+FJC6IAiQFpgFtYIkmZfL0BA7uX4zbHg5IEPK
 ISV6WdnLvO6MfBz1Ju6i1Tj+CxfB2QnmNFYTTZ0LcpDxQqs+DiFMOUAf4CvJ6F3jkw0B
 cXK4Y41SzWRNSHHhHCP+vyGz6imuDtovVbbspoU+27vXEzXIQ9Exr732PS11u8PjYVJG
 ndrQ==
X-Gm-Message-State: AOJu0YwGYtk9hC/7ux69ATkBMma2bcm8toI2cbq3gap2cQeI7zwFF9SB
 Gi/DrJsi7atKB/5eAa39jfDfKzzlUm5yd0Gazlrk04RuIhXrADiO/jJu1EX/epP1gdY=
X-Gm-Gg: ATEYQzyv2NQlorcCkj9urhl2KF9+VFYcQ9IBsPHMyA5bPzmuTXkJ+v9IQRLfGYqw7J+
 koxKhbacEkSSas7xReivJvjzZjxDJJWzPikCb6ut9h7pSUNsT8RLRdfFfPdprz5rM0guGuBhdDG
 R20e3En9WTnoDVR3jKb1cMoqefpyL/dClnjt2ysPOvTB6HuBvTY7sER78wcbUZ9tovjtTpYhRGx
 ly1AIAdWY54eMZ7bTFT1vcp153Xp/YhipWy0g/JMrp9SPVo8Hy2j3556U86uWrudH0/bpt5Y8+e
 nm5lDnEESDGRZJeasiLgMfayeG4kv+VbD8N9mlcUYbmcvivhyASKHGWfBieeiYR8hM73pn6mjON
 dIAvIXAfDJRBc1fnMosrUhs2KTZ+bd+juBMDVUXb/O4i2dvS9basi5OGnkXNT9OzY0vH8YKqM4r
 7BU5IqUgC3EUHz2Z1Zk+Zyh5XQFysXgiV+RkNQ/Gwh
X-Received: by 2002:a05:600c:45c4:b0:486:f308:94ec with SMTP id
 5b1f17b1804b1-486fee227f8mr210227315e9.24.1774353344456; 
 Tue, 24 Mar 2026 04:55:44 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae619sm38477473f8f.5.2026.03.24.04.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 04:55:44 -0700 (PDT)
Message-ID: <69c27bc0.df0a0220.1f9b07.91b3@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260318064630.1604-1-wegao@suse.com>
Date: Tue, 24 Mar 2026 11:55:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

there are still a few things to achieve before merge. Hoefully the next one
will be merged since we have Jan approval already.

> v2->v3:
> - Replaced usleep() with poll() loop
> - Added secondary error check support (error2)

This can't be added to the commit message.

> +
> +		if (!info) {
> +			tst_res(TFAIL, "%s: Event [%d] missing error info",
> +					ex->name, event_num);
> +			continue;
> +		}
> +
> +		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
> +			tst_res(TFAIL, "%s: Event [%d] unexpected errno (%d)",
> +					ex->name, event_num, info->error);
> +		}
> +
> +		if (info) {

We are already having if (!info) {.. continue; } so we don't need this.

> +	pfd.fd = fd_notify;
> +	pfd.events = POLLIN;
> +
> +	while (accumulated_count < tcase->error_count) {
> +		if (poll(&pfd, 1, 5000) <= 0) {
> +			tst_res(TFAIL, "%s: Timeout waiting for events", tcase->name);
> +			goto out;
> +		}
> +
> +		char *current_pos = event_buf + read_len;
> +		int ret = read(fd_notify, current_pos, BUF_SIZE - read_len);
> +
> +		if (ret < 0) {
> +			tst_res(TFAIL, "%s: read failed: %s", tcase->name, strerror(errno));
> +			goto out;
> +		}
> +
> +		struct fanotify_event_metadata *m =
> +			(struct fanotify_event_metadata *)current_pos;
> +		while (FAN_EVENT_OK(m, ret)) {
> +			read_len += ret;

This should be moved out of the while() loop, otherwise we will grow the
read_len for multiple event. 

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

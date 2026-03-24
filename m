Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DBEE9A77A
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774354697; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=mNkWLVkO0a/u/4Hh1Fsh4ozLTojXihslOSo5ZRi5CAc=;
 b=VBbq6lzxkRpwMJEV6snDxdNAjMicMjDF8xJIMQvXYEzyXyf1kd0myOmpWbcyM7NEkvBhC
 OVBgS7X9e04BpOhd40T0mAiqNnxz6FRZsyz+XzIDUtoRL4waAf+42MUCvW+sfOrx6Jitcs6
 jGi6pSheTljNI5XW+CBAyouzmqur4dw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C493E5254
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 13:18:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B3A23C536F
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 13:17:54 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A79EE1A004F4
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 13:17:53 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so33018805e9.2
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774354673; x=1774959473; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YXBHjlxToqS1q7od+hEFPFtJGRNkova6WVWqjWLfPkM=;
 b=Lxvimm6uNHTHGH6cw1fRSsfiZMfQ80nKMIxBAHC0286n78rwEnekJsRz/Aw+No+fkX
 tDKmMDeZBjzXBGpFVZtZbX5wUSWm9e5NVRCw6Sd9lT0+ngqXkd2hSMP2hwqL1yYTIJSB
 CFAUhEqzRtJib9Vtv4+p4laeTTRcWVFjuGz0h4hm/FZDOZfOExkYuHvIOlGf3/PDl+gA
 ICa/szWhDrHRkQzg7Jx2ATZYC2rqTDbNfRRF52Rj9uPHrXY5YDJUZU1w+Em+pgrj2M0k
 zcLOIh23QWo7GX0B+PB6IqucXeNQuF55kWm/wLT4Kk+GgTRF/CM1nZSx3lekKU8ygWiL
 hHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774354673; x=1774959473;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXBHjlxToqS1q7od+hEFPFtJGRNkova6WVWqjWLfPkM=;
 b=ClMVEHxImlLm24+clNCBS8srMR61wY2VNPbO4mV8li9cNIV/n8SGtH7YtPhwIqzFfO
 WM5Hqq5VmHaLZ0P4zMDQSBRPFjWHqJ83S/yarET6NLYoYeYtHeT8ljUm1UUXS+UzouVO
 0FzbPVJ4C7/SCAbWuBhAD41IJZTT71Z7+8ashKMGmSWIVWRz+0zjBHYZxWetiqZWn8jM
 MwEbaXw+eB6ok6YXP+IpoLljWUeIUlPk2WlZ9f/BF55Hpm3LJxLrdXA2RNs/8uANiXXM
 T++toXT8JXEq1EwSD9T4KAUabJ2Wktklvw8V9x0aubmm10o9ZmOsW074U7tt5BERM5Tm
 ys1A==
X-Gm-Message-State: AOJu0Yw+oBr8/caDxYHLbHxWBR6j80yGLrN8o+bXojvqdqUKVBRkDzM3
 qLvSolHgrdwPI1FUPkbdDkSoWdeGyRwp1GN4y2SWiAhDLOnG6eOPhk9lntsKXmKMlBQzamQaOmk
 FeDrl5kk=
X-Gm-Gg: ATEYQzyB4dQA6ADz2cUiuEx5V1/6enDvzqCA+e5ghps95qyoRU6vyVRF6LLiroYfwW3
 rrRFE1vhK02Abm2GVJxHmsrF5bQURvQ5Yla5HRvKvIjk7c7qZ6DM5bvMZDdM1LFdnlKq3LKojCn
 MN6kRxip0Okeo2xkeSvIFuIvlu5RviXq7jzycRxOSIQowqXqHqVw7C/eFVh5MwbxTeq5YpDYI3e
 ngYNUx0X2qUErsmDpvLNqHJEigjlA9ZCmXFbFJ8D0MF/KerO7mKxwIuzA6rBMZOnyilJbaQfRpD
 V4CxVQ8dI/y572gsqz73kPagcDKRPiqkvXjTVuxa6VZMHxCn6PGw+NSQAVegg2+HuAWwAEJwNcT
 +SCcyqtd7O1/hvmifvmgG/DV0Mze6C14rp005+npppb3qiHnVjZvzpyJmHdeeUOVje5S4zh+sTp
 EQOUL7iukNUN3XU66XJn+g+N0frz1xHbg9qkjy/JIa
X-Received: by 2002:a05:600c:3d97:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-486febb5989mr223472835e9.4.1774354672862; 
 Tue, 24 Mar 2026 05:17:52 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871107eda1sm28913035e9.0.2026.03.24.05.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 05:17:52 -0700 (PDT)
Message-ID: <69c280f0.050a0220.2e1b4b.e591@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260316150404.116279-2-always.starving0@gmail.com>
Date: Tue, 24 Mar 2026 12:17:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] fstat: add test for multiple file types
 using fstat
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

Hi Jinseok,

there's one thing to fix:

> +	int fd = open(tc->path, flags);
> +
> +	if (fd < 0) {
> +		tst_res(TCONF | TERRNO, "cannot open %s, skipping", tc->desc);
> +		return;
> +	}

This must be SAFE_OPEN(). I guess your choice was related to the fact that
open() is failing with EACCES when tc->exp_type is S_IFBLK or S_IFCHR. This
happens because tmpfs is mounted with `nodev`. To enabled devs access, you
need to specify a mount point and `.needs_devfs = 1` inside the test struct
definition. You can take `fanotify22` test as a reference to understand how
this works.

After achieving it, we can proceed with merge.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

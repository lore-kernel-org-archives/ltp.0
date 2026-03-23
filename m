Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B66EC01A4
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774256849; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=APKeqPfTKnlJRl39u72vSP2QcRUKQdwj0rd6SSSxEBg=;
 b=MHoc4W2QdQiN4Mv4wNtWE59qOGNOhB3CWT06qBuFBHYcfcWHpOUBouirucus08JP5Vd63
 Ef/pXpygpZD8Y76wIYYwdnf1PfbffevdmVHt+X84V6rsz+xZAvC+q3HnDDbogh6TLCwy9fC
 ghabLP8yc0N+HHEWRnvGXy2IFNl3rCo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 433243E1407
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 10:07:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BFDC3CA1A1
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 10:07:06 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3BAF6001F5
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 10:07:05 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fe2024a9so18520835e9.0
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774256825; x=1774861625; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=Wax6vCOGu2uUlEo1xokcb2TBBrhZZh8LPEcJqVtxe4YfXSi416exWSp/8L1czRgKGj
 iCEwz2QCs6SUGQN41B5inYcE+DnNJIDrxgUalLGB4HG4PH8SwtvbVTWqIj5Om2YaPW0F
 oFUxdm1tN6H4/dSGabz4zVQd1/Uy1OufcoudSvl/SbOHeFfIuUYOvSVf8MfD29NzvA6S
 90wZglfKZhRDynLP6zTbUEcURb47Yy+jFKnJYkaUtlurwKU/Bn5KpwmsK5P/DVn2ezDg
 ZgT6QNkOGLaB3AORih0RY2DglsfrJtFvWSU3BE1hkuXe8g/CdHxQn4CB64NTq4ypUlLe
 nOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774256825; x=1774861625;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=QQj3WZcT2lt6swMdMFp0SFnBwDJRimn65yY5E2mSr+b4vheYW102h89Q+paitLWzUI
 pYVzg3+s5gvM5TZsr12AsFB1gQT79nljleB5MJ/xsx1PZ4Kq6W6sWF2c4fFNghNvApTK
 RAeR89f9qskLtgSeCsFpDSs5EBd5gfgKIXCDCVAeReAmAzCPsklwoGGvaBGwxyxWcV2p
 BUvxzEfwFXknCj7TIiHV9Umxj3E4Lfx2GQiY3OE3Cqo5mo2KFGsBO4PNPBEzPHK9Uvxx
 oCdMBdEViWtB7H6tPrJ7vH3JoUIWwq0sxSuo93PuhvZpCKG0WbTPT3ydiYoxA3jkQ20x
 Q6uQ==
X-Gm-Message-State: AOJu0YyfxrVAmMO7Ad+lzoIRGhe+EdPSoMPdV80E4f+tv90LCv5OUJ4H
 pH5AVA/fJKk083Y2ZkQYbzfSRKRbibXZHgqNWzc6iww8zBGZpA4964++pGUATy90CnE=
X-Gm-Gg: ATEYQzxK/3cJjB1Z7y+k/BRfeUHeLTj1z7MzdbLgxYCLuU8KLCxKheJObAgYmxl6JKR
 /ZP2NWhI1xg9cqRxRkb0HYPC2VBFsGn7kxi+Sff8gTNh4PP6yApDqnJQPMT9yVR0Q6h5nyfy5ba
 hfWbV/bZlP0PdYWE2ZJZ9WcCJuaU93MwbPse1AdEmPZiu/EsSpF2Ov+kcMeNL8Pvq7ch+fVlWZ8
 GGCQvpwS51KAUaqedUHp7CKtAXBxH6n+SaRekRAbV4VZjBJNPcHEGiWN6agJqWnsDIquWemQ4Dc
 nuCXfwJb+m1PqO+4YgUhBua7osGhcLQMCSm+MFiTgngH2Y0pwKKsohLF1ujkMK3hH2yRSJzYW05
 gi442IY+4GDQ4a3wnLFfCy0VLLd5h83DMcwRvaUQm0M0ae3rTbjd/WTqXotDV6axds66XcWN/fA
 CysWSObdir2vI6l0X35ql26eOLinLiMgrqFZq49FvotS0=
X-Received: by 2002:a05:600c:1f86:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-486febbc653mr165094245e9.6.1774256825039; 
 Mon, 23 Mar 2026 02:07:05 -0700 (PDT)
Received: from localhost.localdomain ([37.160.201.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487017210dcsm218831585e9.10.2026.03.23.02.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 02:07:04 -0700 (PDT)
Message-ID: <69c102b8.050a0220.320fcc.cd57@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260323074814.2930709-1-wakel@google.com>
Date: Mon, 23 Mar 2026 09:07:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/file_attr01: Dynamically expect
 EOPNOTSUPP on tmpfs without xattr
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

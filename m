Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4534AE9B24E
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771928459; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=jJ3VxQ1AeZmlbhkBy6oq4K8HmQkCFppKAM2ezlDx0fA=;
 b=ScG+Pq8q756wiIlgWCXwrKq4J6IiFTsUnbl/XxJ3Y+hMOVrgMwUeOT9cLHEhggxwKgKcG
 BK/miD1GpTCGtYx3wm0F8JMAyIV1vgGlcCTLvEWXogKteHy0wwl8RwxBzxXlk99X165+yfW
 A6oWQJhopnrdfg8Zubgdm41l3yxssKI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36AA3D0F80
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 11:20:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F17423CA177
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:20:37 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2C1A1140013B
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:20:37 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4398913af88so252900f8f.2
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771928436; x=1772533236; darn=lists.linux.it;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ai/6MEhpB9JUWZO0Vhxy9twP1TfXygro/bBf/6Lsq2o=;
 b=P1dxlo/HQwvapnk3VHeJ8dHI2EEJiAVEJZv/vLKVEuFbODrYIl5Ua+OjJC6xqNZNcE
 +nJvEbi0cdql9GSxeJ0gfLCIahNDyROVXgCRPhLw/ziDrtLhFVJnB6nHvCMlx//mrVK4
 AW5No9adpxekAdviQx1VTF37silF/SgP6cWP5L+c+qq7HByxJ+0/eYztR3/m+xkc3Np+
 fFPlXkjf89efbFMEbwBLwdkswKQMF/NUUzoSetVMkCSNj8FMjYvjnp87kGEjdXyvcTGW
 TIES/FRTYy+toSFnnZa5AbrctkmidqTg8ArjmirFYbB5NiDOfKv1JcrgOTAlXH4OelsK
 cAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771928436; x=1772533236;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ai/6MEhpB9JUWZO0Vhxy9twP1TfXygro/bBf/6Lsq2o=;
 b=aOGROjJpQHF1Eh07G4Ul8VidQuzG5cp43dRvVEi3/bOOJcM4CDPoGGear0FFF/6Idz
 xH4tMnVc7NZFJ06+zJCxnzI/HFGkCKpYLnttfsMzdBeQwrMSNzyQ7cFdqPAICu7BB36r
 MsY4/QxPLySIP4U/TtA1dfSnzcSysO7hjoem6hFCfz5I26x3A2a9VfDMavymSxSh+NED
 mRycJwpczRfvQDSuJ/n7EOMCSKkuQSZRbbMrFk1zYWVr6Qvc+mj2DJAbh45Xj3re/urh
 rSALwvxiwyKxahIFmhyLvh5NwikWX8zUhrn6Mqhd5FBl+uEKJ/OyYJsmG1Xbwmf+ZdkV
 aHcg==
X-Gm-Message-State: AOJu0YyeY0QJcIgK/ODGkJztm14UPY/I/++oDMWCtz53OaUkPDsOacf9
 RNMYNq3rN3KBNNlnKmE1wNP+su/HGTNtjp7CfBkRLS1sjfx/1bzK+yEL1OvdCf1yKAkLhxsfppQ
 7b8qI82Q=
X-Gm-Gg: ATEYQzychAzRKb4XY8B4l7S1IsqLkbMFZ+Dk0dvF4ixOv+e0Dw74U1baOA1R/ukF1KU
 tNu0IYfO6qQdT8jXLNHUXGrv+fxU/OVgyGP0gfBCKlOCskiZdSkfItFRHUgTAt5mu1mOsfgRZ5o
 91Xo0gVpWhFBANsSyJiKhZ6MFrxFkJHkIkmUiFRR1xzKz8nrv3sw3CIabXZC/lP17ANgFicPwUv
 QNVamf3pnxMsSmijUrxPxDNVBsUV0KcljgMTim5DKJ/weq/Y5pZ2WXbwsB+4DTNs/Cs0n/0bAXg
 OfOq1F+qPlWXUGkPEVQ6aA9JqFtBQjCZF3oEg/3KOWmvFs+rrgJi5j78C6ZX493I09CHqm7QVUw
 T/46ti3IWnR/6mUcbUpFhDo/IzB5nVV0XSNQK056DN4wQtv1UkvF3g7ISf9iBU2roPFrsyJCAcf
 E1hJezEsyqUeDv8KOpkVglLNs+Ag26dRRrVjwWc45o5+v4m0MaSOVIAJBjNjgaD0wMUWTCVn+gz
 1xXEeDewhHB0R11fkU=
X-Received: by 2002:a05:6000:420c:b0:437:6963:a115 with SMTP id
 ffacd0b85a97d-4396f18534emr19464528f8f.42.1771928436460; 
 Tue, 24 Feb 2026 02:20:36 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c626sm28610185f8f.28.2026.02.24.02.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 02:20:36 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 11:20:35 +0100
Message-Id: <DGN47HRFMU73.6AKMTBA60R3K@suse.com>
To: "Jan Polensky" <japo@linux.ibm.com>, <chrubis@suse.cz>, <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260220173928.57467-1-japo@linux.ibm.com>
In-Reply-To: <20260220173928.57467-1-japo@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] [STAGING] ioctl_pidfd06: Select expected
 errno for PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
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

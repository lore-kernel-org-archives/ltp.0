Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B015AC44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784622202; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ATWAoPZYdD4Ew5K7cG/8HNjj8ElDhuWxkOdNVe6xBII=;
 b=YrJTyvnx2rW1/bVXGOuSk+eWrCXTA5bxMYRcNrMc5UtIdUh8+LGZqxaBko2hvv3LFS/Nr
 VTkEyVolCjswGsC6Wg5W9xOVEw/78qmtvnHjtLxq3jX+X1YVKPbRlyv4fuw6OJEVqrWPGen
 TAGc/FeA59xtq+7A0PbiwLZamthCEyk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2DE53E624C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 10:23:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263913E203E
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:23:03 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 89C421400BC4
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:23:02 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso5427767f8f.0
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784622182; x=1785226982; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+tRK6QGC76I4Bgycapp3Ralp9hD0rLCiZGLTUGYma2Y=;
 b=e7JGhw0vKqo0epe2p3fqfl7S63y54i2jvfXP/Qumgv6nvS/Yho+cgm14qb9rnilE2k
 9ZTSw1NOL8ZFKZPxm15dikR2OrMk+SV1aFpengjDmCa6Du//Zu+prOme7f4aHwidtgcS
 K+yfDMUk6FYY0YFocD+gDs67YDxtXx+usRLLXVlF1luk64sGd1Uylz9NVBkOzxfF1X1Y
 fV2MTqs33m6Nc0SvHyfHpf42/yplzCsAmPus8H6W+N8ce6+0YrzUXjDMOA05AEnufoq7
 XMKgvOAM4HjUtyWjo/rs2fsSmb5Q69fluxToiC+EEB3hpuH5Y+huejsrmdYoXhArD4AJ
 zxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622182; x=1785226982;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+tRK6QGC76I4Bgycapp3Ralp9hD0rLCiZGLTUGYma2Y=;
 b=WnXKm3H+XyndGx46Xg7L8kiNZCLxJHcKzktouU2XKDbwSUJLCnTPSlJlrmBFj9El/6
 f6EELE6p4zAymBvh+s48IE//XK03bblGyuR90gtamIerIT3wucdEWNhLg9/HsfOcS6l6
 MBAfzl00h4o3QBLv9S1rbskjLdDOOSu+sq7w79J/zpLC9K2JL0ipb6OoeBsYFoqHtMPi
 vztcJw0owSLBA5DMAUBEwbaZFPZaXkrVS89rqpha5J/XKA9/ZcOmzRCjl4mfys/BbMh3
 UqdmFsNug0El3a2ua2zU7nR47N1eU0YAev7joqoCKNX6qMWeyLvGGZYZjmIEeA38hO8W
 ++NQ==
X-Gm-Message-State: AOJu0YxdvEAxf0o+5xoW5q+Q8fzn17MZsLTpCuaKstCnBN+Hqe3Tszrd
 m/VIsGiJLtGP1YEsTLJO1Gu/uQE2G49egx3cALEVvxKYENlJyOOlcQtiq3mUDvpFe/4Mzj8ajAF
 mASkZRFIikw==
X-Gm-Gg: AR+sD105JhBfbvMweR20rg0SXGD8f5+GkyXsxYGSkQTNQXxA3h01kzRK5z8VezF0v4g
 XUE4QhfCiphp9i7O2bpkkfHX+pAMuFfSrriYN7Op9T/vRuh/YwrDgDzXa9EUtKTbnEdig+SDCKJ
 0fEpXSxzduWd/tzWC+rqm9lSwsSNW2zL+lTggHHy4u6VFerV120umBy/oj4Skxju+RuH+BcWvbc
 +HIONzv5Uo6zzFn3lN1YMJdrB+GLNVkxoFoIdHZW62l7l/XHlG0yoVdPVrWhz7TO7CKLldRQwAE
 JM/UBwf2VpIBuJ445YEtLZjiEvaQyKq4a6guba9YEHOHuV8M2C+97w5ud/+80Zf4U2QMYb83lHw
 4lNGUXrAtbhy/gocsPfhXXgmRJLyy2NnNk9k2IH5iDbiftqT3s5+ZNufZ0/AhUiXu2ddhXjwmLR
 hixBfi9gxTzTSiohmml3m5kNVxFw==
X-Received: by 2002:a05:6000:4028:b0:47f:81c6:5a38 with SMTP id
 ffacd0b85a97d-47f81c65b4dmr1170479f8f.18.1784622181781; 
 Tue, 21 Jul 2026 01:23:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f69e5eff1sm27605945f8f.19.2026.07.21.01.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:23:01 -0700 (PDT)
Message-ID: <6a5f2c65.3fefe569.30a19c.9c0a@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260721074146.2779-1-wegao@suse.com>
Date: Tue, 21 Jul 2026 08:22:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 0/2] open16: allow restricted O_CREAT of FIFOs
 and regular files
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

Hi Wei,

can you please send the patch-set in a new thread, instead of replying
to the old version? we are having a really long thread in the lore
instance and it's getting diffciult to read.

https://lore.kernel.org/ltp/20250516151028.1254207-1-wegao@suse.com/

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

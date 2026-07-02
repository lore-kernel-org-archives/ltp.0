Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA11C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782992947; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Iat/TDApH1ESZyGmMzOlP9Clydn13kqvmHkw33iOn6o=;
 b=PvRUXg3f/gp4TwioA0pbKcLrm7OPb1SAH/clFRfT1lmmp09bFLNHZe/VB8iuh7hVoXcHP
 HBbPOqSWlFKoRyQQBkIvhsH7iudUFcR3fNXNIdyPqayLI6EjTCdzeYQGHmKT0077+j1hrZM
 sAHX8ezAsCkKBVL+qfjGODukeJ3HUe8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96FBE3E4A2B
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 13:49:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28F3A3E1459
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 13:48:49 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C8E81000610
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 13:48:48 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so1966500f8f.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782992928; x=1783597728; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mnp04nIjTCJbE5dpxib7J5HeYxArtxn46ODyiUH67H8=;
 b=eh+H4jx9n/CDKQ2fi3ruqZV694nfXihCYN4+Wvf2SFVR285K8IV+8zvvBCAMMMtsN/
 e/ixj6Lbc9GXvqwDQSsOYiIyQN0FFPlDO75FHIPbMScKjys2rSDU0DfLcieJjLZIwr6+
 gpH2mTxG9EKommG85tbkSAr2GQHQz3kY7mbK4qf6YgbKKV121W4tZc3WXgE1gOVPMpjU
 DkCRBBt6WoVpaHUtCyoxIJkcKYLkSXi9yZpCyYzT+HbaW7DU/uG1lSt6D3QukzvmDjpL
 lkhwub6HTpbilzZnbNA8BLyHckLiaCzcfBCnj6hVPkbtuBVdYw9jAeHeay4AgUH5by3G
 5p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782992928; x=1783597728;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mnp04nIjTCJbE5dpxib7J5HeYxArtxn46ODyiUH67H8=;
 b=lpajr86xTEs2gpLI/oOjq8tBsTQPlAjcErjzXtutGhv2yLaAqd7zSobsUkxviZjzuj
 0hmVudDm3164zUkIx9nMwm4DC22vJcHl5MGIUmvGNOhIWwukyXbUI8FChr6GhPsA7jeH
 +fNoK2wxBmFqpSMmwOTuvXghPq/ROKwS1jQb8+Yexl6Ahr+Bsd1Z7ATlefJ4g8cXsj0k
 IDU99MPT82HkQojj9HWxqybY1qcqrd/su6sclgKACJxbDYYE6k2oa2Q3UhCHBzzlE9cI
 B3N54t05H55CnsCMwqz/ALgp+7JdccPNn2fjDI+ZKvZBvV0tfglpOIq7h4ReNlo2WT/k
 t4dw==
X-Gm-Message-State: AOJu0Ywd8W8q4DJkwS+k/2Uw3JtEgRZcCy5wru0Mb7YxjqqAjA8oNU5F
 YCfvo5NKwOBpfRTBOvS9f5RF5Ds6OVa1IgVOv4aXs5JPghfYQ34bAhVhfUMDFFKHdWA=
X-Gm-Gg: AfdE7ck1zoeyyVmSkCJSqxyu0TBPwxQDMX8zqf6EbvresIB7lQxM3V61tuZl6sx5T7I
 jjDC6a2VUz9nkgwldNt8IEbwsRBSvdCKkabrGEzzdhDRR+423G/b2gg19WzQ3e5Tt/dGF+f1s7Y
 D7iyyLycANUu5XiP/nauHu80wROrAkiHybVWbIScy5DH3aOXEvOqJrx/cR0spHGtBgqaAjJst9C
 n5bqWZXOJShFsKeaJ5vX5lv6x5V5g/NinziO69Mcfi4fKUc0e4NzXwlc+4Ieo3CGuUi0A+SxtDi
 SEnGo3eNGWts+aLWBPZf/+CQUI8LRcNmb5JGNmJk/P9DCCIoNPSGE9hL6AFcT/VDThwhScDEcEb
 mCWf/sDiHGoqPxbYqYtzhboS/Rxh8lQUWd0g5VqJgLLME6ITw/dwSJeeb2KPaFpkqCSw0Jhm7dy
 qiewv0BouYZQ/IhPdo5oWTTxIcy2NS3+HG8UDavGfuMJlMX6qqMa1Q49ppkTFl3g==
X-Received: by 2002:a05:6000:25ef:b0:474:fd7a:93f2 with SMTP id
 ffacd0b85a97d-477b39830c4mr7042458f8f.15.1782992927900; 
 Thu, 02 Jul 2026 04:48:47 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde19fd3sm8491672f8f.25.2026.07.02.04.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:48:47 -0700 (PDT)
Message-ID: <6a46501f.8509f64d.ec809.05c0@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a464ecf.da15fda7.265c5d.795d@mx.google.com>
Date: Thu, 02 Jul 2026 11:48:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] statx/statx04: Skip testing casefolded
 filesystems
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
Cc: Wei Gao via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>    if (!strcmp(tst_device->fs_type, "vfat") || !strcmp(tst_device->fs_type, "exfat"))
>        expected_mask &= ~(STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE | STATX_ATTR_NODUMP);

One more thing: this is a snippet. Remember that we also need to filter
out the right kernel version, which is the v7.1 at this point, since it
has been released.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

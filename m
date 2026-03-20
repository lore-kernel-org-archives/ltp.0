Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214F81098787
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774015004; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Di35tdBFyKBi+U6Em093LEBHAn0gWDJ+duYEMvfwcCA=;
 b=UjAY4TadFghuU4iWaDSL5ZhLiaYVRriUBcE7f8pLnotFqO+e8nCVd9pSTJkHGM7JmCy+r
 i9vwSo8U5Yqd8AsGS6LxjnGHz2hDYPOQl3Z6Piv+DnJHMbYynN5IUz+351HziQ45tHNLTfv
 U/fBPzXkPTyuKUMryrD9PiaTu9ZdPbk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A1B43E4EEF
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 14:56:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E18CB3CFC0E
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 14:56:21 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7039F600455
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 14:56:21 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso639868f8f.0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774014981; x=1774619781; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SsBUk0cSnos6vhlHpVsGWdWs2ZHfOMcD5uN/NUw1c14=;
 b=BPQciLXLDcFtt+77E0jt8U9TxUPhpBs3+kLAse8/equ3ofpNH+gj3cyWKdQoD+duXp
 6i3HSE7v8gitJ7yCHBfvJ7m8vha1h7eHSe29UzLKyhmAu1lMef8ce42MRVna2xm6/PHd
 Bxwrxxc2HC5rbPUIYizpPwc8Ago70tbNzITZJtgyAMl+mEWh4QjCC724kyaB8zFWRRoU
 bM/UmMS7KYnSpfbb8oSqKCiOecHCDpanUB3k0LASFHE7BzqRbBcpKM3ebCgWYHmFMY/S
 7iSh7iuGvcaD4SfsAWBZ9LaX47XNL/0AvP5Q0p/uP3JmKwtPZCBkYsomspwM14gbo6b+
 no1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014981; x=1774619781;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsBUk0cSnos6vhlHpVsGWdWs2ZHfOMcD5uN/NUw1c14=;
 b=CLZ6OB8W6BV/x+FYqALgQ3rq/vogHmskM7+GLMfCmpfrzWuaHaRd3aOd/GkcRERet1
 eHIFNQf4lx82sSfNFenekzZOF7t316lk1T4abm1J9GuuB54peqVkaecOWwNnItvZbkPY
 C+sYKSBc0HVkRmKOvQv7drW/yPwqF5ZcZLcbv3pAeQQyn6wHDYXPry8LbX/ZEEWxb1ar
 kGoNd1omkNPdrx+alCnacHceKsXVn5GrxzuzWLA22D4ln1HP55hm3UUb8qcce/gwva2c
 VesNRX5nNzkpUfvrrZ5DwOenoW74o7SRT9x+DLGpYI18DYUMnFPosO8gFFFXf5d7KcG6
 QS7g==
X-Gm-Message-State: AOJu0Yw2EEYK/cG/j3hOmveKGkpyFi8Dl1Sw4U4fGio3sXrATrv/aGz8
 mcLpnf7YSI+lHlLbsAVCYZV+fR/Z4K89Pw4f3w25Tci+UvjWHgu747j0TLGbkGQOY2I=
X-Gm-Gg: ATEYQzx+MxSrMN/gbJMXZIsszNL2toIZDO0KKYAC8JfkqdVolIwmR1CeolRS1YNEbS/
 jIC15MrqEeueNGsLwC+oO89IxSpNS/JpudJ+aBthW9yzwT6szq8ucAM/m6YvuhlDVPAQ+RXh3uL
 8ijRlmcmGu5EZpOQZ6xljPLfwmZrlakOFkLjKZN5lzGsI4oPPrS2HX/kPIk8VVB9mg48d49iRFU
 L3XqmhQyrnL6yvqo55SyDdcBwncQ8l2Fn/Tnt2TYgKsIt5cja8O+O0mZe/Vk2c2dRPsmTb2u2r6
 En8EdK/N/G94yqHVzwUFGz1fa/NLvTZ72X6xvURYHnkQ+nmRF/tloLH7awvo7XEya1ipqwNZNoP
 Kue/qul5+T/exktuUoXLKcFOwMWmGaMxjdS05Q2XmLiQ2saZboDaEBhk6RAgZvDSTTcP0WmX68F
 XwD2bcTrWfbOvaZmUbv7MqDhcEVC9Eb/whr2bcCF2vUeRSbFk=
X-Received: by 2002:a05:6000:2386:b0:43b:5b25:67fa with SMTP id
 ffacd0b85a97d-43b6423b837mr5939475f8f.18.1774014980596; 
 Fri, 20 Mar 2026 06:56:20 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c7fsm7100043f8f.23.2026.03.20.06.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:56:20 -0700 (PDT)
Message-ID: <69bd5204.050a0220.1a0553.f197@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260219141532.6513-1-always.starving0@gmail.com>
Date: Fri, 20 Mar 2026 13:56:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] open: fix cleanup condition and use
 snprintf
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

Hi!

>  	fds = SAFE_MALLOC(sizeof(int) * (fds_limit - first));
> +	memset(fds, -1, sizeof(int) * (fds_limit - first));
>  	fds[0] = first;

If you set all fds to -1, then we should also check that it's not -1 in the
cleanup() loop, otherwise SAFE_CLOSE() will TBROK.

Since the patch 2/2 has been merged, please rebase on the current master
sending only this corrected patch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

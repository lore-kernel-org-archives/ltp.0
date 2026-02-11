Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E0E9E301
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770814912; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5tCPRrILihtHVulOgj5bkaBqCPYxNorE6I7eDpqYwlI=;
 b=TJ8+59b3rT4Zx5LhcFOGm324zUEuI0VkJJDOIMdbbiiREZA7fyP0ohbuCXUuIAs0mzips
 9D+jLUuAOFw4e+UxxKNqRCskFioqLYA5N+HldHu92ZP8oOaPezmWcotxwQKTKPqSQ+A8SWq
 ln/qc55mq5aL+nx9b9y1t8tKqyk620M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35D573CE514
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 14:01:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE0503CA0E3
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 14:01:28 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 100111A00611
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 14:01:28 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48068127f00so19480065e9.3
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 05:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770814887; x=1771419687; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaYymkZuONC5wDQ3LGmRuf7go9epE2ygnKZ8odacttk=;
 b=e5W2I943+TeEqx+7cY+6+/nRJV15SUGiCtrw1Q+sclgX7aB3cyL/94LQ1PFoVrMWnj
 Kxy74WNEFv3uQXu8E5xkoUKKcachOc3hugqg6gGY9Meiem+uJyTER/sRbyVj2rDExZ61
 +uF/Pc8z0sGrnKLqEpCgmwlgjf+na51kQQG+xtlSjWj69BGkZitm3sMpoztDB6h+4l5v
 6B8QUqpF+IMaki3X5m7CMOsv/+sd6WkW3T8ByPAuz2JONGVXJJCuQ+ULlnrXslV3Er1u
 FRw4wrUT3KC9TDps+aD+xySE5zwK87RsEWzlaH0b8FJjlSVbrckZF1CG5TfZhLuM2WCq
 Zb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770814887; x=1771419687;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CaYymkZuONC5wDQ3LGmRuf7go9epE2ygnKZ8odacttk=;
 b=IrubZ4j/15zbH7DuqTPvbE+nY12mAkmF41ll6DwK4VGD00p8oPtGJLFOfBZrDcrkoL
 /RjMvtxgKhheWSk4PISwCk+ZxwtJEyl+UA8oIBl4N4OnZvteLm35QKVPtWlW0i8GLiVF
 QzrMUDC6/yIe00fHaWN8gghmrsYNt0LUOu1GhnjhKyrZvTontVFIoXKyHpcA028XESXk
 D6KFOkoNfBlMrUZR4FVwBSu04L6c4NawA/kL6vlhza9aTQHTTlPrsxxTE8jhCjx4bbsk
 qOODvqlRuYb3luvCeN52yL9wNEYTXS/y+PPZjdS4TFvFTKkTFoVW19qHAMmiGp1LFQOy
 Il5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjpdpVm5bhLwtFgVAoIjQQf7Bs1hBJCa6LcRYuC5b4vU8hAnYwMNbxLR9BI53CUUXcm+8=@lists.linux.it
X-Gm-Message-State: AOJu0YyURW18h9OQBlAyPhjxugAeSrL132vhjkK3jQW4ehwd0qs/bbzS
 aQMjHTzvIISfcm3tB9q6mwpZNVRgQvptDsM4YpYXt1q3mL1B8fx7Nbm/ffXOI1m6CXTMYFignSk
 6UBBwGeo=
X-Gm-Gg: AZuq6aJ60sM8qHfhdBQnXxbFvq5KYVgHbF/m1Tip5HHDsJt650H9OlBeE6QB9lxK5F9
 GE0OqjLknYFE+szQ4/bC7S9C5X6ziWvCt663g1FnC/pRPzo+LPxmOPQCXX8/iy7UtixMQrnTwhL
 LR45COzDYYZk5HfxcoxmBbH4fTjO3K+8g7HGk2PJ41iEDUWPqjia5czxsSWpnteJ1zrD0Ij7L6+
 oy9Zyh60fmwFgS6KRVWB48FXiNJnkumdLJ3SP3iyer02BK2mUhJnm2tRvcRMKJvFyhV2BdpvSmy
 Dlrg+GwN1Sqtj0jO+t2r3ExaNsVFLEPfq4jpT7M+a1r1IMm8k21U9W/xnl6tQpaKv1cjUWS9UVX
 EyCG737rZX5Mn0DkjONrDKpEr9q35YiZr0tZ4518NvdrIv+8J43/xKN25HaeuIB3vMqmINLxcYp
 itWA6ooWtiD7amIQspZgv3g2oEt4g=
X-Received: by 2002:a05:600c:468d:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-48320231180mr218748325e9.20.1770814887100; 
 Wed, 11 Feb 2026 05:01:27 -0800 (PST)
Received: from localhost ([37.162.249.193]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836131d506sm7987765e9.32.2026.02.11.05.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 05:01:26 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 14:01:22 +0100
Message-Id: <DGC5HIFR0BZ0.2PK69S4GGSREQ@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260203125029.15413-1-mdoucha@suse.cz>
In-Reply-To: <20260203125029.15413-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Rewrite aio_cancel_2-1
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LGTM for the whole patch-set

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

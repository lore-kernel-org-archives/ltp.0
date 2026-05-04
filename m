Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89BFCD3423
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777886818; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=151d2kv/+l6pOHXsWZdye4cU9q9uT+EYI0//cLELNg4=;
 b=aGtKTJ/RvkVqfMHp1hE0jgINLg9v74BKtxJiTdpqu3wPkVmFcDUweW59I5PD6JrW5JkP7
 g+Z92rubxfyVPULQPCv54Scbr7psp56fNpWwI0gqPO0azamX0+94OkgXZSVzeXnL9xwo1L1
 gg+a/oQDJHpyrTMGqTAbb4yMINBKJr0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41DF33E4822
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:26:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 482153E1FD0
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:26:35 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C456C140026F
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:26:33 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so1965010f8f.3
 for <ltp@lists.linux.it>; Mon, 04 May 2026 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777886793; x=1778491593; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qLwHAjuZ/8Y4TlZ+7r8IK0hJW6fIhdZCp60Me6mml+4=;
 b=cYDGbD1r5Tle4sR/0gnUdUIBoY1icLfEHXTUwgKl6RJmR4cZliQq96B/17AqKZNvNB
 m3zfOUGMhDw+7yR4r5mP63dmFQRJP/lyyk+xPWiK7ISAnhd68UpnDmBmaJxx6FaDxung
 LzFy6KdTMFSfQa9+CdWcxHVTg6C4omWB+wWJFgb2P7RNLpexCBWaaqjVgoJlZswjI35n
 lYJPfYHAx7lKVk2joo1f4ohadi4zu3HQIhnPQBJ70xdR5F2Ovo0JPVpKOfFV4VE/i+P9
 8TWKuY72imLbusNAlQwo6cahLj61uReMxZxh5+6KEegWbdf3ER2wESkqJ5l4w51uaEi6
 KyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777886793; x=1778491593;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLwHAjuZ/8Y4TlZ+7r8IK0hJW6fIhdZCp60Me6mml+4=;
 b=ioj9Mb4JwSDB8ylSz3D50pyR3b5XmUfLAm8ZAhNH5YF3YmXhViDHViLV75rqtdfg3c
 Ohyzx4yBHa/DPKfE3HiXzEILmCdL+onWJ0F/ig7uaj0rtHAAIpP57EKpXi+WaPv4ilt7
 04Gt406LcdClnZUrktTLQ5CjdRI6OY0xHYcd5jJXbEG2j4xad7Iu1wwevd7DBfpxW1Ei
 ngJazKOF5aG2RFlNXO2E3NcXe7tcH+0A48h2df9/9tMF3SmFPW5pfFpZvKBIOiK3Jr7B
 zuudXsYGM+YMaoCcenJ+0/Swj8F9qSLXjZ6ZeDCzZ05fhQJxeMDNXUGiPXK+wbHwM3ww
 EGRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dcQ/dsGSUVC0WLZ5x1Qvx/8VP2Ha3Mel9T97PYFXbDG4WSIsIcK9UI8fdwLtMDN2ydLw=@lists.linux.it
X-Gm-Message-State: AOJu0YzXX/qDSPgDtYgUSp6JN5k4vanY9u39Z+aMqdCx6RsG1HX7p+Aq
 VzgJGCLVb625cwdVMbEUJFn8sAJo+g8N9Uud69c/vaj62BbN69HNKHIa19FRpNagsAw=
X-Gm-Gg: AeBDieuCLlEVyUUxf0NyUWbcWW4N223VebHuERVxmNGuv2v/ySxmAIQvdAivsek1zfU
 d65UgxDmJu4BkQHsbieAqEy4FE5zEJQdot2OONl3siE/SQkZEHTrZ6ZKu80/47qD2u5TnO3xX2o
 plY1Zl71vTnq6QSYclxYbCmOpucClCOEK8bsQfNuTHHZwlespO1s2cYUbnQbHFI/BKbAxb1muUl
 SvHfTUGVff4GrsQKZjjbJ+JbejcFv5eMnlOvoo3TTHjAAQbPk7yr/YYcR+3m1Y6qducVM2u5gGN
 URo4Br/Ho7Zhgr61zTVNGVDhH4oikJW03+/bvssYkKZJZ0/Qgq6HyefU2j1b8GybPdX3d94j/7J
 J0/XZqdnWr5plAvGVRO0okVsGj3AkfmdjYCCApa1VOxHLqgwWaw4PNmrQNntISfPMHIcsJ9pbGa
 M9RVsCEWC+SsVm8U6Atnw+AiFRLYYG4Mi6+X4XnKuLFt0APY8Oxyx5
X-Received: by 2002:a05:6000:2f87:b0:43c:f8b4:e58 with SMTP id
 ffacd0b85a97d-44bb6ab1e87mr14102963f8f.41.1777886793121; 
 Mon, 04 May 2026 02:26:33 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a981dee7asm25455153f8f.21.2026.05.04.02.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 02:26:32 -0700 (PDT)
Message-ID: <69f86648.5d0a0220.1636fb.612a@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <afhh6HGimjQqHvWf@yuki.lan>
Date: Mon, 04 May 2026 09:26:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +#ifdef _POSIX_MONOTONIC_CLOCK
> 
> I suppose that this not correct either. If _POSIX_MONOTONIC_CLOCK is set
> to -1 the CLOCK_MONOTONIC constant may not be defined.
> 
> So we either have to to do
> 
> #if _POSIX_MONOTONIC_CLOCK >= 0
> 
> or
> 
> #ifdef CLOCK_MONOTONIC
> 

You are right, that's indeed a valid value. I double checked the
definition and some systems might set it to -1.

I will send a fix for it with the new version.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

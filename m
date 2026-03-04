Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FA5EF8FEE
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772637459; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=RqgPa74io1rLHZ4zVq9ibn6OPZyA/OMEsgdivGANHvTg6X0FG/2Mhz8LUS6VrTgA6xDII
 3Hx4P/jYHpToHAyFZkvu4zHaIAydMV7UV/gM3w/fZx2P6+Dtk/M70JFCbhakUCBDXGTjurC
 /fOXYLuZsCWiN3xd0nLlJFQuMIggBkg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2AE23DCBE9
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 16:17:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F8FF3DC5C0
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:17:15 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB5E4600B44
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:17:14 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso74754115e9.0
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 07:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772637434; x=1773242234; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ewNxGFx0My9E9zlrOo8C26/BnTgQKQkb820XSJGVcIRSRnKv82qbsp2kwR3WgGxBoV
 0fQEy5uuv/aKkxNqUQzyQyfJAXm8KF6dVveZKeiZqj7rjau5UR5ADbUMkOL5hv/fCVq+
 Q/R1pgKzRt8d44f9K4DggeyfjC2neD5PoIOVO2xQ4VazyaYhMe2mHROLsP/nGkTf/PZV
 Hx2U69+FwWUQTy3s9WM0I/2pmcNIQqxSt4XoAR0HaPlYnAcWGlUY7+VXxy3oG7daULXF
 cOMNgoieC4GkLE5IJcDXCBLpfEsvT7Vq28gGyTAOjZYrGiwe+HQatYDyBaPhAW6WLtxZ
 Dh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772637434; x=1773242234;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=enJjhIC7WXGVB/g+/wNHi8DZYlCMIKwII3tdEDIm+IVtvHdvWfsXrdET6qO5r0mso7
 Pyy0+0Gdvxl89T9kHcZPASZSE5ePlbM/psUb2cy56kvLqxlQvXekEOThLpVLRxg5ebAd
 F2deizt/QLlX32/28KHOGwzNDNtKCGGhRM9RmpQelzrqm0gRJR2W7dC7BW6Z8cqS0xJh
 6DRGhDy/LKOu1orMmld1r97HCFBepHn4d5WSv4AoHfR0F0DZTke2L/UlM60Y6dvtjjtu
 KgCbmQEA/+JRTeZQNFhwgPqdg+AMqJTAPXBIUhc+wjXN7BYkomBW1XgdTuaxwkqKY4lc
 +khA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6sZDWZvIkv+Bj2RcfMgicfNqvSn72sqr1UiI7DTodgqNeV3Legamt5TPwHZd73BSuWD4=@lists.linux.it
X-Gm-Message-State: AOJu0YzZfnCZMXsALD/vZtSUQ34z6ALhT3oF3TDsaggoL1S8YMpXZPXn
 nWkLtnLmyLPA/L/MvwPCCHuUiie8v3pMM1431hwYHHjxM+4OEc/lOVyBJjel3odIL/Se7vKXHLe
 Yo/sC
X-Gm-Gg: ATEYQzz6mUZbsPelC32XLjLPLMsZFZOJdd7pGsuvVbijvralvDoqwspttwX+YUq6uCu
 DBtt6t0t10mDTaPtBlQffEideMU7oWg0iOS9wgrKNnsqVdoigwu3ZEqRl9Gj40so9WBZNrmKi6q
 C/arLZHzzwlmfgE7LiCTE76mRoZElevoB4fiLiIeTTex2wneXYNkuxA2iR/D0wN9w6lrXvRshJj
 stkvIvsd9goXgPXmSQIGYy8hqMAUlIOtLXy8knAXK1tZidDPRVExcIh5dqfQm+iEftxBBRwnFrb
 M6cciQK6q/ce2kqHYz/hJvLwbTkqkW2dUadBBegrVatcGGBOkAkMC3Oicva4DK+ww2KQnVsbRBi
 VgUuCWGjnZhGTFGL84mxcq8SkzRsiXupk8GxBKOU7QxXmmdxP7wy0yMa9cv+cEPaSqzdvywQvsK
 0Xu1q8MF2AjokN404NJknjqdgbMPKpK0bzRxH+zI/f
X-Received: by 2002:a05:600c:1d05:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-48519886d70mr38576715e9.22.1772637433820; 
 Wed, 04 Mar 2026 07:17:13 -0800 (PST)
Received: from localhost.localdomain ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b03db76bsm28559556f8f.18.2026.03.04.07.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:17:12 -0800 (PST)
Message-ID: <69a84cf8.050a0220.aac87.80ec@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260304141236.9080-2-chrubis@suse.cz>
Date: Wed, 04 Mar 2026 15:17:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tst_test_macros: Add TST_EXP_LE_LU*()
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

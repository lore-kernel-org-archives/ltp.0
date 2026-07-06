Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728A1C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783325006; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=aXCO8GRMV8Q9MZFRojqS7CE/5KlFeShtCuFkNqpy7R9u6SeGIMuPBurHiJDf2oZYHvJxK
 q4+7869z5yElTgcVFIlvYt7XNh8WSb/IZistepSY7IKohmAPX1tnF4KPgFJ4P27EkxnqIz3
 LGWBOXFTHQLli7NHLvlCw0yyCb6bfnM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C29BE3CC895
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 10:03:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED04D3C0E56
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 10:03:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 385321400441
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 10:03:03 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so20389695e9.3
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783324982; x=1783929782; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=WwetU2DXdhLPlhBT/uh0/vxSHFBJx4kzR93Koh5Fs3pnmBLqv8U0vSQlvfVeueMAOF
 flALfYXo/WYxygIQiwVBrh9JYu9xmSGFMPsUiFvMWh+8XCcqzKZMUC1GGOAayGv2ffu6
 ejbxjMj2TiQNaMbprqM0Utkx0lFiP7lRPp16hD2Lbrrt9OLQPWaz02dp3Ywh7emO2yZx
 /RJWyj8tp8PQ6YhwG6MlenLhAZDbvH+Qp5iM14YuCXWlFYqLM8ns01LLqN0Vy0iT+/Xu
 /ZVtCOPw20WpiNnins7jWkkBGupEzXDWll5QRZlat/aUVz5leOiK0yIq6SgUXrV9iY6y
 nASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783324982; x=1783929782;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=cs9KJdfunD2XGW+RO5gqVxq3HlBBlqenHy8e3NHyU1q7+1wOrZ0cncvMVrxwz2dTBZ
 /jdMyjRdorC2aPgrstvsjfRnKClNVrst053QfuetQBL5gbZc9yDo07m2HzvCfKg+xi25
 LHEWuuT9RCjo8PBzuSOVKEoGewnsSPskp/8/3b9GXQIp9s3NvtZYmyGT0/I6R7ZRJhv4
 T7xslITj0Q63thQ4AHUoVCF+iJkS5O7gVYC2h523BxjyxxfcnCAeFgv+aRvjFN3rTngv
 3vG/ZjuaBhtSreAoZuFuPIPQPvRKTNDZIUnwvk7z7JU2JEo1wA970fmF3aHlQkeZ/2n0
 w6lQ==
X-Gm-Message-State: AOJu0YwUzm6CxFERgW/JY9W3k9TwVgKZw0IDxpud00Vs6eVYamtummw+
 ZuIkM+ONHkNDtMsbbJoNZCb0f+yrZ1SGjeYXDa1zTfpq8PYwpUtu4mfW+B+hBs0TUw2WaRPyrx4
 ZxJWx
X-Gm-Gg: AfdE7ckJfzgmZgB3R0sgBqBZgJjBIcdqe+rqOJrrPK7qO+Q3dW/1e3ofQ7y26nf+ySh
 xInRphQtx3LAPZE5nzH5PxhdUvqYzdFGWua9qPsxEUV//6CTws+CFpms/tXMZG/4+rkHwKULt+4
 ffM1GICNzcgNXiKWA0A19gGbUY0TLOdFUmUSnZz9FDxOAg9VMAZb3xQOJrp0g7000oD0ukkx05i
 DMB9M9eu8fOhn4I8Ux6AUGJINqf973xDXdVjjhLG9WJ2p8v6Y4fcuKhOsG3PpEaPoWCjlZ4Tsnl
 enjNQV26JfkSF6YtNkPrAHdmPOYEtZfT4M2KpXhC1GASbvT50xeBx/d67Su4MkW5nWoZQAPIVnP
 /81TTVm07Gn9uB/k1rg9a60Pxze3X4gJL9kDvxRoBNnUJK99/HZhhKbA2vfjrqPQGvt2h43bGVk
 NTM9w/n0h3sjHTOlw5hRk6ZTxwQ2CoMOXyG3lzxq/FDpvohvZYyPhPvt0qQPgYb+HgmpsS/IDAR
 OfuQfF6j1umlB5vP2Ys0x0=
X-Received: by 2002:a05:600c:34d2:b0:493:af0d:484c with SMTP id
 5b1f17b1804b1-493d11faac9mr112587195e9.34.1783324982449; 
 Mon, 06 Jul 2026 01:03:02 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba971sm583452965e9.13.2026.07.06.01.03.01
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 01:03:02 -0700 (PDT)
Message-ID: <6a4b6136.a264cca4.2c5c61.695d@mx.google.com>
To: "Ivan Hu via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260706013720.450291-1-ivan.hu@canonical.com>
Date: Mon, 06 Jul 2026 08:03:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] landlock04: Skip variants unsupported by the
 running Landlock ABI
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

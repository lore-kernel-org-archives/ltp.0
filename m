Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12775CA600A
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 07:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791443062; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=gSEMr60UPAAAqf5AJ3UmD8sABoFI3et4FxjIDkgHpV3YO9elg865flXWa+jeXf2g31RZH
 XvllPJl02rBYWFiZ1Z4CUj/qu+8vC4AQkJpE0WCM6ogD6IjZr3xz5RESwSmZSAnXwkFo+7s
 wVbMuBOuLpqvOLEM6aVdjMlvqmL4uPY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CDBE3E2F4A
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 09:04:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9473B3CD635
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 09:04:03 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 866B660045E
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 09:04:02 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso4747617f8f.3
 for <ltp@lists.linux.it>; Thu, 08 Oct 2026 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791443042; x=1792047842; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=E40bYZYNT1qhUmrBsg4Iq7F28mSra1bQqDqAWlWXLbwuGEZX2MWZQ4LgKFtbojfR/h
 6Q8xIf9FtVBGRuR9NE/Vrtl6yWjQMZGhJSa4e/m5WRk4WXWqYdlCaXE1HmuVoeNAoH8f
 mulmVjrm364mxmBx2MUpu7WIz+YNEGYTL12vLAD80ad0Jxy7GQNrkYV3n/o8C93w4yov
 x+jWXMLIRsi16Y5CszOAhHDVo1QFHBVR/ohmS54akloTRv/jst9OtXNe41jzKegXALLd
 PYufg+psLFbvcg18aYjcA+d1xdGlKWEgdB2Vx26QPtZ/3dUIEjFJ3dsLr5qi5F/lH0IB
 o+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791443042; x=1792047842;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WOoOGeqf9DEEkJR2TdDsUQQQrmizrfx8W6DwZYL4+xdF5qHju/pPrn33bxPtzZJSrm
 PHEYamQWNWFkVybYxi8gPSqWKovAPpuudxlMbXIX/3ufqLSEWaVLN6OyvIef/58gtpTt
 JYhub7OWy/iI3WT6eKWMZw/d9VbVqjYLqGDTjo4F82tE/E8GX8uP2i2H407NwnbD17dY
 pQBC9365DnX+GhFudFmTlq6uoMYvXf1Em0fP9Mx3AKx7wpf/pZQ2IcuDqYWZcXA0IDsm
 w0zMCD3RxGS94OcA/NLr87BnZyS0BPOqfHmtAVq+ZIXCf+ZQBrsYs3x/QWojR4wp1Ohr
 FQAQ==
X-Gm-Message-State: AFuF++m7Z4I14PDezlJa2SIm8ryqAclewNdZUJxeqF+0LaVRoJFvVLEZ
 2LPN8w7ubm7aD4gAzryBlJuWIRHjUEvwBX1PhRCgSaTHXObiKEEX+QwIGr64yYMpIHM+IOzqqmL
 YU6EptFs=
X-Gm-Gg: AYBFou2kIWLxPuRqcTldkqYcCUtVkbWd4Xu0cWdF+2GMFjPR/gW/vIlAARCJHxIPlZH
 2AkwniDx2nOLEpeT3kRkbIvs6yE1gaHvxtoArfcZ+VDbX6opgtVip1xWFt/NOJW2NPlvtyY6UAH
 G285a33A20ydE7xBww7Z81mMGz0kYMz/uhlSpNpEuRmlOJOJXDLcEaotPO+1h1/MWMDNawJsYLD
 2mmrCM8HEoJSkvyvHeA18vdDmobkgFlMHVTvDh6J8MROpKGv3j9mwAHSR7uRWjl+Mm8iRQj4wZc
 6ZPHcpVl85klZxFccJ56Rl5tqOlpPKcBYIi78YnLJS8MMjbXrv69MrsdQ9twILvXLf7qA2JGB4/
 zxwRbp8CU60a7aSH/ghpdVZ3UwpP2oTBxOZUJCo5/Rsir62F+VisOEkIZ/rL4H4DQmXHLQCSUhP
 ycDiD46sSSBAgvyonprwDngUuLQocKWoIRxRwBKiHzKqCyVNnoeYd5cuepljFmwPILOg0/EbSFI
 QLWioCrJMi8MhVOMtC9ixCFl4Im2u2NR4nrLL6HKUz8WhvsN0PzJeXlUrht+alsApmUDGgXxhld
 6Q==
X-Received: by 2002:a05:600c:810c:b0:4a1:7163:3e41 with SMTP id
 5b1f17b1804b1-4a1804234ffmr73419805e9.9.1791443040160; 
 Thu, 08 Oct 2026 00:04:00 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a180310c9fsm99636305e9.4.2026.10.08.00.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 00:03:57 -0700 (PDT)
Message-ID: <6ac7405d.4e3cbcfa.1ccac7.76e3@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20261006020331.3791608-3-cyyang772@andestech.com>
Date: Thu, 08 Oct 2026 07:03:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Update old API call sites of SAFE_READ() to
 use the enum values
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC5C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784558002; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=awvGRLVRmOXn2/Fjx2KHHrQRsV3ZHDFnSwbQmBhC1iM=;
 b=KOFJDZOBgstTl7t9/FHkuryCTSmR7KG5UTKCzc+TKFfhxhiNjjRwFFENGHnX0WauIe0Gd
 OFjc6V9D6SGemQkk1Q25LBRcPty5okkvIstXsYVSesqzWSem3XbxMc0wMgPDd0hEzR15/ky
 Go6ycN8Qg/McOizqItxEQsvcQ/7juKc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5A2A3E9056
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 16:33:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0BAE3E57AE
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:33:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28C10600643
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:33:00 +0200 (CEST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72C243F608
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784557980;
 bh=Gp8w5strf/sGXwPfbnuf1QD2iSadi2jYXGuYofJ+Ovc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qCvxqV5lSMAgux4XcamppyFcQXFXuYtLUuRwYgpfdNHW68vnBizQ6K74r+L9PBdXH
 vEY1ev/KP9jhUqQ//1xJ/iYUiYYcX56xlaR5o+PxAcXeha9ywHdA+pyULh+/P1PiFR
 GLLoYL8iooUr1sBw2r1FH8sSXufqy+lBVWQvlt8IJimF0Lx+go8T0F0gO6B0Ciqism
 9C2WQZcBkKGM1qfE7Hj/3Jy7GaO5qOnFt18cEf4dci9FH4wz6MwMtTIh12i5h5aUk1
 ownYxd+0qC4La++UDwUolpj2moKlG1CZBS0UbShi4NNJf58FZikj2URVdSI1j/g6LF
 fBd16N4GHrRPkifE8HlZrXh3FuklSAhkpwd1xI8PSYbP78ZUqnhKjFBVzlGCpQyTan
 bIwWOQLzGCSvHBNUXavzEZ5eI5fQwr4BxdgaDg8OZj3TYH/FroqE+ZSk6gngQQnt8T
 dICfiptN/HDDVcurV0KBgpDnuZ9BvLgTg57bAL3iDYR1f8cXUFotm46boE1VohMqv9
 m3ULPou9XNv3sZKxLS1uJm4xWSHtM2p7P2BMNh/x1S/NKdZCdxJhpg23DnziXzEgYm
 c1uqOtZryEOymMGFwWm1H27TomNGjgj71hcrob5tXJ/xp2A7WU4uFS0jnWohzO8zug
 0bjy+LEPL1LH6Jj/x1+GQVbI=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so84783905e9.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 07:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557980; x=1785162780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gp8w5strf/sGXwPfbnuf1QD2iSadi2jYXGuYofJ+Ovc=;
 b=aLAtAvnzcjMJMt465prbrZH4ek5OCBHtHN99JTO2pkOpoWvpobtSQviGmvuM/qu2/j
 rtcJ2CZtN744cvyoGbCdlZj2ZI7dANwAkS4GJvXel7R/rrhQvBSoXBof3//zgE07v7fI
 A9RVLBA2OB/RfonQOCGMccPPrQcM7My3XYwesvZPag+oSgGZHyBDlvS6mm6eVt5hPUmb
 cEujqPeqdcAu7mvm0g9jl/nLx7AFGcYsY+AC9M0gMgMigFXR59PFZLT0jBlDoyfLatRt
 lM47UNfEaNN0QJSG8BGtuNPLJrzAOk4nB8akmd0831Dy/dYqSw6kNghevaL5bhfMm1RR
 ewzQ==
X-Gm-Message-State: AOJu0YwwoL99CIo9bQaKKb4OCov8FWzSmua6aZ1cXoe81w4QRxA7/AsN
 rvKy0goTxU+93kAn785MjivqfHGGkd9qYPZhgcYt1Sy0DIvPHzs+73PMtkTT5k8vVCsSJS7qd/Q
 wY5n6i7DhYkVpxDGhW6/zkBZ9H8YpXHU1uhshyBBZ/3TTgfOcTHIwDmX8U4CTtr3eF8TRcpdoUG
 2L
X-Gm-Gg: AfdE7ckfbJIUIfpe1AuWpeZIwRC+ChljMxCnOhW4WVxCkTvIEeDHvpQeHywNCOrn/Y6
 yAe8/fVD0AgfAGiEx2jk9LD02qzbAQpYZGiiQKKiTyWoF0n9M9LxMIOGyWNvzBbMl+b/5XtlRqt
 BrntrTlUFQfoj8R6mmNAD9+ZDEcHwsduy39bcdFssvagfSIzX2Z8bq3TD2Ub9HYKLKRgCxJguj/
 jUrfT9stSwBbb7PjzlnhJVxYdqVO/BgVsweRheCDWMh9ml5a8jUj8Op4NMKefzwJI9Ku58a/kc7
 mqinCTIYlFvWkEkvRHfqn2tjPnNW578f6S1o+PHtJI220uLE4aZ8ZXjZ092z6FDiSmO0PkhTls9
 MXewOpxpDK6ICBIgMfyYoWq47SbZbaWMR7YWJ9bPg53tvfOJnb5YVYIGbs0YU
X-Received: by 2002:a05:600c:c84:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4954a3ed4bamr154538925e9.13.1784557979931; 
 Mon, 20 Jul 2026 07:32:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c84:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4954a3ed4bamr154538555e9.13.1784557979466; 
 Mon, 20 Jul 2026 07:32:59 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-183-213-56.toya.net.pl.
 [31.183.213.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa81b2sm58369755e9.4.2026.07.20.07.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:32:59 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 20 Jul 2026 16:32:55 +0200
Message-ID: <20260720143255.1666500-1-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <alj3Tw_a1If59w3k@yuki.lan>
References: <alj3Tw_a1If59w3k@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rtc02: skip (TCONF) on read-only RTCs that reject
 RTC_SET_TIME
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
From: Kuba Pawlak via ltp <ltp@lists.linux.it>
Reply-To: Kuba Pawlak <kuba.pawlak@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thank you, v2 sent.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

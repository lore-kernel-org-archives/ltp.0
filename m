Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2029FC5DF94
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787580291; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=dfBMY33zZ1io9UWRN9de/7YOzSoMI7QCAjsSz0DauSpLKC2g8w8niFsVG0mU1WKjZZRWr
 2Pv/mSYoghLizXSkxhXMi1yhNBCH3EEretyesolWNRSWzPjtCm+3SwPS6RU0yNWYQlP3WOv
 J2RQHppWr25E6kjEPtpmQ5+VDs2rNtI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EB513D0EEC
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 16:04:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF6873CE9EB
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 16:04:31 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E60A20076E
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 16:04:31 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c1677c91969so425847666b.1
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787580271; x=1788185071; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=dbOZa7bfebncuRQ297IqooSvou0yW4RNXKCpHVqLFhJsdeF+lYJenvnnqVJ1K0z25O
 7qMqi0lVcd+cL0b/eqHYOC5O/yC9e2Jluy1Ek6Ut+o5wzk1ljh+GVVrsEJ8Git9Dx4zP
 WrOjdaLi5t3u6gWohQeWlGanBwrMPkGIGlj1/sGfX8wzCgoECCV7XyojS2CNPhv6OXVQ
 te13xa+xFeyGhjbY9y7CwPPf5REPz2uYHOeBZQoIzJCoE4Ukb1Qesc+9cUMECfVhveT/
 MDBOT0fowTeP3WDMwbC99A3Oo9h41EtNWZzK4eI2S9HjVaGJkB/Jx0dyEx/ZmI5V0RYk
 AaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580271; x=1788185071;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=r2QhxqO0l9mqIUvKoWrs37pedqQv65fXpLg8z1KXqjLrVKUZqKiWY1X3/CgHSeeyBl
 GlHF2a3F6OpUG/XP0IORjh2Ib3R0VNTFKuux7x0gYylBrNxbX8AtWHAJHdSGZSFNRntM
 qB3pCVpIODNuobhoYhpw0kCIeaT7tutSXxF68uaeALyJ5WlhoERu6ThAFDqndOdZ+yvb
 zKnDPtBDBeBPGLzd515tqhK5mD62hT3w/QIsz+qEPBapZaOG/tkt5xDhYw3+r65FTsEz
 0zZfmBISRjoKplXCoiOJM/drMUYPvwJFS9ib9Ecq7+4oxSas8OugDChWlUGnfDsDewOf
 yEKQ==
X-Gm-Message-State: AFuF++lJZcCqdwzymFtsn7flMc6IXRL79YqzKB2wdCKa2ORrFrFxEuLe
 XpyDbDe7CJIaMIgvt0YRTybuSHmwfMYFVAcGbLFabL7qsBZz77uPnuTrig1YaU5Ixc0=
X-Gm-Gg: AR+sD11peRyQ9G0FIly3m4Hh3xaaxUAhVE8n8WEmsBf4t2ZGrINjeKiSr4iYeAL2KbC
 h6/LkopQrT62DaSTQd9Zor4VLzDkelerNt8zNGGlsSuq7R5gxDUqHTBbmc5VBAwHYyQddVsyILk
 U0qHJ8XCEmdeWlH6S0Yd4lAftvmqw/fz1CslbRwmf1VXyLB3zlQQsLEgpx19+sgvnv90k2TjRLE
 gb4EOX4LQOZ2OulhPc+3sw5GexbeQAiocN6e0KhJsMkStO5Zf0+aiWy26UmZkaaaKn+eOm3qyve
 K+m8ww64kWEo5FRwuL/IzFbS+QQBDgut0ofTtyBXSO1UZD1w9ypsGQPyeVTHYFiEP9SSGouPmnp
 WbYtoBB1H5fpmG4m5y0oxoHYkWf+lC1W7ICWmVtcOA5ccjruIAFIZmDHRusbIkEDRHchwGknozu
 OTiIBU2mxI1JyYlQzGAGDU5qJaIjbVYh0sr4Zrlc73Z6cFGG56xhUeZ7uhFdez5/UyVXVbIk4Ql
 EZX2rvxCwfA8pB95DGKZvO4s0geAKRvclyS
X-Received: by 2002:a17:907:3d42:b0:c12:6632:e7f0 with SMTP id
 a640c23a62f3a-c2492797eb0mr2123426466b.24.1787580270482; 
 Mon, 24 Aug 2026 07:04:30 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b60asm1192715366b.9.2026.08.24.07.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:04:30 -0700 (PDT)
Message-ID: <6a8c4f6e.3e06a27f.1b9d57.558b@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260824135722.200152-1-avinesh.kumar@suse.com>
Date: Mon, 24 Aug 2026 14:04:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] landlock04: Fix false TFAIL in
 _test_truncate() deny path
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

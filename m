Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA6DC55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785409372; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=XqbmztnTVaRWkSQ8ws8LaW0aUrdFRmVqIqblz5UodH8=;
 b=Fbwx8Kp3Y/Mt0KHB/9Ry1sPvVJkax4Nl87P+Q8FbzcfW5DPq3gbPqdz2WcgQ+bBRxy6LL
 Ih6eDbWw/rLLW8iP7tMiiHJgAbRU4qN6+PPDO93I7qqWMuEO2gmlyaQjT26geNplHYMTlc+
 ZyzfVCA8w6CtHYeALZfCMWuSM6f/krI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C79C3E7242
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:02:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 070DF3E16CB
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:02:31 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 045491400769
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:02:30 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1342682f8f.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785409350; x=1786014150; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MDOroInW1cPu7ssZ3nlTNgZua1+hcgY4uQazGZGkfCo=;
 b=CfR7Rxfq9o7/qrNgMDEgILdfbqSdqR8Jqe4WKZZ816ntm1/cv82JtkHtnpOWxvAlkz
 9eQEPK6Zh3II2SAbe2JAvT1n6fjSYYDt4p9SXcw4v/cW+BlpYvDQri6StdQ7qCwrnS8S
 9rjF1oIufclZ87zexHlH6shEyxYvlsEnUqUvatDkXlfJC/bz/ZBYFglsGZlnNOfaUM4q
 kc54RTUf65tE9YH/zKNyozVnkSjmnJkpOl8BVqr2MXpSkkrixx/E49Hpy8KAAi6V9gEP
 45ZLbtYlZHHyuFrJqAGYC1babR5eilmHL2in2SXD/tHuXy5MEAJA1tipG+FhGRizQa6Q
 Da8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785409350; x=1786014150;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MDOroInW1cPu7ssZ3nlTNgZua1+hcgY4uQazGZGkfCo=;
 b=FyS4p1sTZkle+3uxmCneFP3Fjbetlhw9OXf6XejCjdHhWwHyaVntAX+kNGNk4CPPHV
 SB4TPSghq/Ne6FSIa1aQFqt9e8l41gGuUjyScEjLHai8N0HnzBqiY17d7w5x0DSc346H
 vvQv1uX0y8Dm3zX64I7Y6j6Jk3uupDNTe2OiKWHL289YQqChGL554Gx7hoZdcFzDF71k
 j4WQvT3Sk94KwEnDQdX4uUrYjFaO/vFAllmswtx+DUhPtG/KB7EzFtLtXdRqydASIkkN
 G4fJpVJi7s5JROt9BowB9KFXUF0vObUe7M493dXd4FQJa7DtUCktxMOQU/Zg0LB9Cl+t
 oynQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjIlSStmorTYReLGBzCXWJhJqxeFC3oqXVRNW/nPtshmrGJfX5AN2lnfyIzSFqW9NySfE=@lists.linux.it
X-Gm-Message-State: AOJu0YyRIAFPuAA9acL4nN0Vwi4CQ2XbTw8rY47sBzSyV4biSjNV3e+q
 Qmo4WR/NoI6BBDN+0y0satY9bgL0BEJw9H2+OOlZM5Dx0QcUAqDmlHrgZ94dFvtpkOH0Z+hhf8O
 vy+HypEMotw==
X-Gm-Gg: AR+sD10yOwScMa5eXJI7ymMDT5W8QY1LoaGHnsA4uqWLYoXFMOww8GaSUIzFkNDrLAE
 KTLELsdAJY1gW2MvIXFURIwqJwCObMRMuQg09gJ+Jyvq3s8L+ueu33e71WSi4Kc0AP5H0mA1goi
 2gsfB35FIY29Qp4ZgxOWE0gxOmUKA2xXqxWYFDh34Ncs/WrxiUJKVLu4nEDSioYr/cFT43QPq8Y
 jviVP3rn88t9jAAZKFo2wlyOLy17TOQwIGVO6JxhbCaywCA2uXcoiny2/2BEvaFBe4tDLDhuUcG
 ivFeA5z4AiE+ZxnLy8YvsjM7G2rAzG78jQ1RbuxSZK3F2iGOwAYvL/jy7OZm+PBhlp5nDhUOi9K
 koYU7Yrzi/NW2ptFGCp93oiz/EC5st7as8Sdwj7OArKcr7O0rvTiEeGS/ur+t5/yUHNB39TrS3T
 PzYz33FhEKAHH9xT6VOoAxoGlWbVOYecLYy/qxX9nirBc3Y7mHAF8EmYL9xkLW8RhofYNgChVP6
 hug5d9tqpNBamFKGqwhQxWoUbGguk10eeKe9V8=
X-Received: by 2002:a05:6000:4683:b0:47f:ca33:bf75 with SMTP id
 ffacd0b85a97d-47fca33c1f3mr1411740f8f.23.1785409350254; 
 Thu, 30 Jul 2026 04:02:30 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cc49sm5274004f8f.17.2026.07.30.04.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:02:29 -0700 (PDT)
Message-ID: <6a6b2f45.d1054386.1d5b49.88c6@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <amsi77l_1J8Bdbfz@linux.dev>
Date: Thu, 30 Jul 2026 11:02:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mailmap: enable liwang@hygon.cn address
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Yes, I have started a new job and will still be working on
> Linux quality related area, with a continued focus on LTP :).
> 

That sounds fantastic! Thanks for continuing LTP maintenance.
It's really appreciate :-)

And congratulations for your new career!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

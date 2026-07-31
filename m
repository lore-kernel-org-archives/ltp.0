Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2164DC55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785483836; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=rRtViGWeo+YGQNNmZzknOxG/krlqtTEv3fiLkRJNTeAuZczTvw9bwEEXiJdNSiz2mY1B2
 /SxkM7zIF2kNod82DkJ8iRrAMCLHHyHN8iZVuf3LmuJDXF/dN3EJab/biU/TjfLz+p2WV5Z
 iIZ/UpnHVjJ+7eYjQe4aXGzLjMQq7GI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580F63E2D1C
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 09:43:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B14AE3E2958
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:43:36 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 298CF1A00119
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:43:36 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso183839f8f.2
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785483815; x=1786088615; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=QDjkAJrUpJZTyP7NIPZFyO65BKFHHZLpXnyybDdIFy6VYMVUlG/17sgsiql/XpqJrz
 /rrkrUViu+9ftrqHMGXxTr9lOrcXgA/UGhRabuL8k6JeUslnXwpTnOPzluRh913KiK1X
 rfuMGLC8dpkKvtiwBRuzbAIe2YsoiVK2GAE3tdp3fnrOHZYfH4STJ3vOoHhFzVvGtis5
 6prx2T472GhWDw55JiOTyt2ZUtcCOtMbRyyG+CiU/B9qxn9AA6KmIkpYa4bND8TJTLpB
 TytiWvYXQn7lvSDv4J6jMQJMzQr/FoNmSSoPD2YVoMQM8e50xdCsH1cHeJJx0UCAqPnG
 B2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785483815; x=1786088615;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aVRWJ1w7WWZ3xtvph0/+dswlJ7o07pojRKNfR/BkrpIMiyYXgpuksKlML/R0pEWjoX
 UXq3oOoyiVGoUztXCXsFgmh5+teWjFsLFGbDork935ZXyQWoZ1ofPYjcj9RkupQ7f7NJ
 L02p10CxZY8aVK4NE7flPKiHZYkEllgOij+MpDX/TgqOQwgS2RIUSzNidUuRzxiiaoUM
 ZwgYxkDzokAuyhRD4FjZHH2h7/q1EpN+OU3MSHa/3I3v56fv3eEmBTjJyLhVv50SC2uu
 HqVvACDbRqzJHt7OAHfxfkfQSI0eDNWGIJio/B1VFw66ZMsuPwOYgFjnHPJ9xEeCJcra
 ceyg==
X-Gm-Message-State: AOJu0YzKee20uGEc2cJhwGgx+mxICp+5/gtVbTdWWnuvEhsem/Wc6BVB
 JTEEPByyryPpLy8Kim/7FE8axGPhXI0ehJqLL0VfpyAtWjx9LYwPPW+oBIexvU2DmrM=
X-Gm-Gg: AR+sD12lq5W6zczL66Tg2X+F57DLD53T5/tgmn+R1t0odb2qeTVgT7yCsf3O05dgXjE
 hn5IpxsmbmBNmnC1LjXOnNybf/mXZ90hPRHQge7iElm7QfgqjUUiq6ObgpBqrCV0vGkXiKitu+M
 zUh/iznnBuM987PMCSFsDjcCMOBJE7zyLP3XLRbVZJQewoi0MKXUuuWrvvhyzEIkMQhd1Bt0rwd
 TnPq/5ihQiFQLMQbF5WzN6maRPVuDFpW3CagN4ezIXyYYGt9/CFh0xG5S7wixzqdkRDKtY6aVXS
 /URTIiBPiiAmPSdDtYS/dNSgj2nUxCQO0zxVuPW5mjhkmNKWYOylV5FsIiPPfgCGAEGLRfh4SFj
 Q2oH9dkOZ/Rhkp8icPEKHTOkBqTz6XR6afbL+LLJUojZ247SFaLTrSgZZucxO7ff85xtYI+Ng2P
 UNMGC3POc4vRZv20qh51MPmmIC/8CrrZPAa8OhyXvyxccOaHJ2fTXACpabCT8CcRDRaWEcW36dD
 SNPe1nZ3vUhW5paq2ghAV8W5R7bEjFxEyUQrxomq4dbCYDy+ngZaapEDeAHFL3XrJKf85BF7VI3
 czX7gWE=
X-Received: by 2002:a5d:5f05:0:b0:47f:8ac0:ccd3 with SMTP id
 ffacd0b85a97d-47fd2abb4d0mr2356415f8f.2.1785483815410; 
 Fri, 31 Jul 2026 00:43:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458bb4esm1764846f8f.30.2026.07.31.00.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 00:43:34 -0700 (PDT)
Message-ID: <6a6c5226.d5b2c389.166717.d42a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260731054548.133241-1-pvorel@suse.cz>
Date: Fri, 31 Jul 2026 07:43:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B18CD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781524008; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=N7VQlIuEqVcPMA22pFa+MCrv1jEDkc8/ZuRw2Zc2P0I=;
 b=bjwWKGKEx4J/VPCZvFezZ77UIC03LxQ3DFLvbdGVzprHxvASyKKEFQKZKw3SEFujjEj7R
 ulfvnp0U0cXbjbOwj+WOig5JLHLsqC2QQIeo9vJKwmqNRjyA2ip4FklbUAVT84yOpOamuD/
 GGUJs0R+X/668DoOZrwjFi+/y48sVuU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A0973E5C85
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:46:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 745C83E16F2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:46:26 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EC82E60054B
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:46:25 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso22151185e9.1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781523985; x=1782128785; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YtChDIz2kJuXY/AV+bG6cHx3hmESL9zLZPZqVR02FqI=;
 b=VOYMvyCGyTZC1HbQ0C+udUSSbT1LmmuaaxuVcNqAnqwvCMKuUvYTqDDBFMCR6Q1dF7
 wTrRZq10ONn5pE7VVw1rE0PYBMsXEee8kyf16CkARLNtK3fRD2EMbUNE5FuyBvIVzTtY
 zExb+E1rknv8Ms+7tSS4Pp9QRbYuGX19wWFCmGQDs2mEyYGOZJclXQ70/KH3bw7E4DNJ
 WDfZMaBPHuaig/TkqRp2TqEB/7CXYPKvd4esBBhxnnEoIhEkDbH0QwOIH3XWlavRAtZC
 2Sg9lIw+f4RbAdPBsL59Y7SvSEcbzVVc6ysQQWZEsed2Vv63QBdasRovH0pah15Xpd9T
 id6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781523985; x=1782128785;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtChDIz2kJuXY/AV+bG6cHx3hmESL9zLZPZqVR02FqI=;
 b=oux9C/4gikqWSnLTYBU43/KQqypTU+1yFuCulr4TQ3f32rISt5iuxCdiRcVCqU1IeT
 YqjD/t93Muvt3DAqV8tYKZey1fQdbJ1qPXXk7ocS15sQrNySEf8oY5H1Q0RBzaIs2UJM
 dY7qILXNd4sd2kiHHCnRX6KOV1npthjcfS0iirU9yhXx+VEAEjw6O/6K9UbvUyqfFfas
 ofDW+LpYiyirpTr3WsYs3qr5VR9OYuK8OFfDUhWZEUTbh/EstFAb74rv66IL0BgunKtZ
 hqiRqsID84/VVbqyg03cUdoSQnTSWFekIbXwNaJtUVMIPKfXtQReydG3vSEhcO3lBh4i
 Q/Hg==
X-Gm-Message-State: AOJu0YxyFqhbW4yrXZih9OpGi3yL+P/eAUo+iItET8glttfaGX6zHTvf
 tvLo1qL1nJ195HOfkFBpaturnngbZqTtnVWjwkkhJgztuDZKc3W4w/rXa5HV3sse3/Q=
X-Gm-Gg: Acq92OFY28QWSu7+7GZPD+CDky2oqsG7CAKmUWLpAFKnBvu16FSYEbzfDfNO0Zj7Qq4
 X+U28Iw5OD65u7IusrcBKO8CNV8ChMQ2bXbLQFM1UZVR85PObgM2fhlL7KDNahq4NSoZ1qxQAxk
 VB4l9lAX07HB3QZc+3Y064FKZvA2fwk2zuSa9YVxljCuxcaQlAkix1RlY52MLnqmvfl6YhicLi1
 NNEtBIRZARJ2mmVak6KXEujYo9e+XS5wqXz3buscT4DY7+GW2tNi3J0FAVcPys1AI95EuMpR0Jb
 yDGqHkRamp5ywbm12wiCFf5JkQWfhsPvmmeiDzdpw/YdtJh02oxH+yom3ljJ3TBQYJ7AldH2CnT
 TizqScS9iJgIdDB1VCuYuDGXZIQRbdkObeQeSI9Q9VJuPFYdB2eviA2w0gT5ISgo1MNHY16RUum
 laNapuPaFEjn4tgxy8fpOqGtdPe1ytX+J4IosFWJcxOgjX8DH0cBh9wdGxXh+y9QivO4Xxkziw
X-Received: by 2002:a05:600c:3b90:b0:490:b294:c652 with SMTP id
 5b1f17b1804b1-490ec4e755emr174523185e9.20.1781523985224; 
 Mon, 15 Jun 2026 04:46:25 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c35sm34832691f8f.22.2026.06.15.04.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 04:46:24 -0700 (PDT)
Message-ID: <6a2fe610.cf2df9a4.29e9ad.20c6@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260604150643.3433-1-always.starving0@gmail.com>
Date: Mon, 15 Jun 2026 11:46:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fstat02: Verify st_ino field
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

Hi Jinseok,

besides the error discovered by the agent, this patch is missing the
testing point. We are calling stat() on a hard link, which is actually
following the path and getting the file status information.

That means we are testing IF stat() provides the same inode number
of fstat() on the same file while following a hard link.

Why not just calling stat() on the file then? Also, they end up
calling the same vfs_getattr(), while only the path lookup actually
changes.

As you can see from the other tests for fstat()/stat()/lstat() syscalls,
the idea is to compare them _only_ when there's a layer in between them,
otherwise the information coming from the syscall should be compared only
with specific setup that we force on files before obtaining any data.

I will reject this patch for this reason, since a similar pattern has
been achieved by lstat03.c already.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5569BCA9ED1
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791805766; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=f/4Bo/+wMgpXDBOyhZbIm4zFUGvHa+2ZwivBT+KCaqOOJjgql3g3rUP4lRlrX55p2zpah
 7b/iS/ck6WE0FNqbh4aGdAx/llc5WUp9j9viPMSxj9yFusEiXWeaxoIQfC3twkiVLo4mZQ/
 AB0+in5UYxWUp8bJxZPm4NSLuEEZeC8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC2E93EA849
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 13:49:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67CC73E9C61
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:49:06 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A2A8C14004F1
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:49:05 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so757643f8f.2
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791805745; x=1792410545; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=CFJVI+y9l6y93NUdjMx+9qUDNtjnlbryOYys7xsR7xdJbqPKXPGczoK36kmxxhHpSl
 QXUx5HxysikYPwVD7oRSO/gwcR3Lj2JPBJ2TyCg9LiWAY1/XgUaVeH3JB2RckmqSlf+c
 P5KSkMk7yXm4AuFLXGs/tx71TQ6avzIQX687ItsQLY9IJLQU9wmteNnyOijM/mKn2ATT
 vJxqAuuGrijjr9Xuc/9/v719bDcnEcJQ4sG7x13HhBAz3dw6gmFBV2NVDZ+a2ruRX9GJ
 mRER6dJKZ4e3Ix50g929QajAPJ7XBh9lJxzciw3udIeIEa6nlWhOkx8P0cUSM+rpdBa0
 JAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805745; x=1792410545;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fTcYhF9o2WC9EH7wLttCLQRHW3yd16E2cNgw1rIw0d9RRumKyFuvDjPvs5DnXJulAG
 KbOVRiiMMXCdcqeyVfjEZ2qqaSf14G1ofjF7NEhDCiugr6QM4LmDuPxhW7c/bL2ydg9d
 X4EmCPGva6gRZEsne4mDZc7WAgg0v50xcSF86hWuw6slFsLicPDHJlnj6lbrl4ehiVg4
 z+pEbgL1oY5wE2WuhNUO8U3xgTsRqOYHyGH3dqQKKaeELxeyt6O+R8/Yo4anAX/ORbBd
 PHAZSep29g30y20J/1P2+WeAlPY4JrUN6tjBPbIz0mDC4Luh4FXBhY+mqA/so6/geNFD
 N+7w==
X-Gm-Message-State: AFq9FYLgcLJRflhfL4v/tM612xcHayd69CasINzyoAHxybbgcj2yvLhC
 DLZOMwPmGb72BQGWnjyXf5E5wGjhiUbSnBeQfQK0lkuhlRqrk509pUiZ8ybmk1/+2839cO/HiWc
 gS++qYxUDnPh9
X-Gm-Gg: AYBFou2kr2tgJ2dwqRFOtyw2FSDbXkXAa4CHcxks97xZRTyOUAv0B/KD3IBCJ1/UoEP
 YXXu921gEbZxdMLqJAcKIGcruJ34k4lh1BEPqErlCPmxGuzcQcI8fbN0WdAmy9NN3C8Pr8n5Esy
 GuRdKVj+eGJoKtgr6uWqhUNJtYV1AQdylguOk/JThJrN0aVo0uKcO9i7x62ADGWs21knwWcQp3p
 nfPBhwMERjCPIvN/WPPlDygBqdP1I/DCCU+Va3yrwYy6Wo8jFCKh5u0bwn/Xeg0PcjcQMkKMOTK
 ycSvLDpZpCAgudWF7Xv4l2FInh7qXTzZHFLXZ++3D0gjvgLmb+rv7gRcJkFkSORuKsiYFKpHLT0
 Aj30TGZlQb9xyNQiWLmQh6ha6CojQM8/qHhllCIua/QQg7UQi3mgf59KCLzvxW0nniDhm/9PYeO
 gHWLDld/p0Z/gKbIGOKImUkKzUjZUqU/wCq4Y84137Y5xEVeRUsk+VTl93eMI48BTmWaVSEK/D6
 7GF2xud+4/bemO51d/ZZm/fH8E5y1wR09CmmhY/H5X2asNbKwT2vFsx4uR+kUqNRREQ6oAIuxKd
 A4qkurFDHHLG
X-Received: by 2002:adf:e64c:0:b0:485:8ee5:5ffa with SMTP id
 ffacd0b85a97d-48dba9de8f4mr13796206f8f.38.1791805744662; 
 Mon, 12 Oct 2026 04:49:04 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db946323bsm20675754f8f.2.2026.10.12.04.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:49:04 -0700 (PDT)
Message-ID: <lRrJSFkeDUlPAOZvnqLUkTX4r2GsrbAPlFiK@localhost.localdomain>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261002130546.1236713-1-wakel@google.com>
Date: Mon, 12 Oct 2026 11:49:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] keyctl: Fix struct keyctl_dh_params build on
 Bionic
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

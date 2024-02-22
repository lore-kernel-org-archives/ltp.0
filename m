Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F42C48BF6
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 03:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708571453; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bEJUgdQOF5B36JYuzBuDNuMTcGdgcRbevj1ZRm2tbGs=;
 b=SOCFbwDj16PAHtw5B94TqcnvTIXjPjWOr0ujCxOSUIirsO0M4jED+uH0ewEHHNTWZald+
 L01yRyvdPEJggPATDiewPzdPhsiZMaiBwnZId0ghKPuCc0AkBAsEvgyQA6wGJGDrl2wgHe1
 MaqnOz2s5e2MCnAndWKrCvdqolmh47M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63503D11B6
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 04:10:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E27B83CAB05
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:10:30 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D385208F72
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:10:29 +0100 (CET)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d21a68dd3bso76049761fa.1
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 19:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708571428; x=1709176228; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tS2w1IlT5+E5TJHQIGZ+cL5kCRf4LKp2MkCjWqkj3fI=;
 b=WvDSh/GzruIDVomItnycoM4OZZ+rUdN8tVhM6oSLzW80+R7fPY3iBJ4ynpfmxs9vI+
 SohVrk/kNz1h9fVpTOMAzX7Rfq/HSYQllTMc3l2MhKKZsK1DdI4u51zPj+qlhT2Xt0hK
 6kSoNt2z1DxM9La8ygZau3/WbhC1rtdjk3Zo0x36Imu7o8wi5xmI8uwBX5GToFF3F9xF
 e3l/EO1gylRAEWAVDbTo83ZJyyms4SBiQeXAf3Dx6ujGoQmMyop0ghDWZIjfIHnB3u3K
 F4NaOOdA+1c3/6uaqH2p0k8hH0U3tCl0SK9h8Ihdh4duSUS8PDNQCLkxfUjlN1jSNabE
 2W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708571428; x=1709176228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tS2w1IlT5+E5TJHQIGZ+cL5kCRf4LKp2MkCjWqkj3fI=;
 b=OxG+gHiVBWe0XFr8g90FSEomJ03ql9EVRRttY3MoyhZ0TcyOYBx02wwrONkP+7JuXf
 hoOYPcaE6QBgdpJtxOZ8xZ4mpE55j0gT3IBiVUdO/BdbNWVJRX55xtS9fSjomFXkVmmI
 yLJtU6nIguwRrvx6UFHFPlXC+ss1wrHPl9aHzf0v/HHAA9+uJ8Jxc5I9VpJM71pZQJph
 3oqvJHR4Hats+HZUJxOo1PQRpIrdQwfhi6PZAI8E4tGpJy+viHnwdzpm55q8Mv7HVOLf
 0AzBTiMBT+nx1y0aX/0zbhG/sLKnvF+ObM7bLVCsh1ABQpzQzwYiQtQ+7tiW4Ucj7mEa
 zWGg==
X-Gm-Message-State: AOJu0YwZSwLOeB5QPM0TxMG3iLxW34htlbE9f3mKnkdzIV4JbDC+jAzY
 sai92PW29R/tY3azp+tDF+tU4+qVsOIgpyASrbfvQPny6yJdRP7Hq9F0PQW38LWbfSYJ4BPGCwE
 jMQ==
X-Google-Smtp-Source: AGHT+IGUxX+WsVHgONyfbdpeGKJ6uQen+F1gK4vA9t4DfY5ILTfdgSD15gBuhLQ9lz1ULWLY6twHdg==
X-Received: by 2002:a2e:9dd1:0:b0:2d2:3a18:aa11 with SMTP id
 x17-20020a2e9dd1000000b002d23a18aa11mr7024322ljj.39.1708571428220; 
 Wed, 21 Feb 2024 19:10:28 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 y5-20020a62ce05000000b006e2dde36edesm9696538pfg.120.2024.02.21.19.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 19:10:27 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 22:10:16 -0500
Message-Id: <20240222031018.12281-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221084256.32661-1-wegao@suse.com>
References: <20240221084256.32661-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] Set system default umaks to 0
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  cgroup_core01.c: Set system default umaks to 0
  statx07.c: set umask to 0

 testcases/kernel/controllers/cgroup/cgroup_core01.c | 2 ++
 testcases/kernel/syscalls/statx/statx07.c           | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F15CD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 09:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779699784; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=F300BMokxPoQbkVg3GJal8isaMpUDq6pcYaqpisUAN0=;
 b=Kd43f2+xo6jU7VETVVz2O7M+TJwSEMD122xlPcY7d7YaNm7sfpb1HxaWWhjsPKpSuQXLI
 +pFstxR5rL2u6DGrgCt1hPyYyb2W/TW1trytjsIY09e60QB+fZsyuMSya6Olaoy0AuDU4cv
 fbkQ5+/pJdaAvHjrEW1WwY3GLoi4ALU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14F293E27F4
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 11:03:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7093C7392
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:02:40 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5C2B1A002D9
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:02:39 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso4614083f8f.2
 for <ltp@lists.linux.it>; Mon, 25 May 2026 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779699759; x=1780304559; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqAOu4XMtdNLXELbnGNjGLaCV89s2/XCCk6UDrRjnqI=;
 b=V2a8dmOo4BcdJYEyitF1GsBLDi9Fe/3jF6twjvGHYQc8RR/cpzNeFDAWy+13EP8TQy
 Wt3aBognhtGQzMGogFB9LmW0fKRfJ9VPhXJqOoNzIg3wwt2XevsMFHtNz9eJq1mAUfBp
 7Iolxu1lk7r8kC0SbVAzjyj+ho1DrFJ1jpd4zRCjlMY6tPZAOpHPLjHdCPXylJJquhrb
 uhCIsLGQTO5cd2QmGYBbFr5k2ylF7My/tID0Ow+ojV5REHbCc5uPCJrO3KiHo4XcVcEe
 NNZ4/qXuThySsaKyHIKD3uplcMblwQ7u0K6BFVkKc+XPD+HQfKXk1szzXz1zPJgD+ucZ
 Wvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779699759; x=1780304559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DqAOu4XMtdNLXELbnGNjGLaCV89s2/XCCk6UDrRjnqI=;
 b=m8fzZHcr3OEefTAF1ruSSdh9Sjwc7FtbruN7xwCV2HmarQi4ae7cmoGsZdGvZ0emYy
 z2/2XxwycQhsHvQgjAYyzSOFDziO4HWo13UUzsI5J1XmQkV7bs59Ux1fCSWkfXL6ccfX
 J0wjU/LzoheuHqdHGTqtVouMSK2m+YA4B9CJTOGcS5aKcOWk1JIigqrgn9RBjUwZ9buF
 pgEzfANCkbq1flh8CSM0denvsKTDIIscpzF76Kb3LiGodeH+LAKQzR108R6ztWQCzhgh
 gyZtf2yCj/mroWqG26Lko3cqYCV0+Njavjtun/y7w9U2f7FN7OzCcBTviIYp9k+swsrI
 31/A==
X-Gm-Message-State: AOJu0YxAf0D2spFfLLuYlW3UK3oTzCt3nlGG7Gy5fqA06lovyzyb6HNH
 vS0xE484ZG9sRK/UgCAAaFyLDLbip29cv/qWZbl/82xFRmdLRErxtntKmUqkLIsXxgPIkt40Q28
 vL48=
X-Gm-Gg: Acq92OFAUNkSRgI2LzSOf/ZDY60RN8nwqA82yXO01eBa72Nav6B9qf2TVJwRb8cKm/8
 Godtr3ETJa1FdJf5FfJJlDfeXPkUkl9XWlERtgoPYhO7XwmWUyqRAXdBvW7It1P8pGX/FGaMTKc
 +5jzYt5pLqNdg2oKW7Op4tzgoY9E6aRLc2ACF4NRAI2cOoD+SbBv/MG22nRtRmXqwifCGAR95Ha
 DZe6jo5SxiYdz5wOnzePZr0cHi6lzWtQ+197umeQZQmzSxcMFavBRNHHPch0FYWALm9IS0NOLHJ
 RS7Sf0SUrqhbVjGXAC5BiMuD0CEt0oVqSn2WUuiFUa2lZxgif5L7m8w3tGdL5ZiAhAE/VKIHOjN
 SpcqFaZ0/O1/lJEPEwUz3RKLZPjk4ncxB+Q+Hyv9nM0QPZ3dh1XQFxZEiktoDCI79rKhS1NJWu5
 jq/rt5edDgMiIS0BOYRonezBK/2Q==
X-Received: by 2002:a05:600c:3b02:b0:48f:d1c0:5cd3 with SMTP id
 5b1f17b1804b1-490424b3189mr231054445e9.13.1779699758873; 
 Mon, 25 May 2026 02:02:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45eb6d5e363sm26304652f8f.28.2026.05.25.02.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 02:02:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 09:02:19 +0000
Message-ID: <20260525090228.11895-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
References: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] connect01: Convert to new API
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
  connect01: Convert to new API
  connect01: Add negative tests

 testcases/kernel/syscalls/connect/connect01.c | 396 ++++++------------
 1 file changed, 134 insertions(+), 262 deletions(-)

v2->v3:
Update patchset base v2 comments.

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

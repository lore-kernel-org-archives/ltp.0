Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A31FD3762
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772034622; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=m7n/4YSNFv6KcaG4l5EqXp1LmfQHvXzpqjvHbT4f5s0=;
 b=aF7JYM7GuXRIa9tyNfrALhnoS+KwZx4z9aAV1fCf5W9BblGOAPQPrFpc9l9j5wcFGJXZY
 EDflhyJOQkPi39tP9S0gHiZ0P6oRe54Lkag/eIr8FXgMsfRSOgRZQA4Rtp7Fgi6LMupHNnz
 3ujXG+a1LiwNlJplS+dUMkIMajNRDis=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FA193C9424
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 060A73C7B03
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 16:49:58 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E4E810007B8
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 16:49:58 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4837907f535so62370085e9.3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772034598; x=1772639398; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAqtJor5hRJopK+4TLeaGAjFM8/ZtARpLxP4Jp8AkCE=;
 b=Z2EKzkQgvcf7yyelpGjuzZzjlcSRPjDoqGKwfllRxNJmmbcSsIApSBXUZgSbJGpiAS
 wWaFPJQqMaiCjAC+VDN6g23SIMh6+NMwa/K2HIixf6BejQxcUFJU9sIXahPGLtC6Cmwa
 SLdyrvVNqW514XovPbS/Vy1QXntKymljKnRmHbGBCIJTQtZnx+Kamr6z80oHU3S5dsHM
 ZWYh1J6UEvHQVmpNVE/kRLi+UyzULBLsQ1ZdwTN2Y3MG3d2q7vek7ZhDCxiepbBmbMFI
 yWE2Dso8zZUg1+3mfEAb9JqZ3rA/YlK4jrWT7LMIISe3VGE/0hFUcJ8oqo9OzOyzvSH/
 9bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772034598; x=1772639398;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cAqtJor5hRJopK+4TLeaGAjFM8/ZtARpLxP4Jp8AkCE=;
 b=RfmU2VxuBXKuS4aPPyPIhePF4q/9v9zcEQHizL7W9bcEidp23Q9v2ZflHc1YSBjdL0
 gQ0qp7JKCdlPz0usJFPBMFX2TGrHFKuE+SrO5hS7qSW+gWtw7x+FBl0NMihawIHekZsD
 X258h1xKrnbFnYbcz28weoXSwsXSbkb7Njx7toVRUSbTgDTa4Is6ZsZPgtOzH5UuVjQW
 TS/JOzoWdNB5MOAgBtv0W32+bbD/pMP9fsd8QOvgUhvwLyQBMqyiFCXF2M/W9AA6dv5a
 0fDT/TUwmduNuqEQein77Lu48QB4VoTICKYtSJFuo51aMSHopVCrDH5ymyYF2yqb2b+Q
 5qXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe25SbQrAkGOyKcMfK/dywafhS3giOBDHmjFdaV23nCoBoe/u2zvaqRfXeVB0oHnY/nRw=@lists.linux.it
X-Gm-Message-State: AOJu0YxrolT0i8hd+MSWm30++Cv1kw991Pty9ZBiNOaGK1Pev3LxeRGm
 ewnSGWndhIjShfixYwpZGS2F62Vrm3w4dg56/haDVRP86GLAcODlvaJh94JqOH1oHpo=
X-Gm-Gg: ATEYQzxfN/HlNSHCvNrQlpelHpYOfrkZxVKGKamGC+vukVvHoBULuN/7jN+mARoS1PN
 1hIW1os33SuVzSWDFto7IBiFtNLLxqw9sQGtmX2ulI2Wb2wMu9IUsBO3p8vkGU80F365v8JW5XI
 4ZI50KFGtWD6UJJ3/hygYtiTYW+jplSzbkO+hb9sLZMW1DuiPy+sXVF5vV7ZBoLmLS8IRGYCl8U
 qxWHxDMYLupJ1E+bPAFPpfwTa0Y8Dv23qLQQHPB75rTL1UzfbNK0waBNcdQQW2nKrmeoyNKVRfy
 FETF+p1r4lhLtSj6pjN49jSvoZotZmiAv72NVqR6UmiKSJhN40P6+mT3fik0BEBEB0ra0QdrLZ6
 nPftdJMYzzSTessuCDNtgZ2pv61OpL6Kp20JmKit7jxwsPa7QCaZ0JxvBsChEKthe/pyUtIyvSu
 jpF36FFDoZbJWQxC7VnfCjYboc
X-Received: by 2002:a05:600c:a085:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-483c216f3dcmr15026985e9.9.1772034597718; 
 Wed, 25 Feb 2026 07:49:57 -0800 (PST)
Received: from localhost ([88.128.90.40]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb987b0sm13820145e9.13.2026.02.25.07.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 07:49:57 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 25 Feb 2026 16:49:56 +0100
Message-Id: <DGO5U7CVA15A.1TGO497R7HODK@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
References: <20260224162726.28933-1-mdoucha@suse.cz>
In-Reply-To: <20260224162726.28933-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio_cancel_3-1: Rewrite test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

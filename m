Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F920EA4E07
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772462507; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=ZxEZX9eamfKXvwm3RC8oQ+WPGP89U44Cwbx0Mg1avNY=;
 b=ndtiWPdhKNMPwFlWJxGHSF1ahFHn679DCet7RhD5euutXUJibmXWEcXQ/A1lnbN+agY5A
 7r8P0M82VWr+A4Vxc0YnxYX2HyKFyiXEJyCuqG2acPPvmamCIXdaxgAoXio4ozlhraua8ZR
 DkCrUKBSUjNwyURSIKIGDnCW/bF9z0E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A7263D7B90
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 15:41:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7F303CC91F
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 15:41:22 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 29309200072
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 15:41:22 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so1077827f8f.1
 for <ltp@lists.linux.it>; Mon, 02 Mar 2026 06:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772462481; x=1773067281; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:to:from:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A5gUhM9TEOnn2TbvG1UFjyViJs58axR15pnhCXFcFoI=;
 b=MdwyVGAq64j5rTbfOuCA+h2yUDhHt6MfdN2wo3rolwXs1ubyipERFGnY9ddFT3L1vu
 eGuhZrqUays1DMuZBiAb77bX96cUsNNIg2AJhBPmZ5SNPSNX/Drot6WJekf2gPGDDfAU
 wdldY/YE7v9sixfuIujTTw0kMvFIYDKUTpXfZelKU5PuX+2mH7O4MC4gEQOPm3qXGWUR
 DWmTuakQ6khB7uzYTLmxfBHCerq9qoEMf3mTFp90KbDqD4MPBqJHdoHpvM7sg4JuxEbE
 0bmi+nEP1zhFzZkE6BiAhTsgEHOKcOmH+E+1ahU8RNX+MxGYRyzYc8EuGkroGjF/NE5v
 K8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772462481; x=1773067281;
 h=date:content-transfer-encoding:subject:to:from:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5gUhM9TEOnn2TbvG1UFjyViJs58axR15pnhCXFcFoI=;
 b=NMX1QkH2fNywGu/J+P9witWnUwUF4UOg7LWsoCw4sLX0D94+9OjDthZWsZayeaXavD
 z86Jso9/SrzaqhNLyfdPagEZ6aZh0NV6RWi6Fx/G7FPp2oL2oWbzHF9Tphwgyi3tWOTd
 ynw2tTfgeumPX+4Gd5VJcRHZDYlM927P/otBCL3snBvddcG/F8ef3wdab/EDLsyPVUUQ
 bmQKz/+FNhJvVDX34sr3UDbX1sVwpmFvh13A+yo4AcD9p8MUoCF6C/PxIO01jHqBzVXq
 jA8m3T+kzQdCE2xmHDFWeVxIlL1JwYWhhX8wvehDestDcZK81GG+UfYKQx9cjjZDYIx3
 vpyA==
X-Gm-Message-State: AOJu0YwDy0bgeH8CWNVk4eEKC2VSCsAqKf750x3z60mJDq9o8T+VpCrS
 UjM3VSZtkmQEhAeVtLTY6HYi3ysVgE3dfHt5eh6dE0hw0AGLr31DmtLyDcO5uRtLFjdRdO3fXCB
 eRbTFVG0=
X-Gm-Gg: ATEYQzyL5/971gmzDrCeJ6c4CNirt2MtFs3WKCucRbwT5hO+usQ3MIYmz6jTGkLWTYv
 3YBVtdYSF2OWef4OiLwT4YgEbEXI0C8L2qjEnLXh29Etuu6G2dU34RpL608T/jR9KpZfN2ZTM5W
 4hYpDAOmcX8Vn7SGDIvgFf1+5SF87+xbm1Qne9uy0M/u0x2d/KTjGC7S2jjIysr2PRTB62UkSYa
 nNrgJbAYDslE/U/EduxA2c5ZJiOc+Y+O6qBQsy4m4SWxOa3sak2hWdTRLI9Op1pyILAoFW6Vcbf
 zqhModOnA2wL+o4wp4IB89hpwmNqG4M3VOyBJ7kL/ZeYWzNSMGwZzSa3aw7kmq2OT2TG9h69fKL
 X7gzIY2DScAge4w+NaOKIbo+o643aH9S+SBvqu5KPh0dKRrS99aLfJAeFzEfwpW+fOU4z6HUmNA
 5uGej/l7yyXVF0c6ZG1yGsCqzGaNqay3yxAnijuyKP
X-Received: by 2002:a05:6000:18a6:b0:439:b522:37f9 with SMTP id
 ffacd0b85a97d-439b5223c34mr9361789f8f.14.1772462481071; 
 Mon, 02 Mar 2026 06:41:21 -0800 (PST)
Received: from localhost.localdomain ([88.128.90.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55df68dsm9442584f8f.26.2026.03.02.06.41.20
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 06:41:20 -0800 (PST)
Message-ID: <69a5a190.5d0a0220.1b74bd.10f8@mx.google.com>
To: ltp@lists.linux.it
Date: Mon, 02 Mar 2026 14:41:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Extend -D flag to support multiple debug
 levels
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
Reply-To: andrea.cervesato@suse.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Maybe we should also apply the same approach to the LTP_ENABLE_DEBUG
environment variables, otherwise we might support only 0/1 while using
it.

WDYT?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

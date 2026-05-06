Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376D4CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778078831; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t0fPDssoIMAq0TXAlE6VB2c4Ji6xN0aYzp3JP9cCpdA=;
 b=nHEpNU26U+ZYI9V7mM2V+RE3dREE+59v07mFhTQ49r/jrbQMkhJkFWPPmJw0IpgrEqBu9
 c229L8Ii3aiHc6VCiXLgwbURVeLPMiNuEWwW6kphee3nYUcEaz9ekC/iWP3DF2rWYR/dqUQ
 PrBOZRXIh+sWiphHmrUazcCLuU5eZfA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACC603CC6A7
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:47:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BF6B3CC6A7
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:46:47 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 64D76600970
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:46:46 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso55929415e9.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778078806; x=1778683606; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/HDjP2ZHQ8M4nQP7G70Jstf2YdqPB5luLn0QiC0ZGM4=;
 b=VxPFviS9BgQ/nBfigBYSsTlq4+Tws62uiALzBPrzQy9FhEjTTNIakgydtptd27GtV/
 6dBfpw8bRwIBghqZXs0yaFKgRMnqdnLUwqfsCletAUbXYyrNEgFlSP4RiY7VkRPcnrU1
 Bbve4RnDLrc0zMgheQEtqTMGhdgeBmrRdsZhB0NW3UpntZMswa5jQVd2Cf6U1tUtG3zo
 tCQWZ2ybwp3PuI1Yh1viaeC9J70tmj0P9rRxjjBEim/4f51br/v2rmOj+hIoby23nMg0
 YzSDCjdEXfKSxFhxbQ48cktwfhCqR33rxtJCJ0wwVcDykg+BKbph6V6vTwQ/snG2Jy9z
 3SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078806; x=1778683606;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HDjP2ZHQ8M4nQP7G70Jstf2YdqPB5luLn0QiC0ZGM4=;
 b=N6sqBT40N4yzDptNCneFNExmCrFytgwl5TDf3gI8SUxtasCVcrJAkSu4eWXAMUWNDo
 3sByLcG7NZR0/4hO2/7zQXwFzGbZlx80JgZlUmiM8kd33UOgSV0Ibe+enOe+buD6ci7j
 Kcw55YppMoaePDhu649LkIJwyRai3qWSmL5G8ts73b5WqeJn54rO2WnI8ponLSpesvZ1
 DCS3Mrq2q0N6WqL5YG5nQF/m6fQe/ILIjpuyWhcmGaxw9TIeYwCiC+6ZzCzLDjpJux/l
 9JyIqnmnG3XJByAEWnTWv5ZL+gLJFgGvzevVoBAhVB2W7UlfqLicJ3yDS/TmD4I/Gk/X
 sqUQ==
X-Gm-Message-State: AOJu0YzJPo2G9nmqvkJWaKEvQ+tdq/wOS7O98AnMCfE5X/A+qR2bfKTA
 mSdhjtpIxhceI955R+NSQpzXVHbOAkUxUZyPqLdMwT9OLVGijw4urTkjLfQhzstRgN/zI5KBTFk
 +GWbI5VSwVQ==
X-Gm-Gg: AeBDies1poZsaD6rZwK41rk1CvXvy4iqK4MXbXzLe8JkliqOncAecMti8Ed7/mEjC/S
 vNUU7ggrkVGOCvwFOkOy09xvJZddjylqC9inP27n7TD4Vh3X+RapTmIG7U8j8TPULYNBF9mUb6S
 IWfJf7qrUPj8glEBd15HqTFDMokMZzxjZwuL29VlTsTcUQYJ2Zh+5Me7GcIW00S6BVooI2lnKS8
 PE3B6s5DKQknbIVbdx0zt1+Pd/W3VttM98n71xY5kdpkfFJgK40BQAPvGD9iQJqFYWez4nJFKSH
 mo8KXpTcuvg84mKNVf3mlZZ/XddEKux7sSx83odM65GcqkYxc68fWHtprHs98BVeZ1bfHI5f+yk
 7aWwMxV9uVRWADBcS/5GWDH3AZtLljrn1GekATy1qFIs0XkuzsC5CZZNOYwEQA01O4a4q4797Ro
 mr32hnLHZUYwMY0BQbUH5Cjl2pLQvtuwgDJepDyQ2YIwAm3R6gKNVladSXPVVUrTFy7K8AzILjp
 kKTvIjys5db+FA1g2CSW2l3INRrfAwJGT5AIxzKhw92hQ==
X-Received: by 2002:a05:600c:8011:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48e51f3bbabmr61408155e9.22.1778078805562; 
 Wed, 06 May 2026 07:46:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530fdc50sm29395945e9.5.2026.05.06.07.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:46:45 -0700 (PDT)
Message-ID: <69fb5455.050a0220.1c6157.03b6@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260503085544.16915-3-always.starving0@gmail.com>
Date: Wed, 06 May 2026 14:46:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] getppid: Link manpage and fix minor issues
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

Hi!

> -	if (ppid > pid_max)
> +	if (ppid < 1 || ppid > pid_max)

Please remove this, because it's not related to the manpages.
If you want this in, you should add it to an another commit.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

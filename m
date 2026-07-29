Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E66C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 05:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785304319; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=g41p3DT5E6o7Wg/DzUq+sVFk6Oopr83XtoTEpLOct1k=;
 b=Cdu9EVaAMrj0kkqyNeXMIb/f8fDuJG98ARaxNk1p88ag8oWwfU1pAE/gTnO3VzRL3pbK+
 DfQ+lluaWj4aiNLNzlgIdOVwFbra//CFFaj/FN+1/KV+iJhNylJGIpab3zJHi61HDPO0IpU
 HuJlxzT7Z9RepnSfrbZ6TKDb4aSJ4dk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D82DC3E4ABB
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 07:51:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FBB83E171C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:51:38 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76C1810005E3
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:51:38 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso5979245e9.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 22:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785304298; x=1785909098; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P0PDu/BhU2WW8nYkG3M/gbj95VoPR3/CsldTLdaXDY0=;
 b=ERR96EuC1+tS/ixlvmv237/LQL1M9CHiDtzrSA5sA4g6KIyYl/u0qq8psvnt/ARPtn
 I+2W872DT2CZ6l9uT04CT1BY6lsM6IWZFNIBRtFVjJHdd0VdYpg6ZMcZ6V5EC5k+GixE
 Y3LR/XuE0PpoSKd+jd1P1y9Jv77rHqDKJaC2ihMuRsv8jMyHBwsSC384x29CE5v210PV
 q2GVB7GnyemEaQ+Nx6jdTHW+ERZSt/7yMgdjuQPE6WWwyp/1Rr7nQTZnHUPYabWG50Pz
 xxAxWXXahZdWaL0n8Ei+Dw184ZB2tHrQN+RQXbtriEhHfUUxWrdrkRyiteEYXCd9sZSH
 Hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785304298; x=1785909098;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P0PDu/BhU2WW8nYkG3M/gbj95VoPR3/CsldTLdaXDY0=;
 b=RzyoJ/EqW6xu+I/PBJv/uGIifJ3beOreZfO6L1W1tI/wW1CzVZw74RilfyP0Vv+Aet
 12wDas34F7TMsLnDs45zWLxGbfsfl0bsXp3Eb8jbI04MWTcme36v19mgq8a0PS+O2NrM
 FEG5pwgpbmSh4sOK5L7mZqIQW9kxMBMBqmRNubHQZa/4MK7PntapMFsBdHJuADCeZjZc
 WIR66NqQR3Fj976PwoBE/jqfiqrnpFOQ9hOWUQXCV9HO2NQllD9JcvLpLPJyo2W/aex3
 A1qHYDFLAhl43VYhUqr7KzCDXwRIvg5Q/p0uCd4NP54wHXJo1ozODNieJaQtcT2KIzOi
 GVwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVHbTb4/lQgMsq7g8igPyUW0zy+ZUlRTMf4Rz5C+1MqlGvLXYA0xGnWmxlMfNlF36UIkw=@lists.linux.it
X-Gm-Message-State: AOJu0YyU0hgKZvkMmaCYYypspDJ5zavn4EZJTwMBVvWOXrHC4wWZ0BlN
 5+yK+N4RB68xLxLv9zHnDjQvkbzuokx8PE5/VVSKUij2P8YhucIVdRgW610MdgmjZtY=
X-Gm-Gg: AR+sD107Ii155lbRXWM8uPq2/F6ATz5e/jjIpA0g3/jTlAWSg6MH+y85ej39rWgMTeK
 iNoJ60nKIyAdJ3EnbRTS1zcnZH4BeigzvdtbvKMghNiSPR5D0PYSTUvJUxX/kEdEixn7Ta3vbnQ
 /XCfb2OWSysjiH4In5JKpzL/KByLJyWj7HQ11OULWX1ESrunui4eLTk552o+0B1UrNmT/3DRw6F
 nAuh/fWk/IVmg+8JWSS1SFBjZIAHtXIpLs+qJjpTxl3X99+yZxpjn8iODFvhLVuAAzZwyby4eO6
 Pz41QnGjUHsgvN3HtpKhBkbk5cOYG0TgvcCuWECGe5F4qsPAH7AsPl0qF/V6uJJzeen1vSnJLl1
 HVpGn3t3ZFIVFdn/M6ZPrJhhS8W9T5AaCmIOmmuvD/MbtxTxMdlitpEZEttJ2IDu+qeAPd+1MKz
 UiApnpYN9OQu8Eqgtw5SQp90x1oCSs/nWziI8WD2NwdoL/1gy7vvxJiQS4d70e2W7/HDqQ6aJ93
 gZXlBkWZ5g9lvUMyrpoislEnCap6AvoJvrgLIE3Cg==
X-Received: by 2002:a05:600c:5397:b0:495:7739:4e5 with SMTP id
 5b1f17b1804b1-496c65907f1mr57535895e9.22.1785304297825; 
 Tue, 28 Jul 2026 22:51:37 -0700 (PDT)
Received: from localhost.localdomain (ip-109-40-49-254.web.vodafone.de.
 [109.40.49.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44af22dsm116440545e9.1.2026.07.28.22.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 22:51:37 -0700 (PDT)
Message-ID: <6a6994e9.6ab3636b.1b6ed.7916@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a68b46f.f3563870.c8a40.1a2b@mx.google.com>
Date: Wed, 29 Jul 2026 05:51:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify20: Skip FAN_REPORT_PIDFD | FAN_REPORT_TID test
 on v7.2+
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
Cc: AnonymeMeow <anonymemeow@gmail.com>, Amir
 Goldstein <amir73il@gmail.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This observation is correct. If v7.2+ enabled only pidfd + tid combination
> for fanotify, we should not skip pidfd + fid. The 1/5 patch needs to be
> updated to use a per tcase TCONF.

I think I missed Amir comment in here:
https://lore.kernel.org/ltp/CAOQ4uxhnrH3=XsCBhuO3oYtS=pZcRjkAchtrVwtnfJzBVmpNfQ@mail.gmail.com/

Hence, if it's correct, we should then provide a better TINFO message,
or to skip test entirely for v7.2+, explaining inside the test
description why this is needed.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CA9F013FD
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773664295; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fBOlcuwoApXoaXkYyARM7U6VEB5+gM4D1Fn/xxV3o30=;
 b=e987giSVWUDMKPUlNnBVME74sKxNQg2hG0t2sJpgsJIBhIB50CfHzMIsDZxBoy7vwQVMy
 aVMTto/0/VAYPP7ih1GKdgac5G381SLHgvwVEHgy/MncABwcMHU3SxpIRMWqvQfVNDwOTd/
 zOFJdpAOqw/DR3UIGhQLRmlR11iuRDo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3353C3E4B85
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:31:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4CE13E4B85
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:31:11 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1A47B1400972
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:31:09 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so49321745e9.1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773664269; x=1774269069; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tHR+xk2Cx21CKyewUctIgpZkMJiF027huc+NVpaL5Yk=;
 b=XGtzbLYeKZ/u48ct1OO5wMC5fYiItfI7SkAnlochzBSRwAE6zy1xprT9RRBePeX9eN
 wQk97SvXMPjyLnLBbJSpqVgQ6n+YwbeOaA8xWRqkgZPi23u8UVfoeHjApSuyAbMxHYV7
 sf3eCA1szfaiO2E1b923V/hLm9NqvwkB3jGwefQzY7VFqoftV8kdQuU5YaOGjgpwLxBv
 FfARDvZX4qlmyBe4s8bMUG3o56mSSZJObNo85vDG89+jcFxo6iVSOsHbtGG0EbVuKtiu
 ZZZLqAapo2Sgs2iTLNZTW6xMGUPnpwPhfQCxLT9mocooWClEevyTtygm1YwcwVG5a3Mf
 t22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773664269; x=1774269069;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHR+xk2Cx21CKyewUctIgpZkMJiF027huc+NVpaL5Yk=;
 b=VtWB0EZsAgRHuwAEFGyJz+kRz+fbgG/3/Xl14Y8/cYVFo2jGnmrVxYnqmLivhV1ChS
 j9zE2I5+1x4AzAEICz7ZJ7WdQpZGARdR7xGwLXeitkMm7tEZTa4fZPaCd2p6ejF7XIQF
 o5YqPzmg0typ3LEZJW5aS6lpWLBKzall27iuaNywzWeIMn9Iz0xNWXxJ6t6vHVxJT/qK
 ikGYnncyNfgeQama7ghCRbKI2F0pxRLZpOVlz1w5l8e2kcLNDR8SHwALfOTBK64Jdrbs
 qmc91RzFzb3h+VErcgj3XSnQy11bB3OeDIXHB+8l1KmrC0aj7dfkh4z9HIi/pgQ+ZBWN
 VyNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0/9Dc2HpoKtTcydsp1c4MI/A34jMSiftpKogObp5lxETxAGgZXnwxv5b3SoilRUmJGJQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yw0XHD8BHWZqAUykr+swHdpwoayVDoH+F8R4sLohvmRw9E7zoO9
 Hlm9uUneHt7jmCmJpdARjsDr+vIoYYUK6e8o69GdPZmcWjrnZ7dOv1I/foOTN5osNGE=
X-Gm-Gg: ATEYQzxtvjlctT/VVJV3MTcMXQTFnF+KLdLN1ZIg5HN5E1ou7MVuhNE4PwQZe2SVlQW
 3R5FX52Q+VjbDzqTX+12EcKIFuGyMH+FaxfvZwwpcXO8RC6X7pj3ZxH5V2WY28gIfBrKK+8xF1q
 y0NNwioU+BQONM9x6hjOSz7GOzLXhWiBJyCJhiHVUXjtGvDKLdb6FD+fyEeNdffJ2SpW4hnS/F2
 QwqYpaArXRzsIBx6wN0t2LRXWCsfBQsmq9JtAVto3DDl59fUWdDaLw5ivHHcGe5xliGThmHCLAx
 poxK19CAAFVAKmm3pxUSjOmEFTROUyw0fedkTg6C4t6CXrNJURkCvENlAwm2jwgHRUG1po+6HZe
 sH/EGmZZpnBoWBQMTbDkNdCfhfhY3sITWgT6McJNF9kS+fc07S851Gg69F4EGCWYFhuhk1fUmgc
 dIVfMzA7ewdjPYCoGEGbFCFYlyV4uLxrlGZQxYyskzmK7JG3m3oTpBTJ4iDEbKOKkf1bJSUI6br
 m1rJScJAOctgTT9MTPO+lLwhA+LrfuSS7leOchsrRqsUC3GLipecm5UNWxnupYyWXISn9K21J7Z
 Uw==
X-Received: by 2002:a05:600c:c3ce:10b0:485:3bc7:a21c with SMTP id
 5b1f17b1804b1-48556702a01mr151573745e9.24.1773664269310; 
 Mon, 16 Mar 2026 05:31:09 -0700 (PDT)
Received: from p200300ef2f4fc90053e282780f88a5bb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f708sm903884325e9.11.2026.03.16.05.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 05:31:08 -0700 (PDT)
Message-ID: <69b7f80c.050a0220.cd9cc.6c67@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260313160520.39745-2-always.starving0@gmail.com>
Date: Mon, 16 Mar 2026 12:31:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] inotify: fix make check findings
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

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

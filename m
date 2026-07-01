Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7278C43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782899160; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Pom2zmE/H5tNTPLyMCaV6diXXbmT0r1IGmTE2ry0qrwhQM0osjvcV26hPskyxug0bKtrD
 mAwK2inGuZgKSuve+2gSvSI8GMbrZIwhMDzl4qbq3IAA3B9/ThEaukbZo4jMl2CHlRFRJz/
 7WbX4T92iAqwIWQPoDbODQJ/ACne2Z0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91E673E96FD
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 11:46:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A7DE3E27B0
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 11:45:40 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CBDE1400B7B
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 11:45:39 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493b6f1b14bso1772285e9.0
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782899139; x=1783503939; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=TDK3vRy3p5iCMSoOEW7bIyL4iTV6MoEauneqPuKKhT85bJ1noFpCsIlJ0IfgZ25KuS
 Gc+ntGZnSC4aWPDuA2tQpx82iGgGPMmAOTZzm6dG/8ACDqafMp0dh5l76SFJt7FYweUh
 E4g0Jr29HFYlizdHgR7jvFrKKgpRgGqoZq9BzbGqZZ7VUB4QNgPhPnRYMQ7ZomFTR0jA
 ERTFlB1w2n2NxoPSHcXmOfCyrvQU9QwQlFhj1OHfwUQqm0azQvDjazDQ25qaWFACKCfy
 PhXAvTriBilKBLmw/zib/gOs52jv63lJ8h4KPrVPjZLYfuZ23JFxm4jMCbdQj2mZiLBc
 dh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782899139; x=1783503939;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=e7H9ELYv7VeFr+aEGlnX8uoRLp9cJOVl3GXsXkd135dUWOGv1GKC0P/H8KNUWyOj2k
 Jm3MJ67m7IE8wZTmh+zz2NZzOBwxI5DXJgqQwkWIvItT4l3Bs8aN0dA+OwdqxCImJyZY
 zYQpQAsDLaZUATrEdR+/h+jSTAhuSiKc1w6JT02Npx94K95VNkDbZfgS9yxDByjHHyzc
 +1Car9KC3/rgc3oVYlIvSd1lH+uLbJQHLehp4azqvv8PA6HgYRDTuHObXEdrQoR4Vm5e
 EW00hA6o0rue2uhX/CztmPTe9rxL6FDl1dLx5WcTBGjVH5I2uOGUJe+bwSVi+jTdgTd5
 AvTg==
X-Gm-Message-State: AOJu0YysV75YzWysyT91/bMNKZpnsD6K7XCF/I9n1MH6dpm+edKhT2XX
 yPORLWn72+B1X9sgKyLir4aXXwtyep6OFmTmrRCBciZ99CAKmtRfY5YrlpIOoeqxApQ=
X-Gm-Gg: AfdE7ckHzhaxN1nj/lfLGNU0cFqRVEqY1Tk1RLGAeTWWixPskLytWdBsKAGM99rYYxg
 2jFGHompt0u11lMon2qwgtgIbLdE2IY8KYIZVpjGuha8A7rND/QXjdD9x08+m47QeI16mLG27ET
 15GDOT2lKEE0EPVZ6OVh8e7Y8iMMr7V/Tl3GbDC9/4we/R+yuA39j/tnO2TvBsOwvIrP0OeDEZ5
 rOn/ed6rTI/H39e8sxT586dUOzxj6aBT2FdjwD2/chNwuOOlqwuQvi1lVijt+WEqAPATc6lRCfT
 mKageLLBZb6dx41tt1IW2IDyXJRL4pNc57qRsu42eWLuNO+881CgCOpPA901HRoKlTPp9At9gOK
 zfdPPOLw2Rne92uHGQBFvdpE0NqbhtYm9OVXu1JQq6hPhORiB1NCi2riy87pCcfBRHBgQMMwI6H
 kN537nZmib6kymYe05KMfOVQVqZPE0PCz6OhQW+xTVUdcqdE4M/jV4qhGHdeM7T/OMEj43fvGNg
 bpEqw/OWrf4MhSuRaSJ1d0J
X-Received: by 2002:a05:600c:810b:b0:493:b61c:72c3 with SMTP id
 5b1f17b1804b1-493c2b99c43mr11748535e9.32.1782899138766; 
 Wed, 01 Jul 2026 02:45:38 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d15ddsm61791985e9.6.2026.07.01.02.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 02:45:38 -0700 (PDT)
Message-ID: <6a44e1c2.459cdc55.14a098.5178@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260630170611.479639-1-pvorel@suse.cz>
Date: Wed, 01 Jul 2026 09:45:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] irqbalance01: TCONF on missing interrupts
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

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E15EC5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786618930; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=47zLgRhYxbZH1uNpEcE6ZRaC3FEJdBjKywU85R6k2ag=;
 b=R78xliR9KpoDh4sZ6R5dPzFvMmCf6HNdXMRyjtvxux1Vu3YK+7Aeoed7PfUed+ukF63fX
 uRRDHnHM0qhXeOMFIAom+sA29A8DPIJgpJu/fLLlCoTVk8GZCpWsKQKUukoklmAjDgjmnXC
 aZCGnSnM5iQIQGg3m5p35b7S/MD0ccM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99BF3E249C
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 13:02:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D41E63E249C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:01:49 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 316D61A000AF
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:01:49 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so17629285e9.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786618908; x=1787223708; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jGoVpfKDMI2AMLcHsjlvmNmxiyvmELx4Ql7iUnMuecw=;
 b=NCztnbCszfUAWPzvxkMnP90mwlkoMDx2LklLKZL/FKSmuYoVScZEOCFY0IFQWy5JgS
 ATscGzQLeWl9K3LSHb4iFP30sCKFHxS7NJf2s6HZH3VD0FiaWlfnCMs6jw6yt9qr+DlN
 oreg57HLNJVebsP81wh4+ycRTX+3gfLWMX+jWzsWBL4GjwaRO0Z9XaMCEnnskeYVy6c2
 MJtavxG5jOZGeyhw+CeNeW35/PVwctjc8fOpm7f+fV230IRRK8bBaDcsCaSb5hbW6iiC
 jq4gsoDQ4AA+xHbzOWaxetKQUUD7vWU+IiZb2SAPj2OG00E0EWrntAs1Dm1g6QK6h+Pe
 +qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786618908; x=1787223708;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jGoVpfKDMI2AMLcHsjlvmNmxiyvmELx4Ql7iUnMuecw=;
 b=Jw89Bh6WpRhoU1Wkv2xuKudPn9zORzP1p2t3CA/6q/C8nid/p6q2fV8HPO4owybQVT
 szvdhf6NoGyTBYCmtQd227UgbXdUuRnhGCl0jfHlystRAnZgKtnzHsmO1lLWFI87GPuH
 wNcwUEQkaUXYqkCfBAkA1WftAGN4+633ZfUK76u/qDprM8lc2P2LtgueKuubb3+rDm2Y
 CGtWdSb5U2ijjafNV5DHgK/iIgdQVZASmX77GLvsiJPkt2iDp0FyVLYs4YlK7LDiNUHL
 wu4htAKyBzghwDJHTRbkTjxoLg/udBqEwqZOzEWRegjvgFhHuw1ZpuGK+f6pma8zgBP8
 XU0w==
X-Gm-Message-State: AOJu0YwaJB/+ba1EWjzxyNUlNHy39dJhTs4lGF/wCu7zaPRzIUkD6/kB
 G71DjmNUzdH4OseWVxy95IK0gXXPAzovPEb1EcBFKeVx1iFz2cGC4sKUGtm4FNK6zgX1rOWDZAW
 EKPUn4Fk=
X-Gm-Gg: AR+sD13zL/1136OYg5tgZJkfM6b4LiHSelQ1NnWjKk79Y6w4uDOzdt50tpuGxVabdlo
 17mx7He2hCx0+1tL0nr6hmyGJxwHgd3JMUmw1rIHYMC9u9VonxaOhkHLgZRXVmfFUkZwCwYMs1g
 rZCvPgFpPrPjUuSf0GWG0FW4HJ+ZEezmpfij5QMGUURuF77as0qxt8ftjXwCP93M1ScOSPP7rrD
 Ml3sFhauK9N4KQMpyqzUQGCbLcpSpBdPDRA+nHqC5kQ0MNxNXr3NzPnvTBwbSNX2DyIsyg/xCYo
 L+MjNxJASlOW9ITg2Qf+C8CEoPbHJV/SQqYI4bhh1tGnJQSvCkTM+xBewYjfmGBuL5onXSIZwsL
 diwUggiWC3MxafiEXoO+UmSiuhyrmJ6LyLOYx2YTN558CezLIJ5YEpg6gxNfIcCTAoaFStiJRjV
 xHbqILk85V9ORVK6stgNXZjiWLoXU6S8pPNF1GNpVvG6L8Q+3si68yvRuJXEdX7/SrofVk/KY=
X-Received: by 2002:a05:600c:3e8e:b0:499:79ba:ed92 with SMTP id
 5b1f17b1804b1-499821d0652mr64521755e9.13.1786618908258; 
 Thu, 13 Aug 2026 04:01:48 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e4435bsm26768625e9.3.2026.08.13.04.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:01:47 -0700 (PDT)
Message-ID: <6a7da41b.c9654812.141259.ee97@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260806150814.4947-1-always.starving0@gmail.com>
Date: Thu, 13 Aug 2026 11:01:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls: consolidate getpid02 into getppid02
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

merged, with a small fix in cleanup: child_pid needed to be checked
before unloading the memory:

if (child_pid)
    SAFE_MUNMAP(..)

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

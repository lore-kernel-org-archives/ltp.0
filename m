Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A724E9A776
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774352800; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=68NlHfrAVTQwUukz9MHY2+U39/YU3u0XqCSG6UqskTo=;
 b=XnQHtyJ1ONZLHzPPeXjQu+RuhyRdrX+q+sxdMSnrtZ50wu7oVfr4gATMPK4LX/uKwTB+6
 6imp/x/ZDuBxA3b/NCRISuVqrJCuBnVyppj07tLoGRXk8wRVNNY0Omunfsb8oRa/lyYHns4
 chM6qrtwDit7bELP3JLLeJid6PNF0wI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6B233D0E17
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 12:46:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EA6A3D0E17
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 12:46:18 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 585B31A004F4
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 12:46:17 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso11151695e9.2
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774352777; x=1774957577; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1pyZ1h8bQppWuG7ap0jyOvsMRZF8xT3fTetG0A4ebWM=;
 b=L/+JvFpZHzafo0n2279ZT6BB+BGgT9hUFOHgb7HsrN+amc3YZv2hTIMWBx9Hwhu3ZE
 FZhageAzqYvCYTG15Q6/Os2Ls/FdCIpCPBwuuJCvngCF7wa7gQSq++F3T4vBKIzSUZpd
 CSMXYN4SB5aN7u1WDFcnKxklQ1iVL5r4mzsAVsk3Ljl86MECdTbsEHKtOKjpOnNAkj8T
 nzPrwLsdm6bvZ6SZQU4z1kKu0pwHqykxywUqaoz5X+24MmiHLKQPtF8EnlYuR0edQoNk
 8tW1YChAJpSdbU3+IDtiXLJGhJchusIDwemYtbH9H36tR9129NDoMo/QT5mE3sJ8MkRS
 ByrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774352777; x=1774957577;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pyZ1h8bQppWuG7ap0jyOvsMRZF8xT3fTetG0A4ebWM=;
 b=ccK3rhMAq9l43rHiaibM6Evuxd1vsvhtrrUN5QFu3nX/3Jo7tSdnfC5Z2LlZz5XtkC
 ukPmgFKSV1PtiU31PUzZcbvv5+x3+LvwRC/ePX49W9hcC278k2WTdZhGVkvbI+YNv9Mv
 sfXdF7VGCle5d3w6LypVSCEyuXGlwD6fvMHBiWFbXfJP25BG3foHdUXpBwlVL+exAbHt
 TMjVfoSUeuQJdKRzrH27Dgr9K6XM3j54yWU/b/6u4Hd1ENbo3U7GCs7DAHVC/6t66Sak
 4lbjvsjFvxUYrnjw7nKiMIgZAPCGmrWYySpuWmkBTTgaBeq/cA59QfbsrKDW4XOXO9de
 9ywA==
X-Gm-Message-State: AOJu0YwQblNgaAnWOa+2tOwGuAooLiD6ZlyLvTK+v9I7Fv7eo4+byWg4
 ryt8V35cAAiP0n7qcZ24fxhuIY/ktkQ0eZwakE9AhR1Gg3pEU5ipAsynaOK56Kc4GJOZfmXdsVh
 dzmByv20=
X-Gm-Gg: ATEYQzx0Cb8YscuvUBjW8dFCc6jf27zqoTewdWDLLOT/1WMTMWgmkR+NXu9h48qjFmJ
 0vFr+WQqLDofRVdm58VxpxzSLCGNaBnNIziaqVcC6Hcyx4Ec0hQLf3I/2PePeWj64seNlzzUrJW
 i7py79JjnS+A4pkCN/IxRvZh69090gUbzQu3zcbguQ+WuFSL+BHMDyQrMHuNTQ/Z2iuC7MYatza
 WKDswq+TlXMn4FiZ4/uIkTtaWUP/luAYpjE/VV/56SvxTDrgcrJ2JhfqH9fv1LchxzFLEVqHge9
 Ht1EwWFh5q6cKq4QvktEG9l/JNW3bg/JJoj5+NONXj9Wu1fbgb8eXxLT+2vTYn2oS0oSO80ZO5a
 6QKiSNRv72IF4TOzjXmdJmem1Zn2/L5JZ7zjuu+qi19vpnVrpN0U/sZbxDx3+Uys7izVxM2Eme2
 A0vDE9uulf5w5VsCvgP6YNgMIHdmzyXyw7yFL6A9vrP6D682bNw0o=
X-Received: by 2002:a05:600c:3b8c:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-486ff03f4d3mr232561395e9.32.1774352776496; 
 Tue, 24 Mar 2026 04:46:16 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470380asm36555054f8f.24.2026.03.24.04.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 04:46:16 -0700 (PDT)
Message-ID: <69c27988.df0a0220.cd411.ee55@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260324104918.GA44631@pevik>
Date: Tue, 24 Mar 2026 11:46:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 0/5] network: cleanup stress
 tests
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

> > This is a huge change. Did you verify tests one by one? I can trust this
> > patch-set but we really don't want to remove anything that might be used
> > by people at the moment.
> 
> FYI none of these tests is in any runtest file.
> 
> And I expect nobody is actually using them nowadays because all these tests
> require 'rsh' via check_envval script:
> 
> exists cut locale rsh
> 
> > There network testing suite is indeed quite complex and ugly, so you will
> > have my approval if you think we don't need it anymore.
> 
> Maybe some of them have useful test scenario, but they seem to me just checking
> if kernel crashes when sending packet on TCP/UDP/ICMP/various IPsec. And because
> we have better tests covering IPsec over various protocols including TCP and UDP
> I don't think they are actually worth of cleanup.
> 
> Kind regards,
> Petr

Thanks for explaining, feel free to remove then.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

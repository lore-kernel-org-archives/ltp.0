Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A545CD98CF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781532372; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=u4D9UjDUwTxbzgIOt6wLUJLzM+Zu4BXycMULy64xfqU=;
 b=L6QrlBvbsFWfeNRAve6bKmbe+MrrvF7E3VN0l04KAqpMax3Rs6AgEQV3pmzZZ23KFeRzs
 rVvYW4gUj4lNP70NVlx7a8S7HexcuuhN1kLengg1FIe0f39VKCykGROayw2T3mGhd6eNjtw
 47xkiusCUS86mpYJkpVWKsGO681XK98=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E081E3E4E3D
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:06:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 723C13E1628
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:05:53 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C28A2002AE
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:05:53 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46015dc517aso2778718f8f.2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781532352; x=1782137152; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=E67mDCxu9a4ns5b10DygUJ6Z9Mmww3Vw/1kcZ5YiSBo=;
 b=QseyJKpyHWipK5Fk/ipteyC1wkC7rLDQVySGoCuq5XHUx1biDiuX1dy6wZ4/GN52MZ
 hA1Wyit6i9SaULUyd2OCrLuUFn9GtGWFNt4gIormz6hCaQAcPUVj3QNB6EOICSiCcjmk
 HotrNgClC4cPFKCEP8N3mqpcOVVrKUjyKsrDlnmZUQU5vAflnyNA2POGLY7aWW0WI1Pd
 1inppM2Ix6q7vjy9laWvqUgn1Pr1rPsoQefXDKuxpu+DH5hJmsxB4YdUBpm/d78nyzWE
 RlL+hUOsE0wJWnXAl77yRElB0BnPpq+Ff3KralQZSN/jAPWCqqtpkj9+ehEbcadlx6Nh
 jQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781532352; x=1782137152;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E67mDCxu9a4ns5b10DygUJ6Z9Mmww3Vw/1kcZ5YiSBo=;
 b=I6RSGCOlXvpQlGOuojr3kdKN3GP6OWifm/P1CeRc0wOXdkbQuOGTyS8Jz0Z3WLVZDK
 p5s/FxWLnfIUlUEBL4Qa7YjS4qJKMzF2F8GMIrIxeYgAm+Ah3BfdCWMWtv5l2T4FZaM0
 ManUZTX3qRvWEXbxuA32ymOwqD1t4oflywAY0DdZP3Dw1n6oJbgLkqjTtBWfbCRTbrM7
 UnkH9rhhtkQgGBkd9/hYH83IR6/R6k8h1Bx8593Rg1iYbNKnqtpSvEntMc2m8C9luBsG
 +QzRl7TPggWlwg6aSFomCuJ4VsperInftSmbBB4xXXPmRhF851UQ+zC+XrHKLOG6uEnO
 7llA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ohz36JSgvM4EUFHfGmOwX9Q6c1B/6FUrdWxlYD3A9q4zC4dSdSWPudBzsPQvJoDXE87Q=@lists.linux.it
X-Gm-Message-State: AOJu0Ywi3hhGUx/j8nQtfYxcwRxzJWc6SRIMOnA6rl/ftz4oRSNO84dA
 DyM31M+x8phtCvod0UdWe3rhJOdr6zSuotA5pv8V5bKZszfUJ2WWPKUqSo5USw6qPzQ=
X-Gm-Gg: Acq92OFHT35PgvPZgny3/OWV1N43tIsG8cj2Uw0piE/ynaO9Cx4jAcWqC5x0rfNgwuV
 U7nbAY+XdMpasXnT+oyVE0wNGKmhBTXeOU2u1sbSa6OF7WUiyqbOaKFqBEou+/3NR6m27MC0mh8
 gbt5BPqFfnw4wHP+mtlE7RB4AriDzi74GMPVxQFEbs7lj16NHwqbtc6Cmb4EMWhzu7cRRcqZZwN
 lPLG/rKiarMvAzcVC+vRekivpbAw0Ct7NE5K82bPPzzbgia40C9L8kuq5BNFgEkRHAh+XBO2Tpe
 MoRDsMaJ4LYI0mpz9FWlE+rMmb1dNvZwL1oXBylsF+4mNNXEL6GiA1VSqsWNrwNQS+0CpP2tbyz
 ch/XJrFHT9ksw1N4TSk+MMOKQ1mQHlvPp2jKyHpUtwRTQxB1p/5NZxv8FDAQf6aasVlD4p0PGO8
 3YifAuBsmj5ICwHMnfv49ZbcMoW2DMPbHnWT9A2vyzfhGqKra9rz8AlCFhY+SshqznSTNMgOOx
X-Received: by 2002:a05:6000:4904:b0:45e:f302:95b with SMTP id
 ffacd0b85a97d-4606dbac755mr16719347f8f.37.1781532349031; 
 Mon, 15 Jun 2026 07:05:49 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm36404484f8f.11.2026.06.15.07.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:05:48 -0700 (PDT)
Message-ID: <6a3006bc.2224f9ac.1726e2.63df@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajAFeN3dCGapyGUG@yuki.lan>
Date: Mon, 15 Jun 2026 14:05:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] fw_load: Modernize ltp_fw_load kernel
 module
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixed year in 1/4 patch and merged. Thanks.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

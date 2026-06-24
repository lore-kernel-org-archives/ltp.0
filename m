Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C544CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 08:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782288890; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=JncbB6KM+Jcpu3BzfvVmPZoFXGLWhs815cgpPFDpgbI=;
 b=I7h00Qia6vqUDTonx5kcSYsHrGml1E6x79GIPpA/Hj2yIPHv1avhkIFbBwp0/wWVf0i5G
 sVNlUbj7hrVMOubSyOLS1LGZ5vcjVENSim+wYySQ+cJPI3fKO2J52w/dSXg97AXPc1St2rO
 jY1IZSVWA9xTPdO6v/xDW7rtms5PpAA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BFD63E61F5
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:14:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A67683C023C
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:14:29 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A8C9C1400257
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:14:28 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso8693005e9.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782288868; x=1782893668; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=J+rultoc1K4WFj0gAQMVNmSvKJN0LON7ZcUlpIWa3A8=;
 b=XGZRej1YruRVPw3Zh3HseJXJeYx3BzBoR7kinqmNbhBcwygQkjGCUDoXBkKHzI1Fau
 gfHTJwDXQGJpEGumIFd3ySWEGGo47qLl58HWre4UKb8lQBFDkWSzsLTLRetTn0FGFQy7
 tLkbYQ0O9xFI9E7aiHR1Pq/6IUcPqGCaAxoQzGDTu4Mm5/tyoKoeCHaMGHlGJqLOvQ0i
 2NzhpXtx+MPJ5mrEH/964lJGzURjJBse4zGTMzVO3fue71UJh3UFiQQRvvToyhX+q/1h
 /rPwaHYrlTb133U1hYQwDSKdpUKYv+TnFmk2v0Kig+v2dHQgV8pURldQhS3/iM+4Vg/K
 ApHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782288868; x=1782893668;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+rultoc1K4WFj0gAQMVNmSvKJN0LON7ZcUlpIWa3A8=;
 b=GZKstw9goPvZi80q8SdY8lrM6Gi/oxcSv/2DsbEHh6XZ8biE85/4niQ+xxgc/gEh/B
 Mok1kuA2e46Gy+pZW9Nu3TIprHMOC4kp1OlHCxLOUNV+kLnxFJYz9FtE492BdkvMHf75
 VKI3YrdUxGoR2ZtIVrzkoW3ZsbAxzYxM0j3N7/zynnwy5hYCxtDqqKfLH1PwZn11LfNV
 V2FQi0jYz6fgXgsj0HkW6aFgI4gml6kcgrxCs6zZAbsanDMTFttV8IF0T2Fdv3zfv9LB
 QoOqLzAtmJZxBucMyWeNbUnvOMdtR+kXUT7xEn23uI2P71UKGqZxF13cpfgHefOAfdoj
 ubTw==
X-Gm-Message-State: AOJu0YyIY/G+KdXFswZB30x/3oaeYImxd/GQbgowYcUKsrsRmvxxOtcJ
 4UeCtKSYGULor+735uLsEQely7uscs2Rin/l36yK85kjqmflXZZ+cyLexDKJI3MzFtyGWeYmaUy
 qNZrFrUkPuA==
X-Gm-Gg: AfdE7cmTow/t+FoFHJrGGg+n52imyZU8gVaH1g0MvZFqn2v332ivX1ZRO0q5BGnCiP9
 wUAmtLsaPrFW8ZmHHstFkUaC0MZf+mWS7P21coCVUIP9pnhcK2TMokwV401aMJBkM/zcGzhhXFR
 qSTtDTBeWAdycjWlPmh84ALp0w30opKgh6WM6BA6t49u/PwNJsIMBrorSppWdoQ4TXv1eaRiiXX
 PYziBziJdJO+ui0JeGXsbLvyigbZshBCqg8rpjeKW/SQC1ezFd/4h0HROKYPLV9LdwV1J493yNF
 +fmIqle/akIpEmDCq/CA5o43F/UbZYd3eLKdaQBwiVt2uO8hmeS9SpHwsmxpyzagXban7/bHBlE
 Xqryf7rZ8rrAwisbLitfwUKMqaVvng+VjwGAaqVQ1M5yTIXmw9mlZmIJY/c7mFoUwrFDXy7llxU
 H4fi4goR2zJi98CGJ8A8aqUGggJlLHdCEnak4NBONNcxfqe/4+RR6aayAlmZsap5VUuhTox7OvP
 78yAhT+7Wzuat+GbGjMJynHizm8b2IJztk3l11FjLldaIsjNf1oZURW5bSiaRu4FjmiS7V3ijoV
 Aw==
X-Received: by 2002:a05:600c:6286:b0:492:30f2:963a with SMTP id
 5b1f17b1804b1-4925b312c86mr88961355e9.0.1782288867830; 
 Wed, 24 Jun 2026 01:14:27 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496cdsm322734405e9.10.2026.06.24.01.14.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 01:14:27 -0700 (PDT)
Message-ID: <6a3b91e3.49afda34.2c585d.6125@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260623124812.46022-1-avinesh.kumar@suse.com>
Date: Wed, 24 Jun 2026 08:14:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] set_mempolicy05: require CONFIG_NUMA
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

the patch looks good to me, but it's probably not enough. we will
need to implement the same concept for all set_mempolicy() tests,
since it's NUMA specific. We just missed this for all this time
apparently. Did you see the same errors for them as well?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

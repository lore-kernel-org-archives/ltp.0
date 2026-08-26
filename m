Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624ADC61DC2
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787734046; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=nM5HJ7bIf2K2Aa4mNmge3/58gyRthcxa1VPoZmFmc6cvdEqiZhncJoPHoT6hub81p5Qjr
 oMmiEMt8VEQhZqgnU5NjNusT5Hia6hyrgSF6Z4ONXB+84AfZnrwLvEkEN2ng85jySgIysgD
 YNs1e9FeA6nSPgDu5FdbNSkdFiQ+OoY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 983313C8484
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 10:47:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 221B33C2861
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 10:47:07 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD9006007AF
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 10:47:06 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so110732266b.0
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787734026; x=1788338826; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BrNUuq1yXVH0QufsLXF8ETkmsJiynQuwBlNsbAtm49Vz2nAl3c1Ghc3t76lONCG+Id
 ENFqvhoIww/wm//wOqY58TptJJesMQQWv1Ewqagc2qO7/3Xs3PpO758DsvxIgZ2j6guB
 xxlhHVC1j6kjbUMErp+BkJBRsgD5PA38GKHhJZyYIQEHtjY7y65Xnpw8fd3dmgGUgt3C
 IDZINQI7/sSNFJXrzDu4oIx/QD6O9vEXSM2hiGxBBTHhS5COMGWZ+Sv5yBzMAy3z/A27
 8G8GMa/XVbPdCyxrQ8V1CGhoir1Dm0UBycQ60KUoV68+r7sTGrDxIJB8QeHLPwCC7+Ey
 4gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787734026; x=1788338826;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=QwccR356v3+s7J8Agt7M7Soq8UDOXLyBkDSd/GP/ZSpnHs0ksbOFzRWs2KrxvzboI/
 HzA6wMQbYM5Db8al+rWfyw+J5JQ6imIbCt3AwgFtnzchJ9JpcjESfQwjy970ix9O76Tn
 wodd1CSw+GEqythpPJACM56LgK1P3SvUS/uSDoKyKBm4FvKd1u6WNRIuO2E3JWpWK+MO
 W6ZNFXHvWXQ4nwFDJklI0/VHQDtlxjpQIIOyoDMB91KgQ+9cw48S80d+YIPHihF4c1/P
 d9KbKcumz0Wl4XyneOIsRSCjSfrkoDv5jxb/Royphvg2uH1NwR4GKpzAYDEI9Qv7N44A
 WpzA==
X-Gm-Message-State: AFuF++kTFLSXorKztBCagrpIuCvdRi5enGdUIYKOMYUPY7c6OgSbXwfg
 7sNQ9PkyVxtFn+2zhnuyPgv9ByBZmYSXFOKq7p2/twOgpxUusskljDXqJUcmCfbbOiE=
X-Gm-Gg: AR+sD114D2QPD2lxPUeew+V/DKpnPW3xJ+TD0DTUb2pdtcJ7YDbAdfLkKaDI4500BAN
 /wGnL2nBuC0ONEwtuJFITtAnjSdIfYTtEH9Fr3mXHg8JQecytdoVRUWDDtwe/VU/k/YwBb4WZl3
 YafRK1pF6XHy98NZc2R6RgEzxOValhvbNYtUIKGUQ1VDkLhJlcE4qPd9BxY3UhBdhlzCc2JXjZm
 WWe2u9zVJD13lkCIxExMCcFLs/wuH1gHJ6akhbnvffD/agwZin2Meu6VHAk/sulw8mA1IGOtVj0
 ksZzWhs2ZMAdXNkLqMT2gyYZyoEBG5GIR+cOS9KR05aWof98LclrSask10B2pY1hasA0K0RRGk2
 D3RwErpZdyGXfWBXgH2/opjI8jD3llKylGRl7grqgoUWVnTXyRo8WDdznRxi/As6G0AdHQQ4wO6
 LABowwS1DXooTeaoa8cvkCtm0tjn1AZ1SoBjASd3yKSLF9i5XNt7n+JUQCyrpZuXSxZGwxM94I2
 ye+jP7AkCIolSZ342XBn/0/ln5ErzM7B3XswgtYn8D5D+n9pVc1diQnLImqPB/aVmC9tJ0=
X-Received: by 2002:a17:907:d0f:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c250c363717mr699043366b.14.1787734026062; 
 Wed, 26 Aug 2026 01:47:06 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d69a7sm569092966b.8.2026.08.26.01.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 01:47:05 -0700 (PDT)
Message-ID: <6a8ea809.d4813f7b.37063b.921d@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260826020337.3685452-1-cyyang772@andestech.com>
Date: Wed, 26 Aug 2026 08:47:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] readahead02: Fall back to the parent disk's
 BDI for partitions
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

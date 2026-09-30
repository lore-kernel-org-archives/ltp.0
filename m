Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FB6CA5FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790775997; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=QuUbibKraRziyBFkeedc1c3Aeim3fq9IS+nDl43M7e8=;
 b=Y8ZAGK4e9fFoKNJQQiKHLhtr51qvbvpBhp8IOS4XMXDu+tV0dMZuSggJXR8/av8qTC359
 Rg5ojoVdNfcMl+N5XDi69GZ0xs6in7j0Hv2104wMMVajc2Y3n3ulM2HZgwmxaaJyNs0ftTV
 1U1sjVSBAVClP7d8dmPrb0hy7su0+II=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8E6D3E5833
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:46:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4B73C5493
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 15:46:16 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 618E810007AB
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 15:46:16 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so3310307f8f.3
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790775976; x=1791380776; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FmJHkp6SNaCPud3qnJcW9AE6lXOUMyPOZfe5YcP+Da8=;
 b=LDz62LHTg4Ajb9DcHO4CrRijQSCneZouqWJQzL339MaDenStbRLjMTP7/J80ExAxch
 tbkdYhNYGiRJU7qpHBJ73BeENYzZoWqhoCYZsK/nAOkHT/x/97bWc/gM/kRzvoGmThcL
 dDy5KvphWw7M/76f2BMIRJRD/LKSdRIIOAE4Rfe2O4zKjw654RJn/AKr9AOe9TZ5o4fQ
 fjQ94hPLW9bsh33k3Dhpdaw11bF3bA8I4QTAP2wyN6Bhu7eIuNqdp+yVjk3dPKOEF+30
 bK7p5EXNHbI8wDDT2QdtmGqLLTA2x+kRZWGjDyUMmvuDM70mTgbiRpS84Otcp72ik01U
 SA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775976; x=1791380776;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FmJHkp6SNaCPud3qnJcW9AE6lXOUMyPOZfe5YcP+Da8=;
 b=CRY1gI0C+oqs+T/wv/MrouIQvpTRQsk7b/sZeCoov/F4/wvdsqkJZrEh2QkpOkk8OG
 elgaDj7MjyoyEFjD/33fOOobtY/jsnPpLXFi+C+2h9uYyOPtzqFyIdHPcUhbPuzDKogr
 hkwVQIlyP/IpDwGhH/ioG1jX/KsqNQLNsJuv7c9TtlsQR5qERtCcZoA+Rt7yWnqOULwp
 tE70tt7UwMy5Y3r5c28tlzyzD/jttjZahDESyDetxINNzaAFJEM9kE5p8zhlXsSoM/1b
 cGyUqixmnfQ/O0x2ApGnarDNLMcs36zpxHqcCHGBRvJonatWhwMWk8DwF5gTValigbBz
 4isg==
X-Forwarded-Encrypted: i=1;
 AKwUvByAJ/6NyM1rUshGzzEZrEGDceYyTmDG7Cu617X146wZC6XHaAVAyDYZkTMlzzZWV36No4k=@lists.linux.it
X-Gm-Message-State: AFq9FYIS2NXSYiJ0bxho+NK2FjNtaH/p7kg2Wi3/UcBroAJZGu4hjnHx
 sZSSPWOiT5BHr4kZhivzShy/dD8x1Nph8y4J2GUhavkKVIw8QLSfSHEMEo4FRITVhxE=
X-Gm-Gg: AYBFou0+/wPzxw26o5vubApZWqmEf4ieqxj7DML2RWe7sgTjlK6w3iYTpEKmlEvTNvy
 kgsMxY/9JK8Iuh/Qxv1QJMd+o1i1Se+5MBLuvFe5AES5+IwGqI9NRFRu86puPZlwPv9GByYhfOT
 YIKhZBxtxOFxkB3eiAiIsqUySIw0UIn3+VcpjAsA9pNFR6scAcmhucqX78E2sst+jzkp1EUyBPm
 YaB1iCtLRKtEiGIZrN2+vW7BtuMIa5oga3ymNYJjDknIAicaNCcLN69YSe2HpzNKEWAUSnDhZkn
 kwVphAmpaMVqwtn5fCEyidj1ohVP9DQYYKSfxe1Ukrc6u1dXlvS34bjv8MLzBPtERhOgcLnW8Y1
 j+iNRP440ojqOU+Tj6Ps3tnfX8lLJfcCuWhI3V5C8mOs40hCUxTBnl3a0YS936txOfoeKJOhd/b
 RmH2DtFEzs5/wyLXDqexXtdRso+kqNfUqYw7wbnXvGUkoz2W4nUTVIo6DMcAVe68ez4MJVwHYW7
 RzSfJgPFOMcrzh0c5yZSEQTzYzajfpUL5q8hzJhtJ+nTceSAW7TAsHVAyBXC77y0cXsixiWzNTm
 Eg==
X-Received: by 2002:a05:6000:2dc6:b0:487:40d:af33 with SMTP id
 ffacd0b85a97d-48b024d9344mr3054512f8f.13.1790775975679; 
 Wed, 30 Sep 2026 06:46:15 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02949a5esm4661931f8f.4.2026.09.30.06.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:46:15 -0700 (PDT)
Message-ID: <6abd12a7.622c318d.58981.614b@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <be8d0bc2-ff14-48dd-822b-427e818f509e@suse.cz>
Date: Wed, 30 Sep 2026 13:46:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Handle empty saved configuration values
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> I've tested this patch (fix for fw_load02) and also the epoll_ctl06 fix 
> on kernel v4.4, both tests now work correctly.

@Cyril, should I merge it or you do it before the release?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

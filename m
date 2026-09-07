Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4FDC79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 06:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788762568; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KDvJ7djAWnCkt4GCEg67wmPyTUeRjl2UYNHniIT/HxA=;
 b=b8TiSxnSmxWhUVoMnTIqrAcJKtbqsMm6qxFhJgnqygoL/68cQMQBUbEUIPgDkP5zs6GK/
 HxmSDOaW6N4yJhV1HBVCzMpKNiO+kMiQDjvNlexQk4EKimTeX2MvBf8+uokvjSjoHAsuU8D
 fnT22cZaBJasXf5n0Obf3k4F1muXLSo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB0EC3E54F3
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:29:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5FCB3E1EA9
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:29:05 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 999856001EE
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:28:59 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so3496650f8f.1
 for <ltp@lists.linux.it>; Sun, 06 Sep 2026 23:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788762539; x=1789367339; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MsW5sj7g380OnjP2ZvrYViesCHVeid1jRQAh57jnkrk=;
 b=RMFCHIBnrLHC+Ki/b4rRTP910MXwv0aGffNlB1gum2ODp25ER+38reDcUqabg1AXLI
 /8hTGECpsPrOrg8oW5OQSzxpNL+5rqHtTRAiBfHd5j3a8SryhxY7xCSz2DqwoXfYKL/V
 2F/hg9FbIxMX5AvXSwJbwW/5X+mr7HcjOCpEZXi88m4PUTZPrWh7kCRq0I9KxqpkMGZC
 kSGxDfw8wTJ2xIJ1dcRjeaOgB2ZJuzK6aWAu+2W6v4K7YqvKdw0LbPk2yhz2OUJHoicl
 SdnqmDgbOzaFjsROTt/D4qpJdeaYobENbzbS7bc+x22klDplZIoR32o8R/9KYWfDknlK
 7UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788762539; x=1789367339;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MsW5sj7g380OnjP2ZvrYViesCHVeid1jRQAh57jnkrk=;
 b=Nsdc7BlRID3r7a6N6hpLWKAaBm7B4jC0J3TI1Ngz1T5EYHfa0swI0rsK7QVe2DIkP0
 79/mx1ZiOVbtwVnYhf+59fXvjRUGwtvHOhTBWDFzu+/P4E1i88TSj9GcuOFNYLQI12Ah
 ZoMX2+fDym8RDhAVb3771SiLlM5J/iaCQXrPorhJyFMQFP0XfkUdHyUNCAZjn+4Vpyt5
 UaQZFys7FjJDMklJ1nLl8rI6XM01slKM1u+zaVHxQGBv3Qsb+fE/2bOP3HwJAjMwUSEO
 20OE4lM7cNrf+gbvJ/GtL+YxxccmpIwNjslPjfQvCx8s6JixpKPlELAfp+Sli5MUOsWA
 YASw==
X-Gm-Message-State: AFuF++kyJhmHMQRYc/LRSreLZ0frHFkhHonePXWITjWsCaOnbhOz7dAh
 dWGtyq4cEvE8OwmlSG7Hb5EhcOQMWyQxigqPoWTujGmCrlSZf0MV2JH7xXvMtucfDj0=
X-Gm-Gg: AYBFou1DUgsKQYSKaSGrXxz6eO2l6JsonevHpn7J2vP/8sI3N9Mmz6UaE59sQ42uQfe
 6D0lM7TtO721mYrQTLRXJifSXTK18vpw7pjrDL+xLfbAgvw4ormvwIZT4YSYnvvm/w5x23uXPLf
 e8d3W3tB77CDJxW0+2h3JFACbXy/3TuPo4np2UGet05cvEP0undXCKN0GSU67z206EZsYjs7no4
 oW9EwYgoZ9NOtqMhhTBsZ1u7BdrVuv9VdRLOWtCrN5Q1sKsYBBuuFL7z6n3dpe+Sz1cUvbz366f
 an3qGOF23dVcvxvlWeK2ldDZVtJK3T0sT16mSL1n2lJhptfS2qTXvz6+i/x+VZMpTGqNcaNzl0O
 07yLxRG7he2YWfgDnNlqpqC5M25jiDaF9F0aUiSIL3Bxoact42y3DE8W3PDsEbT2T27yaWYWJxp
 G0cnu0zYCiSuf7QmAf9xXaCZ17B+oLUuVtRDKxdRdC/S4eiH9JNnNi6JbAmHxIIsCAjWHu+WXlB
 5IzWFqQq2L7rGfC4HpX+Zt3REFtL5JtNDTQR0xyslmt8S1GfvT+asmAQhReA4h+dl5SnqQ=
X-Received: by 2002:a05:600c:4e4b:b0:49c:f13e:e50 with SMTP id
 5b1f17b1804b1-49cf8925f99mr188761395e9.13.1788762538968; 
 Sun, 06 Sep 2026 23:28:58 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce46696e8sm268939695e9.0.2026.09.06.23.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:28:58 -0700 (PDT)
Message-ID: <6a9e59aa.39f355fa.13d8c8.1eed@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260904124042.212065-1-piotr.kubaj@intel.com>
Date: Mon, 07 Sep 2026 06:28:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] pmc_core: cover the PkgC LTR blocker counters
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

can you please send a patch version that applies?
All CI is failing at the moment:

https://patchwork.kernel.org/project/ltp/patch/20260904124042.212065-2-piotr.kubaj@intel.com/

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

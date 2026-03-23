Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F19CEC01A2
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774255019; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RXo/KiNagD6e8rCUrMjed3jogW43kgVHNUgD34Ug7d4=;
 b=NVNw2okRNsnt3XNxqQbPiplswgzkP+kFnyDzdA0knOLmmrGEX8jMF/J43tKbvjd0PT+9K
 1QliKCTN8nFfI6o7meVOSAV3LAGuqsUt81GF9YjyT1U2//2d4gjWsWGzIlwFpCp+NIpr+ue
 /fZaSBEGAOxboR+ajAmwhrpMBzNI3WQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B8F3E2265
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 09:36:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7DCB3C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 09:36:36 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E717C1A007EA
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 09:36:35 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so21267425e9.0
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774254995; x=1774859795; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PH5mGwxutyD9r4MzD9aPEGMss5dOyngoxHn9b6Dfdgw=;
 b=BT+A/+PCyj8UQqOJGiqXZj4Db6OMAW14XdcXap/wceLFMr3cabSQT2RrGJmEyBSbCv
 qTHdGg5DGfekAHI79zF3gxXy9i+bv5ulVawiJVpSL4FXDYmyCZaQHCIDnFTHKv3UzFXq
 6bPSLGbjgzEFLgH9Emf7ePuPc+W1aZGxX+2Cmvjq0Wyn5OZc8U94aaf/g+qi3XgCaiN9
 zROIh4RjYP734IgZx/dhGMxeLy7MdChrUud5ILy+QPAW0EgnvcX03v4GOJEGNrhTyjx9
 cAah/uayf0hcZoB0q0LnfWcNlFtrIXhwh2EVKNyEoSxRoliMsQOv+9QsJlV+nZFkpLU1
 yk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774254995; x=1774859795;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PH5mGwxutyD9r4MzD9aPEGMss5dOyngoxHn9b6Dfdgw=;
 b=EXdmRYLjDHaX3HMTinNQRMOb+MFapiJAKpZkD8XB6zrKlbR/k2Muap2Xb9yV7FAzgG
 yN/o7iDLiUjAZePumhmdQi9hWCg+TZoW8o0u7HfXpM0+0hgAfIs8S7BeOd41c+BYlN/U
 a8e8t6/dsk8RIL4yttYB/Fi+MvA8iUs8u+CCgZ+hAoR1tQ/+xj4j4MPRE4VIu+6hms7W
 vkBDf4Sr1xV/kvpK4nxI0H1v11L7Ic6E2In4gJAEEMNArZ6VuzUtAzRUIHZT8Gh1ay4w
 1jCwEWbIzxKkMx7qE5DwLEC9zCDCUzHzpiYO8Ja8d9R+bQcsIWVCW9Xit80R9BQGXePA
 xQYg==
X-Gm-Message-State: AOJu0Yzin9LojcB0PrQzUQeBAN+cIdNn55ei9MpobJpgf0tsQy/BHtYA
 Jg1Un1WeenZvDVI/rsE55Ljut20065pvJbcKUTbgnrShGGP8qJmnQCb/oSjtjCbzHHnzaElSD1d
 5RvHgn54=
X-Gm-Gg: ATEYQzyGpFhDpcIpDTJfmiwcC7joSR2QqU+kBPWaf99EGRCu34nzumfgOqbcKaLKjkr
 F5AGszO9+kIYczveyb41hQs7kNcE3uJAUzZL6F2H41NvZpN7Vy0mkx5tVQMUaLWxj754j8YxrK9
 Xgz9uAQRfNN5mgDIL+7qOQUvEHvN0aX/drRKo9e4axpXN3gS+B+/QpCbmJLo1NqmYNsIfJc/HsV
 kwchR/JP4SmmHliwu5tfu0AyQT1XByR9EePZu+kU3JTAqotcwXt1htq9Vz7ZuHp7zoAZTkrGKIP
 EaaX4xohbwzv0B6NzKw25jNKHD0ka4/fDuj81mSabAIbm9hEnZ9mssrJbjSTyG20d1wykLcjDcS
 g1kaIf7k23EACX2wO7Li0YIOm2CwXDfDeFQD3PTr8BAdXWChjjORILDGB4S/GbM4/hrWxluo4Dc
 nGtrce/EpJftRp9eyy1csCpoObcg0sqklJYw8KLrfvgxY=
X-Received: by 2002:a05:600c:5294:b0:486:fe46:b647 with SMTP id
 5b1f17b1804b1-4870334cb27mr102831095e9.10.1774254995240; 
 Mon, 23 Mar 2026 01:36:35 -0700 (PDT)
Received: from localhost.localdomain ([37.160.201.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe889652sm105279535e9.2.2026.03.23.01.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 01:36:34 -0700 (PDT)
Message-ID: <69c0fb92.050a0220.1af5ad.144b@mx.google.com>
To: "Gao Xiang" <gaoxiang@kylinos.cn>
In-Reply-To: <20260323074954.3393-1-gaoxiang@kylinos.cn>
Date: Mon, 23 Mar 2026 08:36:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem/tunable:min_free_kbytes: fix disabled
 check_monitor flag
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

Hi!

This patch is correct. Indeed, `end` is set to 1 only when signal is received,
otherwise we loop into check_monitor(). Interesting enough we did use this test
for a while now. The monitor that was checking for possible failures was never
used.

We can add before merge:

Fixes: f28b29f16ba7

@Li FYI

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

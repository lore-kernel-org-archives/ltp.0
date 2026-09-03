Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7672DC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788442736; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Y5mJyY3+kLBuONpBqrEpTAC+IrOMQyPa0CVjQOyrehY=;
 b=dhsxuNEWSb/16FkNcQsh8Mh0YUiZnJUOqrYd6KwRxbLsPYnxC9T7FHihsH9mRa31GyQoz
 2MqIloJnjntZg4SG5aCGj6VTHDOqEYpBIyBBQuSkiAuwjWfyR6oJdehanitDekFtdWr/JCa
 pF6axU7x3Nv1OqbgfyFDvUU6GWN0g7w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5124B3EADA7
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:38:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7140B3E97FE
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:38:37 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F27C7200B00
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:38:36 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a600a1caf8so666232a12.2
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788442716; x=1789047516; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wMpeD5ydu+/9KxBl/FkjPH2z+tqV097QBQ+dK3mCgM4=;
 b=gcqdy7HV8M45uNG9eemIecg638zsWyMumUJkXAJ0Q4fNi5cC2adyepScjlSKplUh1p
 FcKNSWJN8cnbea0f716sqLlf4kNhrx/rriu0PK9O6eWC1KhdedJIGiueyJSmBRl2ARNu
 ywYpm+YGKu4O+FkyZwhVo4h0TOFDS3pPCETX/tkuvxnWoQP8gkXIErpy47yIiXL9ozrh
 WTGvB/NC7cIzM5Hif6ch8mW2oUnk6r+YjxyriD1rzmvwSLDU+mPenFoRwg7lOM4Kp7Hx
 af02I5lhV2E8VVnlGksLv8cGfYuG/9ioTG/TkXbKRKlv7ja+3sl2O+xVwg4pwdwSmOy+
 8kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442716; x=1789047516;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wMpeD5ydu+/9KxBl/FkjPH2z+tqV097QBQ+dK3mCgM4=;
 b=YlxVn0ZqmIaTgd1oLfYIpqsn5+ACOk0z9F34j730c+ZNdyIFC3jsGuFa0w+v8yHWNe
 cTzoCHtL/xNiSqcqscqgTkmubel7pX2uifr4Nso/SLY+7jlwftLDzaGZ4REwlam/lvMw
 xYL46rMY7/rSPVGVqXLCcdeHdNJPtVdI5QTkNUYCz3AwZbvbBVp1oKl10gKRqM74U5ez
 u40hB2AZA0gom7IZSwqLintMeX+2B2uKS/qwgy6tzhh5RyLcDwaUDeoWAXdAQETUpQcC
 WIxf3aZJ4ile2q+jsHvyb6+lrvIw25lm4xtxHdRbxkyrUe/+vd7pOhT1ICaP2gX2tiVs
 LgLw==
X-Gm-Message-State: AFuF++nKFA1XXsTSeMnKp6r3jdx7hrAyZCiotKMjrgeQBmmC6WjDhI4D
 J7H0IMNfRxbC9oKZkgjDWSIt0DK9ng76nqOdmhL2txx4fuX+SZVXb7e6Dfnez84IRxKx7aysfYO
 eDpCrjJv4gA==
X-Gm-Gg: AYBFou1ykUh96Ri30wG5vYwk5sZBrw0eO1V5VI/SYyknYiPdZ+ewhZZWoGNwrflqviE
 Bp4hj4GtzwoewTVnp9Ijn3RhlIUJZIH1+YwJ6asHBKsQ2mjY4BOKYZjttFqTuWip5YbybGNw04k
 TbCOAOPiN8TlTbByKum247zKHuScWALlkOo2laU0wSMFKLduupE/AP25mWIt448NkE0aDWS/uER
 qIOqxmh3+drziV5HOJnZF5oA0bH4gkIVoHTwBJVwURd7G346/j+5OmRWfGfX2oO/RqklpR38tjh
 v7trft5IljbD4y8sTyB1y+lPMwBpUlkxDmxhAwYQRmv/zeMgCEiBXJt9GyTlAjIxsxaMm57oFf0
 KAFYrGxp1FuPopJ6WWbP4MaNfw0FNj/+Jap+VorEyiQ6oFCQcDXJKdcvhtViNV43QsUuUIaDscs
 PRptbg3lUR+r1Iu+T+8P0arvFax1Q4pC0GffVOXKw3EogZNmARcyckEkD0xqjiIFbRrdrb3H+d4
 koIM2EyC1aN
X-Received: by 2002:a05:6000:4b0f:b0:482:e10e:58df with SMTP id
 ffacd0b85a97d-485860aa7f5mr556366f8f.21.1788442682212; 
 Thu, 03 Sep 2026 06:38:02 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492ce236sm16312633f8f.35.2026.09.03.06.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:38:01 -0700 (PDT)
Message-ID: <6a997839.5fb1dcdd.2df79.d96a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260903124631.1100746-1-pvorel@suse.cz>
Date: Thu, 03 Sep 2026 13:38:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/4] testscripts: Remove outdated scripts
 (ltp-pan)
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
Cc: Steffen Jaeckel <sjaeckel@suse.de>, Tim Bird <tim.bird@sony.com>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For the series:

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

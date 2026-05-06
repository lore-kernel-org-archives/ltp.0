Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC12CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778088524; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=39GhTE3yyeGLvdPsuhEswQ3I8iaCMekCNppIjakA8+c=;
 b=CArhcXoRnBrQ8Cve60ndWHGUN7U9mNLQC/INRtN6HTx4FA9CJg7M9tsuSwlrAb2n/ha7X
 t7zWY5xw5rPXSDsj9Y6RdkgueEsrsfw5G8GC+Ta95dYdUl2XEnK1ZpZ5DWvsuq6xw1M1RsW
 nPFesHvDetkFiZY6HzRM50Q2XgawfuU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3D123E6A98
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 19:28:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 874A63E28A2
 for <ltp@lists.linux.it>; Wed,  6 May 2026 19:28:20 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E29541A0065D
 for <ltp@lists.linux.it>; Wed,  6 May 2026 19:28:19 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so2391929f8f.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778088499; x=1778693299; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4xkyReETN0gk0y2MIGoUlKF0xAR9zfEwW6ylyQ9Aq5A=;
 b=R+dWBPMr1lFy++upjWnAQzc9tkC/Txl9CTFo2JkjwfmyBjo09RptcfJXhRUtXyWklt
 bAOwBJ7Bbay9cPVNJEzw2Nw49oGkKB2N+tWGhIJeF8gL5VSmIaFv1qiaFnKBQYB4ilkv
 d6jq6lg11RNragOzbwrziBjpLKlPuxQ/Y44AFvDOHjyZIEmlnb7B4XaAeXDDJ8WiVzNr
 WU2OZsCJ1anFwxGNBgTkYztOhivsSfMtMK0TiDQ+J3njgZ5k0DQ9/fDVfsdeTSeja7zD
 vgeJ/QQjex3XyMdDFGl1GCvMxOBGl8VS/7kT7yn8JOrvf5dNW4s2f30ph624VRn4PWcY
 GaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778088499; x=1778693299;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xkyReETN0gk0y2MIGoUlKF0xAR9zfEwW6ylyQ9Aq5A=;
 b=c+h1kKaHC0BsvUiFN/fnitLUzhYXx8bLTjhNBG45dRHzqJjJTowwW029WHv0cBTQVe
 5Khoi6Q53C/1NrXAjweuxy3w30mz9bkYHa99YbtBlWzWRx+hH6Yg+D5F+oZIVu5EYf6q
 yHgAxz3o3H9sCF5/tJ1FFW7J4y2eGImJ+5zhVYBNOihPeGmN3mjMhLglpafWXTwaALym
 jqqGRYodnN2ydlH4NaiyH8JEuP9ho8o1dfKg1EHTCDMEAfWvGRKQFGuscIUgOKI9sM3l
 DzCz1+DQ17+bohwEwTwy8u246hj1UadWpX4V1aHBGL9bIjbTPXmUSds7sNNQPhRRK9F1
 ebfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QiejANxPDune1Uaa6WvtoGAC+Cw9HZuQE74J1HJYuTa14WWM9IEdT8LN0JtuxgsosLDk=@lists.linux.it
X-Gm-Message-State: AOJu0Yw5MIKNqDqTTipt3jSDWc4VKO+Zfwls05JkawLJQSQgvfyKjvaF
 1LNl5X/kBUD8GDnb8IA53o42ZAmXpin7TKeudKTWXHEtHnqpYYzTGTHQ0ysylarT25cRyxl1feB
 UHeBIsYRqbw==
X-Gm-Gg: AeBDietWCZBC962JsmOWoV+WJRi0OPz5BV9d/DLv4sBn/toUXow5oK+XrOZQPFLygHx
 RFZcWLO2RLTnsL/veHqwGZYjhcG1a/NlC2IKahbv5oHSTN4HyTP6H7+pCJPnUN9JAps1oeIH7Kf
 ehAxIWmFgRy93drjlLdynMEghbe5Hw+StsDtIEqBxdGGw9MDr3qA6m3fz6JYntXCqzwUjqW6CMn
 aaHUpMlLqCgSsOnPVUu5HW2B9XLpvI/NW6BF00mX54yZfh8KbOjgchhbWit0YEFHrUYZpRtLCoR
 ZXO4ln2/KGPpwGX67pxp7htrzuwH5XMYE87qPpBOgk6r5rEylXZoyAXkhfFzZZPigkGN2GgyVhM
 4waDKr6QG2hFFEA93+rgU6refp94DZQBCTJZGHAlLnVIOjDvEGZHXgGwFO2K5dAbC3H4S606INe
 YDVJNVhIlFSfIAtelqlL7cGtnhd4OrcCC422/c3ZzADIizCRlu7BODQ+rgHiHTqr05AZtyrUOAh
 eADYsyUnCjF3v38wT3W9fSSJ+k3ZbPXdXNnXJF43ZJQKw==
X-Received: by 2002:a5d:649a:0:b0:452:c9f:4b91 with SMTP id
 ffacd0b85a97d-4520c9f4c3bmr3394943f8f.4.1778088499126; 
 Wed, 06 May 2026 10:28:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055d381c8sm13220231f8f.33.2026.05.06.10.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:28:18 -0700 (PDT)
Message-ID: <69fb7a32.df0a0220.1aa799.d780@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260430063500.4035-1-linuxtestproject.agent@gmail.com>
Date: Wed, 06 May 2026 17:28:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

Hi Wei,

the agent review seems to be valid. The shmmax is defined as
unsigned long and we should keep the unsigned state of the
variable.

Please verify that it works and we can proceed with the patch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

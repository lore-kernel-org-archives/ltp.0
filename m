Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A5DEA3C59
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775739121; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=TWPgOYbKJGFjlhlmz2eS0IMHNF4KM0CqCFwy+uy6VOQ=;
 b=KL0KjuXC8pgmttkaBcWZkGonG8XYPe83g4DbGBrws8s9oa8FRGdKp/+qxYn9RsleijJc8
 e2oHK65RTHX/c17yOdEYs1flrnW3/uUAL8hx7Klz2EuS+ep0F3wy3mEYqoKkJOOAMpbX3Bw
 +KyxslQOwIs4NRIM0+1msgHTuYarfZI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6902C3E4D0A
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 14:52:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE4033E4CF7
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 14:51:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F038F1001849
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 14:51:35 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so12378145e9.2
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775739095; x=1776343895; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PidaSUKVrLyuR1Ad4jf1LkN12v93j2a5bs2h+Lqi+TY=;
 b=chReS/MAG7cdUcVWomQZiV0MJwK1TtkSz/TfxMiWmEwVd4LwA8o86y9ToZQeHcAW+b
 0pJuM1JBLbBxiQcLv0iUwp1ozpRa2J9dXbOfxNwU/u4aN7vCfm6OBywqP1HVr76okuO2
 3N29L8RGmXhHHTYTYT0it1pAjKHgbdrWK69eRvKGbXVPr5wyqILCEfqcnpQwDKrIJdwL
 /urdil4RxNmCa7JbUFLwkipPQR8q9IDN8SF3vhGxvQiNR9t6wfnrU6h1ib6IuPOV4SzU
 Pe/JhjLcAfCirYG3YsKbyh/K2s3D326kxkgU6qNdr/aMWn8u27yNkuQ2niDXJNBm69P2
 PKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775739095; x=1776343895;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PidaSUKVrLyuR1Ad4jf1LkN12v93j2a5bs2h+Lqi+TY=;
 b=e/vNmz9lDC575wo7GneM/TMdmN22wFrFSjBF05WsE2ivpUqzf0gy31AE/N8mnA6UGY
 HPg/38K1+d4qh8jFy0HQEa6dDsoBPYDIgg/aHsgkb7hA1jWvNvvwF9FNDaKyBz/KLh4R
 M6KsDinhZMgZf+u7UNk6+b68DcD0ewPbcfoPY4G7bQ7AUB1FSiXntgKdW7TKacwQqWda
 tPPO08tdF3eZQAQv9i+MdXoaQJ99jenxbsFxXHy8BVTaqmSSlODxIQ26J2TT1kYhfmen
 GvXzVwnJaAsudcQ1Yt6p+j203RE5Y7WKS9o44qlObxok03nAwDCtrjFr90xKrGUY0qtG
 O+Cw==
X-Gm-Message-State: AOJu0Yy2czMJwo9X/1pm0VPVPRwoelCJRmUkvOs+6e2QFX6XAV4cS7cj
 9brus0UElaeYhqubNA6F5EGG3+bND/Z09rpnoCzc45KgPGY7m8VI1bHfEb0Z9pAw8fzw10Qq4Op
 VyyiGGS27xw==
X-Gm-Gg: AeBDietKrk9b4DZKDurBZyMlBP3gxrZJXppQ9EiTbzYlHe8PvZ3Ttrp9OIo57i+tc6H
 OpCmihLDTTYZa+JH421/5F+47ZmEuKBP3iCLqAbPCk6v2NPeqXKHhfHRq5iHKpeenHuMTwdLFTN
 a9NHBmT8XPuY9UZXicX7b4VIRlbpKjC5k6XaYo9Mpk6+6FvoFRVChWghTmSWAWORLImhYClNOXV
 5eGGnQO5eUW9gT6c0fYMdgRJd5d6nugmMPa5fGRtMijOlNE+zMbPhnrbgD4DSMsLGf/0+UMmMok
 1j2ygabF/fVOjkLl/Q1qlM8fr8IcC+QYtczbcoSYTEUXMUwvoFOeVlkoY9wyEeyzHixLSRtiaIr
 S4YUcAGtfzlE9M5WwVwUs6xwWnh+sKdKZLUmcT6MuD9Fxrp3GOSdP+YtibkuviTJkRioNnEemv/
 WgkMSf0ZQE9y15jYZGxwyzTKOWE5+b3GWqh1JLTbJ3FJoJpODDiX7f7FnPdt/wMv+2PeswJVJYE
 /asqZJYTrLZcTC326syoowGUQqI4H79gAtszF82nWhBPXPfcT/rHej2D9d/nrtgHbEwE6SCXVQ=
X-Received: by 2002:a05:600d:8448:b0:488:ae6c:42c0 with SMTP id
 5b1f17b1804b1-488ae6c4432mr205917055e9.7.1775739095294; 
 Thu, 09 Apr 2026 05:51:35 -0700 (PDT)
Received: from p200300ff0f085301c60b3f6236adb066.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d58e5sm67267661f8f.23.2026.04.09.05.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 05:51:34 -0700 (PDT)
Message-ID: <69d7a0d6.050a0220.33d791.c2df@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260402121356.31266-2-chrubis@suse.cz>
Date: Thu, 09 Apr 2026 12:51:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/17] syscalls: ioctl08: Remove .needs_drivers
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

LGTM
Feel free to add to all patches:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

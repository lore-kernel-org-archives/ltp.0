Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5121C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789108940; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=SDBHgS9cfe7QC3b3qPP8gFnl7JghWnZxx58E1GX7qwo=;
 b=meUuIT39WvGW0SwRrbegPYv4SIsPc2P09VFc2VSVw747czrFltQ4u1rhQ7YQGFjm4V/fJ
 k5Pwz9CgQ92GDggwgowXkAgQ33oqPoL49j+bKwFojJAKjViJFdWj/FIuFQ/fTSpMhJvNKMP
 YJeR0zMvtKvLIcbtZcixc/+ICpVbyJs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86E533E2E82
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:42:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FECD3C99FC
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:41:57 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 426CD2003B3
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:41:57 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351832so212631f8f.3
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 23:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789108917; x=1789713717; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fo02XRQ6C+KBFhvDN7hAjp4Fmh4OgY0zdUpDzLJXY9A=;
 b=gC5cL/MQPOMq5XgBXD2lF+Mfdzn5xDjmdVZBv2uOKhKHfFH920uU1po1FFa5HWHJhu
 0/ieIk8s85rMlsAUenk0LNV0HIzKeQ1LWWWYQ47e62ZcEuasWzET+1RPf/kCUibpTlWV
 BDBsE/RJenp5PHrxkmrp6eRYZUHOrqwEJjfivvJCvRRSTzqE77LHVG4R3+VouTfeei3A
 DtfXIuiJh/FuQyY9zvom+7Fu3y8oU7skkPQPQ0yKhE0shc/QLdMRGVMbEIDqehkT2veb
 hUP2IcBjPb+Pj4vpFJR0y1CybxVrxqZ+53fsof+LLk4640oxfqfuQpW6ZMnV85jzWPmz
 4iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789108917; x=1789713717;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fo02XRQ6C+KBFhvDN7hAjp4Fmh4OgY0zdUpDzLJXY9A=;
 b=gDOuS5TSIr+aHk1kwKviVf6kYcFteY0NTfeaieuXY4cQVu0v5z5WnbNLmyJvUG8slB
 2cqy7zZCmoYObC9Hf3UAvPwnvSA+uqX9mMzsbpkJefHAFC0yOL3JR5ub880QgL7Vv5w8
 NwRwv2FontXaVZMMdvPReaqv9D6zHmvXiHllIODiURWJLoncr+UuAJMZHGhVL7SjYqSm
 kUa2+8iORABEisNv0USt/rmvy8MRtx+oPl9fEPjaD41mjldz8bG/S2bNn6cxnFhrscAe
 VhFiSrt01C7GmW3765M4MP6GtFHDT0NvhUTUjvQtKRlmFsVyblHjaNeuibCM/rTny2U0
 H4aQ==
X-Gm-Message-State: AFuF++lww2oeYSxsVNcWuy1TYxHMcNFjtvzKZG9VSmaTLGrq55Qqivql
 zz08QdX4y2yw9kTXdFbBM05P48l0P3R2Ch8Ct3DCSsji8WLQqD6F/lARJtm/iYvQlaw=
X-Gm-Gg: AYBFou2EPpD7vHkIb5GkkKr7XuC4re0qBCCxritHXzxFZfLljk3vcQPTE5CnMSQjDo8
 VA/1R8gJlemIwRFwSRxoHoGnynVexrFk9876ayj30HhyOCH7V+uqYkqDj6Lxy3efZoC/ZfuPzb2
 1SHcSPXFABvN3naomfmPvi3zsRzeNluCPMP5epN3g48i0/INR8PDua7ExrbO8JtB9LyFhu5Conr
 5PIDtOavyM02ZVoU9bav798wQ6uDgNSLC7IizR49H7fvI6r8+oj7smF6+y/RogKui9pYrSbGOg9
 BWZV6mZSzbfat6uZGEDwyKnKYr1Q6fI0K4VQzEqOdj6ySsDcrWvUa3WP+wcF//l2K8t4uVix/bq
 msrQYvbcsDBxL7eEtjRxFTjZTWnw/NuaSzmmwioJkvU0vZJtfmOIW/0KkzcGC7pBkD0hRSgQf5K
 964ZWIgs20FlIKOP5Bhtjx2CUqlQjQ9qtMtMZ1Ir4unUgwKvseRC0sAuVWTFJvTk0L+S/O1BvPi
 cARTDpjcKyXXYmTZ+LJTa8rF1FOC+SXdj8Zwr901pqGDGTTMVXrOGfcJpdJPzI6Zd14kBNlaKtO
 4jOZwQ==
X-Received: by 2002:a05:6000:2f84:b0:482:f724:f4ba with SMTP id
 ffacd0b85a97d-486eb2e94dfmr2954693f8f.19.1789108916561; 
 Thu, 10 Sep 2026 23:41:56 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb3602eesm3431614f8f.34.2026.09.10.23.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 23:41:56 -0700 (PDT)
Message-ID: <6aa3a2b4.be490abf.30a09d.d9f7@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
Date: Fri, 11 Sep 2026 06:41:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Check minimal supported kernel version
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

Hi,

> +
> +	if (tst_kvercmp(v1, v2, v3) < 0)
> +		tst_brk(TWARN, "Kernel is older than minimal supported %s", TST_MIN_KVER);
> +}

@Cyril @Petr I'm wondering if this should be tst_res(TWARN, ..) instead.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

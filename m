Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FC1CD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780998296; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MjaW1WLLcb9oe7zo8Isz5AEiVSoZ0IIAuzL9RhotcKI=;
 b=AsUK++CW+sc6In7BlnQZiWbPw5qZ93ykO9VdzNboG2egbhzW2+eLn9k+cseKtWc2wFG65
 X0A2tUQYGH8JQhyFudMqT7zxZ1QPsFSzuP/7SkunyClKy4rKztmDYHi3JqYsZwPDkOHcD0k
 DuaygP7ddn1tauoDtxCNOhhnSvf7vIc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3236C3E2B3A
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 11:44:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C0653C61C4
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 11:44:29 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 153F7600755
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 11:44:29 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-460166910e6so2708904f8f.2
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780998268; x=1781603068; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=R/v1vgXwOh1sspwMNxN+EdY9mF8Zos9kANIHjxBzjK8=;
 b=hCLucDvEhud7zyvavbCSHRxrGZPyReA+n7NSBXxWkmkmkd1475yec4UyAGaa6HOC3d
 07EFQ0sYlZe1qKGYfj+7fJuv2qJmyK6xVGbzGOfO8/Bu0fOQt2JwVI2972JuGtN9ehzs
 cn5ZOXNNCBHe6h6TKpkkguRrieIH/8ZLNc24ZCnB7xklHLM2SKg/d5PUnbzaSS0m1Qjw
 WBr1qkXBEK80xVDy3ZMEkgcvME5kaaZZd+b4CPcrjN5lgc0DqXgo1viifLnHL7U2ODN2
 lUn6fu8XCkkklwCwBaBPIFnWzzIONCdMSNQECipMzQUtY9235PIGmlrJ99SfLNwlzFdW
 YJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998268; x=1781603068;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/v1vgXwOh1sspwMNxN+EdY9mF8Zos9kANIHjxBzjK8=;
 b=fLqldMQkwbhDqbOJUcBKoin+YH5GNJkZI9axV949y6vb0LQNYRQ4n2lPHadmA+Kw53
 q3g9Y20B9zVZhYbSEahVrq7Ta+zKL+GHoM5zP1BR4QZjJaZS58CKHxh3V0pGDkwaBlxg
 Ac9obORZUEA8G3h/1R6q2hIkWFjGKPYvZK+PRvDXXQALBHzt6dwemYeRac8EfjhIzYSe
 XibpfWWUGk3XNbMSqT+X96wXGL4tCUwejBo240vlqbxLJi4xK2HjClHkqCzAJc+/0JCD
 SFG/EbEpGsSQBZPvgYAT7VVE2hOycEZcI0QOhJUsmUQVKyDsqj+gC9gcIJPHOE6Dclzy
 vGQw==
X-Gm-Message-State: AOJu0YzVCO+L+AdIKVWSvv9GkbZxwUepr0xGd59KV7tNb/GJdt95Yqqo
 6X03YjauO6AcHDhfkCp+9F69qZcggl/83F/BLaVVLEmbQFAYokzP7jOR20Xtl0rYY58=
X-Gm-Gg: Acq92OG4Yhjbqa7ZfI4dNeOJHBhZJJ6bNGW8+gUO9i+iDO8GS9NfPB/yr3ZqmRFkSYk
 Qi5HPUEPSFLkWzT+HQ1vPApHqJ7L4mG7FuGDJwI6F7orU6ANnk7OJNFr6u648EcYZqGL16YXq79
 Zt+u12cA2YM1YpIc0BT1Tf4wbN2lXAZ91ZCimsRCNP6K29ZNgPEVxPr4Db2uapb0zk+e4GqRX7y
 sGczoaEgPpeX1AO0+ki/zJShXvDVzavCutgvbGKikLlidMMYSj99vRo5fhs89VshHwqO+i6xzVh
 Umh2BaXhHjehm4A2+37/o08QfLHDfXYz/K0YFq66N7zeqhSaesyZqBt5PdV7Ci3T2BzGusotwUJ
 H50wTMoakMrfbydQQogrbcGNTYmeTRbnfZT71iIup1m2xVxcD2usbJJMcys05IZp+esfMcv4HAN
 WLXvqd+uyWCNK4mWFA0YqzbqiRZnpTDQYXYDsTidJ5asTXf3fMnD4iypVZn2oEzjWuw7G5WxlaX
 t8s6vhziHlxAlWCaAWrRIGq8UD7XvQ8j9oGruur3yUFkA==
X-Received: by 2002:adf:e848:0:b0:460:cfc:eb24 with SMTP id
 ffacd0b85a97d-460304fec2bmr24827241f8f.22.1780998268422; 
 Tue, 09 Jun 2026 02:44:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm109228155f8f.29.2026.06.09.02.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:44:28 -0700 (PDT)
Message-ID: <6a27e07c.159d33f9.2309c6.d93e@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260430051915.2178-1-wegao@suse.com>
Date: Tue, 09 Jun 2026 09:44:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] fsconfig04: Check FSCONFIG_SET_PATH
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

> The fsconfig01.c does not test if FSCONFIG_SET_PATH have any effect,
> most of the calls there just set dummy "sync" parameter. This test
> case aims to verify if the FSCONFIG_SET_PATH operation can be used
> to dynamically change the external journal device of ext3 or ext4
> filesystem.
> 
> Fixes: https://github.com/linux-test-project/ltp/issues/1169

This should be Closes:

> +
> +/*\
> + * This test aims to validate the functionality of fsconfig(FSCONFIG_SET_PATH) in

We need man syntax here, so we can have manual link in the test catalog.
:manpage:`fsconfig(2)`

> +static void setup(void)
> +{

We neeed fsopen_supported_by_kernel() here.

> +	strcpy(dev0, tst_device->dev);
> +

I think we are mixing too many things here. tst_brk() should be used
with TBROK and TFAIL should be followed by a return. Use TFAIL for the
tested feature and TBROK for everything else.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F63CD98D2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781170625; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Eb/2cf7k5wsaJd9w5PeF/3Km9KBcqkSxD/Ip4WTJU9Y=;
 b=T3fo8WRVPJN5yAM7FXrTdNRUQ42jsc9Eybm5eGJ2CnArmzD6t1lKbAf9QwTqBZHWcGF8o
 UoifD2wOG3tU8+QHirrqcg/6taxz+TAipzKYexgwX2WoL9y5RtItBOIVb5Zz3E+cIvCZzYU
 MBiE+V1Tg/6+KF9Wml55iHmkE7e/O7M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A17613E2AC4
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 11:37:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94B373CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:36:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E88D1400508
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:36:42 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so5559333f8f.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781170602; x=1781775402; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+lklYuN7p+S0crlQYGPpX2pSTIJhPoAp6Mki9aJCO1Y=;
 b=SqoxJiUO9wEgi3zbCm32dWvt1THiJmoAHPlkNABGlgXxiue7fCTYUhkzBiuB+1J52D
 80iXNfAiweV4203Tg8AHisCu482Y/8nXBmLWh/fhg2+KAPjZWxHQcFWGKkKgouAOe/8Q
 mgj3Ebewxqqbv5oSN2rXHmpFZgwO+7oljH426diOp0+ZAMM4/mgLNmXKpKdUGyyp9zRt
 lQMeiW+MNUiRgh1AJyMS+jR+PxqJnTiSP2deI5sNI9p4Uo8M65bw3fg0qPeWpC3X/ggC
 8X7D5w/bbV4cYO7UtbA3EpHluTWwMk3EgoAczjCI20fK97CMHiaA4kGcIue8wJWV4arJ
 Zokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781170602; x=1781775402;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lklYuN7p+S0crlQYGPpX2pSTIJhPoAp6Mki9aJCO1Y=;
 b=ndFdDzPpOblnkZgLCfEgHk1mDkGtYIzIr791wy/ckf8YGP/iqtN2pFtd2L6p+03B5s
 TtA8Rc3tKVSs+B8fG/n+aLfm3yoO6A7QNtx7xvFJiSE4Q3kafsyOzXnBJHnW0u6qIuI+
 vve3xLJ2ZJezTQwC3r/sHX4TIkBSY0d7EM7HzHxDjrCQDeoEVK5c8EpynyGJY3y01/2m
 Iu8BGRzytXfn0n9cHeLEEMKM2KkleIQvdm3fC3T0JEnzm1ZiYszD8QIj0F5BSe3kv2P9
 d2Ag8M0nTTOuOESsvyTe/xTRk31BbUBgNxLPPB94MaBpvubcqQSCuaTeGGTK4ltnL+YI
 yCnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9a8/w02HTcls1dTYDEr1C0lHcMalZKPL5h1f4z2lYwlQsEuOvOTr6A1buJ7b/SywWuYSI=@lists.linux.it
X-Gm-Message-State: AOJu0YykFoHXKOeNxLnJAthfMbA3qK+YQPIeypDJmaLeV8STWIXHSeVN
 CaO9KsmQr3bXUt37IFhVdAjW3U4KwK7+JFFnjCg/pPxQvpqtzXzvXHXTYLU2+rvQpK8=
X-Gm-Gg: Acq92OFjwRtVXFPDJRss6T7g1+S4kvf1SUnKBRVsaUwMu3jedOtNT8lyElf01cmdxhQ
 oSkEcsYfYs5Fkysc/DGXsweVdCDWAjNfagU6k5O5OyfHwoVfGPLOAZgVFflOPQcrWJRsGshQphl
 KlRD/BpJLptiozejotjiU818urCbBrlrXZY6mDwIz+beQiFTa5oacTJrO9bIT1qjaMU8WVLHp8y
 ysq53EOH93joPtq3TYHUaZyi5xg4CVztF2zbSTXNYjEDlx+lLRs5vnO8GRKGdBcopDU7h0aS/FH
 eI7PhLtiUwAjZGujDht3af6owLInTvT/eAfjvlxV6oS9tzMkP5WJ//pt+cfiPrjnCFniiB8dODh
 LeU/0i2pmYvdsksy/K9dPwCBlxN2wVoWzaX4d8C2YD8+BeGPGagI3Ey/7cNm6dW4qzJdoohHw3y
 Laup/u6O5zIcw/1ZDaGjR/t7Hq4XwI+iGK9s3uM88BB8tp16JnZuOT2+2qiqcoIpyrQsi4pQNTu
 TuvvLLaoEjTv6IpWjOftVhHmkKiF6KozG1N7a7OxJqNug==
X-Received: by 2002:a05:6000:43c6:20b0:45e:ec47:aa10 with SMTP id
 ffacd0b85a97d-460677cf896mr2260363f8f.32.1781170601648; 
 Thu, 11 Jun 2026 02:36:41 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm138476957f8f.29.2026.06.11.02.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:36:41 -0700 (PDT)
Message-ID: <6a2a81a9.159d33f9.2309c6.33c9@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aip_SuymPZMvUAvo@yuki.lan>
Date: Thu, 11 Jun 2026 09:36:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] firmware/fw_load: add fw_load02 for custom
 firmware path
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

Hi Cyril,

> > +	/*
> > +	 * Point the kernel firmware loader at our writable tmpdir so the
> > +	 * test does not depend on a writable /lib/firmware. The previous
> > +	 * value is restored automatically during cleanup.
> > +	 */
> > +	tst_sys_conf_save(&fw_path);
> 
> I would say that it's cleaner to add the save_restore to the tst_test
> structure without the tmpdir value and use
> SAFE_FILE_PRINTF(FW_PATH, "%s", tmpdir) in the test setup. Since if the
> test crashes the test library will still restore the FW_PATH

The problem here is that we have to use the tmpdir for the custom
folder, because on immutable distribution fw_path will be read-only.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

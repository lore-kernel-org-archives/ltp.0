Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1B7CA0EFF
	for <ltp@archiver.kernel.org>; Wed, 27 Aug 2025 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756299023; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=WHQpuyFHrw9tCyW1p/ljLbZqR/j/GXZuUuIv90P+vUA=;
 b=G4wW2SYYza5vbc0kMwIiEOCT7VuFbuIFA8xWfSG2MKyKiXr/MPwB84xinCEwSQ8BQJvv7
 oxupdgCNrLATyLPyeIhhMXb0vlabMr89SWyibv/pL02Z8vzwSf34Spp5D/dBCFJDYU69K1N
 lS6vNvo9uW2axiiKnxmmNaaHM8NUAuo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D67D03CCF60
	for <ltp@archiver.kernel.org>; Wed, 27 Aug 2025 14:50:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 447CF3CCD4A
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 14:50:02 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFF72140015A
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 14:50:01 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61c68525abbso6319374a12.3
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756299001; x=1756903801; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
 b=XwqzO476jkOE2OW8ZIesOWX/F8bBfDz50FFv9kgeGMpXykwZ2AJ9zfCETuLV4NJ71K
 uo6h16xH3kSQE0id4L9HAZHRp87BuYDxf0GGb0YBTa8T3AtzCN5fkVuk+aWVp/eePOOW
 QPy1X0POJDMP4Shf0YPZtqQMU9ThDWWJHLB1+0F2YWshaZXaxi1NskTlk0nt3oTEu7Pd
 mu9X49TJ/u5Cwu1eNs22wXWs7xAguDl0ZKhDHe2QtwBRzGqodt1Hi7ZABXOq0Hq6tVX9
 hcikvA5rpa2PrIXWI5FflzS1EM6iIy6JLiJWqSZBz86Gj/+7ZY+CVki9WA3wZYUl4WYX
 4DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756299001; x=1756903801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
 b=LqrgIMdoVoW7JmxSVFVDekKsFSkULPM/pK2AhsM+4fClHPt94V78jRjdafvqN/KVCq
 6uZPj15PcGqcdy6HbjR3FrXD2S5a8vS8sp3rfFmqwU2EZD+ga16jVvKTS2n3Rv1OswGo
 RT9uYcWIiqmgoUUCdWiPfeuFkyLN/YEKYGOcXvFPtwrGv5nnfH0Aa5OmWMUa0OPdSiiB
 t654W22CkuXsGlCIHY1efx6seIpyuebfN7e8llCWIoweclBBGYa7xOcBlU/p/PAD6g0W
 P0phU+zkJhpkm8migwHv9dsuL39BKcD6Ew6GM/LjIoTTu/qA2qBSl6soClrDmjW8PdoQ
 Bw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2fmzLljbhSdzCxc802qYexTI43oc09g3MhZyzFXd64pl6CLMZMpLrlAAbLdOEWcFyNJw=@lists.linux.it
X-Gm-Message-State: AOJu0YyEWiLHvXT1ZFx5Hm9pruObJam9rBsCR0LtAt92xNjgaao6hPJ+
 eDOOoGo/4QP++3xr2RgiuFvRPncuQ3y/yTzuytA0Dowja0145TnIeh2baGYL9uZjyMI=
X-Gm-Gg: ASbGncvH6YGtsZ30OjnEpy3mO8mICSfTach5MXHIZdQvJbx5GmIoAEEDD0jTsX5OE7R
 MdnEA+H8VaHqDuktEtOaAwHv96TDP2lErZeEz4RdK712+/HnXcgXb0o/sFJdMGd1MBY2uXgLiTU
 WHpfgUQqoirpgzcCvOUuHHDtU12Z015mlbLEp0LnO2qUWmjA+SzvfTLh12ZFQGTnk+7uYElxe7w
 iFYA35ekTT5N47liB1zW2ypIl5IHKnT5UlP1vv54TgKt3PP2LyjAJrZ1CrbKRBMywvUeFIQVUTV
 MR2XZdEKvv+1fxVOSYM2EkQFhAbWgPl0zCR0l9f9oHFhHxhW/h1WMt/1IWYNejthI9ubJzFmPvk
 +Yvy/vrokmGkjJ1gHwNk6vbOCqhuzg+Nvig==
X-Google-Smtp-Source: AGHT+IH4wvXE4ztWU9murcuVq0fgESYTRWeEozc/9PDzvdeR2uHBi0UV7GPVStIEqzg+8g4KSbUy/w==
X-Received: by 2002:a05:6402:5052:b0:618:2db0:b4e with SMTP id
 4fb4d7f45d1cf-61c1b4a198emr17122848a12.15.1756299001315; 
 Wed, 27 Aug 2025 05:50:01 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.238.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61c312a5821sm8709962a12.13.2025.08.27.05.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 05:50:00 -0700 (PDT)
Message-ID: <eff148b3-276e-420c-8b83-75e2dc6eac50@suse.com>
Date: Wed, 27 Aug 2025 14:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
Content-Language: en-US
In-Reply-To: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Upgrade kirk and ltx
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

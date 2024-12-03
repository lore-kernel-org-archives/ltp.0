Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4C9E64A80
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733226621; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=okQA8RyIZ6GyloQp9SCzykc4ZFk+VlsBqOuyY8ReoKQ=;
 b=ngo4H7irVKhzJRH4P1GsbenDuRAwJYuIyCC4/HqclVGVu5BW0sgmsD7lxcHbiRW7d1bbu
 ZJxunge1HKL1uzCGkcr/5qrRC5LjvNXa+DHAO/6CpQjlij9w4JO/B2xE6I7xNkNtpHQx5sD
 nxoCo5ds9lue23zifAs6zZ96Y/r9CDA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3731F3DDEF0
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 12:50:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7D043DDEBD
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 12:49:59 +0100 (CET)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC3966443B7
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 12:49:58 +0100 (CET)
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f367f97so6472886a12.0
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 03:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733226598; x=1733831398; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZQhe+/TpLAB2CHOQBNTABGyOrOq+g7sYXOeRSOoD6Ik=;
 b=gGoxrKS/z6e62QPR8YHB2w8/zr34FfcOSdkQIjS503jLyldKrHlSWtZfTMaUCrAua4
 LL64yCsVYu5CPCbtv4NTVVL5BXle4MjWqZyEaaN57Vvphy/ilPmHN68fA5e8hV8ONkOJ
 7oaCf8B2MKWK3rlnGL/CvLNSBK8qkhHLXzRp7MwmCtlovi6ZYvlvP9o3RtprJesGjNdh
 AELui4ytbX4Y+DJtFEKVXqeJASJVadD2NK79uqoeQGwzmOAjiReI9Qrdup/eCgTAGmLK
 IdWJ1IGYbaeEma48ItChVK8b83IUJblKmWWhUaCYP54Yc4ijHvD146ocVRcREB/lk3DG
 uHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733226598; x=1733831398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQhe+/TpLAB2CHOQBNTABGyOrOq+g7sYXOeRSOoD6Ik=;
 b=oHrIKXh8G9pNu+PeZ/lMd1VPCofWi7g1uIkyBWSBWxcWTOG9J63pk2whlrVQqovhOo
 yA2OvrHADc+zcawaIXGEoEuUJ7DMjd6T0R9cwHOXqfkfYRmKVZEJLF89cZ1AIPRJaGjR
 Ofpx1WK8s/HHpZa+IL13yqdI3xzimy7PX1SkzfpLBhFlzxUSwNap3Ug+QmA+gDA9VeCi
 Sl/mHrRRpf6hmpT62NEDusx2r40sfjJSmwjINFuNfS6n0xtwEETAYPgqNTW4r5FssRdR
 5800FJh7lrDrR9eD5iyIhwmWT2sf8OX40cx1X58IX6NtuYMx0dOIwDmzRd4n3M9sQCEN
 2njg==
X-Gm-Message-State: AOJu0YzGz/IbwgB1CbNVdWIWZQiAavInJWhHN1+bW8tSBrCA1W9KWuNL
 rFmMbEl5Br8GAKPHYl/4AUKqJVSa9wAkGCDHuwK69T5PZ+zxmsdDvgGYTpi/9Eubfc+meE4xTQJ
 0VHxgjx5U
X-Gm-Gg: ASbGnctxn3mUePTDzVoLRpx/x7MUWL2W8Qqtc12wddmFqjd+0iOzqjFHvtfVWzTUVqK
 NsoUUD681YIHcSr+xt/RlQhLTCltuW9oT/d+zEFxMZoE3QHei1t/hogmYAUTCgDtgIQKEE7pR9A
 RiulSILNkXJa7dyjCaqfgJWZwSdeV0hwsYU86SdsWjIWmFWAyHGjfQzW8MDLeEKWVPGWTPzIUKP
 c6VdAl1a3HIkd8UloIZRH9pdM/Uyf5br/mtznk4rSiiOQiBtt659QpD48nw
X-Google-Smtp-Source: AGHT+IHkFh3MtF5/yy64RBM35oeqVw/toQGgHwePui32ZNNdq8V8Bh6qBGGEWbudGKGAj1rYS2+laQ==
X-Received: by 2002:a05:6402:13d1:b0:5d0:b2c8:8d04 with SMTP id
 4fb4d7f45d1cf-5d10cb5cc5amr1518581a12.18.1733226597989; 
 Tue, 03 Dec 2024 03:49:57 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.63])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e771csm613979166b.127.2024.12.03.03.49.57
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 03:49:57 -0800 (PST)
Message-ID: <571fe72a-d057-4fb4-bc9b-9991b9e2b814@suse.com>
Date: Tue, 3 Dec 2024 12:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
Content-Language: en-US
In-Reply-To: <20241202-input_refactoring-v2-0-369609492896@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/7] Rewrite input testing suite
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

Hi,

merged, thanks for the reviews!

Andrea

On 12/2/24 11:12, Andrea Cervesato wrote:
> Cleanup of the input testing suite, using new LTP API and changing
> the way we are obtaining information from input devices.
> Usage of the tst_uinput.h utilities, rewritten input helper and
> simplified the source code.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v2:
> - use checkpoint in input03
> - move check_ui_get_sysname_ioctl() in tst_uinput.h
> - Link to v1: https://lore.kernel.org/r/20241125-input_refactoring-v1-0-b622b3aa698d@suse.com
>
> ---
> Andrea Cervesato (7):
>        Refactor input01 test
>        Refactor input02 test
>        Refactor input03 test
>        Refactor input04 test
>        Refactor input05 test
>        Refactor input06 test
>        Delete depreacted input test suite helper
>
>   libs/uinput/tst_uinput.c              |  26 ++-
>   testcases/kernel/input/Makefile       |   6 +-
>   testcases/kernel/input/input01.c      | 205 +++++-----------------
>   testcases/kernel/input/input02.c      | 132 ++++++--------
>   testcases/kernel/input/input03.c      | 176 ++++++++-----------
>   testcases/kernel/input/input04.c      | 113 ++++--------
>   testcases/kernel/input/input05.c      | 119 ++++---------
>   testcases/kernel/input/input06.c      | 190 +++++++++------------
>   testcases/kernel/input/input_common.h |  97 +++++++++++
>   testcases/kernel/input/input_helper.c | 313 ----------------------------------
>   testcases/kernel/input/input_helper.h |  36 ----
>   11 files changed, 443 insertions(+), 970 deletions(-)
> ---
> base-commit: ec4161186e51b55d4faaa394dc4607200cb30f68
> change-id: 20241113-input_refactoring-16aea13ed7b8
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

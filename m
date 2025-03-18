Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F226C282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742296805; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=B3lrE+YUvpgj7HatBmY2YGRnTnz/gcPT74PrztFf8n0=;
 b=N8JyxVQsBcFh5Korx/9BojIQTSSV6LL7b0iyaztTajjfjR7HbhrKJJfPwuMXIK259B6N+
 42ak5M99FZiwdkOrJH3ctD79IU2Dje9qVT0CaexoKaywoJwAAbQutBO6quv8IHK3S887csQ
 126b9uOft0jdVs4OhYtCdNkJxNqL55k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4D0B3CABDA
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:20:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF34F3CAB9B
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:19:45 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B17301400BF8
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:19:44 +0100 (CET)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-39133f709f5so3347496f8f.0
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742296784; x=1742901584; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kRJb9BDo08GHY5+9gF/c81Il5lxJEdjc2J5diswlQh8=;
 b=JrmydkqtaOjlq4QAtQpptuPPF6moMyCbRoupfVWt4QjiPxfx0oj78ejKZ50sNxj24P
 aaaozNE4ACskqZjmKkBqsnlHV/b8TLON5CmjUW8MWQQjCSvOJwGEC0Au9LfscUxAsRiD
 8xWdF78iqr8GXFA3+aKmw+AR6/G/K+IG/tCwkHF1tCtMplq4P4cUcLw2sp7yXDSdKVHZ
 6MLZ0R3paDHeqo+a0dD5MrdgB59wYVRn8+vSZvvPyRglODpdkn42NTvUnWkwsfCGSDna
 c7mCiGsZusZOzupaxK7CgmaV80ifpOEqgFgdolzhjnTDxMqz+MqxGuxaDkZKjI2rcaqr
 W4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742296784; x=1742901584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kRJb9BDo08GHY5+9gF/c81Il5lxJEdjc2J5diswlQh8=;
 b=u7L50AOnnLTgLH+d0OoGZ/MMwS3ptJH0elHalULfbMzORt4PD3maWfmcYOTyzoO83M
 9G6cjREhwPpOanUeCCur1OPR4w03cEgjkIKYt+MTwNjKyTKogiqXN42snD84Vdeh4G05
 nNXp3z4peotJ27n2wWAVQx7KR1uF98V7IVGgbKrAWTNhV/PMbt7psmUusrmP5+7ykwJ1
 5pfQd/dgLpAwKrKbf0IcTcxxgFpPmvUtQU8wT0OMmg2kNwxERw8lLls62/o0x4A7KiSg
 5UXz9jzdYewnfPZ+A6bYbOVBVE70y9G4C3HFBv48HtA07ff8d0C6Q3b+cNZqN2ntoy/e
 qFEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMWeac85cxCgDVnNsNyDHdvHMvgJmBTs9wAyRQCRWF8XG4u/epPFGVD8pIrQ3umszoX0M=@lists.linux.it
X-Gm-Message-State: AOJu0YyzmFZMOSImJ8dyNzmslT/Svlmpv2Q3JyBiAs+HR0GuattYR51C
 CgCINzOkb9OOK4sjo39jNTwOzU6Hmoq72nfDQW04t4eXYUt6OhG2Q2M1sO4xPwA=
X-Gm-Gg: ASbGncuWckiIrL8WQKiD7tlahKBsfFIka81hXop3uVwQFESI5yJ8n2urqcmJ/Xb+JvM
 74yyoXZaAIlPNLIPFILVIM4fjDajRYX2fAmpzCzyd2eawJkOpNofFRLhnOPd9+YEEB0foMbSYjW
 OQTu7HqJkkEhi5rsxHAtnzndnMNx+GNNA9rB3EB5b0M9j211WHfxUa9qIkgX2KMlqpXPh9Ne5pp
 Wr4OaXwfhmZ506zcv3QNCKUOS2c8xb+BG8CFVixhMwQ0tJysKBuuV/foolWaWy/pKaNBaCsD3KA
 afWYKZWvL6Bo+mt7MSf092XZoGa60J04eTELM2SnGkL5dILZg1BRng==
X-Google-Smtp-Source: AGHT+IGYUVBmpjlDYkVev3JWfwA/EXrszhjZFM6Wo99/zcVvAMTVK8dH+verMfC6jbQREH3/zmc2aA==
X-Received: by 2002:a5d:47cf:0:b0:391:31c8:ba58 with SMTP id
 ffacd0b85a97d-3971d03ee20mr15400735f8f.10.1742296783847; 
 Tue, 18 Mar 2025 04:19:43 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a5fsm18114459f8f.79.2025.03.18.04.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 04:19:43 -0700 (PDT)
Message-ID: <6c3b13e5-ad48-4c07-b5ea-1028feecf0f7@suse.com>
Date: Tue, 18 Mar 2025 12:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250318-mmap_suite_refactoring-v5-0-1b087988f1c9@suse.com>
Content-Language: en-US
In-Reply-To: <20250318-mmap_suite_refactoring-v5-0-1b087988f1c9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/8] Cleanup the mmap testing suite
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

merged, thanks!

On 3/18/25 12:13, Andrea Cervesato wrote:
> Some of the tests in the mmap testing suites are using old API, having
> documentation which is not linked to the metadata or need to be cleaned
> up a bit. This patch-set is meant to fix these issues. mmap11 is for
> IA64 only and that will require a separate patch and discussion.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v5:
> - mmap10: fix - move tst_res inside inner if
> - mmap21: set memory_data = NULL after SAFE_MUNMAP()
> - Link to v4: https://lore.kernel.org/r/20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com
>
> Changes in v4:
> - mmap03: keep mips only arch and move buffer handling in setup/cleanup
> - mmap10: remove ifdef for MADV_MERGEABLE, since it's available from 2.6
>    get rid of options and use testcases instead
> - mmap12: remove [Description]
> - mmap17: move mmap() in setup
> - mmap19: munmap() if mmap() doesn't fail and simplify description
> - mmap21: create mmap21_01/02, remove child crash check and
>    allocate/deallocate in setup/cleanup
> - Link to v3: https://lore.kernel.org/r/20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com
>
> Changes in v3:
> - mmap01: this and that
> - Link to v2: https://lore.kernel.org/r/20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com
>
> Changes in v2:
> - mmap21: verify SIGSEGV
> - Link to v1: https://lore.kernel.org/r/20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com
>
> ---
> Andrea Cervesato (8):
>        Refactor mmap03 test
>        Refactor mmap10 test
>        Cleanup mmap12 test
>        Cleanup mmap17 test
>        Cleanup mmap18 test
>        Cleanup mmap19 test
>        Cleanup mmap20 test
>        Refactor mmap001 test and move it to mmap21
>
>   runtest/mm                                |  13 +-
>   runtest/syscalls                          |   3 +-
>   testcases/kernel/syscalls/mmap/.gitignore |   2 +-
>   testcases/kernel/syscalls/mmap/mmap001.c  | 183 ---------------------
>   testcases/kernel/syscalls/mmap/mmap03.c   | 265 ++++++++----------------------
>   testcases/kernel/syscalls/mmap/mmap10.c   | 255 ++++++++++------------------
>   testcases/kernel/syscalls/mmap/mmap12.c   |  30 +---
>   testcases/kernel/syscalls/mmap/mmap17.c   |  53 +++---
>   testcases/kernel/syscalls/mmap/mmap18.c   |  90 +++++-----
>   testcases/kernel/syscalls/mmap/mmap19.c   |   2 +-
>   testcases/kernel/syscalls/mmap/mmap20.c   |   3 -
>   testcases/kernel/syscalls/mmap/mmap21.c   | 101 ++++++++++++
>   12 files changed, 335 insertions(+), 665 deletions(-)
> ---
> base-commit: a92aedfabd5826d07809559508c8486c12ff7b96
> change-id: 20250205-mmap_suite_refactoring-322042abb356
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

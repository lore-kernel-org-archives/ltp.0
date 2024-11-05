Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA81D12663
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 08:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730796972; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sZYrGoaO9QdZpiQGJ4UrTVGiyFtNc/dLvkxjY73wErc=;
 b=rcYkNqV2jHLYzSBvWFfNosRwHeh3ToHehaHUb+shdOf1rqutCs5M8EaJK/zEX+gd/TmKa
 194DRPlQjSO1c6z2R0Zpq2FPJRRKX8GrwOTtA8Zkp9JWRg+uu3edppNH9Q1TP+95dFaynRS
 CiXYxGBMjj1iQu2DHdFYbIigBPBwZz0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE2B73D1E82
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 09:56:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCA573D1E0F
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:55:51 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1BA31A0BEBA
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:55:49 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso43733465e9.1
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 00:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730796949; x=1731401749; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOiLS7osUKQSTRs6teEUVkXsco1i1iZrNgU2qo0ugTk=;
 b=SBFzNjrtoixUyEvqEuyJUGtztc65+I30LqexAwZcv3RUDLZCmlv8Eqsgwo1R6pczvk
 knTsYJC3Ze3sVxfsrC5rPmIq0/w/4hSyULW54lFQra24o23b4pFGBOWQl+BeDiLpdngB
 YxR1G1dXrCbPsG3qUEVzHiG9/1g5P2YWHccCfX1ZY9uW5pX80a2IpG+SRKiK6AMRkLLS
 X2w+eAZnJJvNHmj/pgrw/ls5QG+29ssaG0DknszL18+baanamC6CznxVriAlKMX7gDAY
 0fZ2MabY2O+Mw75c6Rpnj2rUNyGHEA+IWLLncLqBsWDmjpP3J7YEuwarxD9j6yNKoD84
 eZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730796949; x=1731401749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOiLS7osUKQSTRs6teEUVkXsco1i1iZrNgU2qo0ugTk=;
 b=oMPXXMhuIPuBzswWaOIAH/cYCZrluyirQTQkprZlZMH9U7FpRy3K7nucG0BnNJfF7S
 BsPfkD55FifacLR7WN/are/Ev8uygHqWpVi46MnNzGw48T9LmJOsb+WQtiCGq0Xaq846
 jw8RpYhQ8AzrXnLj/Gnkz6jbkNL+TVHZw9w8UzGtWIvanyaT/wOtAtWlgdcTHdDqqlnl
 UsU4CR3/AMxbAimLfQgzMLi5pRVTRqKgVaA7jbjRv7haIkp5ZadAEFu1Gv/YU9m34tiW
 8/HQ0n4xqUmqKRKjd1NPlTNbmimvpcuWNFYh48Az6YzBr4a3Ucgc+ILeh1+v4XTKPtMg
 lubw==
X-Gm-Message-State: AOJu0YzjotImtHrqScaxP7A8Lp/E67BL9tR4tFEyrj9yqM4Su6IsuqCb
 Xx+i2UPfimIt0s1tsBePeFf+KIzXYoit0/3W0xa19bikVPo8KCKEN9wtIP0cRwDJOTbw2pZfBHo
 D
X-Google-Smtp-Source: AGHT+IGCNJmXkmOO0rKMEPjkm3xvwQK3XFUJV5lzzX7lsRPxWV0NR8vaLgM6JXHW8Xy+pYJbd7Xh9A==
X-Received: by 2002:a05:600c:3ca1:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-4328327db85mr125553715e9.22.1730796948637; 
 Tue, 05 Nov 2024 00:55:48 -0800 (PST)
Received: from ?IPV6:2a00:20:6006:76f:ba80:af72:413c:f99a?
 ([2a00:20:6006:76f:ba80:af72:413c:f99a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9fb9sm214945765e9.33.2024.11.05.00.55.47
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 00:55:48 -0800 (PST)
Message-ID: <64a21716-965d-490c-9831-b5416b0a08dd@suse.com>
Date: Tue, 5 Nov 2024 09:55:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
Content-Language: en-US
In-Reply-To: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 0/5] Automatically generate syscalls.h
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

Pushed! Thanks

Andrea

On 11/1/24 11:48, Andrea Cervesato wrote:
> The problem we have at the moment is that all syscalls input files must
> be changed by hand each time we need to test a new syscall. The idea is
> to simplify this process, providing a script that is able to read from
> kernel sources and to generate all syscalls files we need.
>
> This patch set adds a new command inside the syscalls folder and
> it refactors the previous regen.sh code.
> The new way we have to generate the syscalls.h file is the following:
>
> 	include/lapi/syscalls/generate_arch.sh 		path/to/kernel/source
> 	include/lapi/syscalls/generate_syscalls.sh 	path/to/syscalls.h
>
> Scripts are independent and they can be run separately.
> generate_syscalls.sh is the equivalent of regen.sh, but its code has
> been cleaned up.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v9:
> - use of printf when printing "\n" string, in order to support both dash
>    and bash. BEWARE: ugliness triggered.
> - rename *.in files with supported-arch.txt file naming convention
> - update *.in files in a separated commit
> - update documentation to be more readable
> - aesthetic code changes
> - Link to v8: https://lore.kernel.org/r/20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com
>
> Changes in v8:
> - use /bin/sh -eu
> - support for dash and removed all bashism madness
> - validation: https://github.com/acerv/ltp/actions/runs/11615377438
> - Link to v7: https://lore.kernel.org/r/20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com
>
> Changes in v7:
> - check for errors in generate_syscalls.sh
> - add documentation
> - validation: https://github.com/acerv/ltp/actions/runs/11611080151
> - Link to v6: https://lore.kernel.org/r/20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com
>
> Changes in v6:
> - aesthetic changes in the syscall generator
> - fix fallback definitions in the syscalls.h file generator
> - Link to v5: https://lore.kernel.org/r/20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com
>
> Changes in v5:
> - license SPDX inside scripts files
> - quote shell variables inside scripts
> - some generic code cleanup
> - Link to v4: https://lore.kernel.org/r/20241009-generate_syscalls-v4-0-5328a785bbad@suse.com
>
> Changes in v4:
> - remove blacklist file
> - update syscalls files
> - Link to v3: https://lore.kernel.org/r/20240930-generate_syscalls-v3-0-e56ede4bc7f5@suse.com
>
> Changes in v3:
> - fix generate_arch.sh to work properly for all architectures
> - rename some arch .in files and handle renaming inside
>    generate_syscalls.sh using the right gcc directives
> - Link to v2: https://lore.kernel.org/r/20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com
>
> Changes in v2:
> - refactor regen.sh
> - split syscalls.h and syscalls .in files creation
> - updated syscalls .in files
> - Link to v1: https://lore.kernel.org/r/20240924-generate_syscalls-v1-0-941507a9cdac@suse.com
>
> ---
> Andrea Cervesato (5):
>        Refactor regen.sh script to generate syscalls
>        Add script to generate arch(s) dependant syscalls
>        Update arch(s) syscalls files
>        Delete obsolete strip_syscall.awk file
>        Add documentation about syscalls.h generator
>
>   configure.ac                                       |   2 +-
>   doc/developers/test_case_tutorial.rst              |  29 +-
>   include/lapi/syscalls/arc.in                       |  41 +-
>   include/lapi/syscalls/arm.in                       | 821 +++++++++++----------
>   include/lapi/syscalls/{loongarch.in => arm64.in}   |  12 +-
>   include/lapi/syscalls/generate_arch.sh             | 213 ++++++
>   include/lapi/syscalls/generate_syscalls.sh         | 109 +++
>   include/lapi/syscalls/hppa.in                      |  54 --
>   include/lapi/syscalls/i386.in                      |  18 +-
>   .../lapi/syscalls/{aarch64.in => loongarch64.in}   |  20 +-
>   include/lapi/syscalls/{mips_n64.in => mips64.in}   |  13 +-
>   .../lapi/syscalls/{mips_n32.in => mips64n32.in}    |  13 +-
>   include/lapi/syscalls/{mips_o32.in => mipso32.in}  |  19 +-
>   include/lapi/syscalls/parisc.in                    | 397 ++++++++++
>   include/lapi/syscalls/powerpc.in                   |  19 +-
>   include/lapi/syscalls/powerpc64.in                 |  47 +-
>   include/lapi/syscalls/regen.sh                     | 129 ----
>   include/lapi/syscalls/s390.in                      |  15 +-
>   include/lapi/syscalls/s390x.in                     |  15 +-
>   include/lapi/syscalls/sh.in                        |  15 +-
>   include/lapi/syscalls/sparc.in                     |  14 +-
>   include/lapi/syscalls/sparc64.in                   |  16 +-
>   include/lapi/syscalls/strip_syscall.awk            |  19 -
>   .../lapi/syscalls/{order => supported-arch.txt}    |  12 +-
>   include/lapi/syscalls/x86_64.in                    |  51 +-
>   25 files changed, 1351 insertions(+), 762 deletions(-)
> ---
> base-commit: 84e77afb3acc4bc69c434c430cc1c1d000427921
> change-id: 20240923-generate_syscalls-780dc2227bdb
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

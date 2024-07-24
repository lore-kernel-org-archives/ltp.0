Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24940C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721849837; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Q88zilhghMdaiUSZIYM8BcuBSJ24iOB9mWRBHsMhRow=;
 b=LAaRFFm//D+7fupjRHr2tF9Y+lStYqOWfy/sAyF8X+GKnT4Pd6owI0pX5KAYYYpydFcLY
 b6SSHFshjLibRCWtjAz+p3S8ydqeK0hGJAalx+LH3lPZMV7wsVfaiq5R7oTvXUa0xe9PPaA
 irnDB0n3lmMkVrcCrPNMOM/V+P61blE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89E993D1C4F
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 21:37:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CDC43D1C30
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 21:36:54 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D557A1A0079C
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 21:36:53 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52efd855adbso82045e87.2
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721849813; x=1722454613; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OQws/QKdH2KabLSTrCyZrgSjwfQrJJS9w+sZB/xHh0c=;
 b=SxvmtaQ2fCPbApwct/QKUDPxcHNkP/MQe1YPBOG5o7Qsiw0WAdK64mPkFqX+WVkBUP
 IV/UIyiQAzwRuuYDsbO4tXGT2qEEXB6CSBf5zVngFuQLhsyH+pJcbjcH+PKDweb4HHWV
 azMBojeccMbP0I7vQdhvVVIlVzaStSHXPY6LgyQfhc2+sUGEglOQ3X8+3v6kNJNJ01Cv
 d8vW7rroXlRyZFIDFij2/4clnDhtSpDoWZjMCfpeYHF1bDTv8rauSEZJkdhSyj3U+EnQ
 gafUAY+GHPb70ImaNFZ6DLRYyfkOXzhuttGnfj9pTkEYIez5ZFJsWTsiwb/8cyxclok4
 Lzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721849813; x=1722454613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OQws/QKdH2KabLSTrCyZrgSjwfQrJJS9w+sZB/xHh0c=;
 b=khmS41yeHwKWom/YqfyP8kRrXxxuxWD1B/X2pGn+hZIgCWBojHgDQ1eXcGf9Kqoa14
 5aMRvBjxHWHghYCzi5dR8TJaAPcICRcu+sdLo0TtoH6t4vcvdDPPJmU9W8+oB0nEaDSI
 f0qBzX1hMWP2lGVHaDHDSMOU+eDEiSqG2LS7hXyuT0EB1lXqorHD31bJzNYNcZghqMpN
 0b7gYDYoqX9MUCXpztwG4Y5R78FggFG6POYkrJjqykt1knf+FzcuCmZEq3d1/k4UszNi
 MFZ6r9WPsn8Lef8WLFGlNZCPt5v++2FPIYF3ul4QaMdelxrN7XDm7eqzmNIYb2zz/BuL
 OVBw==
X-Gm-Message-State: AOJu0Yz7N2EBvt5b5EgWYAJjQPBkq8PVrzyVzrh9nH9M52YX/qnM3nBj
 rX4wmQF9G7fk1ZDuJJrGUOR60gF5dA1FLl+FiW3tQNELUnYCyt2Kbt226YkrbkdyWttCSfSjFy9
 jnz7Lwg==
X-Google-Smtp-Source: AGHT+IEmDNXitGzU70cXwsS4WMKYwEoG0h55KyQqo/qjLAwB6URVuZQdHA4r5KPHeHU9o07h6c/vEA==
X-Received: by 2002:a05:6512:2254:b0:52c:e050:452a with SMTP id
 2adb3069b0e04-52fd3f7e032mr535973e87.37.1721849812169; 
 Wed, 24 Jul 2024 12:36:52 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662?
 ([2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52f02ba063asm1256837e87.226.2024.07.24.12.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 12:36:51 -0700 (PDT)
Message-ID: <3c2626c4-5c26-4112-9c74-4cf9b4ecc3e0@suse.com>
Date: Wed, 24 Jul 2024 21:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-7-33075bbc117f@suse.com> <ZqEg7SD35ejRYCsX@yuki>
Content-Language: en-US
In-Reply-To: <ZqEg7SD35ejRYCsX@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/7] Add ioctl_ficlone04 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/24/24 17:42, Cyril Hrubis wrote:
> Hi!
>> +	switch (fd_src->type) {
>> +	case TST_FD_DEV_ZERO:
>> +	case TST_FD_PROC_MAPS:
>> +	case TST_FD_PIPE_READ:
>> +	case TST_FD_PIPE_WRITE:
>> +	case TST_FD_UNIX_SOCK:
>> +	case TST_FD_INET_SOCK:
>> +	case TST_FD_EPOLL:
>> +	case TST_FD_EVENTFD:
>> +	case TST_FD_SIGNALFD:
>> +	case TST_FD_TIMERFD:
>> +	case TST_FD_PIDFD:
>> +	case TST_FD_FANOTIFY:
>> +	case TST_FD_INOTIFY:
>> +	case TST_FD_USERFAULTFD:
>> +	case TST_FD_PERF_EVENT:
>> +	case TST_FD_IO_URING:
>> +	case TST_FD_BPF_MAP:
>> +	case TST_FD_FSOPEN:
>> +	case TST_FD_FSPICK:
>> +	case TST_FD_OPEN_TREE:
>> +	case TST_FD_MEMFD:
>> +	case TST_FD_MEMFD_SECRET:
>> +		return;
>> +	default:
>> +		break;
>> +	}
> Why do we skip all these cases?
>
I can't understand what's the best way to test all the combinations. As 
you can see there are many flags, which means the amount of permutations 
is big.
Most of those flags are handled (indeed) in the wrong way, since most of 
their permutations return EXDEV. The point is that the syscall has many 
error codes, so it's complex to write a code that covers all possible 
results.

My idea would be to have an array of errors to give to 
TST_EXP_FAIL2_ARR() and to avoid any statement around fd_src/fd_dst, 
because the amount of if/switch-case might explode with the number of 
permutations.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

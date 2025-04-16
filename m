Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757B9C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 07:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744789232; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=b+Xaws0saP4PGkPeouyh+te6udeoMsQ/yFiZgJzZ0kw=;
 b=QGAMxdp1jzrMASJHOhFBUk8JNcxjR9VPf0493bRMZe1BGxIzpWEqQLfbmmICPddLVfZqD
 P6kE4vanlZScIdAq0Zm/Luep0pxFEmETtusfJw3nM4KOQYtz3S+R5h/ZPqmeq89jpZ43yPe
 U7RlhcpjvGk7I2EM7nJloe7Z5Gly5y8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90EE3CB94A
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:40:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 900513C02BF
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:40:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F293C1A005F4
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:40:10 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so59061265e9.0
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744789210; x=1745394010; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ARMt2S/B1dfguZ4jkQgvAIurl0FeBfvnxzsUrcVXsJk=;
 b=FkVQ4xu4d26MjBdmBSxkpzwMgjltHcPIb4IVMAudPP/MuX+gPedSLabq57HiaxiXRm
 366EApDUwPfZM7pXWp/iehupGCLOA1J15xADPefx41Y+5QUDS5CT02md2IgrXWP+F98L
 soy/7gkE7OA+E947uHU0Atm1t+vaPyJ7z8S/3gt1xED8JGqWDKpww8JX3Z0n7EaSTLmC
 h+vL1WiCsSfCA+fEZPHQnSw3/I6fwDGAgeKGdKrmxJZ4vfowrSL9clrk6zihMTYl3JHm
 SpyluYS8oZTcBvogx/d/RS8FJ8FoiUDES/bh6piBQRazReX02s4GDC6/1RAvM86wdmti
 BWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744789210; x=1745394010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ARMt2S/B1dfguZ4jkQgvAIurl0FeBfvnxzsUrcVXsJk=;
 b=COJDBxI93x5rrLc68uw0ktebUQereB9yqW0gmO9RSXHxmwQy+MMys9BP/Zr5E/4SDL
 UeOkPwwbblP+hzKScj2fnENV6KitNdjOHaeYzX/kE7u6e1wobczCE/ZtIGwHpx7l3E7X
 s3ncb2RaVOMdZONdf9n6SCSqYNuARLJB8F7ML+doa7Y1wuOYyuscB5apafNE1RsAX55D
 6yTHlpZPQApFZ7PFHOU8sDlffSOPksQhI9k0ZpEPTayfv/YoUBvXjn6dLmv1I7bmBGLa
 WiDmha/TQk8DwuzjuDw4E4h541vOj/tsZ4R6hxIRArtTFE0HQZmhzhq5M3DdGScWVZxT
 tz8A==
X-Gm-Message-State: AOJu0YyWYVIPZjD31DjNxP5b+YOYPE20pMInQ37LdTdMWURFOk7rhpdC
 EgU9Qw4eTMfUJyadx25KVFwGyaOid5VNNkdkpkaVNQhi2Un924L+RpEuyatTGx4=
X-Gm-Gg: ASbGncvQkJHmkuUjZMCAVOnv3rhKF8GAN7oBKZWlHo8bXGVxt5cg8y1cLXA3LbfGsFo
 mbL/GDoVaECe5JIzI49fUbImYwOw3nesGbrVl5ifIYFxPCoLGs7TkLmjv+8QtSXpAbCrlbtK4Id
 Ifi2NHD8Zg3PRofnc1bFy/m0qzU+0SPfPzH+lapaFDyNeSb/laZSns/nh0HNPbjRSr6OMMR02M5
 fHMnbrFUYxd/dlQP0o2agFywJIAaVX14WGs58i0SCTXOVTFG1DMX4uL2HBEfKL2qaypXan9mKIX
 /E7JqDgdbVKBtebo/TeYX1p6KnmlSHpDSf3eNBa0sT1pzU1GftF5Q4gYcmZr4qHVtjovugTdhwI
 qG4voaynTEOxOP+i4k8DvtT1RUhghZIbgDa4cAN0wXs2eVAtF6E+nugArozGj7O2Y9ibTySsOnW
 +NDnw=
X-Google-Smtp-Source: AGHT+IFNQbnvpn6QHOeiMsqBR8wFhR6PSNED9qsenXzgoBQgJQ23ESYQT//RmBQi1Z6k4Ixk34Zxww==
X-Received: by 2002:a05:600c:1c07:b0:43c:ec28:d31b with SMTP id
 5b1f17b1804b1-4405d616ab4mr8944645e9.10.1744789210263; 
 Wed, 16 Apr 2025 00:40:10 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c8216sm13082765e9.7.2025.04.16.00.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 00:40:10 -0700 (PDT)
Message-ID: <2dcebfbb-2c04-4dc5-bd84-88ecd7e565c9@suse.com>
Date: Wed, 16 Apr 2025 09:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
 <20250415173535.GA520691@pevik>
Content-Language: en-US
In-Reply-To: <20250415173535.GA520691@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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

Hi Petr,

this is exactly the reason why I prefer "set -e" (I'm not a shell script 
expert anyway...). But I was actually thinking that the whole pipe 
command will fail with !=0 ret code anyway, since any curl output which 
is not a REST API reply (JSON string in particular) and having the right 
format, will cause jq to fail. So the first implementation is 
technically working. I would like to keep that simple and check $? later 
on after the piped command as it was before. Let me know what you think.

- Andrea

On 4/15/25 19:35, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +fetch_series() {
>> +        local current_time=$(date +%s)
>> +        local since_time=$(expr $current_time - $PATCHWORK_SINCE)
>> +        local date=$(date -u -d @$since_time +"%Y-%m-%dT%H:%M:%SZ")
>> +        local stdout=$(curl -k -G "$PATCHWORK_URL/api/events/" \
>> +                --data "category=series-completed" \
>> +                --data "project=ltp" \
>> +                --data "state=new" \
>> +                --data "since=$date" \
>> +                --data "archive=no")
>> +
>> +        [ $? -eq 0 ] || exit 1
> You may have noticed in tst_test.sh, that local variable never uses $(...).
> It assign single value, but never call $(...). This is for a reason.
>
> Try:
>
> $ cat foo.sh
> #!/bin/sh
>
> foo()
> {
>      local foo=$(aasfd_command_which_fails)
>
>      [ $? -eq 0 ] || exit 1
>      echo "run after"
> }
>
> bar()
> {
>      local foo
>
>      foo=$(aasfd_command_which_fails)
>
>      [ $? -eq 0 ] || exit 1
>      echo "will not run after"
> }
>
> foo
> bar
>
> ---
> $ bash ./foo.sh
> ./foo.sh: line 5: aasfd_command_which_fails: command not found
> run after
> ./foo.sh: line 15: aasfd_command_which_fails: command not found
>
> What happen? $? is assigned from result of local keyword,
> it overwrite previous result from $(...). Note even '#!/bin/sh -e'
> would not cause it to fail early.
>
> (Deliberately test with bash to demonstrate local behaves oddly not even in dash
> or 'busybox sh' but even with bash. And yes, given how many errors we caught
> with this script and generate_arch.sh and generate_syscalls.sh due shell strange
> syntax and behavior makes me wonder if we really want to use shell scripts for
> anything longer than 5 lines.)
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

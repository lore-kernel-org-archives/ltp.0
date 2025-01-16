Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BABC02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737037984; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=cKsH67/sEBRLXaLHKXpBGvljs8xOVGVfmQTSAPlpDIc=;
 b=U8cY2OIxtoGHfBl0pc0do8KcFwTdv3BhikLYfndqg5OkoV1jM3RrSOJcVSrYs6OGZTQuv
 1aimFaIoLDhZzfK2IBX4MmoG8+mFg0QvnrnIR4j2aXF9/SlCIjotj58jVciwGXHWB/0Q73T
 tq/+lofnTHfdIcRQEh4OldSdUQlMsIg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D399F3C7BFE
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 15:33:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 598BE3C2590
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 15:32:43 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8D091020F12
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 15:32:42 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43618283dedso9346495e9.3
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737037962; x=1737642762; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zCqFG1pw011K5MCW1yR6bYa7vo5Co//ahpxUaRYC8+I=;
 b=hBP3K7yZubeOphe+i6WzTSEPWxqLtXQ+X6H1QCaJntbczHIlwiuy8mBAQMGOAnKrpR
 ecYPs3uqeT5OCAPyKVEX/ly47BTZaI3o7VH7jcRq4DzgOwvUJCz8eECbzD/QdIfdVH6q
 eeS3hze14bfrxS31ZEaJVIvShXxpnQ/Z8Nsu6nMxDZrIUPxYIgNFa6qLBdTqgTIlMtx6
 PMOudKpBzz+l099eUGoO+EpF3NKTn1/2jXUnuJwTIyZwRiMRxEGOsRehDHDvUk/GdS8/
 k0t7NO5oNBy4ABRl+fHxXrOcXq9B6Ck9iMOXTlpwf2HRLh2YnOz/6cZRtb8JASf1qrmB
 uT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737037962; x=1737642762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zCqFG1pw011K5MCW1yR6bYa7vo5Co//ahpxUaRYC8+I=;
 b=FqAlTF3Qlid8/vAiud6ksXr4GTYqxbYsjOIoPMJHmC5vhExKi+2p9DO4ucUALy6P2y
 AHOjfTRuJpfNVH5oe+a0yyA5EOFHdnf8eg43ItQnsdJmYbGsX37MQ06z9+GvHeS31Bf+
 VMNMFDYHQ5FtEpRNdWYAFVHLUMA3gJdrofmUMRbtDXRKmbkOiukMOa7KbFzBHUDOqwQd
 wr3gxqB6qZxqoaVYkCLLKvtcOFdhhCvx7Mrk7dLCi0ebI6vCW+IkxNsI6Pfz0k3ZV1qC
 idZi29OBrqKEmslUxiNPdzhhk58Z5lggdbiMNWQy7KMrGZCN/TjyRKTaJj1Ilj+swr5i
 NoPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7vlkXorucQ6zQDbrNCVJNyN+A6chhvUe2swxGVk4xYsFMdgz+jUqyZavJe4PdDoaMfvk=@lists.linux.it
X-Gm-Message-State: AOJu0YxIA1Ivb0qNRNaBuBDyYd5RIXBwq06/ZwFg9C2nd6R3kYZZCem6
 qb4v02euGPwnWvYiV4MvTiPtzbC3HW19S+2vfopZwbCf/QIdyM1CQE6BAgghWF4=
X-Gm-Gg: ASbGncvZ4QZtDJZAKgS80tG6kYy0fvlc73hh3dSfZ9BNNyt1fL0MPcpDOzJU4NUSIUg
 qZSDRoP6Wowwgd80Bw3MOPFaHbPFP3/tiCQmbYZMs5jJFXynNcZMlQMSBZdLE8xTsWG4FpNN9vx
 tdC4CBTGN+K+rxbUbXsypwPZ8+Yy0voaGANVUQI5DdXaDJdii3DiHj9JHdkZxALHSQ/2P2PbrZa
 s62PEwbqvOw7+cfjQAmxMLHXmGPiJi2Vq65yLuECGS+HIeBvUx7wpDPPMyJL73G67o7uyXVOAa5
 O0Bg2rXkhS7LEVbsz59WMytKtQz/77fnqygV6LDwova1Fof4kHofrNL0yJWz0t1IhvyMHsy3BUE
 uk1GaKE7tLyVW5VnyiLM=
X-Google-Smtp-Source: AGHT+IEyG9jGhJa2HGHuK8YQ4BAkRCVJUBvoDtxcomWLLv5ibXKHB0+eNM9uLI8bUzHcVIwqzVS49A==
X-Received: by 2002:a05:600c:1d9e:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-436e2707c41mr273439195e9.22.1737037962011; 
 Thu, 16 Jan 2025 06:32:42 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904087cbsm1267785e9.3.2025.01.16.06.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 06:32:41 -0800 (PST)
Message-ID: <c49d20e1-8b05-4003-aaf9-99c9c18043f8@suse.com>
Date: Thu, 16 Jan 2025 15:32:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
Content-Language: en-US
In-Reply-To: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix opened fd leak
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
Cc: liwan@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks for the patch. The test seems to fail with a big number of 
iterations and it may be caused by the restart process which is not 
waiting to complete all activated operations. I tried to figure out the 
code (I'm a bit rusty with the source code at the moment), but I don't 
see big logical issues.

The patch seems ok, but we should probably end all active operations 
before finished operations.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Kind regards,
Andrea

On 1/16/25 13:18, Jan Stancek wrote:
> In cases where worker completes specified number of `iterations` before
> oper completes all `total_ios`, such oper remains on active_list.
> This is a problem because cleanup only walks over finished list,
> and closes fds only for items on this list. So it's possible for
> test to exhaust ulimit for open files and fail:
>
> $ ./aio-stress -a1 -I100 -o2 -r4 -f1 -d1^
> aio-stress.c:1347: TPASS: Test passed
> aio-stress.c:1285: TINFO: starting with random write
> aio-stress.c:1296: TINFO: file size 1024MB, record size 0KB, depth 1, I/O per iteration 1
> aio-stress.c:1298: TINFO: max io_submit 1, buffer alignment set to 4KB
> aio-stress.c:1300: TINFO: threads 1 files 1 contexts 1 context offset 2MB verification off
> aio-stress.c:1314: TBROK: open(file0.bin,1052738,0600) failed: EMFILE (24)
>
> Clean/free also items from active_list. Also don't let `status` from cleanup
> be set to zero once it becomes non-zero.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/io/ltp-aiodio/aio-stress.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> index 419fc2cd25a4..e84308d1d0e8 100644
> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> @@ -1122,7 +1122,12 @@ restart:
>   	while (t->finished_opers) {
>   		oper = t->finished_opers;
>   		oper_list_del(oper, &t->finished_opers);
> -		status = finish_oper(t, oper);
> +		status = finish_oper(t, oper) ? : status;
> +	}
> +	while (t->active_opers) {
> +		oper = t->active_opers;
> +		oper_list_del(oper, &t->active_opers);
> +		status = finish_oper(t, oper) ? : status;
>   	}
>   
>   	if (t->num_global_pending)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

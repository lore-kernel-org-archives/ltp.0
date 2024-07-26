Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5754DC3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721994306; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=OaPZeWvjkt5NazzhpvQKPduBOZFGGD27oRJKca7mw1Y=;
 b=bFbYIYwCm1fUZquUqKKAuVRFi34bjwxyJY4MYMQF8q+YcEbwLczuyGqRbuTrf9c/Asx5+
 6GX9dGLpHRkD8rDrXYexuvlE5RsvVojyvjVt85o9/QTzNrjD0pzKTSnacJIpenq2RcfogXT
 kf9h6N/iQMdYGv0kPCOLWONVE4PdCYA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF4803D1C9F
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 13:45:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1F673CF2B5
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 13:44:45 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 732761000553
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 13:44:44 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so15635681fa.1
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721994284; x=1722599084; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uhyXpH9KVk+971xWNPZMI8bLmwiHzBC/iNYixQsFmao=;
 b=X5QZjDTS0pfZULWNAUkw4SlacRUPSxg41gwFHftOcyE+OMm3wRf8Oav0rNig22fOhU
 vAAIKXp4RU9PdW/uuNLT/eS7vhtasrMpZBS+RW4pIlLpFqvhPmSxmRX78ed+3JQqFjI+
 a0sRutG0/mw4pVxCxVgyhHNJrtc1yw4OqmopCUxTBjb+Pe1Wf3XkeEz9yr5eC6xbGWiP
 DkmjEe8DEHWpB2D8VYbxQX8BcTsJ1/1pQI6joI9TwK5HZlWuURvEsnn9nPWva3VXvsRX
 daQ4XHMdklzHffbGiRSLORR/iuDGVH0Xe4cU4eUg/TlUeENSC1UyCtzsO2n/xExawd/i
 d6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721994284; x=1722599084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uhyXpH9KVk+971xWNPZMI8bLmwiHzBC/iNYixQsFmao=;
 b=Z2jnnxw3cewS6dFMkHTCw2brBi68pAB/IT7mgmsnLlW5UG6OJ7IK7CS5MJ9N4vmkuV
 Zkz2QdwcsPofJhDI/WFv/t5hpSdGQD09bsE2n7vmzmaXP2DyHDl1eC80r07Qc1D+itwa
 L7VtYXTOX7bC2ESAkyAOoToWg7Vix+yXSIZcMXShad45ZCOukFoJnGuzgT0m3Oh+tbBN
 p1wAmc5Vz92RuyiYa21jjXAu3rdyvonZOthJ5JGDQk485ADnShRDjknjIx27Tvey86/4
 xYnMIqomz8DAxr7rOzc/+ElS4ldAqIHs57eZITomrynZFCt0IdUwxI3h+sUtNi5NrFBO
 kU1A==
X-Gm-Message-State: AOJu0YwnTdFL5PlOnXM2Q8op0IWAKR9odviaWgvjVt3EP8Tb644cDK6h
 urITFWYg82Sy6ymKrZCq5PSTufpx489knmE0ocORClXp86YfzJKYYMv56vI4jEk=
X-Google-Smtp-Source: AGHT+IF9LhnRQBCl5e2/CvDLZMU++ODgkXqnzxr2o765cLBITkojjFdPAaKHwm2+8M2Ftjye2qWnYA==
X-Received: by 2002:a2e:8198:0:b0:2ef:2e3f:35d9 with SMTP id
 38308e7fff4ca-2f03dbb4e81mr46650491fa.33.1721994283278; 
 Fri, 26 Jul 2024 04:44:43 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662?
 ([2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4ded1sm167084366b.56.2024.07.26.04.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 04:44:42 -0700 (PDT)
Message-ID: <45a5e965-d7ff-4ef1-8866-147f2230c750@suse.com>
Date: Fri, 26 Jul 2024 13:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
 <20240725-landlock-v4-1-66f5a1c0c693@suse.com>
 <20240726110139.GC1062794@pevik>
Content-Language: en-US
In-Reply-To: <20240726110139.GC1062794@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/5] Add landlock03 test
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
Cc: mic@digikod.net, gnoack@google.com, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

feel free to push with that.

Andrea

On 7/26/24 13:01, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +static struct tst_cap dropadmin = {
>> +	.action = TST_CAP_DROP,
>> +	.id = CAP_SYS_ADMIN,
>> +	.name = "CAP_SYS_ADMIN",
>> +};
>> +
>> +static struct tst_cap needadmin = {
>> +	.action = TST_CAP_REQ,
>> +	.id = CAP_SYS_ADMIN,
>> +	.name = "CAP_SYS_ADMIN",
>> +};
> I dared to merge this with very minor change:
>
> +++ testcases/kernel/syscalls/landlock/landlock03.c
> @@ -26,16 +26,15 @@ static int ruleset_fd = -1;
>   static int ruleset_invalid = -1;
>   static int file_fd = -1;
>   
> +#define ID_NAME(x) .id = x, .name = #x
>   static struct tst_cap dropadmin = {
>   	.action = TST_CAP_DROP,
> -	.id = CAP_SYS_ADMIN,
> -	.name = "CAP_SYS_ADMIN",
> +	ID_NAME(CAP_SYS_ADMIN),
>   };
>   
>   static struct tst_cap needadmin = {
>   	.action = TST_CAP_REQ,
> -	.id = CAP_SYS_ADMIN,
> -	.name = "CAP_SYS_ADMIN",
> +	ID_NAME(CAP_SYS_ADMIN),
>   };
>   
>   static struct tcase {



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

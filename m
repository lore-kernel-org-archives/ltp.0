Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B08CEED603
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726147587; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=silFEHS626Ubs2jL//Rj5/RYylIWaNrELseidvTz62U=;
 b=oo7ZTj6HnmWfkDELh1jPkUbhbMnpFEk8TFHIeKdR7xF3l+vS3H/7HZx5GGOvRNyWT3xeO
 DAv4nNq3kXySNDAJjPekyLuzfOMCx9IMWxqXNM4PfLafThLx26/KnHik3yose9psEMeqbIx
 rZ9Y0aXYVpQYzhV643l6XUzeTmsflhw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F311F3C2690
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 15:26:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7654B3C23C5
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:26:06 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF5626009EE
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:26:05 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so1104702a12.1
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726147565; x=1726752365; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNhcDraAmZDjJfPWSd4z8Nm2WYELjszZBbqWHEoXuAE=;
 b=B7C8LYqNSR6hGD1fP9Gw9P1h/K85K5W5QotdeGwRezOYAw3gUVII5lz5mskYpO7Eme
 rArJzSzrdUbjj2U7HG+M4z6+XVtYOUqptdY0GlX9MGooQY+sBVvVcmzsYmEocTCxcfzN
 TC0Z30xjj7mERXYyhGcPjaBASFzs0KWe3JPz+8fHm3MQFMnmi9PQ88GjSy12KqtnOW7T
 6i36iBc5dH5At0/ED9VGOII8VUy+KEMDZaXA/uHZ812lKf9Wq1s7TRAguh2fzz72X7o/
 KVcmhLxwnF80R2s31Vuhq+4mcuDlgX8EBvVuvmmylDFBuBrFzJffNAHhQckdcNLhwd5A
 CAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726147565; x=1726752365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNhcDraAmZDjJfPWSd4z8Nm2WYELjszZBbqWHEoXuAE=;
 b=a4W3fZdLEdqIRhXH31xaFah7bl4ZwSWSfUueDy8cAVzdi4Yv724E4TSG603OF/mqUS
 0l+piK/jTD6Av/3chFpYvvxWhsrvlluXoQebn3fBT/mE3bKbQeQSNAWBFxKiHdvYimdI
 4YgEw8iPb1xHXPWgQ8JlPlK5Lcc45pFkh/CLw9UO3OclmkfhTeDXfLzHs2M4jifue2QU
 thaVEI0XKm3MjYro0SzbmHM1UvD9JcjJYQxZwbPLcMRk3zw9eYWRJSp4uu0Y6gtDRM+T
 NEnQ9+Cd4BcQcl6AU5kzdhH9PoBa7ig27SPqPmjLD78J8gfgMQf1z53SWmq1S3GcPjTy
 aMhA==
X-Gm-Message-State: AOJu0Yzmo93Z+7QbDrnl5bap95Ft8fYVzKrr1TH0G0kNt3Pu2yqu3IRM
 TjCvyQi/9OhFeD5lrwqBXDJyTWBNcfUXRd8RMN2GXOgZRahkqaMkiO+LfdtIMxA=
X-Google-Smtp-Source: AGHT+IFH8XSQa7AjtqDp+oPC1pwZwXJjfzYpbshCGEhK+mKch3a85dJfnDsfiF/z4N7daO0bYUEahg==
X-Received: by 2002:a05:6402:5290:b0:5af:30d9:e2b6 with SMTP id
 4fb4d7f45d1cf-5c413e4a402mr2334147a12.23.1726147564251; 
 Thu, 12 Sep 2024 06:26:04 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.36.216])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd52010sm6564538a12.43.2024.09.12.06.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 06:26:04 -0700 (PDT)
Message-ID: <27d7207a-d53c-4ade-9516-27b6bfc27952@suse.com>
Date: Thu, 12 Sep 2024 15:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240912083102.3216-1-andrea.cervesato@suse.de>
 <ZuLrHjIy3Z_aGm1I@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuLrHjIy3Z_aGm1I@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Add rename15 test
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

Let me recheck and resend the patch eventually..

Andrea

On 9/12/24 15:22, Cyril Hrubis wrote:
> Hi!
> Am I blind or does this patch miss the changes added to v4?
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

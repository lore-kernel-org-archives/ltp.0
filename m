Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079F4C27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718002742; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=cz1zbJjewXsDgNKgMSQEoerWcvwO4vp5rPjSnbKtI+U=;
 b=gMpFt/94yS73aGKdx5L4aLvwLb8IWdLXm+01E+CvTfhyFaR/vXDzr4bTRIMv0QLmnWTD1
 1c1srL8vmjP4kLs9qnE2hDtiyuHDqYMMUhCqozY2H97VcV3QWnTlWjSIzKav7wsO9ZWl1Tv
 xoQBCjrFPj/zXbxsbC2s/FMfve1VzIg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBBDC3D0B33
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 08:59:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD3803D0761
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 08:58:41 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 301B0607125
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 08:58:40 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f13dddf7eso115635866b.0
 for <ltp@lists.linux.it>; Sun, 09 Jun 2024 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718002719; x=1718607519; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tv0A2AYz6iUKiQXY0IxXX2xm9kmPH2CGC7PJwCJv+ZU=;
 b=KNyNPESztsgAefU0DTRlvIJq28lFFY499+e0efRZDaprW+jRRQDDkpZZfceQ8BDWJK
 A21hjxIe7rmfIsHn2/KPi3nHvaiKe4PEPZa4VDjrL62eKGcwIi7/sswxC37HiRQpe7KA
 RJv0cCZT0dOtZvoJmcrwQ86IeUkUeQ64ZZ3pN3JsslTT1tWVEjSd468vCSW9VG7BRcO7
 lSP4cgfBeGRh4CGYrii88g32m21dHjD4lyl/R4c0xLKN+EQXqC7WAq7e6fm9j9cZcg8g
 HSPCAOTK+QQrWFx9IiondQihrLUsbDsMR2W8zamYIL/FTUwJkwW4pZwyUj6mqfSh8og0
 YXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718002719; x=1718607519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tv0A2AYz6iUKiQXY0IxXX2xm9kmPH2CGC7PJwCJv+ZU=;
 b=r39jGxpo++7AyTi+5Hg2ftAaWrCU7Eq/4vA6PEZ2wKHGceqoomppijQZQDqATLeWJA
 j/3Fe6KX40nyjW1PaHJr8DqD1Sbk+HYAljom3WdpOoXfO8qNEc2AmAwncHpDyfLZVreH
 kXkv/qGJio2gCGO/nGobUCoxULAj6e933V8XiwATvIYZVfR7xo3z0Qjn94MLOTeKGIwN
 xTGQnkz6goVFUEZOmAgBLe0Xe2vQIFPRqn5jFSE/tK4uk1sXgz3kLPElZLktAnqd70xK
 6HF7GsNZ2/cnMOQ2LPR8xRpQScSfG+xQZ9mRTr5pVBqa88HZl3Gwwjr5i77VLzKRxyPl
 tu+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOesMhUYjB7vRrmIwOiwV92tCTJmKVFVYurtChzgNIB0Y7U6e3diJGQWk8M+DK2YsTEjXDbsuTej4DWEZMFwKNAjY=
X-Gm-Message-State: AOJu0YwqznVRTJsw/foVK8C6totRCkntPQxPdY5g7VFs/PqDqzz8r6ls
 8hIGsl7zZI7NGTY1dQa/jVTKOdDV6TgVmEUvvADLv+Br2CrvHXZH8VqnvTI0ch0=
X-Google-Smtp-Source: AGHT+IGH2Ch3CxU+iuHTZ3XxCQtFJlUStG/kJDz+GDBCB9Yxjn+cXU8U55aTgmrnvsH81VE7HjXINg==
X-Received: by 2002:a17:906:68c5:b0:a6f:2d5c:5c8d with SMTP id
 a640c23a62f3a-a6f2d5c6342mr9195066b.30.1718002719504; 
 Sun, 09 Jun 2024 23:58:39 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.42.167])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0f98a285sm252784266b.210.2024.06.09.23.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 23:58:39 -0700 (PDT)
Message-ID: <6521fb41-3ac4-4487-8cf4-e1faff1e86b7@suse.com>
Date: Mon, 10 Jun 2024 08:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240607115304.86028-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240607115304.86028-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [KIRK PATCH 1/1] README: Document passing environment
 variables
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

Hi!

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 6/7/24 13:53, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   README.md | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/README.md b/README.md
> index 72e5c56..cb69049 100644
> --- a/README.md
> +++ b/README.md
> @@ -104,6 +104,10 @@ Some basic commands are the following:
>           --sut ssh:host=myhost.com:user=root:key_file=myhost_id_rsa \
>           --run-suite syscalls --workers 16
>   
> +    # pass environment variables (list of key=value separated by ':')
> +    ./kirk --framework ltp --run-suite net.features \
> +        --env 'VIRT_PERF_THRESHOLD=180:LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1'
> +
>   It's possible to run a single command before running testing suites using
>   `--run-command` option as following:
>   

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

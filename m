Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F9DC021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739798219; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=MgpY88vhjPcIyY4iJKa1r96iER2d1Ep21ElZO3YukEI=;
 b=GBHmx7FThIoO10rJ9kyn42qtXThLHTTefXEJAvv0u3fpO7M6MGPqBb50O/PQxFvxvU08D
 r85F/lD0Mg4Nrh692YpV5iX4heR/HwTpEMW8xl71tIzfPpqowm7EolIfXqm/9uQcoMbP0fN
 o8IS9Omlg06mR8mTdOKziqKZZpC2utE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04FE63C9C84
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:16:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ED9B3C99E9
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:16:37 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 786F820E5B9
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:16:06 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e05780509dso1574828a12.2
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739798166; x=1740402966; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=633yEiwb0ZImCydcK293f789q+xD+CAtlXEq4SPAfcI=;
 b=TwVvcBL8wUgo8OEob3muAf+SEa2jby2vvS6QsqSU/bqqrSaZ1bg+Ar8M4wE0tngsJf
 33XNkuozbNchR1Z951snDWnZSrLUdxt/ZUK2ur6l11YWoqp+yZUzE9TmQGAIbU1inbbt
 5vA3HQRkKfFQTr1LtufErLO3DsV797O7YK/BigKGXyLQ/O7ilFmIP/TdYooR1jw1tQ69
 407xSujhaGi1nWFOeEXSeNE8wGrc8CuOEsnx+dxMO8nWs08znGB5wEXIf/V2IkXcVJMi
 qbKMeGPqeP67q8SkWMDhlq4Wmg77cBCD9d2ZK9IHOI0SRWgd+5JTKk2JM+uX8aV6lfXZ
 3RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798166; x=1740402966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=633yEiwb0ZImCydcK293f789q+xD+CAtlXEq4SPAfcI=;
 b=Mbmkhd56nd+3fOz0M8ZYoMI62BAtHsYy2f7zE00bXHC8cobYJBeI+Fn7VvVQRyC3PV
 H6riK1xu1EmJ+cj7kYFVn3HC2TBCFXl9ZULQGe1F3i7wI6cj4CGQxVRolMX2+OjZtcvu
 TEgvujbYl3TrtwuDeeq54KesoyqlAjYbMwRl/rUZiUHwhdKC90aleuhTBRCB4xxtyKsm
 7tRZ+GktJBW6lDWhyOT9YWtnNS7EC4cUr9B1WKG9RxXdc/SC8dNzXVUkknU1dR54EvQ/
 84jHN4hem9K3cawH7an6R87qstP8Ihzb/PDgCObLJMX4jywfXvIe11grbjm8T6+51Dz8
 YH+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsZMJ/1BGMCKR2kfQNs+HKTSFKu6vJCYjOtTGBRK4cV/fgWg94X9jbU3f0rOK7urJ+mfs=@lists.linux.it
X-Gm-Message-State: AOJu0YxTvy+8d2irEtFSO10I7OkuFw8leCCjOs14jupPcMuLIqCRUf8r
 haPFkDvO4fsmzQByc1gQ+F+TQMd4eXoHec9AKWZ0Xz1B8m2IDBPAMsLopQT76dM=
X-Gm-Gg: ASbGnctozPb84Mv6kJyWmgGG3TB0O90iu1PMS45Qvs5izjr8cfeVWCRqMDmtFqenKpI
 l0IOvjXk6QvccSx0GDV82t5HtAG1cmU/m3WpOwdMO+2qlfdg4cCh28VD7TD3Ev8lMuhOtyMoLpE
 eZBifymN4P9AjEs66KmNGDINsKNsKnAm1BqZUF7r2ZuuzxXHcofLqMcZxBMmkar9mvvX69KrErX
 Aa3Pn8EIVDoEQuOq9o9ZZyjjsj21GDj40nRFykzQIQAH6NlZSs8w12OOhJUXcxT/RMDjVVvvQ+2
 iVf3/oSoC2N1Sf5w+zbEHe1x9cgDAVwymhAh5XXNpsgRdBou1vvPyUadbd64NH0kq4qDv4lEn9K
 Bo/Jo3S73dsWSp1ehAPyuIKMYF6ZEX52GfY/v8EQsQvu3w6LR7kg=
X-Google-Smtp-Source: AGHT+IG/ixv4XfgO+GhXzBReL/4kbqvALq5gidmjoDKhsUheWYGjETOjdVEv2JjINY2oS0n51tyaXA==
X-Received: by 2002:a05:6402:2384:b0:5e0:36c0:7b00 with SMTP id
 4fb4d7f45d1cf-5e036c07d5fmr8098648a12.31.1739798165875; 
 Mon, 17 Feb 2025 05:16:05 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5decdfe758asm7219295a12.0.2025.02.17.05.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:16:04 -0800 (PST)
Message-ID: <f8d6c3fd-7b1d-4d16-b034-a2b01f956870@suse.com>
Date: Mon, 17 Feb 2025 14:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250217130839.2392666-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250217130839.2392666-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_security.sh: Fix SELinux detection
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
Cc: linux-integrity@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/17/25 14:08, Petr Vorel wrote:
> Some SLES15 versions create /selinux directory which fails the detection
> if SELinux is actually not enabled. Therefore detect if directory
> actually contains the 'enforce' file.
>
> Also drop /selinux directory detection and detect only /sys/fs/selinux,
> /sys/fs/selinux mount point was added in kernel 3.0 in commit
> 7a627e3b9a2b ("SELINUX: add /sys/fs/selinux mount point to put selinuxfs")
> 14 years is enough, kernel 3.0 is not even supported in current LTP and
> we don't even support /selinux in C API (tst_security.c).
>
> Fixes: e7b804df65 ("shell: Add tst_security.sh helper")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/lib/tst_security.sh | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
> index 05640234ea..356c28fc73 100644
> --- a/testcases/lib/tst_security.sh
> +++ b/testcases/lib/tst_security.sh
> @@ -127,8 +127,7 @@ tst_get_selinux_dir()
>   {
>   	local dir="/sys/fs/selinux"
>   
> -	[ -d "$dir" ] || dir="/selinux"
> -	[ -d "$dir" ] && echo "$dir"
> +	[ -f "$dir/enforce" ] && echo "$dir"
>   }
>   
>   # Get SELinux enforce file path

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

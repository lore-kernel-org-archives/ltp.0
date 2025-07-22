Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948A4C83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 07:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753168414; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9EFLmQMqv4nZuxaIwRyJTJFkzBw/Jcx7VzeTX6XcTuw=;
 b=MKftUP//c8nO0bHs9JoU0l3k7dwQhiE7fMtuOJEdP3nOREjm9pYKZ8EGBr6kM7Ovj+KYm
 FOWKUJTO2OkBa+Cish+rojuhaQ3E+eNzeT1mb22uwZPeomKB0HH9QoTdA/zW+443hnd2vzq
 v/5J47/9A8makhLr8iNXjhH5RzVRfgk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 059633C9AFA
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 09:13:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 035463C1CE9
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 09:13:11 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 154C21A00CBA
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 09:13:11 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so3582518f8f.2
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753168390; x=1753773190; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ra6MkDsCJ270laN289BfQ0Ch4pCWzSJOBLHbAIT7pj8=;
 b=SrnuUqXFRpDmGFWQHPQESF2O1hwoQhzxtLtGSe43YV2voU1dW32CSSIeyqFEI/Asxr
 kU8VB9T7LcwKfW3lLocxt5/UdOUI9gS0Cw3O1mGAGwfP31TalcV3FZt8qkY1Ew1GhqzV
 CjLWEQkRU88yGqt5ETqwMTH8fTddX7udFeWckDDnStnTJS4BiCCVjN/CwZ81vMLMASqP
 7n4qL8aMKDvqWP/45F2LOIBEF4eJzhbaEuIXpOXo/ENJuetaElFg0U73GTGCNidXkBMB
 AsKn6WvoOwAa2I7GPolMjSqL1mS5SLfp5HZq/56ablsNRp2jUaH10pqQprkOoyaRDml2
 AhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753168390; x=1753773190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ra6MkDsCJ270laN289BfQ0Ch4pCWzSJOBLHbAIT7pj8=;
 b=q+2Gi0JptRCbQKuiNgJHM5Z4w7egNUX2AjDGFp545Q1m/iLEPHoQDnnRXjgENxapv6
 RQviaM56xztTSs6uXt+8EufvaEgzJjq9Llslv9zASRD4DHyKg8qP8MOsfwY/z0K42Spq
 iqWDmrqUqtY39IyY8DR5rFovbnpOoO8swy82z8M23qPhdNCRvYIXhvH43MiSIqQwEBO1
 XXn8dJtyXi/PRUWHjtbPfaVlCOz0NWz3h0r72fSTx1tdK0PedfrdEN5Qsw+4pEEnHcuH
 b99KsfXvBAOalZdOI7mIPnpDTVfoA/T57dPuX4YW7BNxvAmeycQ4dqZNc7BFIA5dYW+F
 xDUA==
X-Gm-Message-State: AOJu0Yx1KLv6aWRmXoVDcsi8JF/SqU9TxMxTCbYBX+KwXAubVs5+fyGB
 cz7er/2v5dZ9Wk8Nt//YwzuPZnOoPIdjqjUnU7xYbvQFXyFK6iaw7IXCPyYe6p8xksdBqoSlZD2
 74p4=
X-Gm-Gg: ASbGncv8xcz2ET8vSZwn271RtHUfQt5P6KkUYV21NaVbr6Uigz4sMu2b4de8LOtjSMT
 /3haGgjM1GgEj3gtWTHdz8o8NyzK490GdH+poOAhDBy0+HcS3P56F1AghQ6+Gx0eQPUAbsfqdgh
 ApUAUishbgs7AzdWKxTIm5hQRA4Xet79sUiaZbczngkx57jNvowsCkjhH4B75pyWErfVacGpBHy
 A0QMB+VauPSBC0jEp6I57DVM1gBM1lOYp5tTwZsmi3JybCfGnzittEgzLycuSaecDxJndoJ6Rka
 BvxabHd0568D6tk9vcO7NuJ8EX26A/bgVODfSPZfpbPLvKIoVU8XRwssEe8YKbmu7NwUoppr6tC
 OajkJVV20Fjvj3lLZiydY9Q==
X-Google-Smtp-Source: AGHT+IGbS84NpbuOAro+gr2sBvvYlGFQIVVUSfki8k/9+mbLqCC7HfSwdtXLFyVBJUDIq7t4ZqBBZQ==
X-Received: by 2002:a5d:5f08:0:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3b60e4c90dcmr13464477f8f.18.1753168390407; 
 Tue, 22 Jul 2025 00:13:10 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb678d8dsm6871749b3a.110.2025.07.22.00.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 00:13:09 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:12:20 -0400
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aH_ilL8VI-ZhG74G@MiWiFi-CR6608-srv>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 22, 2025 at 08:55:56AM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Add tst_selinux_enabled() utility in tst_security.h in order to verify
> if SELinux is currently up and running in the system.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/tst_security.h |  1 +
>  lib/tst_security.c     | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_security.h b/include/tst_security.h
> index 5d91f8a98f104b0cafaaf2046bc0ceec06870606..cb5490a896f027245064abebb9d7c36270fd2e8a 100644
> --- a/include/tst_security.h
> +++ b/include/tst_security.h
> @@ -14,5 +14,6 @@ int tst_fips_enabled(void);
>  int tst_lockdown_enabled(void);
>  int tst_secureboot_enabled(void);
>  int tst_selinux_enforcing(void);
> +int tst_selinux_enabled(void);
>  
>  #endif /* TST_SECURITY_H__ */
> diff --git a/lib/tst_security.c b/lib/tst_security.c
> index 7d929fafe729058f55b921bf5cf7806b253496e0..f4669c60fbcafeddcab23835ee8c568a4aab46c3 100644
> --- a/lib/tst_security.c
> +++ b/lib/tst_security.c
> @@ -7,7 +7,8 @@
>  
>  #define PATH_FIPS	"/proc/sys/crypto/fips_enabled"
>  #define PATH_LOCKDOWN	"/sys/kernel/security/lockdown"
> -#define SELINUX_STATUS_PATH "/sys/fs/selinux/enforce"
> +#define SELINUX_PATH "/sys/fs/selinux"
> +#define SELINUX_STATUS_PATH (SELINUX_PATH "/enforce")
>  
>  #if defined(__powerpc64__) || defined(__ppc64__)
>  # define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
> @@ -102,6 +103,18 @@ int tst_secureboot_enabled(void)
>  	return data[VAR_DATA_SIZE - 1];
>  }
>  
> +int tst_selinux_enabled(void)
> +{
> +	int res = 0;
> +
> +	if (tst_is_mounted(SELINUX_PATH))
> +		res = 1;
> +
> +	tst_res(TINFO, "SELinux enabled: %s", res ? "yes" : "no");
> +
> +	return res;
> +}
> +
>  int tst_selinux_enforcing(void)
>  {
>  	int res = 0;
> 
Reviewed-by: Wei Gao <wegao@suse.com>
> -- 
> 2.50.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

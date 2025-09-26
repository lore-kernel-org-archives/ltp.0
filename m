Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5839FCAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758893064; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=UB/kFsh/WfIbGA/77igp3qmdUiMFB/EjSDyWWo6ldZM=;
 b=IDRN9DbJ+xGultSwKzFuLsG7DCzpxx3NCcIMD672fE/UvH86S71ZzxCm0TZuxBVQbhXjL
 dmkj/4fZIdufAO0pQoCC2gSETun2nh/w7MC6Ry5UJMF+oRYmuS7mQ/R7BzA6mOE/PBm5tgN
 K6N28fYUZp4o0917erJNTtgjPOTprmA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FF973CE11F
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 15:24:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83A7C3CE0BA
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 15:24:03 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CAF11600795
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 15:24:02 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b33d785de7cso363864766b.1
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758893042; x=1759497842; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mrCp85iHRSr4mhN4gYizf3lcWOW3hSYXN8olpbvvbnM=;
 b=g7gownJWZyAdrCcvshyUMBLS9xs0NyU9JLpyXWq9klgitIoVvB+WTC/Kb4eHjJyHDn
 xHB4d9mDiSSPuPbhlVE3ZalRTA3XAhuDC2wmgco36DMqKUw3z2EbcKJR0QYZ5zoBSLV3
 kxU5pTJYfsYuhTv+M4I1Du3bClohnMqcS1PdK8CPE+UYy1ksqXpmbeDRhWPrwaineDS2
 0i4UMrZMrqIcK+ZSuv5Irw+McUCa8jjMVF2bzMwNG5SendUWmcIZyrIt6MZFcBtY2e37
 9O4I5cE7Zi0m2tKDvRsNPob2LCf1415Il3Z8IOniqWM8+5BpeM5e+VYkwhtAUJZhRCTA
 9wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758893042; x=1759497842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrCp85iHRSr4mhN4gYizf3lcWOW3hSYXN8olpbvvbnM=;
 b=MXQSUbjv/UoSWumMeQY/YluCn29TS26rvbiCKyJiuuINQILUYLpMviv6iyfsKj9ntJ
 gE0DbKt7Ah1ZG4FnOqt+N76B2fJLlkd8m+gK/D5ovW3Rmg235PWJTOXvqdQHjcMiNi8r
 JisL1ZC2uGV1pDFGagnBV99kGpMYOvHLoAOq0ne28uxQ71ebhrmA/T3UHvcXZ9wfrjNW
 ZtGgocZw3WfJtPvcu+hh/cpuUduMitbua2//+irSUk2RoZiohnpVeTbD77j7eeLTGfOI
 5fT72LDzzGzO9de/4/g5K0DSuyVA8nEz3bp6deyc3Jv3kwSSdhO5MHKvNVNBWyqV909c
 eNhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE+5f5hTLWAh26Q5vNgp4tDHLLNWC6kUzPMY5Mc98iuMjW8duibKYX8ykej1zOilAQbcs=@lists.linux.it
X-Gm-Message-State: AOJu0YxWLzWS88bPMBpM/5xJ/GyHNIKYyIBmG96xeC6gfUs7Gefo8Wqm
 TpsBDHAjzTqSi/GsVHI5+ny9seER7Yd2VRdMtwiED1BnVwiMK230CtTrTMmRS2wqXfuv2mPuOpd
 LzxHqkw4=
X-Gm-Gg: ASbGnctnU2/T/Yv7w3ismO3zUDr6Rb8eqOqz+2EogWoLIVxV0x4jzQl8v3pzwW4CrKw
 8/+2kKGLmVDP+qN8+I7nDyjtTs9twXYVRYxVoG1G65M5PKC+u/Y5EXfr2uh4RNQmkYqyOcu1OOn
 7nl2ZALdqunQe3A8Rko8kgyKD3aNtsNEr3q9gB20Gmn0I6w42IBZIg+Wmd42CWljMaHojfGtVS5
 jUXlETjbed1k4P9cC15COxgGh5gRNUjhkOzlJ1HcTzLmeazsczAFMnowi2BCJMKWP4AuoAu9ooS
 h5vfgNRH7lMtCXQsh8A5423HrqQd4Fvqg1LI6xYIyMv3XrMPHNT5FmrUO5Gtcqkg600Kn91ziZ9
 yMn8p9+bnh1S8q1FtzgZB8WNLvz4dIroGgeVrVb0E80mLM/wA4TjGsjh/dKRLzPR5ggEb6PlXyD
 mQkLFzDhCihvFFTHkiHbB7nXMPzISn10UHEl5ukfQL6J3G8ht60M1q/bjTX8pXbgY=
X-Google-Smtp-Source: AGHT+IFvG9yNMLzAyCnwTDCAqw2hfhkwPTHNUv7+zXd7UlOge1qT3+90dQ0Im2ss5ZcACfQwPoEs2Q==
X-Received: by 2002:a17:907:3d9e:b0:b2d:830a:8c17 with SMTP id
 a640c23a62f3a-b34bd068ecdmr822846766b.56.1758893042107; 
 Fri, 26 Sep 2025 06:24:02 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b35446f7834sm363261466b.65.2025.09.26.06.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 06:24:01 -0700 (PDT)
Message-ID: <aa769509-d4b8-46eb-b02d-699a573b0080@suse.com>
Date: Fri, 26 Sep 2025 15:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250917102737.GA336745@pevik>
Content-Language: en-US
In-Reply-To: <20250917102737.GA336745@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] 'nobody' user for testing
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
Cc: Betty Zhou <bettyzhou@google.com>, Edward Liaw <edliaw@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 9/17/25 12:27 PM, Petr Vorel wrote:
> Hi,
>
> I found a setup bug on LTP IMA tests ima_conditionals.sh and
> ima_measurements.sh which use 'sudo' (with user 'nobody'). We have many C tests
> in LTP which use 'nobody' user somehow, but they don't actually execute
> anything with this account. IMHO these are the only tests which execute with 'sudo'
> (please double check me).
>
> $ git grep -l nobody testcases/kernel/syscalls/ | wc -l
> 160
>
> Because on newer systems (I checked Tumblewed, Fedora, Debian) 'nobody' account use
> /usr/sbin/nologin which prevents logging, we 1) either need to change account
> to use bash (and restore it back after testing) or 2) create a dedicated user
> for testing. I'd try to use 'useradd' and check with grep /etc/passwd if the
> user is not already defined.
>
> I tend to use 2), add it only to IMA tests (to ima_setup.sh). But I could
> put some more generic code to tst_test.sh so that it can be reused by other
> tests in the future. WDYT?
>
> Also, as we heavily use 'nobody' already I'm not sure if it's worth to bother
> with putting environment variable allowing a different user. Nobody so far complained,
> even AOSP folks seem to be used C tests which use 'nobody' (e.g. fchmod06.c is
> compiled [1] and not disabled [2]).
>
> Also, we agreed with Cyril, that it'd be good to convert these 2 IMA tests to
> use 'su' instead of 'sudo' because 'su' is simpler than 'sudo' (although when
> testing with rapido [3] none of them works out of the box).
>
> [1] https://android.googlesource.com/platform/external/ltp/+/refs/heads/main/android/Android.bp
> [2] https://android.googlesource.com/platform/external/ltp/+/refs/heads/main/android/tools/disabled_tests.txt
> [3] https://github.com/rapido-linux/rapido
As far as I understand, the ima_conditionals.sh and ima_measurements.sh 
tests are using sudo for creating a file from a specific user/group. 
This is already achieved in other tests such as dirtyc0w_shmem, where we 
spawn a new process, changing its current user/group to 'nobody' and 
executing a command.

I don't know the internal sudo implementation, but I guess that's enough 
for the IMA tests, unless IMA testing suite wants to verify that sudo 
command is working properly within the IMA support.

In short, I would re-implement those two tests in C to make it easy.

-- 
Andrea Cervesato

andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

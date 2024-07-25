Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD50C3DA5D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 07:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721891839; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ubYkpiQmtbeUbJ3EVzrVHnx2gHDsAzo1jLlalqg4iIg=;
 b=C/ClorofRUlcstGI44HG1iuZ7Y7kFGxXVpFEF1UpTlHT30WO58xNumWv4gZItfzAAFaOd
 AAuW4Sx4+pTe3zpoVBXlb2q+6Vzlsl+gfDGxbq+AA9Z7HiiDMoSQbBENXexBQGkutvincDu
 Ouopt9k2/1XpfZ6ToInhZGCtsYGPF2U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4559D3D1C7D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:17:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 805D63D1C63
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:16:57 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16E7B601565
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:16:57 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7a8e73b29cso15123266b.3
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721891816; x=1722496616; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aeDTrD4XprfjVDMjvJuJXCUbvAx9n3irJ7cUapE0bwY=;
 b=SMxmkfpeArK+RHpcCDvt7pYrVI5Lnj80ySa1LElHB1dMG1VwKTiIyTcuPXbuZE1zEH
 bAY4IHdnlsBUvfFDXeT6atpmhBoCqJFFv7/6vC2CC56wgEHOc6GWXy1zvkO1hoVuvAc1
 b2cnjUrIsnFiuMceAbwMsChsE2rDk+kQ/VVCfFihIdis3uCWG4QIKuTQykV/kBxq6l5E
 xC8sUnIVlb0pt+ruHY4fscnMLebbuDWhUhAzi2O2bRvrIkjUpnc9AlVvhOBREii2GZNF
 T1CU21M94pTMIa2pp+pNsIfhQu8vaFTcoFnU6rCVGuGZmIyhLroABXfWcdPNxrbNVwzT
 BYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721891816; x=1722496616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aeDTrD4XprfjVDMjvJuJXCUbvAx9n3irJ7cUapE0bwY=;
 b=RFsDgHGxY/KBPtHnJ8C9ZX9nItBDoe7EtSy0v76ZCK2DlkELU6ZgjqCPDObzy4rutC
 ONHpkA1rvCYydku7i9zaE93Xg/LI22OWH9DPO2xsX+/9vG78iGCFjALMAb3IhJNlFqB4
 hD5JGDU2glRRR1/YM5pYloKh3oOTqfr9wY/WDrFWH0MInOpaj3cC04vKCTErwFQZiuOj
 /1BtLNrCPIy5lep7qclX8tmom03tz3UYSpN2Tal6uqDgODJTxAJ2fm7BVd1ZLElzZYWM
 HdPJkqhLtfPMNB80FEk6r2z0/mmkg3DIfhuPaouyT5bPMT6SStQ5NLT5QEzsmmxTp+nO
 lBjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtnFk2615QcW8ig/oxOeZ6jAWP9D7wOi7MvDBmuoXyjP02TQE2zU2OLj+qah3zT7Xg3Ui4y4lYie5f7s1c68x/Ivc=
X-Gm-Message-State: AOJu0Yz3pcvTQTz5se7PSRB5riFtryQTJew42XtqXZKpD11j+VFYfYE4
 BxRYvdJW6MtLuQ9+pTEXzbS8vR/Xw/dW8QEsw3z1/xd9728gmI02Hacshp2ve8w=
X-Google-Smtp-Source: AGHT+IGQbZoQd8jpf3PH2qvtu/qSlHU8l2tURDUi5FcvQ8VP2WJ1ORvQZFZT1xT0MAIbgGTLnGRl8g==
X-Received: by 2002:a17:907:1ca1:b0:a7a:9ece:ea68 with SMTP id
 a640c23a62f3a-a7acb39b4bamr64419566b.10.1721891816175; 
 Thu, 25 Jul 2024 00:16:56 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662?
 ([2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41462sm39486766b.119.2024.07.25.00.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:16:55 -0700 (PDT)
Message-ID: <c6fe3040-3d4c-4c87-a55e-84f6124b6602@suse.com>
Date: Thu, 25 Jul 2024 09:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-7-33075bbc117f@suse.com> <ZqEg7SD35ejRYCsX@yuki>
 <3c2626c4-5c26-4112-9c74-4cf9b4ecc3e0@suse.com> <ZqFe4Qxw78uMJZGC@rei>
Content-Language: en-US
In-Reply-To: <ZqFe4Qxw78uMJZGC@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

Hi!

On 7/24/24 22:06, Cyril Hrubis wrote:
> Hi!
>> I can't understand what's the best way to test all the combinations. As
>> you can see there are many flags, which means the amount of permutations
>> is big.
>> Most of those flags are handled (indeed) in the wrong way, since most of
>> their permutations return EXDEV. The point is that the syscall has many
>> error codes, so it's complex to write a code that covers all possible
>> results.
>>
>> My idea would be to have an array of errors to give to
>> TST_EXP_FAIL2_ARR() and to avoid any statement around fd_src/fd_dst,
>> because the amount of if/switch-case might explode with the number of
>> permutations.
> The purpose of the tst_fd iterator is mainly to hammer syscalls with
> different kinds of file descriptors and trigger code paths in the kernel
> that are not excercies under normal circumstances. So it's fine to have
> a single array with a few sensible errno codes and pass that in all the
> cases.
>
Sent v4 that does exactly this.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

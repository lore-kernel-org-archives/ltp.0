Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2102C71130
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751904408; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=0F7ANV1XptoS8UMoVTHvOdTm08tLd7oKLN90ffjRSms=;
 b=Zbo64ewn/ilJfIDteZXydSIwhBwgb6Ybji+ZHZvnvKq7S0WX21CgBsdMLD8dyU1eMPCm9
 U4nxHeKYDwMSD+xGyez9wKcgAlhOYTvymbbe0DevmvMAtFsNZ7fxQkvHQeJm5URTuFuavU5
 ZCKMQy9SGd2vhnORREDEhnAEnCAL8ZE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5336A3CA083
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 18:06:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 758C33C8BA1
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 18:06:28 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF6981A009AB
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 18:06:27 +0200 (CEST)
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so6525861a12.3
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751904387; x=1752509187; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nd7VYO8A4+2mfjLIcjiHYVYMYU2NX6MvKOorWXPJdOY=;
 b=glJfK2QSBu6qfYY/39IEb/p5XIccocHPK90LT4lT24BmrYwjEQs1h01ba3UnqKCybH
 TxiokXp8TZED/5PyLExRjeIHSAKpwnAxlHMREGtvudRexUTOU1mMghDmOA/RP1GfO+Un
 VQvnDIqEctYcBpZRhXOjasGQ8X1QAMn/5TKugUm7AynIxkLfHUcHXHGWb7HuRxQZXKVW
 6XlK4tKpxEkUWQxrKDCxrSop+WvI1mKE9O3kqSCyB1hPT6u9h3dfLZlZ8rkkO/dx0+P9
 D14fV5MAxM0AVA9FYYljKzdspqORnIO0MpEltrMSUNqy/4fcZ7D2uVENuYART4vFkLEy
 C0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751904387; x=1752509187;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nd7VYO8A4+2mfjLIcjiHYVYMYU2NX6MvKOorWXPJdOY=;
 b=moat+5NdEGwilBbsFFr2KDgBA1ZZLU86278U8uy4KpR+deiZMqZxPYozti2Znj4fAE
 Hhk5F4BBJI1OiwRQTuFLdZZRT+d+5kaMmzQQkm85QxzmFdSx1KKhiJNQZwLfNnmvTSvj
 YIhayLUv8cbk294X664TzsRukBfQozcm++CRD2kLHuM66Qmj09t2yMiPSMmWacnONRni
 QW5LxeL38OFWTLG7Mub9liAtBXVKQGlP6JrTl0zd83OcdWkDE+N0iXelUSh5CzZpFX5N
 THZ37F2R2gGn34m1ztLXE9GrBCHEAOryNk/0cnQXTrbvxHFfZA3Y4B8g5FqX0Os3Ncj/
 XfRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS3JmRRzIHro+xY5M9F9mVTMN2DKUrAGiJ7ITiv/ONVdIAcmiHoGyPOa660M4D52krww0=@lists.linux.it
X-Gm-Message-State: AOJu0YyNFp4r9YqkgyHnxCRxFVSc26y/nECjp1bwIkfNVtk9TZeI1BQF
 GLjkhkU5pXbC8TYRL2gLwuUZov+beBNJGm9Ov6SR0146YyfLzSRMJ+NMnHuFaWcA+U0=
X-Gm-Gg: ASbGncuo3lCtZFlkXeGSwJujz3F0eTd/bzZhwzCLCW0y2jiz5faAFBjz345u6RUptga
 vFRbYYhZ+PYQRq6Oy5525fD91RhQ6qeJvh0ECQPHQGYy32svWQdbJN4m1TTec5AnRrfKcIcyAWc
 taWBh5uSQF2JK3qA9xroPDU6WjYOVAj9wYATj1JwGzsA6E7WoP/bDTF4tPxpjpdYC1FIC6EalGH
 UhPuibHdKzxu4NCLfYBzpYyRrnEuuv54H+vj/f78xoIYJ3fkHwh7dsJ14wf40vj69Cego3uSEdY
 5rREMknyGR9lNHsYfQVNqNHjCJ0HRAfxgU+iq8LcmWPe7QO61NJx5fDONwJXeRE56yzqktaDS0w
 08meZt7YK+2XJT38z7V/FABhYO5OBztw=
X-Google-Smtp-Source: AGHT+IFfKfrkGF1MDA8L7U+Pe0eT0Ipfi/K+XsTfOwrnffxCkpXtxSQXU5c9rIFeUSNWJ7YfvG40Lg==
X-Received: by 2002:a05:6402:2794:b0:607:f513:4808 with SMTP id
 4fb4d7f45d1cf-60fd65092bdmr8986979a12.1.1751904387036; 
 Mon, 07 Jul 2025 09:06:27 -0700 (PDT)
Received: from [172.20.10.10] (ip-109-40-178-88.web.vodafone.de.
 [109.40.178.88]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60feab9b483sm4219568a12.22.2025.07.07.09.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 09:06:26 -0700 (PDT)
Message-ID: <f59b8fad-6abb-4199-bbc9-c0f115c45d75@suse.com>
Date: Mon, 7 Jul 2025 18:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
 <aGu-qne-SMpTCEy4@yuki.lan> <7080e0b9-2d4a-41b4-8566-c7afcc694bfe@suse.com>
 <aGvptwZtV26Dj7e_@yuki.lan>
Content-Language: en-US
In-Reply-To: <aGvptwZtV26Dj7e_@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Add ioctl_pidfd02 test
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

On 7/7/25 5:37 PM, Cyril Hrubis wrote:
> Hi!
>>> Looking at the kernel code it looks that if the PIDFD_INFO_EXIT is not
>>> supported we will get ESRCH in the second case. So I suppose that better
>>> fix would be to allow ESRCH in the second case if kernel is older than
>>> 6.15 instead of skipping the whole test.
>> Maybe it makes more sense to check PIDFD_INFO_EXIT is available via
>> configure.ac and eventually check for this support in the setup(). So we
>> avoid weird runtime checks. WDYT?
> And if you think about checking PIDFD_INFO_EXIT in the test setup() that
> may be doable. But there is no need for configure checks in that case,
> we just use PIDFD_INFO_EXIT fallback definition from the lapi headers.
>
> I suppose adding a check for support that would be called if kernel
> version is older than 6.15 would work as well.
>
If PIDFD_INFO_EXIT is defined, then struct pidfd_info.exit_code will be defined. We can verify this via configure.ac.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

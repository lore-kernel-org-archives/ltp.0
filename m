Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFEECEFC25
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728401639; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=vjrLti1Y9ad4q2+HA5b+xRdBIzupOR1fBkYAUuzgDrE=;
 b=b2IAxkoTsVqRcIMO5xmdCP4gUecrgot+rDZSfQWBwdvbLrT+rro9brWuqaB12IDMjG2FK
 OYuRV3fIgCjqxwdIfwVbRYjyNCSZ+kxZBLwax4I7a1Tcmf2kPZ+A8/TgZSzqUEDAAklWPri
 gy2tswNy+xLLlYj101MWD3YH7aQyciE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72E2C3C21FF
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 17:33:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C097E3C0FEA
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:33:39 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3FC81000D5C
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:33:38 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9941a48ac8so418159166b.3
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728401618; x=1729006418; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v6nn9DXauHiYCsmnaytxiPzI9Yl/eiTJQ2fnD93ZKX0=;
 b=MiM+zF9s4RndSaEKNOLp/V3nr2ALa+g6BtLuVWNhLRo4vTf6FIURLxbd8WHWY3qHkY
 K0Ou26G2ocbIzRhUgf9lpRUQJEvVYmaqeCS82gTzVZV1sZbWOQQNTpAEWhdfRl5rkUHw
 mmYpENBlHdYlaFaABRANLt8KinL5C35DRBjzOZsizJPQx9wOoOLenfSAB7fgkIhC54/P
 HlYbGspTj4Tw09pWmUzY+i0WZSWmr7eH0oX4lu9HOMEqcrDOqcXIahbmI+47t77ookj9
 mNxgEg5GH93Cd6jxqQC0RkvB4xf5gw644qnlTpOuQ5hd13enZagNuYLIos5DSC4v4JWL
 63UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728401618; x=1729006418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v6nn9DXauHiYCsmnaytxiPzI9Yl/eiTJQ2fnD93ZKX0=;
 b=RtNB/OTRdlTb2xmubGd86MnoX9tfwPGLcwULZMVUXcRm7XVCadHn05CO0BZ6QvQcxn
 A6eVORMi2t6OKtWVuDzDjfkF9GbTpWNgf1b2Lmszlsnu2D7ohYO8qIyBzM+AGyb67ddF
 V41kRKGfx5oywazsuRWwKqpPn5C6YHpr+C+q+bvsgy9azwNgSBU3VSBfnLK8AcVJThFc
 CHeoUSLpSTLx/Q5/USFsXGRXqQ9opt7LO+VHTTus2Nk4uUUyV7ZTZ2mijwwUsAkmUMPk
 juNuWy1JY7MGfdnZ7oHfgGnXAp6l7Rd3SL/qtI6oa9rroPgBBJAjJ/aq3WNsdqRDpOAV
 Dr+Q==
X-Gm-Message-State: AOJu0YxAPT0Dam9foch0hh0K42OEoY+3LKeHl+IWREt5K6zt2DmchfqD
 2yrJvTPzXDi0GFSSUxLM4ty1nFX+FWVKtsNihnalDYCpc1vXTPiVSHo+BwuJq6mCIlUl6a2K8IY
 v
X-Google-Smtp-Source: AGHT+IHWYJ6fG2IohuqQ3ABDSConR7qmJs37XVc42NXHbSXUcOEKIg5ZCCN0nciuARFiH0O+7wcYOQ==
X-Received: by 2002:a17:907:97d5:b0:a99:3eae:87f3 with SMTP id
 a640c23a62f3a-a993eae8b86mr1186775466b.47.1728401618264; 
 Tue, 08 Oct 2024 08:33:38 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9942ee3dffsm420539066b.80.2024.10.08.08.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 08:33:37 -0700 (PDT)
Message-ID: <781538d9-fa64-4352-af94-6ee0edc7d2c4@suse.com>
Date: Tue, 8 Oct 2024 17:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
 <20241008-listmount_statmount-v5-16-66f4e1a9e7db@suse.com>
 <ZwVJHzkFhggPqrik@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZwVJHzkFhggPqrik@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 16/16] Add listmount04 test
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

Hi,

On 10/8/24 17:00, Cyril Hrubis wrote:
> Hi!
>> +	{
>> +		.req = &request_small,
>> +		.mnt_ids = mnt_ids,
>> +		.nr_mnt_ids = MNT_SIZE,
>> +		.flags = 0,
>> +		.exp_errno = EINVAL,
>> +		.msg = "request has insufficient size",
>> +	},
> It took me a while to realize that this is a request with .size set to
> 0, which is obviously rejected as invalid. Maybe it should be called
> request_zero_size instead.
This is actually a request with a small memory size for mnt_id_req. I 
remove 4 bytes allocation from the struct, so it doesn't make sense 
request_zero_size.
>
> Also there is quite a bit more errors we can trigger, looking at
> statmount kernel syscall we can easily trigger at least:
>
> - param > 0 && param <= MNT_UNIUQE_ID_OFFSET -> EINVAL
> - spare != 0 -> EINVAL
> - nonexisting mnt_ns_id -> ENOENT
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE8C4828F
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707310682; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=72u5zWMr7la8HMtpz/T4KdNVrfNT4OwkYEp+lbDD5F4=;
 b=Y0sX4XzOMq1ZSJPWGa0WaNuXFdylkt/I+dOWSXcsU+sE9lViYC2ZWFM6yXrLiQyiWCngd
 JeeYAtVz6voxh3Qtd0SIp7IAA+CyF3+YTmS8L4j0JixZjdbRO+qKObI/k30SPXDz3iHA1iU
 CsK4s+c+u8IJM+vKrcMlQVy6N2V1SR8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 156403CF5A2
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 13:58:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A9C83C5AC4
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 13:57:39 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C121814044C4
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 13:57:38 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4101eb5a115so1624465e9.1
 for <ltp@lists.linux.it>; Wed, 07 Feb 2024 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707310658; x=1707915458; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWm8j8grqIWfvWt0gQL4z3/GZxu5cvqZwVIjvfcts6I=;
 b=AfN2QoQnvWLK5trlIAk+lLLa29cBtvWnthtIV8Psu4MNCx5/KRLHt/mbEyOo0HNd/+
 /3FLS1zg4pmC7WLP9tWv5E3RA95zujI9MD8DqDhX1A5HF+Tqbz4ckROrwoywj8QSyNcQ
 F5B+AkV8AgevrlerD6ZN1JfJrzSzXg7Y2Nl34alDB+XjEvdVRV4SmUKQq9SVoF2GxfKe
 m8Byx7o6T9qpfW8m/t+Tg3tZZHXcX4ydQ1JBL0hKyPl3W5BYZIlVObE7f2uBoYHwY3hm
 FtRfpG26fzeJOVRRsthV3Lq/ARqiS5YlSb2peEiODqGf3+l8WPPz4GXqAPHxvgRBruaD
 n/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707310658; x=1707915458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWm8j8grqIWfvWt0gQL4z3/GZxu5cvqZwVIjvfcts6I=;
 b=l9NLgznB8HDX73lt4Dri2uDzizY3VUff/N5ysDzpmf/WmMxpqz88LYCGMToRfZELzo
 TAh1B6YeSut0q0KiBqMwtSouzJZ4F4Iwjp1g2n+nGGq373B2r04jQZG8KQMijviXYgp8
 V8v+KB5IeJtJkd97Od+Ojkc+K5gDd28612lNZWdg3icWAzjI6TOHihI54MLX8QYmEsOj
 eU9zWhP3G4PfNxLUcLmttmc+skm52LpwOhoi1cHuJ8eFFDJSiC2qDw/Ag3BjCnjwzTZw
 Ud3Si5JUCPP+BNyj6p8pNq/5iwKdQ3/WeR685oBA0opZNllS88G3znkKPtua7Ey+gmaA
 CRog==
X-Gm-Message-State: AOJu0Yx0t2t2l2IVWvF+esZFYFyW1JpsP/6XJ3z6VVvq2emO6bS7BCVc
 ifW/ALswmR+Dr6KMw44DDquEObRrDfrlwCK3KQ0WBE7J+imGi4Cbd3RvtJS9aEs=
X-Google-Smtp-Source: AGHT+IFAHxg/bw0ot5+VMeJPcSKwPVVBYXYLsGU/ahuUbqbN/Z4U1BNd7elps80d5vtwtlkkWPD8og==
X-Received: by 2002:a5d:42cc:0:b0:33b:2fba:1ea8 with SMTP id
 t12-20020a5d42cc000000b0033b2fba1ea8mr3280974wrr.52.1707310658095; 
 Wed, 07 Feb 2024 04:57:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4opTjp3tVmlviIIi0kLfIpgXYrQbKY/1ncM4KBIIyDXhKxT2U1OAxV01XCEW5860DFLh03l6NdtFLahQPoGeWe7I861mf2is=
Received: from [10.232.133.56] ([88.128.88.93])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a5d468a000000b0033b44b4da56sm1448871wrq.111.2024.02.07.04.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 04:57:37 -0800 (PST)
Message-ID: <271d0a7e-e61b-42f9-9276-96f3b5b6b17b@suse.com>
Date: Wed, 7 Feb 2024 13:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240118153514.2436-1-andrea.cervesato@suse.de>
 <Zb0iHOdsiarQykNS@yuki>
In-Reply-To: <Zb0iHOdsiarQykNS@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add mkdir10 test
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

On 2/2/24 18:10, Cyril Hrubis wrote:
> Hi!
>> +static void run(void)
>> +{
>> +	char *symname = "my_symlink0";
>> +
>> +	SAFE_SYMLINK(tst_get_tmpdir(), symname);
>> +	TST_EXP_FAIL(mkdir(symname, 0777), EEXIST);
> This can be easily added into mkdir03.c as well as a few more different
> cases (we can't overwrite named pipe, directory, device node, etc.) if
> we wanted to.
>
I would prefer to keep mkdir10 and add more cases rather than 
complicating mkdir01 that seems more focusing on checking multiple errors.

Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C619AE6B27C
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730467447; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ajJUipK5U9JzKEPTZvjAoB6KwRgMgXKxxhYwVtwMnTg=;
 b=TgVrAE4WU2md/Z1bnxrFyRD7UJzYVjN6SkE8eRpwD0QdLysl0BDO1HCScmoWPEkGAE8L0
 EHuUDC5ZE2mSXNzpUhdyRyfLMHahX0NcLz7m1VqhYaXd4wD/X+AwWW/O40e4OEOKBL+tPeK
 4tVWS7/qBHozXadoVzo/5KSZMFlR7Wg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00DBE3CD58E
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:24:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4913A3CD537
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:23:46 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9C36B1BBE288
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:23:44 +0100 (CET)
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so1375571f8f.3
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730467424; x=1731072224; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T95iX734L6OyFnhZNJZESRjQ3N8Ti1zfJwYEr6PphgM=;
 b=f6/rVin2yDZFZ7wmTeYfkeBCs0FYhrlzprV5r59VB43Qwlc/ypwXooIHEj9F61r+Rr
 Pd022BExPG3bBurJOo9vq+M5DWao/xv6Rl06dHnwDKOoaFumOQidkWpFblK0D9Gd9689
 u5DkhXfM7KGwRIa9DnHUDzgQS0Qulu4DNTA5BBYZuXjPquauk4YV7qj14lkgcg7Kl987
 wqgXW75o2YxfCqWknVV484rLgBNcubqaDnOmRNA6UzFQlMAmFM45p0znO5Klf/hkfbei
 2p2eXUhda1D3hGsXq9My6g8EPoIy9mYJYmY0kre46MKN4G2q645tk0j9AKduuntfkxo2
 MgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730467424; x=1731072224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T95iX734L6OyFnhZNJZESRjQ3N8Ti1zfJwYEr6PphgM=;
 b=UdXxfmw1nAAWKe/XdhLdIhWnxYEqw/kCFgZMoimELCQ5xeLyibJfVQqHEm/4WSGK1w
 nPIYKz+8kJaQYf7ep9JvSCJBGM4bKt6rDDXv/1F05rdpXWH0/O2M0Fj6m5jrMrJXD6Hs
 1sPtA6jphvzGmrvyJuP4Z/p0CzxEoZn36wQShOAYLombTXgCGjTfqiLvb7ajkpfWRZvD
 yFetiZ0PD9Z5mtrdmV0CB8rPhzJ8F+CVefuaaDiyFII58B/wtPLKTX0uC1fng7EwPFTD
 7N2ccSG+YF7KNiBiK9E9Q5Y2wGXVtpH2qVkZh0gR7U92x3kwAQfjrgfGxqj1ncm+lIxa
 HdNA==
X-Gm-Message-State: AOJu0YzvRa8ZVlv0975xBvqze1bRD/clKr7BMyrEcPidtNgJrZ0JFHWF
 qAmYgIe/5I/6YyTl+sGsVPLzXbZT7gGJmfz1BpxbmYtNKgN9hMknF8Kqft+IpbY=
X-Google-Smtp-Source: AGHT+IE8QkpvlMviZCeo/VAs9wZ2+SaogrVO91ziknSBkBS98+32hxPIvpGFpQpETbTm7l3vvCGh4Q==
X-Received: by 2002:a5d:47a7:0:b0:37e:d965:4e1e with SMTP id
 ffacd0b85a97d-381bea1c0a8mr5401101f8f.42.1730467424276; 
 Fri, 01 Nov 2024 06:23:44 -0700 (PDT)
Received: from [172.20.10.2] ([37.162.215.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c1esm5159402f8f.12.2024.11.01.06.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 06:23:43 -0700 (PDT)
Message-ID: <d6bf0ba3-92eb-476e-8c6d-b6fcec1c258c@suse.com>
Date: Fri, 1 Nov 2024 14:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
 <20241101-generate_syscalls-v9-2-d2c3820b0323@suse.com>
 <20241101113019.GA1264676@pevik>
Content-Language: en-US
In-Reply-To: <20241101113019.GA1264676@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 2/5] Add script to generate arch(s) dependant
 syscalls
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

On 11/1/24 12:30, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +		for syscall in $(cat ${TEMP}/syscall-names.txt); do
>> +			printf "
>> +		#ifdef __NR_$syscall
>> +			printf(\"$syscall %%d"
>> +			# i know the following print is ugly, but dash and bash
>> +			# treat double quoted strings in a different way and we
>> +			# really need to inject '\n' character in the C code
>> +			# rather than carriage return
>> +			printf '\\n'
>> +			printf "\", __NR_$syscall);
> How about using heredocs? IMHO more compatible way of echo/printf "" for new
> lines:
> cat << EOF
> ...
> EOF
>
> I should have noted that at previous version.
> Hint: looking into tst_test.sh can sometimes help.
>
> Also there is echo/printf '' variant:
> cat << 'EOF'
> EOF
> https://unix.stackexchange.com/questions/462593/how-to-escape-a-character-in-a-heredoc-bash-script/462595#462595
>
> There is also ~EOF - ignore leading whitespace, even for terminating EOF.
>
> Kind regards,
> Petr

This method is so ugly: basically the ending EOF must be in the first 
column of the next line, otherwise it won't be parsed. And this breaks 
readability of course (probably some debugging). I really would avoid 
this way..

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

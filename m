Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093ABC021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740126136; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=MgfdgD2ojLecaowYAdzhioAD3orHF0mMN6OOIbCMVLM=;
 b=pCHs0fL/yAmEJeGtmU+051q1zbm4uIpM/DIi9iFlX86aGzEJmnE/M/rFl9R1RVO/2+IW3
 6Du4WU26Wbwe13ziVCc2E7JoLoTvMR07nW9K2SywLBi8O31gXAMdGjEadWYLaPxBiYl7EPC
 q6lOfxmHM6hKlbDyvNbQGKq/IsaIYZQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27B123C7CE8
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 09:22:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40BF43C239D
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:21:53 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 021DD1A001B7
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:21:51 +0100 (CET)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30795988ebeso17659441fa.3
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 00:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740126111; x=1740730911; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbyONCRQU/F0Omrhm6Ut68r9KC0Hj7aK1qbTlP08kFU=;
 b=TCkw9CpEZVEKT2Fzp8HU9HwwCz6Uo5hXjulHxhk96F4sGT05Ou4PqL01A6dwgiDWL8
 WPbuTMfeckN6VIcKO0u4w/yB5ugeEpTqASaexmZ4fKFNR3Qn1ZbDjxZvR8dgXkFpBBWq
 6XTjkW4a4C94+yNNZ3f3UImXqbvmBR60tcUNvllRWuj6LruncPhJT20quvTQKrE8jaVz
 egtXfm12ltLHjLKEOk2wCk6FyD1fFqyllyGQxTZwQYOPc33okgaEEo+ufusN46nVpjYP
 RZFc1tjHuiAK4NjGqDwNlCZsspSQQkvZMFqRVy6yX/BJt/OjtEq97J7A9mcV4PvdsOdN
 OA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740126111; x=1740730911;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dbyONCRQU/F0Omrhm6Ut68r9KC0Hj7aK1qbTlP08kFU=;
 b=AKFvCPLF74S/w2bHUTpRHMyf/CDQp2UwBa9Xv8WxggNVS1fiTQ2jsXOsoeqag6oAca
 weInRrBqqhqPNOxAckGMg4A54MTFIXT3fkguWAmNY2SuiJOxGFBM7vYgsLPd6k58A7R/
 qGhSD+IkbV//QNGzpPmf/Ey6h6iNCbLrquF9vAuIQBW24xsuyZ35ct8cTOzBb1xMCYff
 4nApwQ+GSibeHjsjiTk8+K1po47fcJJgooJ3YypkGji+8MmuyclAtEhab1EeGflCWJMl
 TznV38VfZrwS4vQjr960ayba2NvEfNhM83ZdSirAJVNkjvibdibc76Yf5TSo+2nt7Fv7
 NmNA==
X-Gm-Message-State: AOJu0Yy4oOh4/d6Wf8GZnKDQ/Zc7saZH1GgHX/9kz0CJK0Ote4HizRrL
 VxXruLB4cdTc1Umr7pp9Q32D+o1wzGMeoMbpK8y4GN7u7l4/yinxyLFN72WYWOc=
X-Gm-Gg: ASbGnct7haf7+sPEq1safmgI5q2q4oGDJ4L4hcaYzSm5QJUw3abCRIfQeGI2OEROzTt
 rbO+MR4d4woHIKXbK39dtLMr0b3Zxu+JovcimmLMtaGYNKnHxbqnZzbrZaZ9MHP5xmCYKYRZOwk
 18o+loqlUVKnNmYQwQdYthjpcYAstaIzEslrZPLMx6Q5Q8OHVTHamsNqThB/c4/5y6qTXhIGIpA
 Eo/ISHB8mOzCSmwIilD+mYMN+XXVik8ewU2WDCUCtlYBSH0v545cUH8JcSX2XIf20wBK6crp+3n
 IbbPrL9Cgyw337gNJebFuFu+YEgJSxL3TKjb9a6dtE86I8b4TBfuEhL3RwyVcyrzId/zaDJNyqb
 UOrk7cgNM
X-Google-Smtp-Source: AGHT+IGZ6QcFUxPVPmcX45RDhAkfHTuxHmVZeIAiuWcyxiwV3JNNX5bfTHnrBZxy8+KMg1IiAfwa1Q==
X-Received: by 2002:a2e:b614:0:b0:308:f84b:6b34 with SMTP id
 38308e7fff4ca-30a5990b2ebmr6960681fa.20.1740126110921; 
 Fri, 21 Feb 2025 00:21:50 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30928c24a47sm21114061fa.93.2025.02.21.00.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 00:21:50 -0800 (PST)
Message-ID: <8240dcd3-fc9f-4c52-bf16-8c7a940cb470@suse.com>
Date: Fri, 21 Feb 2025 09:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250219160143.2589026-1-pvorel@suse.cz>
 <f2a0be74-94c4-480f-b53c-7ba4673014f1@suse.com>
 <20250220230000.GB2726725@pevik>
Content-Language: en-US
In-Reply-To: <20250220230000.GB2726725@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] doc: Link struct tst_test and tst_tag
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

Hi Petr,

On 2/21/25 00:00, Petr Vorel wrote:
> I was although thinking about it, but haven't checked the code. I suppose you'll
> be much faster than me with this as you're more familiar with sphinx. I gave up
> because reader is nearly at the correct location.
>
> I suppose missing code needs to be done in linuxdoc.rstKernelDoc extension.
> Because although it's possible to link to the member in linuxdoc.rstKernelDoc
> (e.g. &tst_test.needs_root), but it leads to "struct tst_test" [1] definition,
> which has only anchors for Definitions [2] and Members [3]. I guess it's somehow
> possible to link it via C domain [4], but it's not used in linuxdoc.rstKernelDoc
> extension.
>
> I tried linuxdoc [5] update to the latest 20240924 (not much changes anyway),
> but members still do not have id sections.
>
> Kind regards,
> Petr
>
> [1]https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#struct-tst-test
> [2]https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-definition
> [3]https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-members
> [4]https://www.sphinx-doc.org/en/master/usage/domains/c.html#role-c-var
> [5]https://github.com/return42/linuxdoc.git
>
>> Andrea

Thanks for the references, I took a look at it. It doesn't seem to be 
supported unless we change the code base of kerneldoc. I don't know if 
the effort is worth the result honestly. And the reference to tst_test 
for each struct attribute is a bit an overkill.

Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

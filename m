Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31FC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738852998; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=r/sLFSrGNk2CBkn1c7rcp8ywxjmKc6CfCvSb+ZcxasE=;
 b=Tb/3sAWQKlwHw4Ls+7Qc2L99iW9EDLiwM7N32NKBPD9rCOhFGntRf/PEzJi7LMsSthA0k
 aJvHtxfdRau45Lo41z1FYtyYx1IwbWvVgZrDrDbBMbVCiiVS0pyALMEpxMJlpWnzHv72Z7G
 oKOzJNsKnDT5EdI2ggCU1qv4XXYGjdk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68F533C9292
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:43:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 638C43C01B2
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:42:56 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EFB792275E7
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:42:55 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5dce090bbe5so2367203a12.0
 for <ltp@lists.linux.it>; Thu, 06 Feb 2025 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738852975; x=1739457775; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPzkqoScECM2kPAP/uaTHmf3ZMeP4clnAXVqUg7tJnE=;
 b=ab6WuuyZJh5Q/XMu+OERf8Rgk1UNliQETBgb96USxbC4igN3C808OazEQTytSypsC6
 vakqfHnMKaSnE9cpyOrF92AmfMdul6uXcPUdOYDT98HZSQz8LEI72rHjmZC/JMD6NETM
 cSiIJH4GXJyZb117XBs7CGu8R2bzizn8RVxZ09RzJyNxLGHzGPT8PSgwYi1fdZuAtw2G
 fZDbcPjWbnTIVV+mqOvmNDQfJZKd4Jmz6wRaQPhe34r1l1wZLBvNHYYdWE9pBZbTf96W
 1bLy0HcZ4XmiDo3skzslx9Y9GcJMAQoBggYpDzqos5/C+0jm4MjEw4LF8OIsWAnkvTa5
 b2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738852975; x=1739457775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPzkqoScECM2kPAP/uaTHmf3ZMeP4clnAXVqUg7tJnE=;
 b=Hb8jrEFQVe9s4Tps4xgksLahOHZc2PHZP08LJ/vbnmr8+W1V47YneMnfn5VNuL49N+
 TVuYM6QO22eYaGzYkFvQL/GhUfwu9+e+kAns4a5uzavPIkkeE3Pe29q+UFe6BpYaVf7b
 HszFn1KoMcECKBzia0Z8x9bBw4FZvg7+iWRrGjMifk6PWnmc1DA1UG6KNv/9ZaRoqSLp
 CB8TTL8OKaBLlf+6qeoSLhNWXiMqJvogK7CtJVg2oUaKQ9ykPi3isSgEK+grL4W8DlhT
 yBT8H+65FaU9Pi8oeQ6QfiJKUhyRf9qn/knBWNPAXynaJAcG1d1fCqyEwMJr7blTAZDM
 j49w==
X-Gm-Message-State: AOJu0YwqRUwXcAX5PkzO/IZHJflqGjvTMUefSc1TBz8a8OHgKEjfGl0y
 +OWWli4nt6uvvIJ6wtJ3tR7FfP03UzwfZeH3mYiC1p75ortHmm2cVkZJ8SQY62c=
X-Gm-Gg: ASbGncvZCMqxBAB4Vxb8sWW8V2OHZegaLw6SXq4K1URap+9t5qCruzmgN9xRaScP1aX
 hoiBuucWyHkmK0XtS/wSFzoK3qh50E0yJAyRAHkOwWvZcRhFzWX1Y/ixhaZREBk1d8VQLA2mQDm
 4p/95K+ZvsaQ1kcgAaxOnYPEKlGmPkKrnAEBS1uiU25haPAxD5W2Os/ac//h8YZWfkP9k+9mqfc
 IRA8Sr1OvS77ThTGJsEIZPl0lsWxWcHWN6yb0yHJNuBxLNPskLfFt5wX3HKnsqc7w1revp8uKiD
 ZA1rBIaTC/+zp8AhHGEMe5UKJ4T4aQQcMCUFpMKyMIOSCxntPMbX+Mgjp0oOCrtxYQlVI0R+7Pq
 csdTblBc3ISzH/bnDg82+kxzRqQ25hE3MpKoUOqg9LOANj90PutM=
X-Google-Smtp-Source: AGHT+IECPri8NS7uVlRtjUHXuLybzNSE4RVKhmneBrWe2O+kmoKsTGqtvd1mw7dEg4XkxPiuwr3yLA==
X-Received: by 2002:a05:6402:40cd:b0:5d0:e570:508d with SMTP id
 4fb4d7f45d1cf-5dcdb72e3fbmr8827947a12.17.1738852975346; 
 Thu, 06 Feb 2025 06:42:55 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7b0a2sm957032a12.22.2025.02.06.06.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 06:42:55 -0800 (PST)
Message-ID: <1bb1f143-4ce5-4451-9da9-7176dd8fd0f4@suse.com>
Date: Thu, 6 Feb 2025 15:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250206-doc_tests_list-v5-0-52110e1421a9@suse.com>
 <20250206-doc_tests_list-v5-2-52110e1421a9@suse.com>
 <20250206142656.GB1566904@pevik>
Content-Language: en-US
In-Reply-To: <20250206142656.GB1566904@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] doc: add tests catalog page
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

On 2/6/25 15:26, Petr Vorel wrote:
> Hi Andrea,
>
> Acked-by: Petr Vorel<pvorel@suse.cz>
>
> Thanks for extra comments to _generate_setup_table().
>
> There is quite a lot of warnings. I'm not suggesting we should fix them (I don't
> want to block this, let's merge it today), but more warnings and errors we get
> the worse is to find a real problem which might appear in the future.
>
> I might take time in the future to fix them - some of them could be easily
> fixed and some of the warning means part of the description got lost, e.g.
> "1. First test case" and "2. Second test case" in mountns0[1-3].c is not
> followed by the actual description "X: bind mounts DIR_B to DIR_A", indent is
> also wrong. This means sphinx syntax (reST) is not 100% compatible to
> asciidoc{,tor} syntax. Syntax problems are also visible in Vim with highlighting
> on.
The warnings are all related to the asciidoc format which needs to be 
converted into RST.
The meaning of these patches was also to introduce this change.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B409D767D9
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730386395; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=h0Ikl5QPd3UG/27jxd9jQTO9A4QHiSo0CM70RQs4lgM=;
 b=jmK5cMEf0imePwc1rsybKgNvXpT2txViifL5/CEW+8YrEkfIXbgqf+qeVVexiEgMADRe/
 SBo8S4keIVvz+BVtijD6PAp1RBHvlqutmYrzQA3Tl4S0hi0EwuoH/Zrte2LXytiRXJmQB2f
 UF4KDcSdjbzkpS6lyflCMJFW9NlVxlY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AEBD3CC204
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 15:53:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9AD93CC152
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 15:52:55 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E6DFD61E717
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 15:52:54 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so9182335e9.1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730386374; x=1730991174; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=we1ZuspVj5tK3id2z+KKoa39SGdEfWyjWQTRZ9KPpAc=;
 b=KVDrEP+RnhxuT3yQ6QwcZAcLwM27NG+2ZGO7IfBJMuerwOhjHufWe092x49trlBRvP
 rLlit78lqJarXNnjOrZ7wMn4+Q9ITJKF6NYZ6Ael6493dWPpujAFfoxsUAJEgLgjWrvG
 Xp4RAaNG4NW2tX3H23XTcmbA9UcPZ+LJ120IAKZJnBTkLfIfKv7vy1b/I+mW3x29kCQq
 dU1tco/eBgbvu+RdlsYmrTlYxYv3ncYuL/kdoWzMVBPYxv9oW8JcVAOD3qBGcIp71lZp
 /G2182OVJZ4z43tyFz6OphsUtV4FQsyq2H2juB/pTxXIRdnIDzdkTspLzSDtCZjsY2/2
 oyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730386374; x=1730991174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=we1ZuspVj5tK3id2z+KKoa39SGdEfWyjWQTRZ9KPpAc=;
 b=Mwuu1uWFp+qrwZ9TGQPISlo5+OWoGksghU9amfm57uiji6648jGCbn0LiddZSe6cvv
 S/jXiG2A5LA4IjjXTge7Zd/pySeCDQBZ+racQ6sOrVqGtURIOmNYXdAWmF4AMt24nbXe
 G3i5YnQ3lHNqQ6DXIfvI9nlq3EIyoZbLfwv0kBIXldzpedlKM88rS32hmPB0K20VJHOm
 NLJ0/6/R24AuXD/yHlzZKzO4SP8OPsDMxnq6afaFwEIqB0qi0jDPKEmz9iJsdURl+a05
 FvYMvFTzg7TbFCqCh+t9V58P4ZmoQRInUgQmEx7jqcaeA+lPtvDXPsMOMmbM2J8E9UnU
 bJPQ==
X-Gm-Message-State: AOJu0YygUQfTvNij0tVcy7z40arNFrVqMevS1BwhDvrw4HF4hn8N0A5x
 lfUhmocFZtnb8OyyX9ZsESYyUGm6hmqTdJFMmZFngnTy4EkKeSzCuylQrh6Upm0=
X-Google-Smtp-Source: AGHT+IGPennvMYeoVXx6zl0tHDU+ON9TDdBs0Ztl7jehquRUHJfmEvMhchqmGtI/gUzVoJ5DfXUiHg==
X-Received: by 2002:a5d:64a1:0:b0:37c:d23f:e464 with SMTP id
 ffacd0b85a97d-381bea1c163mr3214647f8f.38.1730386374291; 
 Thu, 31 Oct 2024 07:52:54 -0700 (PDT)
Received: from ?IPV6:2a00:20:6047:3333:1b05:5290:eb22:1d88?
 ([2a00:20:6047:3333:1b05:5290:eb22:1d88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ac37csm29120635e9.10.2024.10.31.07.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 07:52:53 -0700 (PDT)
Message-ID: <bf896dde-ba72-4db3-8355-92e600f1dd43@suse.com>
Date: Thu, 31 Oct 2024 15:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
 <20241031-generate_syscalls-v7-2-f3e26c06814e@suse.com>
 <20241031135814.GB1049242@pevik>
Content-Language: en-US
In-Reply-To: <20241031135814.GB1049242@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] Add script to generate arch(s) dependant
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

The kernel doesn't need to be compiled. That's done by the script via 
`make headers` command. I don't know why that is happening honestly.

On 10/31/24 14:58, Petr Vorel wrote:
> That fails in generate_table on:
> if [ $bits == 32 ]; then

That's because the right syntax should be (for bash):

if [[ "$bits" == "32" ]]; then

But in other shells sh compatible, probably I should use:

if [ "$bits" -eq "32" ]; then


I'm gonna fix this.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

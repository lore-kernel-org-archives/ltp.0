Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15EC25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717573084; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=mrtueenipQ9pNyKW2iJY3KCfnEXX0zG//jqHFNSzTMY=;
 b=Qde4UAXsr/bu7aRXNr6AphK4QFW7ludjEe80SuqdDqdFlBM3GjgcT+RPSKjmWP7ikcGeO
 C097kXJSu6teQUOKrwx95XDV6LjUI7PicscplrmKwPEgoU3nS5dZNnt3jLIosaWgJnfR+JW
 3HriE5WNlz1BB2ym1TMHJy4ivrgYPLo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4683D0978
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 09:38:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86CBA3D094E
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 09:37:41 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8418260142A
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 09:37:40 +0200 (CEST)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e73359b979so63894871fa.1
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717573060; x=1718177860; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R8Se602QiX2MwQ3U4/6/TYErGourASOV+QmIqxHuKmE=;
 b=NHfrQWk/2DTEIUfGyvS9ISLyc84o0jrTJv/P+qNDbFtIgja1deoDYiri+8CN1gacFa
 DQsmLofIEub9Zq6lrA7N/eBgs+bJn5cVr+K9GcmREwEJvRHfuRDHRIctn3fKfned3uE3
 vcO7X2bKtZQ+ircKa7PPcaSrW0NIy5XwYP/5h1i8r5HjPOUwy8bFhUdoXSGGFuy98Oyl
 rYGjh0sDCQh9K4sKqQz15W+CCPgzn7qGGndY8lUKTDOyemRORXzlHKBfpRykfCKdyRoT
 8OCnLYO+i1aCkKUy3cF5MBnUkWzF87cHnO+2TXeynNcIPtw5HWGz4xRSvMl2dmqnYXQz
 /63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717573060; x=1718177860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R8Se602QiX2MwQ3U4/6/TYErGourASOV+QmIqxHuKmE=;
 b=adXlG/QN5gnNZm/B3yUOzcj339kbWfP4GoSxo7/g4nku5xtogweL8rEg1zxvq3kuQv
 qHgHMt3Bop2cUhCUrK6D8JX3qutVaChIq+bCNQ87oPGzYL0pvHtR3CmRskG3pTILOFrG
 D5j99Vqpn1RZ3Br+YTkKxuG+n/vKSazKdPSe77T73fjV93bsvHlu8inoAaTFbQS8HGKW
 5QIg18k4OFw3iJOCpRk0TIk1YZtMMrCh8wujjSTOZZ6tdg7+G+yND+NV00u8qY8BDh+J
 RJroI9iCS28IxTn8utvsUhXlW68LjuvUd92NQzdTHFc61neiWxvlRvVKiEtrxbYl0CI4
 6AjQ==
X-Gm-Message-State: AOJu0YzbTXBHYdhkt6XWd32kKZb5gq1S/IlgkoKTZqVDdKsnc7lwJ53V
 6FKSV4XtPbyJMpHi3tZocEDrwt5C93pz4Pz8LF6l9WFR0LJOdb9eIMpkd5syzRs=
X-Google-Smtp-Source: AGHT+IGr4vF24g/5DmgP8EZ0QEPPfsesiOhFyrmZB3SPJYcMaQgLNsv+2oxPcSAho7OX94w7g8/Lqg==
X-Received: by 2002:a2e:a60b:0:b0:2e9:5263:36e9 with SMTP id
 38308e7fff4ca-2eac7a6ffb9mr7888871fa.43.1717573059698; 
 Wed, 05 Jun 2024 00:37:39 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.36.118])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632338c14sm96117685ad.36.2024.06.05.00.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:37:39 -0700 (PDT)
Message-ID: <5d94c7a0-c972-4342-b5d1-06f1cfa2f121@suse.com>
Date: Wed, 5 Jun 2024 09:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Avinesh Kumar <akumar@suse.de>
References: <CAJCsO8fTwOsVwhCdBksStaPVjXHBi8m3g+_b-ZAnKByUR3cqyA@mail.gmail.com>
 <20240603124653.31967-1-akumar@suse.de> <20240605071101.GC348321@pevik>
Content-Language: en-US
In-Reply-To: <20240605071101.GC348321@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unlink09: Fix open syscall flags
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
Cc: sebastian.chlad@suse.com, schlad@suse.de, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Unfortunately this patch is not working, due to the fact test requires 
to check if filesystem supports inode attributes.
OPEN_CREAT() is more appropriate in this case and please refer to the 
following patch instead, since it's fixing the issue:

https://patchwork.ozlabs.org/project/ltp/patch/20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com/

Andrea

On 6/5/24 09:11, Petr Vorel wrote:
> Hi all,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> I suppose with this fix Andrea's extra check is not needed, right?
> But sure, it would not harm anyway.
>
> It'd be still interesting to know what exactly triggered the problem.
>
> https://patchwork.ozlabs.org/project/ltp/patch/20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com/
>
> Kind regards,
> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

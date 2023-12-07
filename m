Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03856C46CA0
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:34:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09BBE3CF04B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 13:34:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEF773CBB62
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:34:34 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 285671000947
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:34:34 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54c67b0da54so1191392a12.0
 for <ltp@lists.linux.it>; Thu, 07 Dec 2023 04:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1701952473; x=1702557273; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CjAWRxEhIzVSsWU03El4zUtSWXwfWzgmn8Tjqbs/zYY=;
 b=UBNoqOBbgicIDgjHnnqX0yqUBLFXrojKOEmBodw9LWIBtPVPvUE1eNgz8X49hT4oo1
 I5o53ELLlDERmpBnfGgm3ZObPJPJWF2xVJ2NAsns0VjypVI5LveFF0NY4xRcrUZ40RUE
 G7Md95ghEKmsCMqiTdQHiHt4p/U1ExiGFvQ/nlUeyyWRdFRSbVqtSFaiFsoVj0G9guXx
 4T9d/leFq+qweeRuQdrH+EaCJjc83sw1TEYvEyghJulACex6o+ILv8vzkgaRB/QID8Uw
 0VXFQBPdnshBR7amCKGk1iRwoHyhpJI7bVhSp2KbuzB2+HmTTPYvJzXeAc4ZW7Ot6BIs
 m8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701952473; x=1702557273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CjAWRxEhIzVSsWU03El4zUtSWXwfWzgmn8Tjqbs/zYY=;
 b=tpaF3Oe2Yzn8+9YVjvMyoqX5OvEaDIUUYPzMNskaw0AO3JUv79WT99Yb0fdybltxbh
 sBlJJRPW8E9ugiJMWykfTEFwhCbpSYzJFcBae0qiTW5ZHKckm459QZZPsQAyp/cm3MqF
 7IKOc7Cuxw/28r/TEhmx6sliPiNYPHrjgpOLVCzNL9zcia9icv6o9MGLLNYBn8skRI33
 fdoIMITplZrEXwG3daIaaVqVzayIzQteUEMCK9RWnYSga93fO8RdLAq+YTp2V5OJrGmq
 t93h202AmvarCst2e3DRIayDnubSkgihfFNCQYnzwQ6BNdHoFwjQc9yLA2yK+KEavWlf
 GOaw==
X-Gm-Message-State: AOJu0YzLax8eC2jNHLF9IIoOf/pul21e0RPmwCpOyDkb9xP+RZXNfVc/
 a+E0pCNrLs9GHoSKgd3K5kss8CKqIlggyuzvQyZ/cA==
X-Google-Smtp-Source: AGHT+IHmpqoumuedp+c9/6E1wcvanaB423uasM8m/HzZec3H53kAUL9Aw5KBAD3f3ICiwK+ryR7UPw==
X-Received: by 2002:a17:906:7488:b0:a1e:4f60:c413 with SMTP id
 e8-20020a170906748800b00a1e4f60c413mr1051697ejl.95.1701952473637; 
 Thu, 07 Dec 2023 04:34:33 -0800 (PST)
Received: from [10.232.133.55] ([88.128.88.38])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a17090646cb00b00a1c6e3e454fsm762784ejs.166.2023.12.07.04.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 04:34:33 -0800 (PST)
Message-ID: <72e80847-aa5d-4180-8f55-fa2fd06aeec7@suse.com>
Date: Thu, 7 Dec 2023 13:34:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20231207111223.234170-1-pvorel@suse.cz>
 <20231207111844.GA234785@pevik> <ZXGrB76MCu0-0K0y@yuki>
 <aecb0e4c-9042-463d-9888-7f4508e277fb@suse.com> <ZXG5x8R56fISvCLW@rei>
 <164f3362-ef24-4bc8-a27e-56d28ecdb60e@suse.com> <ZXG7d_ImcsTa_a0_@rei>
In-Reply-To: <ZXG7d_ImcsTa_a0_@rei>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsx-linux: Reduce log output
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

On 12/7/23 13:32, Cyril Hrubis wrote:
> Hi!
>> What about mixing TVERB flag with the others ? Something like "TINFO |
>> TVERB"
> That's too much typing to be honest. Maybe TVINFO?
>
"TINFO | TVERB" makes somehow sense, since we can have it for other 
flags as well.
And we have the same for TERRNO

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

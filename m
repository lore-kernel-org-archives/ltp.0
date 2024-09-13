Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FECAFA372E
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726216529; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=BAwu/PwZd2ADrv6mbDQldHMviuoVyUNCFT4fg1WquY0=;
 b=UevuwjR0FkfuwqQdy4z08K5dAPVfIa2iywnfWUqBMUNHbooxoKXAR1KT8zbxxp8gvQ7Sd
 2rOyj+OHoKmUAQ6y3+nYova3sevIBsCT4z6kAy2mWOCAmQjX8F1ciodigUA0b6vASLkrJ78
 YlScR627KP6DtZbyBebMEml56K/VlQc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFECC3C2798
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 10:35:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC373C1327
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 10:35:08 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 684CB20D1A0
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 10:35:08 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a7596b7dfso278806066b.0
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726216508; x=1726821308; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=96K6lEDwvg34d/9eCX3QXgfM02x7mu7cCW+YnCE5yMU=;
 b=gipor8a772hwsRjYoxtvxf63/h8NoXqIXPo3puMJaNVhVW0+x2L+7e+m0ugX7UKrbH
 9O8H3kc4wu52LtVclz9BRC2mctqo+nG9bOlQu7vXSdfghF4YI+wmJOt8EWD+9iStPTNN
 JKOuwZFK1HblaCt+Pf15BwiACbcI+1VBph/KVM80/CMIZ+RDzX3LAjgQIn6UfAqBR8/O
 /aFJmj5uI3rwPDr2FYmEYtEL4uCs+WlHel9Tlj/5Oer0Fliq/ceR88DpND6F78MlAz3U
 g/eAugFTvcfTAazPtQxBbHrVlXsjb2zEg2raUJ+UyF3hyCItm4FPwLqcSGSeK2Zttru2
 pZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726216508; x=1726821308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=96K6lEDwvg34d/9eCX3QXgfM02x7mu7cCW+YnCE5yMU=;
 b=tu9Am+mqUBsTVeNs94fO6kKa7grWQTfLgpLkJqnsB81RKvAb40RS/cgUUJy+E51CTx
 2tMigYr+DsBXaH+xyp6J+Hfke59k5zTl6ZG92T9Vuo97Zhlj8Yw7d7h+TkCcZncRis7P
 qw2+VgiXPC7ACfJpreJCg4esV+vypGw7WhWqzr17R4plxjKL5gSPpyqAPnysWmUkj2vJ
 h/vt1VcXXYufG3LP3lZd5fgH76O6ez9CQt2WNi/D/KQdUa129uTWFjLRzTCNoDlEEvs7
 JeUdRhIXcrDPoKoycrIrYZzTPXm4wm+Yi17g6bbjQBeapyFKtFoVWroKmebJ7OX8v0ri
 sRlw==
X-Gm-Message-State: AOJu0YygfxyTdhmdpC97o2iqFwZcBay30xWMckiBxo8ULBPlcFuFLZFS
 QV8hySKnOSDV+D8jRNfEF0q2J/wrDxJB4gZCz3FJW8UTF8mAZsouJEfvpgY0wbA=
X-Google-Smtp-Source: AGHT+IEVH9a3AtnTUoS+Fq5S3Vuj5Q7r8evrcV261DosFbf7s/CKTMFETPmMZozANGDBvzvfwACg5g==
X-Received: by 2002:a17:907:7f16:b0:a8a:6db7:6659 with SMTP id
 a640c23a62f3a-a8ffab6cbbfmr1075230266b.9.1726216507008; 
 Fri, 13 Sep 2024 01:35:07 -0700 (PDT)
Received: from [192.168.178.49] ([79.140.125.254])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835cc9sm835172166b.26.2024.09.13.01.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 01:35:06 -0700 (PDT)
Message-ID: <6cb2d79e-5ba1-4c0c-9870-f953f9d09348@suse.com>
Date: Fri, 13 Sep 2024 10:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240912-rename15-v7-1-546aba5b929f@suse.com>
 <ZuP3XePGs7Q_GJ-O@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuP3XePGs7Q_GJ-O@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] Add rename15 test
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

Pushed, thanks

Andrea

On 9/13/24 10:27, Cyril Hrubis wrote:
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

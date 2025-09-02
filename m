Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C098CA0FFE
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756808613; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=jupm1cnRPmTPf0VDYe7A5AVyZoKY2fwsY0qxhI/dmf4=;
 b=JL9z2Qic3lThB80Ne4Mwa5IfX/DvqYYBb+mWlNgKaqWhUBidARbVOAtYDjr0F0xlXg6xX
 j6hg51UtErL9c+MHcXWEk3KvWoW6u2edQ3PuW0J/QO28zsuKpVFneCZK9Hfe1IXh6hTXETm
 uijdOybHpOElcWjdBKOmDiM9IgrKwvc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 163F53CD3A1
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 12:23:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 899733CD22C
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:23:11 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D314E6002C2
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:23:10 +0200 (CEST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-61cbfa1d820so10196820a12.3
 for <ltp@lists.linux.it>; Tue, 02 Sep 2025 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756808590; x=1757413390; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ecxs18yyj/KSSK5kB74x701Z7W8sr/WyptkDJnEc0HA=;
 b=NCmG7k4aHHefgkaK1TNk68aPGPI5wVlRNGTv3vIEFjm5qEwxtxt/fQGTJokrJ59IkO
 byon8l1oouxoci5cInH/T/xna+ZKAD9YsOcMtqIA0DQ2WSTQa29EwPXZuFqVp9gY1IXX
 GFJCXaem8XH/ClzTHIWJg3BcAWJqbPKllDUpGnDz7LAJkn9uXI+a4tF1Qwd42SzjnEK1
 Wt8/peKjoFPz39HkcJ5LKem1bCMAeSLDxNAyolmVUyHmiSXvy6gHwy+fOBaibW4xST07
 sla6bBsoV/yGudYyOOCm//bGOvidG+vc2ALIJom6WJVfO9+YOZq6H2z2kxv/do46WlxV
 WrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808590; x=1757413390;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ecxs18yyj/KSSK5kB74x701Z7W8sr/WyptkDJnEc0HA=;
 b=ibo4mr2pA7pO0+WzNbgMWyyjKWd7qkRP1h1VR10xgapUCK2Ay7ZxQP8WIfmGTs5fHt
 1y10tspgTrG8GdO0dhKQ6IH7uPrNLycNjz1nr45VLgFH9lSkYtS0Z4mmOcFXGmXXfw4e
 dGoNw+o5F8Xss7mk8Ot1p/3lvxFIQsA8nJHJYdanskSZeFnk2GH3U0s6VeOoMkgCbbY3
 jXppxtFKriHO8svbfIN5udTgN4nFTft4EbSuyz+tUSgr33jaj28vvXWxOyUDg3aDhOT/
 T0MCrw23uhRfpHjlU/hVrN8dflpW53jPOqXp933dLBB37cE7ENmNpMNsB6hecm3JY+Up
 YGBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9CR5UnlkKoIiLPgOBlmC7D9HKHdZKBQTaLehlXcvceQ4yrIbHgeCyJJrAfSsNQeYMxLw=@lists.linux.it
X-Gm-Message-State: AOJu0Yz/oLdkWsvmOXcXGrJjwwfc/KgWjbUSnUzhLRg3t/qO4HrmO895
 TPpE6gN+PUeXRK1sJac4tHHjySQNI9Y+Y7jOgZNIv6Q/7GFfjbmr/xZLqg4HaRPYG3o=
X-Gm-Gg: ASbGncvvy+GBhQhmgQKkeRDCw2u5lNnSd2+paWvAmnNWuvpeGiSL+Dp7cNImvoZKhEn
 +LGK94yw5Snphnai1wcw6Jpou2JBg5k9bdxqR3DzPO+yntjG+/iHuqTJ8Ois3RFAaw/w9rL4W/h
 TnrZrsw/O0cNlGCaAVWaiYRbEdEaAyx9IiZjKXA4ikVBbNK5fkVpetM1bgBWoeBvjqUubuGN9yF
 J0Xr0KdsV7GHLn2oZqvQ0w24Ww0OW1eTY9eFrCoaeAjdwn5HgigWYju09AhZqjPnFxw40L12bOd
 mlNGSFdVDep7cwqaI9VOnABocoNfug8v4xdLnGUuzyt4/vkMiVlVylP2weJeUfQTdqnpDeuuqeK
 ttP8FyOObajo3nw9DPX5fYsRzpqWcIyMVvlJz8ZsP1rRuWn4OiI8lqfSBEMExrUEqYJZU5+XPin
 pH1Y9kLiz5TS6phcbB
X-Google-Smtp-Source: AGHT+IHfZGm+wJ7K1QW/Dsp0tTM7/uJrXGbec4LjGyMh+7xKKo+SIanbKe5Uco9CdasP3Raj9EKUFQ==
X-Received: by 2002:a05:6402:52cb:b0:61c:7a45:583a with SMTP id
 4fb4d7f45d1cf-61d269a7390mr9682321a12.10.1756808590213; 
 Tue, 02 Sep 2025 03:23:10 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4ea764sm9221755a12.40.2025.09.02.03.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:23:09 -0700 (PDT)
Message-ID: <69ec2719-0603-4cf2-8774-9f3ceb70a3ca@suse.com>
Date: Tue, 2 Sep 2025 12:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <aLVzVyaVhr4IHkyd@yuki.lan>
Content-Language: en-US
In-Reply-To: <aLVzVyaVhr4IHkyd@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 9/1/25 12:20 PM, Cyril Hrubis wrote:
> Hi!
> It's about the time we start to prepare for the September release. As
> usuall I will go over the patches in the patchwork in the next week or
> two. If there is something that you think should be part of the release,
> please point it out so that I can have a look ASAP.
>
Thanks. It would be nice to merge these patches before release:

- doc testing in CI: 
https://patchwork.ozlabs.org/project/ltp/list/?series=454189
- open_tree_attr() coverage: 
https://patchwork.ozlabs.org/project/ltp/list/?series=471820

Also @Ricardo has many patches sent which are waiting to be merged and 
some of them are interesting.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

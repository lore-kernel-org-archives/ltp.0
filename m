Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B47ACD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712236058; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=xelHMTUC8hsdfj7vEMPhs0eVHoLYrRpak03K6x+gQSs=;
 b=YYzCAVhW7GvnexmEEcgv/gAJiikGA7XQCM76+oqKWa7urEoV72Tmu70CT158bsrXEzbGQ
 wwtSaKaW8hy6C9zRTmRqD2+t4eQdkjXpijCO/HfYgoKkcj4aEKdiC7su+956THtGI9UkgWK
 a36b5HgIKFZFZpcHykC+/AD+nXnJphA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FB4E3CE3CC
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 15:07:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A7403C111A
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:07:16 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8BF05613F1E
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:07:15 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-415515178ceso7255395e9.0
 for <ltp@lists.linux.it>; Thu, 04 Apr 2024 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712236035; x=1712840835; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7lIk4hROPl1ewSBE+KDV03vd90xUxRPd9ZZNW7XJXgg=;
 b=GOsUpMyua731jQXaa+jVZGun4I1eWyex3iUxMnDZc//JLdjNXHIaCyS5l0duSyOm8d
 gsTfTjKzh0bFI2evWdGU/RAF2Xyo19CBSBoeHU0Lwigh5sC/YDeZM6d+YQ9wkn4X5MvR
 PMU0/B67CUSPdoEJLawo+AfekB5Blr24Qpg8aCU4IV7E5LWSmSfE15MJEZyYpAkUPtxU
 lBGW5DxrqYJ26kmCcBAd9ChS+SdoGth0ffoPvgPM6r7tq+mnJZwiirFic12IpgtpQbVy
 w10IAJWD3m0IhQfCJPQriv4QxGehfPvE9k+GcO6WVXctHGa3cbP9GEoLQ+XnbzD1n2Z7
 nJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712236035; x=1712840835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7lIk4hROPl1ewSBE+KDV03vd90xUxRPd9ZZNW7XJXgg=;
 b=wAWAHz3UdbDSXM3kJCRNFXg7f4oLMwG73zQjCtx5rbA+6aqcytTH6RFpJaE1DmYOPc
 umgxT1gy26l8NPLYLaslXe81LI0bu/PGkgQGKLB4JijrU/CiLtiXmQf/sQRuZnUw3iTU
 hWoddNjfyqa1PZ3mONStYnQ+Etcimq9vNUoWKaCZNfGS6RZu/yOJWeYt/J4QBDCQA6uy
 jI8Mv1taE3h789x+jXcSbJEDtMa9Nf7D+i6PwHv64AaKrdCIJLbDXHH4u8zSx4Env60D
 rEPqgn4MA8u401RNJvMSgoA4o9QL10n5U5padDYuhq31mfqwZRP/765GiNariL5KFLIB
 mknQ==
X-Gm-Message-State: AOJu0YxtYkLPTCcfSqOjNIR3gulINoT3FR+DQ+ozAXKYKT+DvYuhA5tc
 00Oqkr4khoNXL4X6d9EWUR0ulc+PTR13XS33sPpTAHTvNl8qQvRX4YLZJXLP1YU=
X-Google-Smtp-Source: AGHT+IG2Hs7P2MPMbW4EhDqK5mA3goMASb/G99OYA8sbjZBjjRhuR1cjj4Js+utd3WXjb1m7AgksOg==
X-Received: by 2002:a05:600c:4c16:b0:414:c1b:4bbc with SMTP id
 d22-20020a05600c4c1600b004140c1b4bbcmr1610441wmp.6.1712236034982; 
 Thu, 04 Apr 2024 06:07:14 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:843f:e00:d596:e8e:78c7:ff41?
 ([2a02:a31b:843f:e00:d596:e8e:78c7:ff41])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c314d00b004162bd5ba59sm971852wmo.39.2024.04.04.06.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 06:07:14 -0700 (PDT)
Message-ID: <d6a87d99-923b-49c9-abe1-a7d37e9f43eb@suse.com>
Date: Thu, 4 Apr 2024 15:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240404121521.22483-1-andrea.cervesato@suse.de>
 <Zg6lbcX3_8LYj3k6@yuki>
In-Reply-To: <Zg6lbcX3_8LYj3k6@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] New LTP documentation
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

On 4/4/24 15:04, Cyril Hrubis wrote:
> Hi!
> Can we please fix the spelling errors before this patchset is applied?
>
> $ make spelling
> ...
> WARNING: developers/build_system.rst:134: : Spell check: Explaination: Explaination.
> WARNING: developers/test_case_tutorial.rst:136: : Spell check: initialisation: initialisation code. It is important to note that this is a completely.
> WARNING: developers/test_case_tutorial.rst:378: : Spell check: internalising: ABI (Application Binary Interface), rather than internalising actual.
> WARNING: developers/test_case_tutorial.rst:638: : Spell check: dependants: dependants before their dependencies..
> WARNING: developers/test_case_tutorial.rst:663: : Spell check: organisational: We are about to make some organisational changes to the test, so now would be.
> WARNING: developers/test_case_tutorial.rst:1004: : Spell check: organisational: Style and organisational issues are best left to after you have found logical.
> WARNING: developers/test_case_tutorial.rst:1030: : Spell check: synchronising: also various helper functions for synchronising and forking processes..
> WARNING: developers/writing_tests.rst:51: : Spell check: overcomment: Do not overcomment.
> WARNING: developers/writing_tests.rst:67: : Spell check: highlevel: paragraph with highlevel test description at the beginning of the file right.
> WARNING: developers/writing_tests.rst:89: : Spell check: vendored: uses (among other checks) our vendored version of.
> WARNING: developers/writing_tests.rst:162: : Spell check: vendored: It uses (among other checks) our vendored version of.
> WARNING: developers/writing_tests.rst:303: : Spell check: Subexecutables: Subexecutables.
> WARNING: maintainers/patch_review.rst:29: : Spell check: behaviour: Use sanitizers e.g. undefined behaviour, address..
> WARNING: maintainers/patch_review.rst:66: : Spell check: behaviour: Could future kernel behaviour change without "breaking userland"?.
> WARNING: maintainers/patch_review.rst:141: : Spell check: licence: ; the licence for test (e.g. GPL-2.0) should not change.
> WARNING: users/setup_tests.rst:7: : Spell check: behaviour: tests behaviour by setting environment variables and using specific tests.
> WARNING: users/setup_tests.rst:38: : Spell check: behaviour: file. Force colorized output behaviour: .
> WARNING: users/setup_tests.rst:64: : Spell check: tella: empty string, tella the library that system is not a virtual machine..
> WARNING: users/setup_tests.rst:69: : Spell check: addjust: It's required to addjust path: .
> WARNING: users/setup_tests.rst:97: : Spell check: commandline: variable or set on a commandline by the .
> WARNING: users/setup_tests.rst:96: : Spell check: Hoewever:  parameter. Hoewever,.
> WARNING: Found 21 misspelled words
> build succeeded, 22 warnings.
>
> Most of these are actually valid typos.
>
> Other than that:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Sure, good idea.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

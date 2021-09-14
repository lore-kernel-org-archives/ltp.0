Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29FCC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 09:42:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31C96108B
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 09:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C31C96108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell-sw.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE75D3C8A0C
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 11:42:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A36C03C1D8F
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 11:42:42 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DDC3F20015E
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 11:42:41 +0200 (CEST)
Received: by mail-lf1-x12c.google.com with SMTP id k13so27479325lfv.2
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nzSjD0M+zYK5G3CfL2R+DkReBXH4ic4+66S1vNRcUnU=;
 b=UYjPY3pKa6zbRZ5pF+SFphWvMNSodgu/ZWI2sZGyQbOu/5Kabd9+Bgv2080okScfSs
 tNKG/LUryIHjvV/aLk/aWa3z8s1mkoRromIzr4lTi77UikYi7Q8gmtJXmEqqyNwvClst
 Lc0Qutpe4p/NIwLXTIgKiAshCldT625l9pc+4Du4ApRldz+pgnmRlcKKz2uI/v2QSfja
 NSUi7mOpXjxxzsFbP4I74eRqqmdjn3fyF9X+eY/ilDnakjEbxFe7Tb0hb1+asvi6dnc1
 bMF7sCvi7SFwb/deA817+maVAlJtIpRZ0E4pBp54SXskrMHY+LGzSAAo8VV9T8nF3Tjj
 44nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nzSjD0M+zYK5G3CfL2R+DkReBXH4ic4+66S1vNRcUnU=;
 b=7j9s2HPYhEqzK2gDPY7XPSHGLpc9hYHNN+fl8jL8VXZAcjCbXRSq5NYvHQAaayOwFQ
 PZG/R4tRt+t9b/KoQVEighvdpRqhFJbCSuixKcn0cnfUZY8Nz5aQOpfXGZFgRWASAw6e
 j5AI14AkaSLuZSU/62glnY5NeVUNlSkWPKas497pqgK+R8lhCbUhbTucuzH7vtccnsxF
 yaIUn7kVC0opgBqVTlyrRd2faCtgll4m9tS7jikQ+1Nu/rOhWwj4njA2tzbBXeNJx0jG
 hh40njXMlXWyUi4PEEmcntBIbKYT3gQ4+O+chUXjVv4Chwt43Elj4Lhm8Q6+xtZHPv1s
 n1FA==
X-Gm-Message-State: AOAM531gTd8VBHiz+inLBRfnwJkHLSyn2ntZonDHsfNI/x/L11dYFoaH
 8mO/zLPNbpcGq4/5CVEYjvEooaWJB8Md
X-Google-Smtp-Source: ABdhPJwWH8NAqjRaYLge7W9Vcs6mhDyrh2yTJnvbvWdJAqSsxs3aFQssviX83hRLBnRVV7subgdxeQ==
X-Received: by 2002:a19:6b18:: with SMTP id d24mr12915155lfa.84.1631612561059; 
 Tue, 14 Sep 2021 02:42:41 -0700 (PDT)
Received: from [192.168.1.52] ([95.161.221.177])
 by smtp.gmail.com with ESMTPSA id z1sm1073536lfu.222.2021.09.14.02.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 02:42:40 -0700 (PDT)
To: Petr Vorel <pvorel@suse.cz>
References: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
 <YUA3UIvykJPNyyi4@pevik>
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <82b63456-0ba6-dedc-9688-cc74c40e4982@bell-sw.com>
Date: Tue, 14 Sep 2021 12:42:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUA3UIvykJPNyyi4@pevik>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib/tst_net.sh: ignore errors on rhost with
 -i option in tst_net_run()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210914094240.p0jIPFtX7mYpJx2AM3_Pliv2F2WSmGcc1lyucreMMA4@z>

Hi Petr,
On 14.09.2021 08:46, Petr Vorel wrote:
> Hi Alexey,
> 
> good catch!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> BTW are you going to send patch / report it to busybox? (I haven't find anything on ML)

Looking at busybox history, seems expected from the beginning there:

commit 64309f8669f08f2c3c16a3b5bf82d9cae84ec388
Author: Denis Vlasenko <vda.linux@googlemail.com>
Date:   Thu Nov 29 06:40:28 2007 +0000

    sysctl: add -e: supress warnings about invalid key (Jeremy Kerr <jk@ozlabs.org>)

-e option unsets FLAG_SHOW_KEY_ERRORS.

busybox/sysctl: "-e	Don't warn about unknown keys"
(Though, -q option can be used for that, which was added later, in 2012)
vs
procps/sysctl:  "-e, --ignore         ignore unknown variables errors"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

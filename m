Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BFEC433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 12:28:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D65643C98CB
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 13:28:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6486E3C896C
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 13:28:40 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 92CD92009A6
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 13:28:39 +0100 (CET)
Received: by mail-oi1-x22c.google.com with SMTP id m9so39306666oia.12
 for <ltp@lists.linux.it>; Wed, 02 Feb 2022 04:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=A76yyw9UJb8ccr7GEhV/fkx49nII9NKEbWjRWQJKsfs=;
 b=hYJB5XK8SxWPibqpiqVToiBYiXQZ2n4B9lZhJA5lEWILFkXJTFFbs1M7StbR6wT7Sa
 BHxo+hKYkukaJ+aZHN5OAldcRwjJlmYP8q3HlXM+KF0G5xyLdaiQDTNlgcaKS61Cu2YQ
 PIOF+Gvm7j1Wl/ZhIn4n35j8zw2Ffok6sss9RQUnGEzJSQ9pOXMNVK+c3yCN0SNASMui
 vyPNW44Hag9EvVPz+hzPDQYOOYLtxLA1tP1T7+OuWJzq+u2qV08JPUqAPQWJc9BIqmr4
 jrJdG2hbwRTqmT+efS7HKF15bSPamvUI6inFK9srcf0XAala9Rv+RNvwls9IZtpNFMNv
 uLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A76yyw9UJb8ccr7GEhV/fkx49nII9NKEbWjRWQJKsfs=;
 b=ymJajT8LC2KmZRC8o2zQqf6sFj7HpQs7mY0/zgdAF+d2xUninlRiTm6Hluo8TCRH92
 QuOCF84Xw6HqkDbskrGul9/5dshzcWzfvTr57syleDEWIpXxQ2gsR+Hadv2wvc23ZT9w
 xtqUttkgvKRzQAe5l1xHLMnS+uHs6SO7TqHLtru/2itfygRV2+Js6muCvvGFwjr1M6n+
 Sn9BpCKVXXU252ATztpOc/YC5gGUFQ6s2681UF5h21v7VilZt/LlMdbl0USwSXW7m4a9
 wust5ndFVXLSNWnbvAFDx5CiZYbXoafIUE41a2zK8YnTQrggRAgsmtnBu5Eiwi880h/H
 y8FA==
X-Gm-Message-State: AOAM532tiOq/YPvmcBmHR1sTTgv/OPdTFfITr39fHb/iMtBFSSDoQZCn
 Dty7sZXIHC/A1c49t8GqkX4=
X-Google-Smtp-Source: ABdhPJznYX+bdEvvOMVAeIwLUbTl0pXVE1FjZNnhVlmx8o4nYUaMv4YiujFXaMb8g9VC5hQQwCDUKQ==
X-Received: by 2002:a05:6808:5c8:: with SMTP id
 d8mr4211661oij.251.1643804918254; 
 Wed, 02 Feb 2022 04:28:38 -0800 (PST)
Received: from t14s.localdomain ([2001:1284:f016:4a2a:cb7b:9b09:85a6:b020])
 by smtp.gmail.com with ESMTPSA id n67sm12261968oib.31.2022.02.02.04.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Feb 2022 04:28:38 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
 id 5B8C015AC2C; Wed,  2 Feb 2022 09:28:36 -0300 (-03)
Date: Wed, 2 Feb 2022 09:28:36 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yfp49PCW9Res5gXG@t14s.localdomain>
References: <YfpnVfrto4Elshy5@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfpnVfrto4Elshy5@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] SCTP tests in LTP vs. on github.com/sctp
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
Cc: Xin Long <lucien.xin@gmail.com>, Neil Horman <nhorman@tuxdriver.com>,
 Vlad Yasevich <vyasevich@gmail.com>, linux-sctp@vger.kernel.org,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Wed, Feb 02, 2022 at 12:13:25PM +0100, Petr Vorel wrote:
> Hi all,
> 
> SCTP tests lksctp-tools [1] are also in LTP [2].
> IMHO it's not worth to have it on both places.

Agree. I wasn't aware of the copy in LTP, btw.

A question I have now is, is getting more exposure because it is in
LTP? As in, does it get executed periodically by bots somewhere?

> 
> lksctp-tools looks like to be the official ones [3] so maybe drop it from LTP?
> 
> Version in LTP was updated to 1.0.15 some time ago (upstream has 1.0.19, containing various fixes [4],
> maybe worth to be backported to lksctp-tools? Frankly speaking even being older
> version the LTP code looks to me better. One test was even rewritten to LTP new
> C API [5] in order to apply more improvements [6].
> 
> BTW I'd really recommend lksctp-tools project to take new LTP C API [7] and
> rewrite tests into it. But are these tests still relevant? (is it worth of
> work?)

These are nice tips, thanks. We certainly can have a take on them.

Best regards,
Marcelo

> 
> Kind regards,
> Petr
> 
> [1] https://github.com/sctp/lksctp-tools
> [2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
> [3] https://github.com/sctp
> [4] https://github.com/linux-test-project/ltp/commits/master/utils/sctp
> [5] https://github.com/linux-test-project/ltp/commit/fcd43b3dd7a8e8fab2b03ec9fa659f21ff5cecb2
> [6] https://github.com/linux-test-project/ltp/commit/fcd43b3dd7a8e8fab2b03ec9fa659f21ff5cecb2
> [7] https://github.com/linux-test-project/ltp/wiki/C-Test-API

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

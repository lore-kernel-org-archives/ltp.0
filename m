Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4F9CD8C9D
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 18:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763057078; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LCQWiQY+xqMs1J8abX120Umzsf3jt3pRHMuRbvBec+M=;
 b=K7dfG+0RE7vZcEmN5ZtAE2iUxgBDWnZD5GhV8KxQzeDboXQnTkRiA6IyPFoD68B8cyHMR
 LeRVnjHF/xmWCS8M2+QNpomwbjpQ6JbjrgmFszZkjxbonrc2QZSN/0T68F6VUPCCWSaUiBo
 kFkqyL0KTK79F9UMDGj2gKj/7tLynw8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D56613CF7FD
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 19:04:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56AE43CE325
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 19:04:20 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83500600A5E
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 19:04:19 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47755a7652eso8199525e9.0
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1763057059; x=1763661859; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h8GFF9Y/QWEfWjwfUYKesoKM1oWJH5rSmuxhaxjX00w=;
 b=W9rKkEU95OWL3+Sx0x9pxx/jt2wYYz5XwdS6Wf6qpKF3hXNz771iMohTo7VlMjWqSJ
 fQHNzhuNzGF+pSgHiUB/rQBWy6IfEIS2Z8vaDTlmIKFhNm+IC/TEwy65k7En/yor4TVI
 aVxn+oBTvQV0kHGMnNMhDwWFmeC1T0ye/XE+Qfw02SQ2opdMSUaggr/UKRkps8RVQyHE
 5cfaqbfaafKG1ip5D0momYVjpIbM5tp2TaFFvAVUabQ17UU1eGxjPXEqww4l9mkGSawC
 nBK6yReXS2jMlxc65dNs8Q8efJd0dGfEpS0dwUHB19fDkgXy0BQDC6JRHu7F+yUOMqwM
 SF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763057059; x=1763661859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8GFF9Y/QWEfWjwfUYKesoKM1oWJH5rSmuxhaxjX00w=;
 b=SnlSq1a6nov1pGoSVWmP6F+bXmelbp1EDrLWzB7b+AlFEXAzoaJ3mOgSfwvnKC7ZbD
 owxZoWFvjfFox+uGghSXOsOHCsm0qUp45p1ax8uxS3EGAhT7i1FAtarRWz9a9vOKna6n
 b/0DdjKKyULg/ojvO5tlXik2q2JKn5s0WOr1O2Nn6YXQKyiul7syfA/1FEwFR9mMYh3n
 e+It6yc/PRK+BeWh5g1fO9Hq07/j2q5RMz9qsEAKpZvTdw8qNmKDDA0jY6FZCkKMdLPK
 uOIz5+WRC1LhxPJslPGn4ElD7o7+w+9kGjbZJR/zYcK+iUPg0GUAA/q+RxFWc4Bio83/
 0hbg==
X-Gm-Message-State: AOJu0Yw5Y2Q9NzqHF8dEKqjQYG0cNcFsuo9lWaU2lXRaxYSNm/mXCkB6
 9VdirDKwy31O59UsKTgix0S0lRX/sVQf1Mi5WCRNnfKLJNxwyxs6ZaEJsUGAhAFwz1k=
X-Gm-Gg: ASbGncuYp353v0abBHlLnwIrnHxHQ8xTytteTKTa9YlwbDkQEZuP0m9FNARgzUA60+s
 6X84IypyXgdy33q+1UidMiVonj7cF4XhywQW4nxUZo7vCplYEZCBO9fbsXbSWRuB5ThFktSCAd0
 GN2P6jQEbj0+kqVJeVu2qClsHO7k9BTOZUPTAk0EmZChOMdu7B/9zPn95HNK/IdCKFp6QY5ftTr
 zHFBTSE1sQ9Em83R9rXrV1BUQBNSfrIVDzHud64rqpF9qEMxYDln79sw/QNGYA85q1Xo1oLB6ZK
 IYnrmGiAav623p9qPgsQ0x+EEcm9gEpxifTfadvQbQMkkS5LFKH4uKZNlMyqjxEKvWgPZaEI+iI
 O3I54KXH7pMRyTx0RfSs4y8aFBbgWUfJg27gaVOYhyKkz6QjncweSkCxikRYXN0pDcw9/0sCqWi
 MMLeEz+yaxHq7ekLfoUOVS
X-Google-Smtp-Source: AGHT+IEcUY1JB/4G5OLV4PPrqXebxpgf4yLvLQnX3djkeeI/mZhxeJl7s5BgNRLZ27pLSr9UX5KtIw==
X-Received: by 2002:a05:600c:a05:b0:477:54cd:2029 with SMTP id
 5b1f17b1804b1-4778fe4fa23mr4075475e9.4.1763057058883; 
 Thu, 13 Nov 2025 10:04:18 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47789ffea1esm79744825e9.13.2025.11.13.10.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 10:04:18 -0800 (PST)
Date: Thu, 13 Nov 2025 19:04:17 +0100
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <x6dptvv4poqcxzrwlcznxlpczxa4ysdwide7kzxg2ujd3dbwh3@hb6xomm3o2zd>
References: <20251111-b4-memcg_stress_rewrite-v3-1-a56a0e0cb887@suse.com>
 <g6kd2n247qvdsl4w5zdfqzp3b4bmuzixhpgj3g53gecqhuwt7z@kjybzlrjxag2>
 <DE7K8F9TLAEB.YEV47QRMXPTL@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DE7K8F9TLAEB.YEV47QRMXPTL@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] memory: rewrite memcg_stress_test into C API
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Nov 13, 2025 at 01:19:30PM +0100, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> I'm not sure about this, because system might have other applications
> running which are (de)allocating memory there and there, and
> "MemAvailable" would change accordingly.

So the environemtn isn't sadly a good opportunity for such test :-/

> Also I was thinking that maybe we should mlock() memory pages to ensure
> we are not going to touch swap memory. WDYT?

As I wrote in [1], I'd start with the rewrite into the renewed infra
that mimics what the original stress test was supposed to do. (But I
admit it was neither a good stress nor test in my eyes.)

I'm not sure what would be the objective of avoiding swap and mlocking?

Neverthless, as a followup to the rewrite above, try converting the test
into something more useful (where it verifies something and won't
produce too many false positives). And that in a separate commit(s) with
reasoning, maybe not necessarily touching memcg_stess_test. I'd
personally still try pursuing something like a) and b) from that mail
[1] (striving to run and measure it in isolation, e.g. all in one
encompassing memcg). Of course this idea may inspire you to something
even better :-)

Thanks,
Michal

[1] https://lore.kernel.org/ltp/cvvobn3ncapngynjplotpft3vbbfzg6me2gq3omnclzgwdoqli@ga7vc5e6f5t3/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

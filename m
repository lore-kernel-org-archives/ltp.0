Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79E5CD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780652387; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=NK9fnMFlx+nFkeJjUbHQj9riMMTcaARvaXBd21b7Uw8=;
 b=Pb024TNjUC4FWa7GKcasXxX7JaKSXRYzFSInnCkwe2W7IPWxaHIq7AgToxfFQ0KLnPUmG
 1Qb8JT99poSWvcfS/B6nJgG5WrEVDQfeHrDZLTCvULJBxSa0z0X9DJXVj5WomQaKT4kBPNe
 1xqqWRDuTjYuZZaoH7CapMQgylssD9U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F6013E547C
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:39:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACAA43CCEAA
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:39:26 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F24A11000A5B
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:39:25 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4602e2a0372so964337f8f.3
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780652365; x=1781257165; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=08wQEAfxvYWaYzMMAvz9PQtjxuXAo1mWEIEY5qAEEAA=;
 b=Ghvfb2lJrXhC/X4UorziXWQB+C/lw6veaVk8fYMqzhCyh7iJ+kXpFpAwAa5wKLwzQj
 rm/BdjalF46bzdts08C6Jz0I00yjYjCh5Yo4xM0ZZq5xvi0i5Jv+Kvhd1w1F7d20R9iL
 wwgxrizGJC3SvMwsynv3uWTJmS5xArIAfnlLTUuwoOLSlXMY7Q3kyGLhIQb/FdISC8nP
 uDve2VfSer56gKPgNhh7U26pqvXDzVg+YBSpKSwLnmAtYt8h6bMjZOxlwj3pfmw55C2N
 TE5HNxpT11oews8ivXHNEWQgmdb8g1HEYwGGLnJgyqgkwK0somYlOJtLc5vmHj2JskvI
 ByEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652365; x=1781257165;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08wQEAfxvYWaYzMMAvz9PQtjxuXAo1mWEIEY5qAEEAA=;
 b=JXv2aRibkXLMnQeCZV89xpa4+gG+L3+Pzx6WAXevi5cZaqgzDz6u7HUun9mLAbF8Rw
 j9DnB11r4qFP6CJ1/5mBVj5ebmeqT9cMjzTQ4v1r7jGtKRc/zn/m+e8B6k2r1xcNANtc
 P4jhQqBi/H/OSlF2RNsObBI240TSVwr1HVpsxa7qA0Y1FpcWeCypccj3gHLVCGcdlGMl
 wQ6cwCrMzBx4b4/FiIzuZflbAOoLrcpKEUf8kW35JLrQXe18PahWHqgTVF8KbHR+afhh
 S3ney6waWSqrvtcJLOI8JTqzVM00zMyWSBCQ3WjY/fWjdqsIGRWcTv/onLxV+3ZOUDt2
 b79w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xMBP3MjKel52rcf50/XVgx7RttupZoENEjI5eOPYqRAoz5vfChJgKfuhheDyP5KvYciA=@lists.linux.it
X-Gm-Message-State: AOJu0YyjfurqN62tw2IB/BOVPbic6XVEecekV8wT5CU2OuoQqIChM7wc
 YeL1vPE3uynfz/mksPcc+WhukHXrgyeiQoeIS/K3g3rLrHcllBTD3aBMB4g5Yf8zzOA=
X-Gm-Gg: Acq92OECUC+V54gJtwDWOEhHMlVmVs7JucM/E7DJPxVT89GbtISGaDElvh2bZpXMMNX
 nM1wVQ5Ur2idx6PZvKQi+M7K7GJjj+YnsEhzYVIGWOyheZnShfSqysQqlIy3lJObXn+YgsyRZIK
 QyjJ7GIwxwxnVj/HAPtALmdiJMljAzfmk6D3U24ow/6S3TjZGEPEUUtaBlL7D/oCnuqKRONfCRo
 Dblg8aga1ypf1lrRaSF2/+Nu5nBrbLWeen5Rwi4/aCLIG3FKv1E/nhxnmyWotbQa+mMqdhUmuTb
 VepZczz6FKDQClwMFu+x/jaBF0w5uhI9IHj65xHjEs4RArvCbGp5uBplbgpVTqBmG9WthnMHFl2
 FLSwuaIscmmlFaEE3ENs7O3/vd0JhG93ftHGISdFvKc7uJR+BvN3NshJrdCsOpF/cKVOSNJZmRz
 w2MOOSAJwGxlldUu5JjQnaxBGIxnBePGs8zQlCb4NQ6JicMdqrI/Ke5lJ+lg==
X-Received: by 2002:adf:f24d:0:b0:45e:ed7f:1d9 with SMTP id
 ffacd0b85a97d-46030615ab8mr3535979f8f.17.1780652365345; 
 Fri, 05 Jun 2026 02:39:25 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm40132225f8f.29.2026.06.05.02.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:39:25 -0700 (PDT)
Message-ID: <6a22994d.159d33f9.2309c6.e4c8@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260605093020.4127-1-linuxtestproject.agent@gmail.com>
Date: Fri, 05 Jun 2026 09:39:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> 
> >     Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")
> 
> The Fixes tag references a commit that does not exist in the git
> history. `git cat-file -t eef750db28` returns "Not a valid object
> name". Either the hash is wrong or the tag should be dropped.
> 

This is caused by the CI. I need to fix it.

> --- [PATCH 2/3] ---
> 
> >     * - .needs_device
> >       - TST_NEEDS_DEVICE
> >
> > +    * - .needs_hugetlbfs
> > +      - \-
> > +
> >      * - removed
> >        - TST_NEEDS_DRIVERS
> 
> The `removed` row corresponds to the formerly-named `.needs_drivers`
> field. Alphabetically `needs_drivers` (d) sorts before
> `needs_hugetlbfs` (h), so the `removed` row should appear before
> `.needs_hugetlbfs`, not after it.

This is valid.

> 
> >     Add 8 missing struct tst_test fields to the C/Shell API comparison
> >     table in writing_tests.rst: ...
> >
> >     Add a shell API variables reference section to api_shell_tests.rst
> 
> Two independent changes are bundled here: updating the comparison
> table in writing_tests.rst and adding the "Shell API variables"
> section to api_shell_tests.rst. These touch different files and serve
> different purposes. Each should be a separate commit per ground rule 7
> (one logical change per patch).
> 
> --- [PATCH 3/3] ---
> 
> > - ``SAFE_FILE_READ_STR(path, buf)``
> 
> The macro is declared in include/tst_safe_file_ops.h as:
> 
>   #define SAFE_FILE_READ_STR(path, buf, buf_size)
> 
> It takes three arguments, not two. The `buf_size` parameter is
> missing from the listed signature.

This is also valid.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

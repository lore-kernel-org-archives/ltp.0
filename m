Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D441BC3600C
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 09:39:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EA123C8112
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 10:39:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F1603C13E2
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 10:39:27 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5BED11000458
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 10:39:27 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso25703635e9.0
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742809167; x=1743413967; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EqQYH89jqwocgM2G/buarqQs6vhv0VKh9mPWz4hb7Zo=;
 b=F4ypKftwF5va5Sp/P94x3KVzNQNeHCdN4DYoWqxe4BFb4roWgAmPPVN+sD2lt18BzK
 hOjjgDxXGMG+9zEjIj+tjBuXjGvOPRzk/iy2u8tKon3LcRoYMX/aaiSbJdgBB8Jk1h+z
 5rlz5TUZXFmQ1GlsFmDN0itf8a+gLzKORhz0vrHoCiChY2iYMZ5XrG3soUX2E2k89Nyt
 aHvo0rGLgjIZVyff0sQnaESg7p28HmQFs6lgTMqO0lf7UpVMNIVWgOAPd12XqCrGIpMQ
 DLGI+Af9IE+ae2MGfXG19srodT4LI+mScgxFrO94BM9BK+Gk/Hkk0jOauVMz1fq9GYNO
 kY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742809167; x=1743413967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqQYH89jqwocgM2G/buarqQs6vhv0VKh9mPWz4hb7Zo=;
 b=h75MXyIC64EyHIOpoCYg7VwORAfRX/XjC8VmrhbshSbJPtO/PXJLKcr/qxIbLP5fv/
 irxtNvHr++AbYEjMGZPfEOr/M6uwwOh2HjaIyQa6vrDx+9f63iF/lC1Jpw/npoqqjPvU
 OL00QU2k351daDiPgCvgrIcrp8TulWauXcTiJm0pHKSDfQxKVyeWKn7ahUjQZa9I6trd
 49ao/5vNP0uVHhGPxa9hCuz4uOqbBaKib115pQ9b7i2LRKPSDxjOjA0AZTG4Lg1fFzej
 WizylcRrxvVndErL36vWHxLdAG3mYTx/Wa+HT3JCig2XHjagJi9+FRy42nhErZ81I7HK
 B10Q==
X-Gm-Message-State: AOJu0YxdMeWvo0/1FEZLj3tb86MUzmF8u2pIfIQUFb8bfVnNPWkBL323
 5FPgAXgpbYBYOIXE5w/K7rZXFI5ZGaWoq++0BhqRp4agWgPLElmq3ECy8Hgtl1tuWUKVNsn0ErQ
 l1F7lA/lwubyJXQWciuzO5v08mGBNTcrq
X-Gm-Gg: ASbGnctsmy4q6aQx7DekZIbHFYw3j1jRYnIhD+Zp9OBCPkmygbf0CX2oqYrpvzQ+glc
 yZ10V/IDAPSA5ZGl/PwlgeU+jXBD7Bid/3Sw+iDAGUcBGIZw4WZCXJNfFxsP4lnJJBEupA47nkS
 SouSZ2vK7rCMnO7ZStDzCCOA==
X-Google-Smtp-Source: AGHT+IEe9vKdTLDegjkI22haq3o8uAnPrt4xJujRcD0R4Cdpt+tDJhDESfK4y/q19+q+o/yaClR2++ckGDbUqj1eBVU=
X-Received: by 2002:a05:600c:1c96:b0:439:8e95:796a with SMTP id
 5b1f17b1804b1-43d503673aamr98421375e9.13.1742809166277; Mon, 24 Mar 2025
 02:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <529e9b45-ff7d-4aea-9313-7bf54060f409@suse.com>
In-Reply-To: <529e9b45-ff7d-4aea-9313-7bf54060f409@suse.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Mon, 24 Mar 2025 10:39:15 +0100
X-Gm-Features: AQ5f1JpUO4ZqQ0eGEB7uMSJ5KKXC04rcrhPbDK5zKZrnMfsGK6Wb0W41oWc0-xY
Message-ID: <CAJCsO8cWB0fWsYCwt6gLv+8Bqbpd+6bL2PJaTyUa=hooGd9Sfw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Open LTP meeting 24th of March 09:00 UTC
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

MoM (not ideal but at least some; feel free to edit or add more info):

- we had a longer gap since the last meeting was held; the last call was in
November '24
- back in November we talked about kirk, shell lib and also the test
coverage
- we should be more on time the next time
- currently we have about 300 tests using old API
- run test files - those should be replaced about the metadata
new features:
- ltp shell lib
-- we also have the first shell tests which is ported to the new api and we
have the documentation describing the process of porting
- redhat switched to using kirk and that looks stable and good
- kirk in the latest release should be executing the test faster; there is
also a new kirk feature: monitoring which helps monitoring the test
execution in the real time
- as of now kirk has a single maintainer it seems and this isn't ideal.
Ideally we would have more people working on that. Cyril is already trying
to work on getting to know kirk more. Request from @Cyril Hrubis
<chrubis@suse.cz> ideally all people joining the LTP call would look into
kirk and be able to fix and maintain the kirk code
- metadata: what to do with the old tests to have the proper json structure
for the test catalog? Cyril suggests to have the manual process to prepare
the json for old test cases and then use that for docs/the test catalog. We
keep this open and we need to figure out what to do. Ideally we simply have
no old tests (tests complying with the old libs).

On Fri, 21 Mar 2025 at 10:21, Andrea Cervesato via ltp <ltp@lists.linux.it>
wrote:

> Hello everyone,
>
> this is a friendly reminder for the LTP mailing list about the next LTP
> meeting.
> As previously discussed.
>
> Next meeting will be on the 24th of March 09:00 UTC.
> Platform: https://meet.google.com/jon-gytf-uei
>
> Thank you,
> Andrea
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

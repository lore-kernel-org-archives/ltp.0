Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20840D37E3A
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768401510; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nKrV8dKoaPa89XW/HwTyzIEvaQtgLz2lcSd+2fzwqE4=;
 b=jrd1YwGPh0ez2glJhIxeRVZilqSBn1fq/usAYvUiM95VND5vdJQp0uHsQ/WgUuG1elaca
 L4OSgBxMTvY5YRiDlo3zYzuKdVavnvkR2WrzSM+m+AZxidaMOmOUBOQ7YWsALHEo0BSVxXy
 YNhRa+YnL+qnXzNbdKVMn7zG7PVLNQg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34EB73C9CB6
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 15:38:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD1353C60CB
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:38:07 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 483066008C8
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:38:07 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso59675065e9.1
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768401487; x=1769006287; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXuxpCB+C200gDac6NFfMYpeaCyypHjDHET7hpKl7Hg=;
 b=T/77y9TkW6uNV48lDk4QDE7KSImI8uHFrrEaWeZg+AqJvF0yOM1wImGQ5QBjALUMLu
 c5+9eWrL0vamCLQWnyIxWrxJWZSXx89E3aSo1qdUxngvEUdBpzjtQr9ghW8MvsHkxGth
 Og9MVBOq6xXSSwplh7EmXCgyt7z+ehSER2hK3uQ8NP9Dij4RjJtziz3iOwMsT49MYkA7
 Y/bljwUX+dVyPx8qOpjq1Ig/J3jtVkFbG5TG/x9dAxz642/RUbiwV7q5RPBoq0iisqYC
 9GYqwvV921EBrq8q4ONQFLUGR/UcqIuc14MIyUrIPDVzsfLEM/hD9BDDpSzLiAQHf2sq
 jrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401487; x=1769006287;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xXuxpCB+C200gDac6NFfMYpeaCyypHjDHET7hpKl7Hg=;
 b=BGjdFRyL39bK2efovtkvW5Ah0z+xNFlwcC78McffjVDTHnHWpIKHJmUK9WdKEVB7Wb
 ZC+TTxKN4tJzuGxP7SNGdgduTIngBHvUmWFs46VuDSnVdzeUitPH9PxmQyUlQ1rJZrl8
 cHb78mt74ZGuVqvrav6CcFcSieSlpF88t6q0bVXAZvjGZ4SIjGK4jKIHhEiAHQb1rmUJ
 n+KTiIWEVEOihKUrHGKwOiYzK5cpB70pFn+XtUTjpE4qxOevEBwUxqI1SODKl8EtmSa4
 PfAVXQ1F0movWZowoTNRE6TjhuHl/NCa1k911ZRYoid4rkTqLw7Cd5gzA1LwJwfdsN70
 mYXw==
X-Gm-Message-State: AOJu0Yw/eZO7BYIzRQEKdkq73fsfDk4a2+CxEWV4XFj+RvBam8UwVGuk
 TDmPfK+gY776NdWFS+ZoQcUmo94iwdKAdovJ4CtFqvKkV4xWkxunp8oj6Mb7ETNp2i8=
X-Gm-Gg: AY/fxX7RBQZtTp/erhWF72ttL7ZQK778btecaWJnOWBVgFH/YyMLl0yhn3IS3ZKIx1H
 qHV/m9cqSCikuDnOCoI/G+iV+tT+Aw2dEGlDjf5NNr7ExRkiQO1WBqg/2IDTbUaYLcbwA3BFSg5
 xHsubJ1YiCCraOPf12L7o0UztxvEH04rXyNsbiZzd+/77ODHw94WU/A5DSb6onFMlSp+GjoXL/Y
 WISyQvuF8Ht5HsT4CWQnTTjpWbHsf/CPq9HPS6jcw4izBbibEDAhrrszDhGrx0TWCZOdCdWLkCv
 zvwdRXcGRiNuiYts6peLnYaxEsUfq/6EA/O3XLWSdko5u7qqImD73x5KkzqYrBwOIgi+zVmSGIE
 mQWYfhK8HsjUjlRlMEVrRLB2tY/GnnCzs8g/ajpk4oWItccZbzzw6kffthnXwDumXH4sBP5Yoxt
 XY8JgXoz1bbmgRYp8+nn6xHrnIEd1TjpdkW0m09EY2NDmPndPExBK7q80dMsW4YzNQkmplYQsO4
 VKe
X-Received: by 2002:a05:600d:17:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-47ee8de7443mr9820425e9.22.1768401486562; 
 Wed, 14 Jan 2026 06:38:06 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee2a5e48asm20271865e9.20.2026.01.14.06.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:38:06 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 15:38:05 +0100
Message-Id: <DFOE0BC22OI4.1TO4CKB63W9M0@suse.com>
To: "Al Viro" <viro@zeniv.linux.org.uk>
X-Mailer: aerc 0.18.2
References: <20260113194936.GQ3634291@ZenIV>
 <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com> <20260114143021.GU3634291@ZenIV>
In-Reply-To: <20260114143021.GU3634291@ZenIV>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
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
Cc: linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> Er...  Intent was to verify two things: that anything longer than PATH_MAX triggers
> ENAMETOOLONG, but anything up to PATH_MAX does not.  Having a pathname of exactly
> 4095 '/' (or interleaved . and / in the same amount, etc.) be rejected with ENAMETOOLONG
> is just as much of a failure as not triggering ENAMETOOLONG on anything longer...

In this case we need a new test verifying that PATH_MAX is actually
handled well, as Cyril suggested. But in this test we should only
verifying errors.

>
> FWIW, I considered something like
> 	mkdir("subdirectory", 0700);
> concatenating enough copies of "subdirectory/../" to get just under PATH_MAX and appending
> "././././././././" to the end, so that truncation to PATH_MAX and to PATH_MAX-1 would
> both be otherwise valid paths; decided that it's better to keep it simpler - a pile of
> slashes is easier to produce and would resolve to a valid directory if not for the
> total length restrictions.

It's up to you how you create the string that will trigger the error.
Also, you probably need to take a look at tst_test.needs_tmpdir.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

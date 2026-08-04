Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60104C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785843047; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IYyNgICsyjRbe0U4DSn1wx6FHv77ey5Ix9rcHb0bjJM=;
 b=EVxVRBOO7DnqE3d6nTiYe2a4ZzY90ET1s+b3j9k99wOFGC28RShwLjXZQosMXt7XCV/6R
 zVdC3NfMxKNdRb0ESUqCjVhXVMkpOymzr7p0jckzVocPEmmcQ+NCUKR9Mmdp+Pn81EoBKTe
 9pT3FwFuoxgC8iq9Qy7PCeyPfk3KXWI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A0B3E717C
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:30:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96AC53E1942
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 13:30:28 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EAFE920076E
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 13:30:23 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so2616985f8f.3
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785843023; x=1786447823; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TKbtM6VAypN4vFMzusJEcEN89HtTAPhyGc49jiE/WvE=;
 b=R5O5TXfIcJl5cf1M+iQ1wyS8IXPlO8x6W/iuycGK7+J+lS3+TGHKkUs68ayR2pMvUR
 g6DBJFUcp7lVBkUQ3nL+DAHAD+JHhadkMk1GHTVoTN1aoJjSeLmCroYO4gQKQQwYnl8X
 thFHclgb+0QP+pydvmy6JzCtbz2j8aQDyxX3mCgXM2Y7+lE0tDShF8EwEZuSkphCdt/u
 l/wg+Cw+AHYyAKQ6MEv72jEBvquBc3OusYs965c2EIUU7nmfbOBVBsk18wlXUx+C5OJb
 Dy8HYndulasQ8XbGun0K7aisS/CYTIlye8o0tIQVxxll4DfyQnKmtdwQ5o/67AhMw3/r
 toSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785843023; x=1786447823;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TKbtM6VAypN4vFMzusJEcEN89HtTAPhyGc49jiE/WvE=;
 b=pnUbUjQ8zP1Ysfketaf25rLKDhYhNs75b+1oo1MOr4Ki+GGHu22I+EClH1I+FbWrHO
 1NpBdWLkcfFNhgO29fKJbBQ0IomA+a8OMUMS2p61sV/5o6q/Z9VvfK65YB7HSkihpoVh
 tP8owjz9OjZZAfIbQUjzfkdiFzJT6WzhBkwkmoX7PUL6WW7O7+FJpBk+schdwT7ZMwuD
 BYcexa7okorgVSstfvHHhxd/rLAKV0UhLJgxtXcllOLEtJZiwQg6+WWiTWYY5GTnuqAk
 O0JfSE9RrWWodR8rmcLFpM4QR8AbCPFNINobf9ICT+OMJH6kqZQglRioBoM9md0H39uu
 yrBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBmTQlkezM34U8Xol7Hx8fdihppbJczHezBPYtqdmV7YvC9WLYS9eHu6ctcrup+Quhwzs=@lists.linux.it
X-Gm-Message-State: AOJu0YyAwmYTsSsAYYNoUsZ2L4GBEM+ZQgB7VVvWZbP5GU7EWyy9SiJI
 m2Mz3v6fIBti4TQxTJPNH02ckOnaNkCJDSIjAXvvzJv6X6bkzWJ1LuB4qpyQPp9safE=
X-Gm-Gg: AR+sD13unxpTS1lFw7DEkwWGXOvRKRIPeIVYVzrGQazcIPOavWj3lZV3msXz6LeldwK
 3pEl5uF9BseBDUHwQUGNYiBV5ettfmAaUOtX537d6FfmzTg1+sceau2/B0l9ByjetOq4XCfAQzr
 rHvQewkVdgERZcJ4+b2ZDGwn/a2DGqs4h9iSdkrBAc4hNbAZQ7HhoJIDxrCFbwYEHnXnfLvr7P7
 ek2TeEBkTK8ruIUiTiGuT1ZvX7fqmASo15RO5Uweea3mjt+a6vzqJphgpb/FuRu0oyfmbMaZCw7
 Z5gHuW1wOEq2/nLoGgLbGqOweCk63ULzWukzCai9QHXqctxLbMsOxDJTtzwXBz+fhb9V1O7mjS9
 qLKsqVQacn1XqglxOym4a7YcotZli1AAw2Vns2Z7odsIyBIvOlp6cSMgzbRREcDUHEKLd9LMGdy
 kPHBiLATvG54E8yCqbHnusYhHvLfPrjrx4MUcD8NQY+917Po0qeX9wyBgmB1/DxlWNE4Jsr0U9f
 THFGqQBm+rOTBjc8zFQDDfDZKyUIp7jwnle3zOxWRxLIvuhqD4f+e6kl2T1aFoA5mJK4rsSXz4F
 Eb5P6wY6vBUD1INAmc+0yi3IjSPm8eIXB6EbuwmkoH/i39ae2A==
X-Received: by 2002:a05:6000:4614:b0:478:19e7:22a2 with SMTP id
 ffacd0b85a97d-47fd72c3639mr36877989f8f.25.1785843023296; 
 Tue, 04 Aug 2026 04:30:23 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a5a4sm42838720f8f.20.2026.08.04.04.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 04:30:22 -0700 (PDT)
Message-ID: <6a71cd4e.97b59ccb.1e4332.3163@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260804104047.7850-1-linuxtestproject.agent@gmail.com>
Date: Tue, 04 Aug 2026 11:30:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shell: enable OOM protection by default
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

> Major: Could the test body run in an unprotected child here, as it does in
> the C harness?
> 
> This sets -1000 on the same shell that later executes the test functions, so
> all workloads forked by existing tests inherit OOM protection. For example,
> memcg_limit_in_bytes.sh reaches test_proc_kill() and starts memcg_process in
> the background. Linux 7.2 copies oom_score_adj on fork, and its cgroup
> documentation says that tasks with -1000 are never killed. That path will
> therefore report that memcg_process was not killed instead of observing the
> expected cgroup OOM kill.
> 
> The commit message says that the test runs in a child, but this patch does not
> create that boundary. tst_oom_unprotect() is only called by the new self-test,
> so it does not reset the existing workload launch sites.

the review is correct, I will sent a new version.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

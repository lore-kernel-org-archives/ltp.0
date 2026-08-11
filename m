Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6E3C5AD7B
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 03:01:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 592493D0736
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 05:01:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A47B43CBEC5
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 05:00:58 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC90B200741
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 05:00:57 +0200 (CEST)
Date: Tue, 11 Aug 2026 11:00:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786417256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xP6yBUnKaOk2dDOIfQzbs6f3eQp4pFql54WCC14DUdw=;
 b=uWqiYOKOM2TYKb0m5wFcQbPAeaMT7Yp74QQ73wmgNym86jdSneoXPVXc6KmGz3KpaYNUdU
 gnUXdUqIvJq0CBTzgajXp3AknsQaRmJ2gY9RUg6BORpCxMNOV/6tPBYgg3C7J04NWatnf0
 6Y15bwhLoA6nHrZa3+MjHx82cs85iQg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
	Petr Vorel <pvorel@suse.cz>
Message-ID: <anqQXb08RqRK-74w@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Petr Vorel <pvorel@suse.cz>,
 Linux Test Project <ltp@lists.linux.it>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] shell: enable OOM protection by default
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

Hi Andrea, Petr,

After looking into it more, now I slightly think doing OOM protection
in the shell harness isn't worth it: the benefit doesn't justify the
complexity. Forking the whole test body means dealing with cleanup and
timer ownership across the fork, plus passing results back from the
child, and all of that would need revalidating for every shell test
that goes through tst_test.sh.

Given that only a few tests actually produce memory pressure, I'd
rather keep it simple and handle it locally in those tests instead of
touching the common harness. Something like a small helper the test
can wrap the memory hungry workload with:

    tst_oom_run()
    {
        ( echo 0 > /proc/self/oom_score_adj; exec "$@" )
    }

The harness (or the setup) protects itself with oom_score_adj -1000,
and only the workload started via tst_oom_run stays killable.
This keeps the harness alive to report results without forking the
whole test body, and matches the C harness model where the worker is
the unprotected part.

Does this direction make sense to you, or do you see a case that
really needs the protection to be harness-wide?
 
> Suggested-by: Li Wang <liwang@redhat.com>

This email address is no longer in use :).

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

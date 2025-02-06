Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81455C02198
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738856784; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=ASxCfSEjbYLm7lJK4ZQDWh6iMOotkRrtxgarEw5NZ7w=;
 b=F3M6u5pP6ksZuu5lGZ3Z77CETFSnUoWgZiRtBtAOM3oSsHe54m04f/8hopDo4IHGu5HH+
 MLaZAU+25ssMJrDBBx2Wo/5uiONOvRrM9hv1Wm1nFHBKY8kRfGoEfNJSmhLi2Wf5jA+g3tN
 2chDa05ASCkCCP93KCFt4GLVJtFJW8Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 149DA3C9298
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 16:46:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12A3B3C6A8F
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:46:03 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B4D4114223BB
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:46:02 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so7436815e9.2
 for <ltp@lists.linux.it>; Thu, 06 Feb 2025 07:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738856762; x=1739461562; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvUS2y0/mkviuFh0W+NmA3EiJ5sVwUOYVLPdkbUh80w=;
 b=VuKdMXGg/NA2o5WXyfewK+VhLr0cuRMG0slhmu8fTBsJ4Hre3p8JwtG2EkiAvSK7cm
 ApCjSlaZ3HXqExBre9ySoLu4VtOE2FrhOwyOvdeQmqdZ71wMrHsWAx9Fhgz4OxD/mo5q
 rmshP5UiOJLvRQtx35298WgsxFof+GGQIVgfFNulKqtEz8jjY4+JgtLKhJiIab7zbd6e
 bxYA54+bDZdPHpf923bPVxXD+X+z83dT+6RPnkTO0huNEc1f7qyt/n/6r0jtELjB95x5
 bPC9xFs4RyIcS3RTj8MeHqfW/bZqCkUohUO3x02mIEsfYtY3YvSIZ85D+f7DNyW4uiL3
 3XCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738856762; x=1739461562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvUS2y0/mkviuFh0W+NmA3EiJ5sVwUOYVLPdkbUh80w=;
 b=KiYkCA6kUogzHmBpqnylsp8dXtQ+ZA/ygTlLpOywI9eWZ5EdI5Ts/cSTqLAbe/PIiI
 d4E2V3uJNlfwS6j7fRMgb6pBnUmoCw5pYjH9YIyAU16NMVFS+VStT4+lb5Rtauj+ucU4
 KUly3y9Xo8V19FTcmolYGVCSjuOdd6qflFnq5w0vzoBcAUnJ0nz9hVP091A4OmaDjeae
 +G/7RYZWn/Z4DhbBzxVflDr0z+2lZLk/rsNdr6XwhFzUaaO1J+5WE5Q0aHJNqaWPpist
 hHN9i4lNy2tXOrctKFxKr2r+rbVPNqIDHUoK9amJZK9Pg5ggBqFAoRL/WKLzJw7igSxO
 BZeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz4Ud5Spr2OblLwQeHMTc3qdVsa1PGcqnZU8k8zDGHHerNcYhB9vVjgnyyHCAgQt1KOAg=@lists.linux.it
X-Gm-Message-State: AOJu0YzMBaAOWE3s+R0wopKpIWnmSuXOOUhc5tFvCb2PgSzCTTDTDuL6
 +1daZQUWwcDx9O5ZNF3n/qUQg1u99nqD4uJztbmgG7cHAEnNRcT5wzdNq+veLbfFe0+QS8ktvV/
 uZo5tYQ==
X-Gm-Gg: ASbGncsmIpoGlosjNCdxayqnw9Kb2nSwf5LyVxX0sqO7Q3zXoYnUnsnCSPgpLQzbC+8
 8h6vjfIHnx+PNlCeLHQwSYYLQmY+zh39EKM7fVcwpINKLL/+kJUILBFmTCNPFTGtWgdpYtYIsAH
 hRmHn45Hf/difsAQG5fC6dbtzkitGFfS6ovSKjZ4BgOH2LDq74VpweecK9rIg646m79A4wlSMl1
 xKHsU4fe4XcGhnr2za0PrT7dUB7uTi4xk1rReN/BEQaL4H3kHX6i8N0MPLDzeSJwu7V2G9WFGgU
 tPwq8CufffOAzl/0Jlp6u81PB7xJKmznDa5j/NqJcT4wmPWLAsHICmOTQ2RH9zxI1Bp74sccxN1
 Q/xH8lS8UYbIV9FwpWdVXu4U74mI+81dn3PcfO/ThvFjlA9TLmR4=
X-Google-Smtp-Source: AGHT+IFlQg+2nqnqpqmIV/cb6i8/oLhF3v8q9mW40t8m7x+6liVuU3oyzfq12XnGMEgv+N/2dRQrEQ==
X-Received: by 2002:a05:600c:35d2:b0:436:51bb:7a52 with SMTP id
 5b1f17b1804b1-4390d4352e1mr63658835e9.7.1738856762123; 
 Thu, 06 Feb 2025 07:46:02 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd84b9sm22709045e9.39.2025.02.06.07.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 07:46:01 -0800 (PST)
Message-ID: <f652b056-7548-4a8d-a318-b32fbe941de6@suse.com>
Date: Thu, 6 Feb 2025 16:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250206153435.1602181-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250206153435.1602181-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/5] configure.ac and make cleanup
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks for fixing this.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/6/25 16:34, Petr Vorel wrote:
> Hi,
>
> TL;DR: Commits which fix CI are 1st and 4rd:
>
>    doc/Makefile: Add dependency on metadata/ltp.json
>    .github: ci-sphinx-doc: Run autotools and configure
>
> If I don't get any feedback, I'll merge them tonight.
> Other commits can wait.
>
> Tested:
>
> https://github.com/pevik/ltp/actions/runs/13182184736
> https://github.com/pevik/ltp/actions/runs/13182184734
>
> Changes in v1:
> * Remove virtualenv (Andrea)
> * Rebase to put fixing commit first
> * Further improve make clean pattern, remove unneded distclean patern
> * Drop 2 patches which aren't important to fix CI
>    - 8662c96207 ("configure: Ignore --with-{bash,python} knobs")
>    - 98b6a63202 ("realtime: Document bash and python3 dependencies")
>
> Link to v1:
> https://patchwork.ozlabs.org/project/ltp/list/?series=443127&state=*
> https://lore.kernel.org/ltp/20250206143421.1571918-1-pvorel@suse.cz/
>
> Kind regards,
> Petr
>
> Petr Vorel (5):
>    doc/Makefile: Add dependency on metadata/ltp.json
>    doc/Makefile: Improve clean target
>    doc: documentation.rst: Update build instructions
>    .github: ci-sphinx-doc: Run autotools and configure
>    configure: make: Add SPDX, update copyright
>
>   .github/workflows/ci-sphinx-doc.yml |  9 +++++++--
>   configure.ac                        |  3 +++
>   doc/Makefile                        | 14 ++++++++++++--
>   doc/developers/documentation.rst    |  8 ++++----
>   include/mk/automake.mk              | 24 ++++--------------------
>   include/mk/config-openposix.mk.in   |  2 ++
>   include/mk/config.mk.in             | 23 +++--------------------
>   include/mk/env_post.mk              | 25 ++++---------------------
>   include/mk/env_pre.mk               | 26 ++++----------------------
>   include/mk/features.mk.in           | 22 ++--------------------
>   include/mk/functions.mk             | 25 ++++---------------------
>   include/mk/generic_leaf_target.inc  | 24 ++++--------------------
>   include/mk/generic_leaf_target.mk   | 24 ++++--------------------
>   include/mk/generic_trunk_target.inc | 24 ++++--------------------
>   include/mk/generic_trunk_target.mk  | 24 ++++--------------------
>   include/mk/lib.mk                   | 27 ++++-----------------------
>   include/mk/man.mk                   | 23 +++--------------------
>   include/mk/module.mk                | 18 ++----------------
>   include/mk/rules.mk                 |  3 +++
>   include/mk/sparse.mk                |  2 ++
>   include/mk/testcases.mk             | 22 ++--------------------
>   21 files changed, 81 insertions(+), 291 deletions(-)
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

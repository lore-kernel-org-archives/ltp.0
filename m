Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423D6C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 07:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786604763; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5HS4FLSJ9rShnpcQZFNpjHWzx7LaHnPMn3CqIV0uBDw=;
 b=PYm+OaGGU80tY61dDYw+9Nsy/kyTs0Ffu3WkZvO9k+HMeqn517TXUWdr/h/leRX3tTXPe
 4qAvOOpfma+s4rj5w+KKN7CM8bU5lX32Un35TsPh6v40LwJ0yoRtvJJNeGRvsuWP5qBOo97
 uNYE60T9B7qw7LcGKmwVU1A32dUKi/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 855953E6BFF
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 09:06:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C38303D9E8C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 09:05:43 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1D981400257
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 09:05:42 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-495590dde14so21251175e9.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786604742; x=1787209542; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lMXOo4Nr5BZc7zmOIbLQB7dd0jbQdwPYg974dC/huPA=;
 b=fJzQahvtANyM9Vi25pSI68UagpOXyIgJFMX409kUFSdehYFmWOWePVeZ+4b23g/OPE
 bWD+WA1w3AcghPpDPpFkojHarRpT47gF4RgUYA8Eb/rNUqLQpvuUj+GC05R+CNatKjL7
 VWS1T9yW3zVskJtUNKwVTj1au/zVWo9OE6B9a1+iLSHwCPQMijSnKWzrZC42S8lUo2in
 6O+G7lpQi1nlfc7rS6f45+el5EiBFOyNtPbXTZlE42uGW8D6SCuxO3zaKvkxZeyruQhj
 mhsRjerSnV49THF399DF0zHSKjdCtgM9xFgyeEh9M3oL2rKqvQtAp5SEr2EkFtKcORbN
 6l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604742; x=1787209542;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lMXOo4Nr5BZc7zmOIbLQB7dd0jbQdwPYg974dC/huPA=;
 b=BZXOBkfetgzxAR+Dw+zeiwhj32z2M/x+U+5pK7annCI0N3kIZ6Hdkz4kUg5c0284YS
 jZ6nNuU0wbNjAcy0NTCRSDe/GP79J7MRmRpc+nbJT8luozMKBnuDT7DdEuueE5yfiQ7u
 9ij/N01Ai6hajUMucD1Q0o6HNuwq+FgT4q2IdTkispcdMGU3NmIsmTlSN/jFNIJx8onu
 OXrCXnP1fUZlFpIs7vvlBhCNtY7QPEaIQvnbSgOkYcKYTLDUz+htmuDvtmdW6+CoPVlM
 VG6zYzuMy+ZzcU+Z1YXszwxKj9C0OSRk0Rr3OCJHTqWEjOXMbngh7eMJXcItGVqudplN
 owAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy+/smdkeX6vmg5z8dd/ldlOkJI2x6PTrcCuD0/cNzwNSMbS+iDOO4Xuon4OoFAxUxrC0=@lists.linux.it
X-Gm-Message-State: AOJu0Yz5yWs2icc2hstBECeGGbPnkWBx6EU4AwnOx4sv8AlZo8TTuSS0
 8z+56IHYx+qn4M3z0WSQsZhLM6zEJ+Y2I5wWOH3s38tuIYL8dRbmQbvx5CspV1TpHGjbbvnPUvd
 +bkS1z/0=
X-Gm-Gg: AR+sD13mWc/LsuprixVc9squ5gWk0tkZFjH57bOoCptxuYTxVSah/70Dg36/h74cEs8
 CvmonYRJQzHzqB6AZ2X99SJtfIAX0rY7G28/3c56vawyH1iBi1R7BZgNz3y0Hq8Rr/Bin/FEJcd
 9hQETHOSp7TGxrHv3bmvScFbLKbhdOGiDxAsYogqLqP7ImeuBaRRmPRl5jFma0sLUZsrUl0Kf/O
 UBD0U8oTEyxg6t8+SVljfhgUkPba0YKwZ07xg3F7Or2kTmEDerBksfA5beIK04X9xw405tt+ovy
 r6AmT5txWQuXaexW8VSlJuqg6li9x7lo+lTqboC7NzacQcwXtcWwEZgDmYkl/wveOX0Tz64KFCA
 /6HjoX5hAJuOvcRH7hRgzUWeyeHaKK/FDKox/bKfOlI1EYG7U0r3kky9gAIHP+xkubas9TjlNLU
 gOYzMFkRwsxmQF+uQEvGDWqf4C3MK6WclXsdr/NwatuIORnBZI074Yk382XEkObH9Y2SsmtCBP
X-Received: by 2002:a05:600c:19d0:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-4998218db78mr35377205e9.8.1786604742086; 
 Thu, 13 Aug 2026 00:05:42 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b5823fsm45436225e9.11.2026.08.13.00.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 00:05:41 -0700 (PDT)
Message-ID: <6a7d6cc5.87c5160c.2715fa.9370@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260811171005.9063-1-linuxtestproject.agent@gmail.com>
Date: Thu, 13 Aug 2026 07:05:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pmc_core: add test for pkgc_blocker_residency_show
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

Hi Piotr,

> Hi Piotr,
> 
> On August 11, 2026, Piotr Kubaj wrote:
> > pmc_core: add test for pkgc_blocker_residency_show
> 
> > 	/*
> > 	 * Interval between the two samples. The PMT telemetry region behind these
> > 	 * counters refreshes at roughly 1s granularity: measured on Nova Lake, no
> > 	 * counter moved over 200ms or 500ms, while 5 of 28 moved over 1s. Sample well
> > 	 * past that so a static counter means "idle source", not "not refreshed yet".
> > 	 */
> > 	#define SAMPLE_DELAY_US 2000000
> > 	...
> > 	usleep(SAMPLE_DELAY_US);
> 
> Could this use bounded exponential-backoff polling instead? The fixed sleep is
> being used to synchronize the second sample with the asynchronous telemetry
> refresh, which violates the no sleep-based synchronization rule.
> 
> > 		if (sscanf(line, "%63s %u", name, &value) != 2) {
> > 			tst_res(TFAIL, "malformed counter line: '%s'", line);
> > 			continue;
> > 		}
> >
> > 		if (strncmp(name, PREFIX, sizeof(PREFIX) - 1)) {
> 
> Could this validate the complete line and require a nonempty source suffix?
> The current conversion accepts signed values, trailing tokens, and the bare
> name "PKGC_BLOCK_RESIDENCY_". If both snapshots contain such a line, it is
> recorded as a valid counter and the test can pass despite malformed output.
> 
> > 	.needs_root = 1,
> 
> Could the high-level description explain why root is required? Tests setting
> needs_root must document the reason in the exported test description.
> 
> >  high_freq_hwp_cap_cppc
> >  cpufreq_intel
> >  rfim01
> > +pkgc_blocker_residency_show
> 
> Could the new entry be inserted alphabetically? Leaf .gitignore entries are
> required to remain sorted.
> 
> Verdict - Needs revision
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

the review is correct. Please send v2

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

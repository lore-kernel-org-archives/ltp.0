Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79403C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B703C926E
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 12:13:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40F223C282E
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 12:13:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A3AAD601033
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 12:13:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1800210FE;
 Tue, 21 Dec 2021 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640085189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3kdSucoKjFkWW8dLVOWKKWzm/7ik6SlDIyizwIa0tQ=;
 b=hfpI6f6ApNgSvTlO+k8YPBo7TeNGeXY7p8ks2gV9jzM1l4b3mHRDbZZNXk7vzHmG9YaaFl
 RhTCAnEzxmRdrcm3zRvbnoepMItjNW1g1MlaVk/QTs16xqv8gVpUuRXG8srqnvSspvt7Vg
 M5HXX0K+56il2VtFckfQqB9WOhixTvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640085189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3kdSucoKjFkWW8dLVOWKKWzm/7ik6SlDIyizwIa0tQ=;
 b=2lW/qVay5IR9Q4sy3MQ9ospQd0G7PfHPELCxXO3/TS5GqFPD8OTniru4P0DhvNr3Ik79N8
 lMn311QtbD/0RvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD2BF13C50;
 Tue, 21 Dec 2021 11:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PPPkNMW2wWFWcwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Dec 2021 11:13:09 +0000
Date: Tue, 21 Dec 2021 12:14:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YcG3IB2Oksw77mbg@yuki>
References: <20211220131043.18894-1-rpalethorpe@suse.com>
 <20211220131043.18894-3-rpalethorpe@suse.com>
 <YcCk13sQIpG+E0jR@yuki> <87a6gufd77.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6gufd77.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] cgroup: Add memcontrol02
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

Hi!
> > But even then all the macros all written in a way that they do expect
> > a syscall as a first parameter and the messages are not clear.
> 
> Possibly it should just be TST_EXP(bool_expr, fmt, ...). That would be like
> practically every other testing framework. OTOH LTP is somewhat special
> as we usually are checking the return value of a syscall. So I should
> probably leave these macros alone in this case.

Sounds reasonably.

> > Maybe we need a different solution. We already have tst_assert_foo()
> > functions for sysfs/proc files so maybe we need something as compare
> > function for the cgroup file attributes:
> 
> Frankly that is poor naming. One would expect tst_assert to be similar
> to assert from assert.h.

Feel free to propose rename if you have a better idea.

> >
> > 	enum cmp {
> > 		CMP_EQ,
> > 		CMP_NE,
> > 		CMP_LT,
> > 		CMP_GT,
> > 		CMP_LE,
> > 		CMP_GE,
> > 		CMP_EPS,
> > 	};
> >
> > 	CGROUP_ASSERT_CMP_SIZE(cg_child, "memory.current", CMP_EQ, 0);
> >
> > 	CGROUP_ASSERT_CMP_SIZE(cg_child, "memory.current", CMP_EPS, file, 10);
> >
> >
> > 	or even simple macro that would compare two values accordingly
> > 	to the OP and print PASS/FAIL would be better than this.
> >
> 
> I think it would be simpler to just create a general assert_expr
> macro. The above function won't neatly handle loading multiple values
> from multiple files. Nor will it handle transforming values.

Yes, that is one of the limitations.

> We could implement SQL queries for sys files, like osquery, that would
> be neat!

Hmm, we do allready have boolean parser in LTP library, maybe we can
just reuse that, as long as we add a code that parses specified sysfs
files into variables that are passed to the parser it should work
reasonably well for us.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

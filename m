Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88538C38142
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 08:28:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 079C83CC77A
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 09:28:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAA693CB378
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 09:28:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ECCE9600D23
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 09:28:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42C0720197;
 Fri, 27 Jan 2023 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674808118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXIfr13bGwX8TvaZb+KqwynBYt6OfYFc2rurA4h+J5w=;
 b=V4+5x4d+WkmJWmwBT4g69/VI0rLlkwutgvjn6YchnAQcQZKwJk+atqnsasNH6IUMVUio7S
 tgoW7SCtcvJYJsbEgu20NJuxJZ6VYWlRKBLZgNoOlLNypniw/x41nLXPBUFOZK8H43so0w
 ti+k2ZC3X+BEgnTbD2P2UX69j9mKQso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674808118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXIfr13bGwX8TvaZb+KqwynBYt6OfYFc2rurA4h+J5w=;
 b=MmT42KNVmAwsBlzr8Eq2Jxq0JSQZVJgFpH4DSc3Zsts2zgSSVNT7S5PKfx2cOA8xcP01yc
 tDBoUUdpIcVCAuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 149061336F;
 Fri, 27 Jan 2023 08:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kPERAzaL02NoewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Jan 2023 08:28:38 +0000
Date: Fri, 27 Jan 2023 09:28:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y9OLNKA20wUoP3/e@pevik>
References: <20230125222703.19943-1-pvorel@suse.cz>
 <20230125222703.19943-2-pvorel@suse.cz>
 <87edrh0zy2.fsf@linux.ibm.com> <Y9MGHKXel5kjwoTT@pevik>
 <87sffwq32u.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sffwq32u.fsf@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] hugemmap15: Compile with -O
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> >> Though It already got merged, please note this,
> > FYI this has not been merged (only the second patch "hugemmap15: Use
> > TST_TEST_TCONF() for unsupported archs", which was needed to fix compilations).

> Ok.
And don't worry, this will not be merged before release,
which is going to happen hopefully today (or on Monday).

> >> IIRC, I specifically turned off optimization for hugemmap15
> >> because of clang compiler issue, it behaves weirdly with clang
> >> without -O0 and test fails on the system.

> > Isn't -O the same as -O0 ?
> I think -O is -O1.
Yes, -O Equivalent to -O1 [1].

> I tested with clang with -O, it fails. So yeah it is not turning off
> relevant optimization.

Yes, you're right. It worked for me, but after full cleanup it really failed
with -O or -O1 (at least on x86_64 on clang 15.0.7).

@Cyril: I wonder why we need
1) -D_FORTIFY_SOURCE=2 for all (in CPPFLAGS), defined in m4/ltp-fortify_source.m4,
this will warn, when we need to disable optimisation for some test?
-D_FORTIFY_SOURCE=0 obviously warn for redefinition.
It was added in 2013 (4b3007a8e1), not sure which glibc version required it, but
maybe time to drop it? (after release of course)
2) to use CPPFLAGS and CFLAGS together?

Kind regards,
Petr

[1] https://clang.llvm.org/docs/CommandGuide/clang.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

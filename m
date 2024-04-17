Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F638C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 08:14:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01A873CFB26
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 10:14:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9D643CFAFB
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 10:14:17 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F163C1400DBD
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 10:14:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BCDF228AC;
 Wed, 17 Apr 2024 08:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713341655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jq3Zc3RIwRCpNTQZ0sHfzUCEQsapcN03Lc+q8ymIt+c=;
 b=1GkwDz455Jtz7hCKaJgsPNne2E9qnKMhKdQQ1BtaBJAk8S/LAHReH0FedFxlIGlcRNzJzS
 rLS7NFIcRgxyPIZotMWBBiUdF59HePQOCyplm742wkakxz0nPSSQd2d9xnZEK/SCHaR71G
 Zu62EmOwq8imhk/Yh3vvP3XWS9Nyo+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713341655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jq3Zc3RIwRCpNTQZ0sHfzUCEQsapcN03Lc+q8ymIt+c=;
 b=A4hFLDty5luj6BOquJtcCw/Q9p+SUWn7L4cjbWAEjMogbuc7ll7dE+OMiFXdBpsQb/SuCJ
 QjxZjCk7FL10NwAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713341655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jq3Zc3RIwRCpNTQZ0sHfzUCEQsapcN03Lc+q8ymIt+c=;
 b=1GkwDz455Jtz7hCKaJgsPNne2E9qnKMhKdQQ1BtaBJAk8S/LAHReH0FedFxlIGlcRNzJzS
 rLS7NFIcRgxyPIZotMWBBiUdF59HePQOCyplm742wkakxz0nPSSQd2d9xnZEK/SCHaR71G
 Zu62EmOwq8imhk/Yh3vvP3XWS9Nyo+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713341655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jq3Zc3RIwRCpNTQZ0sHfzUCEQsapcN03Lc+q8ymIt+c=;
 b=A4hFLDty5luj6BOquJtcCw/Q9p+SUWn7L4cjbWAEjMogbuc7ll7dE+OMiFXdBpsQb/SuCJ
 QjxZjCk7FL10NwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27CB31384C;
 Wed, 17 Apr 2024 08:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4uPMCNeEH2bBPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Apr 2024 08:14:15 +0000
Date: Wed, 17 Apr 2024 10:13:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Luigi Pellecchia <lpellecc@redhat.com>
Message-ID: <Zh-Ep88ZAMngLbpf@yuki>
References: <CAE3MqZyt47uc=h1P2tryBJsXeoEEzNnHSX5A02hM=RR0goxJKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE3MqZyt47uc=h1P2tryBJsXeoEEzNnHSX5A02hM=RR0goxJKg@mail.gmail.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, linkedin.com:url, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Identify current test coverage and clarify contribution
 opportunities
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
> I'm Luigi Pellecchia, a Principal SW Quality Engineer at Red Hat.
> I developed an Open Source Software Quality Management Tool, named "BASIL
> The FuSa Spice" that can help the LTP keep track of the test case coverage
> against man pages and to clarify contribution opportunities to new members.
> I prepared an initial demo I shared on LinkedIn at
> https://www.linkedin.com/posts/luigi-pellecchia_how-basil-can-help-linux-test-project-to-activity-7186248090129956864-d-vC?utm_source=share&utm_medium=member_desktop
> This tool is under the hood of ELISA (Linux Foundation) github at
> https://github.com/elisa-tech/BASIL
> 
> Any feedback will be greatly appreciated

Sorry to break it to you but this is not going to work at all for a
couple of reasons.

Firstly man pages are not complete enough and majority of the kernel
interfaces are completely undocumented and this is not going to get
fixed anytime soon. So any metric based on man pages is doomed to fail.

Secondly from the demo it looks like there is a major manual effort
required to pair man page snippets with testcases, which needs to be
redone each time any of them changes. There are thousands of tests in
LTP, going over them would take years of manpower, that is better spend
elsewhere. We have very obvious gaps in coverage so writing new tests
for subsystem that are sparsely covered is way better than trying to
identify minor coverage gaps in existing tests.

Thirdly writing tests to cover API specification is not exactly the best
strategy, it has been tried before and it didn't produce resonable
results. That may work for very simple libraries but for anything more
complex the reality is more tricky and useful tests often require clever
thinking. The prime example of this is the open posix testsuite inside
LTP where they tried to write tests for each assertion from POSIX. That
often lead to nonsensical tests and we are stil trying to clean up the
fallout from that. Also if you look at any kernel regression tests,
which are the most useful ones, the code does not follow any assertions
from man pages, it usuall does wild stuff that is not documented
anywhere. The most useful tests we have were written with thinking
outside of the box, which is not something you can achieve when trying
to adhere pedantically to a specification.

Also if you look at the example from your presentation, you pointed out
that nanosleep() is not tested againts EFAULT, which is not really
useful to be honest. Sure we should add that testcase, but in 99% of the
cases the userspace buffers are copied to kernel by a common function.
That means that it's very unlikely that we wouldn't catch a problem in
that function since we have thousands of tests that actually check for
EFAULT handling in syscalls. Do you see how pedantic comparsion of
manual pages against tests can easily lead you to something that is
not that useful?

To sum it up, this does not look very useful and has potential to divert
manpower from where it's needed most i.e. actuall test writing.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

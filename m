Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB484C25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 08:48:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 313153CCB38
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 10:48:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD7ED3CCB15
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:48:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D9BE8201162
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:48:34 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AB2F521B48
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 08:48:33 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 412122D55E;
 Thu, 26 Oct 2023 08:48:33 +0000 (UTC)
References: <20231025110533.6516-1-rpalethorpe@suse.com>
 <1881613.tdWV9SEqCh@linux-9lzf> <20231025151808.GA345083@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Oct 2023 08:32:53 +0100
Organization: Linux Private Site
In-reply-to: <20231025151808.GA345083@pevik>
Message-ID: <87ttqdu5up.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: AB2F521B48
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup: Handle trailing new line in
 cgroup.controllers
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie, Martchus,
>
> @Richie, please add Fixes: tag when commit
>
> I suppose it should be
> Fixes: 310da3784 ("Add new CGroups APIs")
> but please check yourself.

Yes that is right.

>
> Why this is useful? It helps to identify which test failures were false
> positives. Also, you actually not just fix a line character, but also do other
> validation, it would be worth to mention that.

The validation is primarily checking my assumptions. We don't want to
cut the name off at a '_' then get more confusing errors in the future.

>
>
>> Am Mittwoch, 25. Oktober 2023, 13:05:33 CEST schrieb Richard Palethorpe via 
>> ltp:
>> > +	switch (ctrl_name[l]) {
>> > +	case '\n': break;
>> > +	case '\0': break;
>> > +	default:
>> > +		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, 
>> ctrl_name[l]);
>
>> I'm wondering whether that's a bit too restrictive. Or is there any official 
>> documentation says that you really can only have the letters a-z in cgroup 
>> names (and not even A-Z). Otherwise it might be better to make this just a 
>> warning or allow any printable characters.

Well I assumed there wasn't, but it seems this was actually thought
about and specified to some extent. I should have scanned the docs.

>
> I guess for cgroup v1 [1]
>
> 	The name should match [\w.-]+

Thats the name of the "hierarchy" AFAICT. I don't think that is the
controller/subsystem name. Those characters would be a pain for naming
things in C.

>
> \w Matches a "word" character (alphanumeric plus "_", plus other connector
> punctuation chars plus Unicode marks). Also '.' and '-' can be used.
> => [A-Z.-] and others are valid names in v1. Although I'm not sure if
> cgroup_find_ctrl() is used on systems with cgroups v1.

None of the existing upstream controllers contain a _ unless we are
missing one or more. However we should allow it, so I'll add it.

>
> Also, shouldn't we check with MAX_CGROUP_TYPE_NAMELEN:
>
> 	- name: should be initialized to a unique subsystem name. Should be
> 	  no longer than MAX_CGROUP_TYPE_NAMELEN.
>

It's not exposed to userland or specified in the docs. I suppose I could
issue a WARN if it is over 32 though. Mostly likely if that happens then
there is a parsing error.

The kernel will also issue a WARN if the subsystem name is over 32.

> For cgroup v2 [2] it looks to be:
>
> 	All cgroup core interface files are prefixed with "cgroup." and each
> 	controller's interface files are prefixed with the controller name and a
> 	dot. A controller's name is composed of lower case alphabets and '_'s but
> 	never begins with an '_' so it can be used as the prefix character for
> 	collision avoidance. Also, interface file names won't start or end with
> 	terms which are often used in categorizing workloads such as job, service,
> 	slice, unit or workload.
>
> => It matches ^[a-z][a-z_]. At least "_" is missing. Also this validation should
> specify somewhere if it's for v2 only or for both.
>
> Kind regards,
> Petr
>
> [1] https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
> [2] https://docs.kernel.org/admin-guide/cgroup-v2.html#avoid-name-collisions


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

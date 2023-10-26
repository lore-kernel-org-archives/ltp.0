Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1AEC25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 09:34:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8725E3CCB51
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:34:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFDF43C6BD3
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:34:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E731F1400264
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:34:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B23AB1FE17;
 Thu, 26 Oct 2023 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698312861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wanILSuTVG12j8riPYZON42xl2TcWjE0+YYKE077qCo=;
 b=etIhRGfoWpvZGn9XwvgrJIp/+r5ZGVMCODjsJaFR0chjfTgIiANjdmELFp+jSTbAw+wdAX
 5KsGOH+l8LcpcG9oTbo2CGBuFN5qGxj6j/wdOhsI8aN6edTjr2a6h/OHfeJjrMnn43O9Ib
 4WnTY18WFwpt0RYGcQN3S9XwSbN8w0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698312861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wanILSuTVG12j8riPYZON42xl2TcWjE0+YYKE077qCo=;
 b=kQc73hDp4LeIoUMFvJVxLM321RtS0caP97puhlBe7Tca++JPuxm3YywqK1a2qUeJauHrNn
 rcVmBitEEf/z9PDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89A32133F5;
 Thu, 26 Oct 2023 09:34:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VCGPH50yOmW0MQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 09:34:21 +0000
Date: Thu, 26 Oct 2023 11:34:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231026093420.GA580291@pevik>
References: <20231025110533.6516-1-rpalethorpe@suse.com>
 <1881613.tdWV9SEqCh@linux-9lzf> <20231025151808.GA345083@pevik>
 <87ttqdu5up.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ttqdu5up.fsf@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie, Martchus,

> > @Richie, please add Fixes: tag when commit

> > I suppose it should be
> > Fixes: 310da3784 ("Add new CGroups APIs")
> > but please check yourself.

> Yes that is right.

+1


> > Why this is useful? It helps to identify which test failures were false
> > positives. Also, you actually not just fix a line character, but also do other
> > validation, it would be worth to mention that.

> The validation is primarily checking my assumptions. We don't want to
> cut the name off at a '_' then get more confusing errors in the future.

+1, looking into the code and description once more, it makes sense.


> >> Am Mittwoch, 25. Oktober 2023, 13:05:33 CEST schrieb Richard Palethorpe via 
> >> ltp:
> >> > +	switch (ctrl_name[l]) {
> >> > +	case '\n': break;
> >> > +	case '\0': break;
> >> > +	default:
> >> > +		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, 
> >> ctrl_name[l]);

> >> I'm wondering whether that's a bit too restrictive. Or is there any official 
> >> documentation says that you really can only have the letters a-z in cgroup 
> >> names (and not even A-Z). Otherwise it might be better to make this just a 
> >> warning or allow any printable characters.

> Well I assumed there wasn't, but it seems this was actually thought
> about and specified to some extent. I should have scanned the docs.


> > I guess for cgroup v1 [1]

> > 	The name should match [\w.-]+

> Thats the name of the "hierarchy" AFAICT. I don't think that is the
> controller/subsystem name. Those characters would be a pain for naming
> things in C.

Ah, right, I'm sorry.

> > \w Matches a "word" character (alphanumeric plus "_", plus other connector
> > punctuation chars plus Unicode marks). Also '.' and '-' can be used.
> > => [A-Z.-] and others are valid names in v1. Although I'm not sure if
> > cgroup_find_ctrl() is used on systems with cgroups v1.

> None of the existing upstream controllers contain a _ unless we are
> missing one or more. However we should allow it, so I'll add it.

+1

> > Also, shouldn't we check with MAX_CGROUP_TYPE_NAMELEN:

> > 	- name: should be initialized to a unique subsystem name. Should be
> > 	  no longer than MAX_CGROUP_TYPE_NAMELEN.


> It's not exposed to userland or specified in the docs. I suppose I could
> issue a WARN if it is over 32 though. Mostly likely if that happens then
> there is a parsing error.

+1

> The kernel will also issue a WARN if the subsystem name is over 32.

Good. But warning in LTP will be more visible (not everybody parses dmesg).

Kind regards,
Petr

> > For cgroup v2 [2] it looks to be:

> > 	All cgroup core interface files are prefixed with "cgroup." and each
> > 	controller's interface files are prefixed with the controller name and a
> > 	dot. A controller's name is composed of lower case alphabets and '_'s but
> > 	never begins with an '_' so it can be used as the prefix character for
> > 	collision avoidance. Also, interface file names won't start or end with
> > 	terms which are often used in categorizing workloads such as job, service,
> > 	slice, unit or workload.

> > => It matches ^[a-z][a-z_]. At least "_" is missing. Also this validation should
> > specify somewhere if it's for v2 only or for both.

> > Kind regards,
> > Petr

> > [1] https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
> > [2] https://docs.kernel.org/admin-guide/cgroup-v2.html#avoid-name-collisions

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

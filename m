Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56898C07545
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 15:18:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B18E3CEC3F
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 17:18:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34B0A3CCC4D
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 17:18:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 881A9600628
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 17:18:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8978021BD8;
 Wed, 25 Oct 2023 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698247090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNlp6I6WzY//x7VkcVJhAKdK7hWNleoEOR04SR6mPYI=;
 b=JstlqaLpIf22zjjwSEQShJykyfudkeJEDVOpyAbJyDcxQWhLC5cplRqGCylwEugEZpdTp6
 KMni44X81JNOqMdAkaa1w59XcRfd7GnTXre9qdaYyRkwcZ/7E9DrazXoRWpV60zpSQkDyB
 V8cb+vTdud7kTWrOvyEGowRu/FWxeug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698247090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNlp6I6WzY//x7VkcVJhAKdK7hWNleoEOR04SR6mPYI=;
 b=xl/cd/+eH1QGOUmW3/fsK6GMt6HX8a1KKEAzqyfWz88JeUCAXqHxmhH/4okzWjv0DJJ3DL
 RmWR7tyaMNLRJoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CCDD138E9;
 Wed, 25 Oct 2023 15:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EtTiE7IxOWUANAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 15:18:10 +0000
Date: Wed, 25 Oct 2023 17:18:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>,
 Marius Kittler <mkittler@suse.de>
Message-ID: <20231025151808.GA345083@pevik>
References: <20231025110533.6516-1-rpalethorpe@suse.com>
 <1881613.tdWV9SEqCh@linux-9lzf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1881613.tdWV9SEqCh@linux-9lzf>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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

Hi Richie, Martchus,

@Richie, please add Fixes: tag when commit

I suppose it should be
Fixes: 310da3784 ("Add new CGroups APIs")
but please check yourself.

Why this is useful? It helps to identify which test failures were false
positives. Also, you actually not just fix a line character, but also do other
validation, it would be worth to mention that.


> Am Mittwoch, 25. Oktober 2023, 13:05:33 CEST schrieb Richard Palethorpe via 
> ltp:
> > +	switch (ctrl_name[l]) {
> > +	case '\n': break;
> > +	case '\0': break;
> > +	default:
> > +		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, 
> ctrl_name[l]);

> I'm wondering whether that's a bit too restrictive. Or is there any official 
> documentation says that you really can only have the letters a-z in cgroup 
> names (and not even A-Z). Otherwise it might be better to make this just a 
> warning or allow any printable characters.

I guess for cgroup v1 [1]

	The name should match [\w.-]+

\w Matches a "word" character (alphanumeric plus "_", plus other connector
punctuation chars plus Unicode marks). Also '.' and '-' can be used.
=> [A-Z.-] and others are valid names in v1. Although I'm not sure if
cgroup_find_ctrl() is used on systems with cgroups v1.

Also, shouldn't we check with MAX_CGROUP_TYPE_NAMELEN:

	- name: should be initialized to a unique subsystem name. Should be
	  no longer than MAX_CGROUP_TYPE_NAMELEN.

For cgroup v2 [2] it looks to be:

	All cgroup core interface files are prefixed with "cgroup." and each
	controller's interface files are prefixed with the controller name and a
	dot. A controller's name is composed of lower case alphabets and '_'s but
	never begins with an '_' so it can be used as the prefix character for
	collision avoidance. Also, interface file names won't start or end with
	terms which are often used in categorizing workloads such as job, service,
	slice, unit or workload.

=> It matches ^[a-z][a-z_]. At least "_" is missing. Also this validation should
specify somewhere if it's for v2 only or for both.

Kind regards,
Petr

[1] https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
[2] https://docs.kernel.org/admin-guide/cgroup-v2.html#avoid-name-collisions

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

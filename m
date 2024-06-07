Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52A6C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:48:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6676B3D0AB2
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 18:48:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6137A3CBDEF
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:48:27 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9185F1A00927
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:48:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E614A1FBA6;
 Fri,  7 Jun 2024 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717778904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DqBRYUchN9h/56GEqasXWBUlF8vCqUGO/niIQ1ZAxjA=;
 b=qBU+/XU2sfmxLyl+JeEljc3lMP6QIGnrDUhONdhRAb3ApTg4xyT9SIdnpShrkKwRG1Syvz
 FkgerUIzwX9kUrsbkk3L/g13HXAgqp51njIiDh1d4Brymg36pVV7wapZ8D0mS4MNALlW1Q
 ZrX1wqg8748ZJRKEJK+fJFkTyRHSWOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717778904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DqBRYUchN9h/56GEqasXWBUlF8vCqUGO/niIQ1ZAxjA=;
 b=owQi7HUAdDvSGt+5+F9a6NpVIMKiSCttwHlSSGgjcR12asMvv2hR6KFDTbzXU5x083K4RA
 MjIM+eoWiuUOE2Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717778903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DqBRYUchN9h/56GEqasXWBUlF8vCqUGO/niIQ1ZAxjA=;
 b=ZPx3EC4IeaojJaI3grPLSNQkGTWzg1ADYCWGu5cu4lrRoMB+CUv7MaRO/dpr7waflHCMKo
 juH/QbGZNTQ94qv4q500PgZOw2ehMbYH0We5azwHrfGrFC2yBx8wzYQijbXsMTg4PQq13O
 Im2CD/OghH/ax9WRSYXTXMXrRgPFSlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717778903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DqBRYUchN9h/56GEqasXWBUlF8vCqUGO/niIQ1ZAxjA=;
 b=DngntAxhsB8v5H5LQ6FBcFMyxWWFtG35DlneOi2FusTF8YZYbO4SZpYcCAtZV0A3Yf9j5g
 dRXZrZka0hDV3NBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3B10133F3;
 Fri,  7 Jun 2024 16:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lYxjM9c5Y2acNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jun 2024 16:48:23 +0000
Date: Fri, 7 Jun 2024 18:48:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tim Bird <tim.bird@sony.com>
Message-ID: <ZmM5y3a4xNCsRTT-@yuki>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <SA3PR13MB6372C183B9989156CF692F5CFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SA3PR13MB6372C183B9989156CF692F5CFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I'm in the same position as Richard here.  Fuego uses runltp on the target (device under test),
> and has it's own mechanisms for detecting timeouts or kernel crashes, gathering test output,
> restarting targets, etc. from a test host.  These same mechanisms are used for other tests.
> Fuego also has mechanisms for running individual LTP tests on the device (by installing the
> individual test, executing it, gathering results remotely, and removing the test and test artifacts).
> This is used in cases where the overhead of installing and running runltp is too big.  I haven't
> investigated kirk yet (but it was on my list of things to do).

If you are executing a single test you do not need runltp. The current
added value of runltp is that it loops over all tests in a set of
runtest files, collects the results and saves overall status. If you
want to run a single test, you need to set up a few environment
variables and you are good to go.

> Will kirk and/or LTP provide a simple mechanism for quick install and execution of
> individual tests or small sets of tests (and itself)?  Fuego's model of testing is geared towards
> testing of production devices, where no test artifacts are pre-installed on the target,
> and full cleanup (removal of tests and test artifacts) is done between tests.

Currently installation is completely out of scope for kirk. The workflow
we have expects LTP installed and first step kirk does is to download
runtest files and metadata from the device under test.

And I'm perfectly aware that single workflow will not fit everybody,
that's why my initial idea was a set of reusable components rather than
a full solution.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

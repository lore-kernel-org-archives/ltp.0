Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87C9C25B76
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 08:43:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88CF63D0B9F
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 10:43:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A921D3D0B5C
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 10:42:47 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D47C21A0118B
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 10:42:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C19322D6B;
 Tue, 11 Jun 2024 08:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718095365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IO1JfO6p9bJZ9gnpSPiS32Un89j7+xlPxGRVOC/2JVg=;
 b=WU24NVdIUdyGo9r5bs/AaRV/kj+sBGrH0E6CkzUF3rJXXMpxEBzPur1pRByewpGqB4WHm4
 F/r+hbx79rNS1i7CacTWGfOfgD4KUgiHdqfCj4Ebn8BtkwBCnVCXKfPS0USaBlJEO/cXBp
 AVp6rbWqMeewHFVBpa3DwRtGKOQ+6K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718095365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IO1JfO6p9bJZ9gnpSPiS32Un89j7+xlPxGRVOC/2JVg=;
 b=ZWfLi1FXNqxS5xe+345m7L0hcgczy8e47q1h7iQzcbzia/ni+E/MGdmNZHCpMWimkHB/iN
 hrHwxd/lPVIYJWBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718095365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IO1JfO6p9bJZ9gnpSPiS32Un89j7+xlPxGRVOC/2JVg=;
 b=WU24NVdIUdyGo9r5bs/AaRV/kj+sBGrH0E6CkzUF3rJXXMpxEBzPur1pRByewpGqB4WHm4
 F/r+hbx79rNS1i7CacTWGfOfgD4KUgiHdqfCj4Ebn8BtkwBCnVCXKfPS0USaBlJEO/cXBp
 AVp6rbWqMeewHFVBpa3DwRtGKOQ+6K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718095365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IO1JfO6p9bJZ9gnpSPiS32Un89j7+xlPxGRVOC/2JVg=;
 b=ZWfLi1FXNqxS5xe+345m7L0hcgczy8e47q1h7iQzcbzia/ni+E/MGdmNZHCpMWimkHB/iN
 hrHwxd/lPVIYJWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BD34137DF;
 Tue, 11 Jun 2024 08:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ej7SBQUOaGbbYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 11 Jun 2024 08:42:45 +0000
Date: Tue, 11 Jun 2024 10:42:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <ZmgN_gG87wZLK1gY@yuki>
References: <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <4a19e93b-b009-4b0f-9be8-8c348a9ab214@suse.com>
 <SA3PR13MB637200A7A377000193BAF3D2FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SA3PR13MB637200A7A377000193BAF3D2FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_EQ_ADDR_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > No, but it provides something better than that: a JSON file that can be
> > easily parsed by most of the libraries out there.
> > kirk can be literally used as it is runltp, with difference of python
> > dependency. If you have python, you can run kirk on
> > host as well as on target. All features like Qemu, LTX, SSH (etc.)
> > supports are meant to be used by host only.
> 
> The python dependency is unfortunate.  In Fuego, we have carefully
> avoided any dependencies on the target other than those that can
> be provided by busybox (or toybox or toolbox).  This includes limiting all
> test programs to either native binaries or shell scripts using  just POSIX
> shell features.
> 
> It sounds like kirk won't be useful to my project.

I guess that it has been cleared up in the rest of thread but let me
repeat the point here. The python code is not supposed to be run on the
device under test, you can do that but it's suboptimal.

The ltx is the minimalistic tool that should run on the device under
test and that needs only libc and some kind of byte oriented connection
to the kirk runnig elsewhere.

I would say that the desing is sound, the implementation needs to be
finished to make it production ready. However we will not remove runltp
until kirk is 100% functional and tested in our production.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

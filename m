Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34B4CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 11:48:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53F2C3CDEC7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 13:48:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2F2E3CDEA0
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:48:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4E32E60072D
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:48:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5CF0221A7;
 Tue, 23 Sep 2025 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758628119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDp/OjQltzBm7EQHmFxXrNytYxVx4wODQxRi/EUTN/o=;
 b=Xh+OghcqseI8ANf/MMdEpdDitvBvG8A32GAXDMBZQLBjTtBaB1bbFLcmyJRSlLEzNS+Waa
 oHfXv1ehUZl7pS9mHPyoTGs7IsgxnB8xDPY3Cmeybe65reLGMoGsosRX/h0tnrjoUbF60+
 JuMyeBnxab4pzj/6CV69gs5eEurg57Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758628119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDp/OjQltzBm7EQHmFxXrNytYxVx4wODQxRi/EUTN/o=;
 b=I9+RIbsx0K2x94nV94NEILvwYATN0FxoRGC114+HJcSfX1OLGHvOUu9kfr63aUL+muppf3
 A06wef05Ba/hkDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758628118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDp/OjQltzBm7EQHmFxXrNytYxVx4wODQxRi/EUTN/o=;
 b=zJw7G5aR5bDyF6LdQxoGhYmTpzyQbLSTx9+89j2gsxYZtiWjKQjgEomNvPhxan4UFO4WcB
 FfNw6hyL7dudyEwEJ6Gz9MbmOOYY70xDj1WnuY9uqU5dcsZdQ0zHITEHqKR4nfyzrPmC9R
 QuxiUFNE4Gskc9RAiu9CoQTNqthDxDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758628118;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDp/OjQltzBm7EQHmFxXrNytYxVx4wODQxRi/EUTN/o=;
 b=h03eoXdEqmDy/HawrskHSA/NahRTad8Baguw5FsfrLJM2Wm1I0V08fDHZLOrEDniWB+7Pt
 9RHup9jOFKWXQyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19261388C;
 Tue, 23 Sep 2025 11:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eqCXJhaJ0mj+CQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 23 Sep 2025 11:48:38 +0000
Date: Tue, 23 Sep 2025 13:49:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aNKJP8fKNn6JcT5I@yuki.lan>
References: <20250922210723.GA44059@pevik>
 <20250923075118.29757-1-akumar@suse.de> <aNKBrcI4ZuHL8RE0@yuki.lan>
 <20250923113912.GA15673@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250923113912.GA15673@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Introduce ioctl_pidfd_get_info_supported()
 function
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
> > Generally I do not like this code that much, since we depend on the fact
> > that we get ESCHR from the syscall if PIDFD_INFO_EXIT is not
> > implemented. Without the PIDFD_INFO_EXIT flag the pidfd_info() syscall
> > is supposed to work on a process before it's waited for and
> > PIDFD_INFO_EXIT does not work before the process is waited for, mixing
> > these two checks is a bit ugly.
> 
> Avinesh, I'm sorry, I see my suggestion to reuse code to detect PIDFD_INFO_EXIT
> for checking PIDFD_GET_INFO was not a good idea. It'll be clearer to have them
> separated.

We went through a few iteration of the check with Andrea before we
arrived at a working version. Sometimes detecting features gets
complex...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

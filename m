Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AF8C3DA42
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 08:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9AAB3D1AB9
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 10:50:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 881C63D0C40
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:49:52 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CBF61A0BC31
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:49:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE86521991;
 Wed, 17 Jul 2024 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721206190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPpGIeZvFpAfN+ZR9t4R7deq7OX6k9nccrTCy3Uq3s8=;
 b=Rh6+i9FFCxyteaVcEzbltep+NYHdaL3N8RMG3xfij8klqihkciYCJpdyRPZ63oZ91UvL0Y
 1SbQfgnJ7ftvo1rW5wvWpaoTAx14YMFYPyOJR3quVA729fpbaK2E6prGxxo3AILGt7C6+o
 mpOX5G/Cnf6CDDVBw5GPMp4nh/hi+YI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721206190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPpGIeZvFpAfN+ZR9t4R7deq7OX6k9nccrTCy3Uq3s8=;
 b=kfAX3/cX1lFyKe2WN4mdUWSBoStoDq1bkSLW39gaaNFeLbwXbnU0OqBXvqI3g+U53Cj9BE
 LGiuXqHDmxnKeUDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721206189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPpGIeZvFpAfN+ZR9t4R7deq7OX6k9nccrTCy3Uq3s8=;
 b=E0rrxn4A1FA3c4CgtmwHcRexaw7Ufa12XrOrucXD508rJNzEeUeNUbEV6VmA6t5uU01Okx
 7XOe4fgRQdFfGtYR2hwdA59tf85CLgrBxmJ056sRR7CqZiQaaeIHrpz9hb3cMXGg8Xgmj1
 1VrJbJOBoADDXVTDk+/qTmBf86pSIFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721206189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPpGIeZvFpAfN+ZR9t4R7deq7OX6k9nccrTCy3Uq3s8=;
 b=1vAzWGG99DKuVVG7w1PGQ9bX3p7V5TfuH48A7+KDC2LAne/TPdtVZonpl7Pb8stR8MP9dJ
 Sdk+v0GYpCCl8kAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD9F21368F;
 Wed, 17 Jul 2024 08:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 60gNNa2Fl2baGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jul 2024 08:49:49 +0000
Date: Wed, 17 Jul 2024 10:52:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZpeGRluc-U1NHjNY@rei>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <CAEemH2cAfjhGLv3GWPA_5xgsFNYiRf-oQwyLPhbWWSPKn=yAhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cAfjhGLv3GWPA_5xgsFNYiRf-oQwyLPhbWWSPKn=yAhw@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
> Since execvpe() is a GNU extension, we need to ensure that
> we are compiling with GNU extensions enabled.
> 
> add this line into the head of tst_test.c:
> #define _GNU_SOURCE

As for the execvpe() I've used that for the prototype but I'm unsure if
it could be used in the final product, since this is the test library it
has to compile on all kinds of libc out there. It looks like musl does
support it but I haven't checked Android bionic.

So we may need to write our own implemtantion on the top of the execve()
syscall. But that should be as easy as getting the path to the script
before we pass it to execve().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

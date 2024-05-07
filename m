Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99762C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 09:37:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81BDD3CDC8C
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 11:37:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64D963CD61B
 for <ltp@lists.linux.it>; Tue,  7 May 2024 11:36:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 760AA14317C3
 for <ltp@lists.linux.it>; Tue,  7 May 2024 11:36:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6DA820716;
 Tue,  7 May 2024 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715074603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YpfZrYW+S/PNOEudnxwMQB+vOJRATdA/SgWwhaYtpJg=;
 b=YPQ2R8iM+q8EFyADf03b5K4D1OEd+BkIAhysbDZkfe0WJ75/NWcummyG7GwLVtkbdE6PNe
 0YiXgGFEA8ANbZ+LmvSzl46FkDbTL0akyjJWM37bfOX19lVH/3P8BG0SbWqgJNAmhsrVnM
 NY7JiEc1asfA5wqKYzGsHGBrtKReqUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715074603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YpfZrYW+S/PNOEudnxwMQB+vOJRATdA/SgWwhaYtpJg=;
 b=/32SR+B0gifkVeItmqpBDKYxSt028SXUU+gcmy/i7SzRKzK7nrnvU1D9WPSRTJzcb9FLyA
 1PfyizUKs/cV+YDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M1yHlcJa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Es5AgUe8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715074602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YpfZrYW+S/PNOEudnxwMQB+vOJRATdA/SgWwhaYtpJg=;
 b=M1yHlcJaXsRi+gFh/gJD0asTkT+PNtyf9pSaz32D0zOFld39MYpSBpwdNhvPYTsJ4ctvwb
 xaWSpTHs6YznwFn2EhE4h5keW4+mQ5OfT9ejuuIh/r1o9WzuazZQvi2/Di2NQ6l68CHGyV
 bcmGQ3/Nd3cHi998GO8PNJPVuf+wO/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715074602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YpfZrYW+S/PNOEudnxwMQB+vOJRATdA/SgWwhaYtpJg=;
 b=Es5AgUe87eHDg96kYCLjEdgIDaGF5oT7dDiXVwtBH2DLFOaby726syGz/rD7fcWx2b63VV
 /8WjMB6yrDGj6zDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6FF413A2D;
 Tue,  7 May 2024 09:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vOe2Kyr2OWaoUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 May 2024 09:36:42 +0000
Date: Tue, 7 May 2024 11:35:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: John Stultz <jstultz@google.com>
Message-ID: <Zjn1-1YRyZGIUtEP@yuki>
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C6DA820716
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Wouldn't it make more sense to use the include/tst_atomic.h now instead
> > of the functions from librttest.h. At least the version in the
> > tst_atomic.h have proper memory barries for load, fallback in the case
> > that compiler does not support __atomic_foo(), etc.
> 
> I don't object, but trying to include tst_atomic.h causes lots of
> redefinition warnings for PACKAGE, PACKAGE_*, and VERSION which are
> also set from librttest.h -> realtime_config.h
> 
> Suggestions on how to proceed there?

The problem obviously is that we have two different config.h files that
conflicts.

Given that there isn't much in the realtime/configure.ac and these
checks does not seem to be relevant anymore it would make sense just to
get rid of it.

What we check for:

PTHREAD_PRIO_INHERIT - likely required for LinuxThreads vs NPTL
exp10 - seems to be supported in glibc since 2.1
__sync_add_and_fetch() - not needed when include/tst_atomic.h is used

Other than that the realtime/configure.ac contains stale data such as
defunct email to the ltp sourceforge mailing list which should be
removed anyways.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

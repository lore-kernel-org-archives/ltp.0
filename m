Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73C6E9B249
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:44:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C1513D0F85
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 11:44:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A8213C7721
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:44:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F101B200747
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:44:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA3C03F18E;
 Tue, 24 Feb 2026 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771929876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2n7vg3lVsGWSikiYzYVzdXON3ZvbTXywyQ/+cDn5pM=;
 b=oG8W3NUH5O4Xajy9106BuEeO54VVJ+nDjNlpyabhq9DgKWefuEC8aKzEFU65mKhKSkNeuo
 P/+BVBhvZTty3/6rMzPR/PkQip5ow1odJixZhDno6X4vaXXqlhB+RyFEZo3vSMIBgL8Ql3
 +FBNzzWCjdHkYFljUDu4prpOhreSllc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771929876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2n7vg3lVsGWSikiYzYVzdXON3ZvbTXywyQ/+cDn5pM=;
 b=LXwrDIod42p6HFqSAewQEnSNbKO1SNMwNIErKJn7hU/Pp+RmKFLSfeo51szAsPbSnqsdCX
 4AEwG/wGgfnrbfBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771929876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2n7vg3lVsGWSikiYzYVzdXON3ZvbTXywyQ/+cDn5pM=;
 b=oG8W3NUH5O4Xajy9106BuEeO54VVJ+nDjNlpyabhq9DgKWefuEC8aKzEFU65mKhKSkNeuo
 P/+BVBhvZTty3/6rMzPR/PkQip5ow1odJixZhDno6X4vaXXqlhB+RyFEZo3vSMIBgL8Ql3
 +FBNzzWCjdHkYFljUDu4prpOhreSllc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771929876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2n7vg3lVsGWSikiYzYVzdXON3ZvbTXywyQ/+cDn5pM=;
 b=LXwrDIod42p6HFqSAewQEnSNbKO1SNMwNIErKJn7hU/Pp+RmKFLSfeo51szAsPbSnqsdCX
 4AEwG/wGgfnrbfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E5613EA68;
 Tue, 24 Feb 2026 10:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xgI+IBSBnWkEWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 24 Feb 2026 10:44:36 +0000
Date: Tue, 24 Feb 2026 11:44:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aZ2BGwrdHKeaxXkD@yuki.lan>
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik> <aZyGMpdvgFXoYjHb@yuki.lan>
 <20260224093820.GA37927@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260224093820.GA37927@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it,
 Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > And with that we would need some kind of "master file" that would
> > explain which script should be executed on which host etc. But I guess
> > that it would be tricky to desing this properly.
> 
> I'm not sure if separated file is worth of adding. There is tst_rhost_run()
> function which should be used for checking, which works well on both netns and 2
> host based setup (that's why v2).

This is just me thinking if we can actually desing something more proper
in the future now that runltp is gone. I think that the whole
tst_rhost_run() infrastructure is a bit of a hack and that the
multimachine test can be desingned differently. I would say that more
proper solution would be to have the test split into one script per
worker and having some master script/description to drive the testing.
The testrunner would read the information about which script to run on
which worker and would also have to handle synchronization.

In the case of the NFS tests the master script would say to run a script
that sets up NFS server and signal the testrunner once it's done and
wait. The script that would be doing the actuall test would be executed
once the the NFS server script to signaled it's completion and then
start the actual test. Once it's finished testing it would exit, which
would tell the testrunner to wake up the NFS server script in order to
cleanup. If we decided to write multimachine tests this way we would
need to add a way how to pass parameters such as IP addresses from kirk
to tests and also add a way how to propagate events between tests via
kirk so that we can have some kind of locking.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

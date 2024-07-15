Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C239FC3DA4B
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 12:44:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FA623CDECA
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 14:44:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7D683CDECA
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:44:26 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2AA814010F0
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:44:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0653D1F80C;
 Mon, 15 Jul 2024 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721047465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lg93mFJ44NTzFjO4DLavPbkHq6axEtJJjz6LTGY52I0=;
 b=PIR+5OVGI9utjfd7X42k7wriV1CWlnOKhg3dxv465iGMo864oCjafqPNzjo0kUSp8O4esl
 /GqAMOREa7+Vke+aYh7eS7WOawfxrbjOdoQToILg7DZ3BNYX5KP+eWSYXeMR7jfbRg1Ltu
 W1UtvQ9Y+yPQtD6WdOA0KSoB1SLRQGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721047465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lg93mFJ44NTzFjO4DLavPbkHq6axEtJJjz6LTGY52I0=;
 b=ZTGR5pgskqHB6oKaxaer/4bcihOGXZRw5f6z8kUOhvD7GweIfRfk5y1gn6M0mpABWnXt1a
 ljQVM4pjeDLhsLAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721047465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lg93mFJ44NTzFjO4DLavPbkHq6axEtJJjz6LTGY52I0=;
 b=PIR+5OVGI9utjfd7X42k7wriV1CWlnOKhg3dxv465iGMo864oCjafqPNzjo0kUSp8O4esl
 /GqAMOREa7+Vke+aYh7eS7WOawfxrbjOdoQToILg7DZ3BNYX5KP+eWSYXeMR7jfbRg1Ltu
 W1UtvQ9Y+yPQtD6WdOA0KSoB1SLRQGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721047465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lg93mFJ44NTzFjO4DLavPbkHq6axEtJJjz6LTGY52I0=;
 b=ZTGR5pgskqHB6oKaxaer/4bcihOGXZRw5f6z8kUOhvD7GweIfRfk5y1gn6M0mpABWnXt1a
 ljQVM4pjeDLhsLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A172B137EB;
 Mon, 15 Jul 2024 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TWNcJagZlWZKSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Jul 2024 12:44:24 +0000
Date: Mon, 15 Jul 2024 14:44:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240715124423.GC424468@pevik>
References: <20240711104400.63355-1-pvorel@suse.cz>
 <20240711104400.63355-2-pvorel@suse.cz> <ZpERtIxWiodTJiYS@rei>
 <20240712132205.GA145191@pevik> <ZpE5q627g9bpxfwj@yuki>
 <20240712190926.GA399927@pevik> <ZpTmyoh2J1zvWHwO@yuki>
 <20240715095213.GA424468@pevik> <ZpT8QdtUZydGj6lN@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZpT8QdtUZydGj6lN@yuki>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] sched_football: Rewrite into new API
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
Cc: John Stultz <jstultz@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > And the main problem with our build system is not the tooling we choose,
> > > but the complexity imposed by the out-of-tree build implemented in the
> > > complex makefiles. As far as I can tell 99% of the problems would be
> > > solved by ripping out out-of-tree support, which would remove most of
> > > the code we have in there.

> > +1 for removal. I wonder if anybody finds a time to do that.

> That is unfortunatelly a major task...

> > > > But back to the reality, would it be possible to merge this even with broken
> > > > dependency? I'm not sure myself.

> > > I will double check the code, before adding my final reviewed-by.

> > Thank you! It still bothers me that building sched_football does not trigger
> > building a library, but at least it will work for a full build (building whole
> > LTP).

> It's even more subtle, there are more things to consider. The test
> should be rebuild even if any of the headers it includes change, which
> is not detected properly at the moment. For that to work first thing the
> build system has to do is to generate a dependencies with $(CC) -MM and
> then include them in the build system.

Cool, it really detects required headers.
$ gcc -MM  -I../../include tst_needs_cmds04.c
tst_needs_cmds04.o: tst_needs_cmds04.c ../../include/tst_test.h \
 ../../include/tst_common.h ../../include/tst_res_flags.h \
 ../../include/tst_parse.h ../../include/tst_test_macros.h \
 ../../include/tst_checkpoint.h ../../include/tst_checkpoint_fn.h \
 ../../include/tst_device.h ../../include/tst_mkfs.h \
 ../../include/tst_fs.h ../../include/tst_pid.h ../../include/tst_cmd.h \
 ../../include/tst_cpu.h ../../include/tst_process_state.h \
...
 ../../include/tst_cgroup.h

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

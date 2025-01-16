Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B93C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 16:12:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 246DE3C7C0E
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 17:12:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B41B93C4CED
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:12:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3FBE61BDD08F
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:12:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C4D22116C;
 Thu, 16 Jan 2025 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737043955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9hoBaWef2t+jwuMnVFxlOJZqHdoqNyU48NwFSzoHce0=;
 b=DMelqGn3PTCLkhC4fmHWWgwBHq+X5BL9JHkVmtwYuRhgn+42IrpCI7oZb8gOtfycupvdBV
 RvOKNb3WznIVy/PmRa+Lh6g0UvWieAahp8zfeb4DuBjqXjMnHCEScO2CTw/Wlveb9MlubW
 4ll5Li0SmDiD7+r1wPVvTjafGRu/b8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737043955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9hoBaWef2t+jwuMnVFxlOJZqHdoqNyU48NwFSzoHce0=;
 b=M2v+BIlyt96Qot94Lb3IgD7yKRfRASBQ5ZMZh//86HaK5t6szKozUJ5O5qiYpgGpggEpmY
 9ztpI+fmFsWyCkBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737043955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9hoBaWef2t+jwuMnVFxlOJZqHdoqNyU48NwFSzoHce0=;
 b=DMelqGn3PTCLkhC4fmHWWgwBHq+X5BL9JHkVmtwYuRhgn+42IrpCI7oZb8gOtfycupvdBV
 RvOKNb3WznIVy/PmRa+Lh6g0UvWieAahp8zfeb4DuBjqXjMnHCEScO2CTw/Wlveb9MlubW
 4ll5Li0SmDiD7+r1wPVvTjafGRu/b8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737043955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9hoBaWef2t+jwuMnVFxlOJZqHdoqNyU48NwFSzoHce0=;
 b=M2v+BIlyt96Qot94Lb3IgD7yKRfRASBQ5ZMZh//86HaK5t6szKozUJ5O5qiYpgGpggEpmY
 9ztpI+fmFsWyCkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31CC613A57;
 Thu, 16 Jan 2025 16:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N/s9CvMviWf1HgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jan 2025 16:12:35 +0000
Date: Thu, 16 Jan 2025 17:12:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z4kv5tqVaCgF1gUJ@yuki.lan>
References: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
 <Z4kqqIQlgj4QF21X@yuki.lan>
 <CAASaF6y6_j=fy3XQ-a14t6dm3f9RD0O1bCqiWrDptVw0q3CWAA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6y6_j=fy3XQ-a14t6dm3f9RD0O1bCqiWrDptVw0q3CWAA@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix opened fd leak
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > In cases where worker completes specified number of `iterations` before
> > > oper completes all `total_ios`, such oper remains on active_list.
> > > This is a problem because cleanup only walks over finished list,
> > > and closes fds only for items on this list. So it's possible for
> > > test to exhaust ulimit for open files and fail:
> > >
> > > $ ./aio-stress -a1 -I100 -o2 -r4 -f1 -d1^
> > > aio-stress.c:1347: TPASS: Test passed
> > > aio-stress.c:1285: TINFO: starting with random write
> > > aio-stress.c:1296: TINFO: file size 1024MB, record size 0KB, depth 1, I/O per iteration 1
> > > aio-stress.c:1298: TINFO: max io_submit 1, buffer alignment set to 4KB
> > > aio-stress.c:1300: TINFO: threads 1 files 1 contexts 1 context offset 2MB verification off
> > > aio-stress.c:1314: TBROK: open(file0.bin,1052738,0600) failed: EMFILE (24)
> >
> > Looks like the test has many options and some combinations may set
> > things in a way that does not make much sense.
> 
> I think the options I saw in failures were defaults, the "-a1" above I
> added to reproduce it faster.

That's entirely possible, given how complex the options for the test
are and how they are connected to each other. I guess that we can try to
figure out how they are working together given enough time and large
enough piece of paper, however I'm not going to have a time for that
before we stabilize LTP for the January release.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EB3C27C4F
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 02:30:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D7573D0B47
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 04:30:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A9693C9430
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 04:29:52 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE15C600D63
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 04:29:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 223E82036C;
 Tue, 11 Jun 2024 02:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718072989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
 b=sGgGM0tZZ3ni9LHXf083sO61ArvvEGZ4D66I35vZ6DnsNFzACFLO1oTG+PCfeNT6Y2J/j6
 Ho0PxzD8WeBYxFnKtp3Z/405vsNj2NbbuQPRRHj8v4kG3v/ZqWFdhJhaXVuKThO0rxqE+5
 dWktFl6Pz8m3lrb2sym68SQgnJRwIck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718072989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
 b=et/mc+f8i1I3Gk/L6wkVs6k4p2WaOwsYdFyTO6XjJNTY7DEuWV/hp3dC3zoG/4T0q0w/L8
 igqspgdDlMM+2SBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718072989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
 b=sGgGM0tZZ3ni9LHXf083sO61ArvvEGZ4D66I35vZ6DnsNFzACFLO1oTG+PCfeNT6Y2J/j6
 Ho0PxzD8WeBYxFnKtp3Z/405vsNj2NbbuQPRRHj8v4kG3v/ZqWFdhJhaXVuKThO0rxqE+5
 dWktFl6Pz8m3lrb2sym68SQgnJRwIck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718072989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
 b=et/mc+f8i1I3Gk/L6wkVs6k4p2WaOwsYdFyTO6XjJNTY7DEuWV/hp3dC3zoG/4T0q0w/L8
 igqspgdDlMM+2SBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE966137DF;
 Tue, 11 Jun 2024 02:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MNs4IJq2Z2ZifQAAD6G6ig
 (envelope-from <neilb@suse.de>); Tue, 11 Jun 2024 02:29:46 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "James Clark" <james.clark@arm.com>
In-reply-to: <01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.com>
References: <>, <01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.com>
Date: Tue, 11 Jun 2024 12:29:42 +1000
Message-id: <171807298283.14261.13687949173694068461@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.26 / 50.00]; BAYES_HAM(-2.96)[99.82%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC
 correctly.
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
Cc: linux-nfs@vger.kernel.org, broonie@kernel.org, Aishwarya.TCV@arm.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 07 Jun 2024, James Clark wrote:
> 
> Hi Neil,
> 
> Now that your fix is in linux-next the statvfs01 test is passing again.
> However inotify02 is still failing.
> 
> This is because the test expects the IN_CREATE and IN_OPEN events to
> come in that order after calling creat(), but now they are reversed. To
> me it seems like it could be a test issue and the test should handle
> them in either order? Or maybe there should be a single inotify event
> with both flags set for the atomic open?

Interesting....  I don't see how any filesystem that uses ->atomic_open
would get these in the "right" order - and I do think IN_CREATE should
come before IN_OPEN.

Does NFSv4 pass this test?

IN_OPEN is generated (by fsnotify_open()) when finish_open() is called,
which must be (and is) called by all atomic_open functions.
IN_CREATE is generated (by fsnotify_create()) when open_last_lookups()
detects that FMODE_CREATE was set and that happens *after* lookup_open()
is called, which calls atomic_open().

For filesystems that don't use atomic_open, the IN_OPEN is generated by
the call to do_open() which happens *after* open_last_lookups(), not
inside it.

So the ltp test must already fail for NFSv4, 9p ceph fuse gfs2 ntfs3
overlayfs smb.

Can you confirm is that is, or is not, the case?

Thanks,
NeilBrown

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

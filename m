Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A82C43458
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 12:10:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F3683E4D1D
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F84B3C0039
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 14:10:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 310E91400511
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 14:10:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2643F759CE;
 Mon, 29 Jun 2026 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782735002;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4etdNwdrqdiYxLM3PmQ0f83LgVjyUJz5TqMt+bK3CMo=;
 b=qTF7vlMNAIyQUZqrgZr24eyHAf6p1aaRODRusyxxziwAAIw95xKAH6pntbnCFbIyYMBIsO
 Kam2j2O3dbJ25K37160u8qNWe2IRCIAlTiTmkmdEGWnU7Ls/O00Ra05F0tw/9tE6qlusDx
 NfjGDjOqRv+8zaxUh+iFbnvC4Zh4MX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782735002;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4etdNwdrqdiYxLM3PmQ0f83LgVjyUJz5TqMt+bK3CMo=;
 b=XFUmL7NWCyTibIhrptaaAfo7b08TvuYaJozx0W5hM+XDk6NfY3NNYwUWibaV5CBNzFhC3H
 k814r90SFYpUd2Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y7Djf6ax;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RyPxxX0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782735001;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4etdNwdrqdiYxLM3PmQ0f83LgVjyUJz5TqMt+bK3CMo=;
 b=Y7Djf6ax7WFMT59w5ZxjfmkPF+P6G7YsYgrmjwT36ewhdhNhD23/T0SeLjQn5KoUnpJIKu
 gXzcvGotcd1sVYzY2eTQhNIElUbJeN7QmqBDvRZH6HjJVn0DQJFapdx4hsX9rpYADh3kyd
 YeEmemBzgP90qkWEJ1D0h35Q/DU6MeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782735001;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4etdNwdrqdiYxLM3PmQ0f83LgVjyUJz5TqMt+bK3CMo=;
 b=RyPxxX0ENUR8GqZ+92HngF3Y1SToxc310UmAdN1rWQc5qeq1Ew1Pf8YHyNUduwQ/JCvORz
 7WiCLTp3PWlLChAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2E10779A8;
 Mon, 29 Jun 2026 12:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id waTCOZhgQmpZAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jun 2026 12:10:00 +0000
Date: Mon, 29 Jun 2026 14:09:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Layton <jlayton@kernel.org>, Linux Test Project <ltp@lists.linux.it>,
 Mark Brown <broonie@kernel.org>
Message-ID: <20260629120959.GB385134@pevik>
References: <20260626-master-v2-1-d1365499b710@kernel.org>
 <akDDQ_eT17mvMOjo@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <akDDQ_eT17mvMOjo@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2643F759CE
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl10: fix the sscanf() call to handle
 64-bit inode on 32-bit arch
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Fri, Jun 26, 2026 at 02:20:01PM -0400, Jeff Layton via ltp wrote:
> > This test started failing recently on arm32, when we switched the
> > kernel to displaying the full 64-bit inode number in the maps file.
> > Change the testcase to allow for a full 64-bit inode number on all
> > arches. The value it's compared to is already 64-bits, so widening
> > this field is all that is necessary.

> > Reported-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>

> Reviewed-by: Li Wang <li.wang@linux.dev>

Merged, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10163D0C5F4
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 09:38:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C9C93C72AA
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 11:37:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35A5E3C7245
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 11:37:42 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6A5C9200C30
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 11:37:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8B9D1F7E0;
 Fri, 25 Oct 2024 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729849059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/NhJnxP+yRF1raAUexCQA1bektHdPi6ZddGSLb/BzQ=;
 b=eT1j+kaO6bXV40XxnYXNwZ6zVFoq27sdmtS5a+Rr6MdFPJLvQ7RLaV18quoK+qnoHJPfU4
 BhGpbMeuP5XdkmntMY1Y0EBT/fnrBaX1b2n2D38Zib9z94qxcG44gnXHYNSykCIr1PA30x
 uApDA5+yUZNr+HmXxFDPfrLUrFwGzUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729849059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/NhJnxP+yRF1raAUexCQA1bektHdPi6ZddGSLb/BzQ=;
 b=0nYvntp5zhkrEbHMn1orIZNWF2y0QxvDn1tpPqPI7EIcvICQIhGF8YaxaYz2Gi2C6BHluC
 OOPJEzqFDBTXl9Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aJ4THWQV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h9gYEMm7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729849058;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/NhJnxP+yRF1raAUexCQA1bektHdPi6ZddGSLb/BzQ=;
 b=aJ4THWQVXEtSFekJVjqnhPX3fdMZsE752ome3hnnjxJiXpEyVTsRRXiYyZOo7aApubgEvn
 Nj0ekP1e/WGxhdGLZAAJQ2m7oTo1zmvq2BLNyYzPKrBelEXjIUNFy2YPeTtEKveBD2OgB/
 FklaU+cCY6ZxdchieOZAUsjK/OTcwfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729849058;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/NhJnxP+yRF1raAUexCQA1bektHdPi6ZddGSLb/BzQ=;
 b=h9gYEMm7aXJEKySQOh60tRqHY1/eTmZIiLK24V5y3foNDKdW3MSy6wOuqc0jFdezl5RdIC
 H1nKCK5V7me30xAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E946132D3;
 Fri, 25 Oct 2024 09:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PT3PGOJmG2fueQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Oct 2024 09:37:38 +0000
Date: Fri, 25 Oct 2024 11:37:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20241025093732.GA682542@pevik>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
 <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
 <CAEemH2fyP++1HsNyN_EUjOAXj+XOKjnMXs4muzP-V4Dtnq1PQg@mail.gmail.com>
 <20241015171717.GA36237@pevik>
 <69c655f5-3635-48c7-a925-544ad2af05ca@suse.com>
 <20241023125707.GA594199@pevik>
 <2857ad7b-9d0f-496b-bed8-566508d7b9d8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2857ad7b-9d0f-496b-bed8-566508d7b9d8@suse.com>
X-Rspamd-Queue-Id: C8B9D1F7E0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> On 10/23/24 14:57, Petr Vorel wrote:
> > Hi Andrea,

> > > Hi Petr,
> > ...
> > > > Also, this 4th patch also does not apply. Unlike first commit there are more
> > > > conflicts (applying of course on the top of the 3 previous patches):
> > > > Description: [v4,4/4] Update syscalls files
> > > > Applying: Update syscalls files
> > > > error: patch failed: include/lapi/syscalls/arm.in:1
> > > > error: include/lapi/syscalls/arm.in: patch does not apply
> > > > error: patch failed: include/lapi/syscalls/arm64.in:294
> > > > error: include/lapi/syscalls/arm64.in: patch does not apply
> > > > error: patch failed: include/lapi/syscalls/ia64.in:341
> > > > error: include/lapi/syscalls/ia64.in: patch does not apply
> > > > error: patch failed: include/lapi/syscalls/x86_64.in:349
> > > > error: include/lapi/syscalls/x86_64.in: patch does not apply
> > > > Patch failed at 0001 Update syscalls files
> > > This is really strange. It's not happening for me even with the latest HEAD.
> > > Did you rebase first?
> > I was applying to the master (as I wrote first I need to adjust first patch
> > which also didn't apply, but that's just a single line). Don't bother if the
> > problem is really on my side.  But pushing the patchset to your fork would help
> > me to actually test the code.

> You can check it out here:
> https://github.com/acerv/ltp/actions/runs/11480881574

thanks, but the run points to the b4/generate_syscalls branch [1], which is not the
same as you post as v4. It has 4 commits, but 1st of them "Automatically
generate syscalls.h" [2] is a cover letter without change. And it does not have
the 4th commit [3] which I was unable to apply (the error reported, it's in few
lines above in the email).

Anyway, you got a review from Li, thus feel free just merge what you sent as v4,
no need to resent a new version just because it's not applicable.
I try to have a quick look on v4, but you don't have to wait for me.

Kind regards,
Petr

[1] https://github.com/acerv/ltp/commits/refs/heads/b4/generate_syscalls/
[2] https://github.com/acerv/ltp/commit/7544e1faa28cced4fdd6c47dc81ee5b84fb2ae01
[3] https://lore.kernel.org/ltp/20241009-generate_syscalls-v4-4-5328a785bbad@suse.com/

> Andrea


> > Kind regards,
> > Petr

> > > > Kind regards,
> > > > Petr
> > > Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

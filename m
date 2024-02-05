Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9791AC48291
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 11:04:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272EC3CDF90
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 12:04:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC82E3C8B7A
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 12:04:28 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59D7A1000DD3
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 12:04:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9119C22105;
 Mon,  5 Feb 2024 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707131067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
 b=BDC4N4tL77M7wzLYLPAISimsvrYlWFbo0F7ZUEt3zmNdUQ/taqEKloVf6lkhyp8AgBrVfJ
 j00Q3Y2Rgbo+2or830GQOkfRs8XnbvJAolYJFSEq3yGuCmTBBd7GtHMKevxtcNRRpO/FNV
 br2OnbT489xEsuow/Vjp+2ndtR8z5fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707131067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
 b=lHSJ5A72SdjNmwxr4mkb52PY4X2R8H7kQ+vLPvjtkWjsdww1giYMfT/6envWDBX0X1a3/i
 TbN3Lb4ddAdZ/1AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707131067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
 b=BDC4N4tL77M7wzLYLPAISimsvrYlWFbo0F7ZUEt3zmNdUQ/taqEKloVf6lkhyp8AgBrVfJ
 j00Q3Y2Rgbo+2or830GQOkfRs8XnbvJAolYJFSEq3yGuCmTBBd7GtHMKevxtcNRRpO/FNV
 br2OnbT489xEsuow/Vjp+2ndtR8z5fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707131067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
 b=lHSJ5A72SdjNmwxr4mkb52PY4X2R8H7kQ+vLPvjtkWjsdww1giYMfT/6envWDBX0X1a3/i
 TbN3Lb4ddAdZ/1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1561D132DD;
 Mon,  5 Feb 2024 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C5KCOrrAwGU8OgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 11:04:26 +0000
Date: Mon, 5 Feb 2024 12:04:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
 lwn@lwn.net, automated-testing@lists.yoctoproject.org
Message-ID: <20240205110425.GB201808@pevik>
References: <ZbjZxy4vbxoXUJ-i@yuki>
 <20240203235708.GA164636@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240203235708.GA164636@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.62 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.08)[63.23%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JANUARY 2024
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

> Hi all,

> > Good news everyone,

> > the Linux Test Project test suite stable release for *January 2024* has been
> > released.

> > Since the last release 315 patches by 34 authors were merged.

> > Patch review is what most of the projects struggle with and LTP is no
> > different. If you can spare some effort helping with the patch review is more
> > than welcomed.

> > NOTABLE CHANGES
> > ===============

> FYI, there is missing removal of runtest/connectors [1], which can break some
> tooling.

And we removed also runtest/fsx [2] in this release.

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://github.com/linux-test-project/ltp/commit/9b642d89c0bcf5885b051c2d5768fa94b61d86cb
[2] https://github.com/linux-test-project/ltp/commit/fb2b6a0b3c840aa80229acf4360b7bdc3ced5edb
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

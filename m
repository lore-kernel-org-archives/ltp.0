Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90661C61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:28:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C0463C71FD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:28:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BED93C244F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:28:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F6C4600A2C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:28:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D6E01F7D2;
 Tue, 25 Aug 2026 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYP4qX5oWYpbQnM54hTH/9wLdf40D3Zh+AtNEmOV8C8=;
 b=QjUCEE3fxH0SxraZZiAIrulHUPNv7PAlww6Abh9/SpbS4dIadWsIsAo0QHYjIxIl9phrZs
 bPfOkVCJWhL0lLOPW6X2Js2TB+22J6ZwwqbRUsfLqUkNSNx9f7yI8Z7WE3frApMdKYboiD
 r/fM43UQG3kXg3ZsxyJDW6cuw531G30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYP4qX5oWYpbQnM54hTH/9wLdf40D3Zh+AtNEmOV8C8=;
 b=W6KNfi3hL0B/qoj/ARd63H27Sks2gc/OkB/XffvN4IxzWvfzNJpsAgTX3alEj6lBt2Fdo/
 0UnUHYdEt7E3NkBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VnE8YMy2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z+qfQhxA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYP4qX5oWYpbQnM54hTH/9wLdf40D3Zh+AtNEmOV8C8=;
 b=VnE8YMy2XV21l3T/t4VAzQQnUTK9vn+grDzkibRxnI1SQejMzTLnp4vOJ1p48SJAOzjJe8
 O1iESqCFDwH3Ea7QlzZGGu8YvZvXODUUjv908zo8uajzXcGibvPlIg6NzqHcjFPKPBwLm+
 xfCOjMiDic6PCG5QozN93tUzs123i8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYP4qX5oWYpbQnM54hTH/9wLdf40D3Zh+AtNEmOV8C8=;
 b=z+qfQhxAxecjZJgdPNMV0sUO2VMI1Hz3UKKfGkdDbkZwFL6/h+nA59tnOTbMEJKLJs58LA
 LCzq/B4Hv0M1h1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2117213331;
 Tue, 25 Aug 2026 11:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TxyOAz18jWpGQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 11:27:57 +0000
Date: Tue, 25 Aug 2026 13:27:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260825112755.GA62429@pevik>
References: <ajQFErzQW4qfU_Cp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <6a463902.41a38e5f.27f5bd.337a@mx.google.com>
 <akzN_iISxNTztbEw@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <akzN_iISxNTztbEw@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-Spamd-Result: default: False [1.59 / 50.00];
 ABUSE_SURBL(5.00)[linux.ibm.com:email];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAD_REP_POLICIES(0.10)[]; MX_GOOD(-0.01)[];
 R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto,suse.cz:email,suse.cz:dkim];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 7D6E01F7D2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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

> On Thu, Jul 02, 2026 at 10:10:09AM +0000, Andrea Cervesato wrote:
> > Hi Jan,

> > I seen you implemented in v7.2-rc1:

> > commit 03a43677ca91e3997355a13b1da6e47329b025e1
> > Author: Jan Polensky <japo@linux.ibm.com>
> > Date:   Tue Jun 9 18:21:49 2026 +0900

> >     exfat: add swap_activate support

> >     Commit 07d67f3e9083 ("exfat: add iomap buffered I/O support")
> >     converted exfat buffered I/O to iomap, but did not add a
> >     .swap_activate handler to the address_space_operations.

> >     swapon(2) on an exfat swapfile then fails with EINVAL, which causes
> >     LTP swap tests to fail.

> >     Add exfat_iomap_swap_activate() and hook it into exfat_aops so exfat
> >     uses iomap_swapfile_activate() for swapfile activation.

> >     Fixes: 614f71ca1bdf ("exfat: add iomap buffered I/O support")
> >     Closes: https://lore.kernel.org/all/20260603110212.3020276-1-japo@linux.ibm.com/
> >     Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> >     Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

> > what should we do with your patch in LTP?

> > Regards,
> > --
> > Andrea Cervesato
> > SUSE QE Automation Engineer Linux
> > andrea.cervesato@suse.com

> Hi Andrea,

> Thanks for following up on this.

> On my side (s390x, Fedora 44, kernel v7.2-rc1), I still need both
> patches for the LTP swap tests to pass:
>  1. The kernel fix (03a43677ca91 "exfat: add swap_activate support")
>  2. This LTP patch (adding exfat to tst_fill_file)

> Without the LTP patch, the tests still fail even with the kernel fix
> applied.

> Could you validate on your setup whether the kernel fix alone is
> sufficient, or if you also need this LTP patch? It would be good to
> understand if this is architecture-specific or a general requirement.

> If you can confirm the tests pass with only the kernel fix, we can
> close this LTP patch. Otherwise, one should merge it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

And yeah, we need it in kernel 7.2 on any distro :).

Should we somehow mention relevant kernel commit at least in the commit message?

e.g.: Change needed since 03a43677ca91 ("exfat: add swap_activate support") from
v7.2-rc1.

Kind regards,
Petr

> Best regards,
> Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

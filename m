Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B36FC5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 06:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D40503CA2B3
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 08:56:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA3F33C064C
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 08:56:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D262A20074A
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 08:56:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 281175BD0C;
 Thu,  5 Jun 2025 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749106581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7DmcrhkNIQ/niQtAcDn0EafwzfBhjs/ITtA0DL8NLk=;
 b=l5HBe9FOwBUnRA+lEFmbj2DncCL3BIjP1q/cFSrThjZysEfU8x8sHJLZHQYWsom5mqUF9r
 LuyTeF+MdspZQpF3xGvaVj7/FFQtKguQpc3tjhjU6rPb9bA14obufhqArDlxEVRGUXrJeV
 Y2uQH3UuIxmqtOAJakKw5z1uVmqYQ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749106581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7DmcrhkNIQ/niQtAcDn0EafwzfBhjs/ITtA0DL8NLk=;
 b=+nC0KmnbW5Sq7AM06TucYHGuADFPsw7horx1e2gnjyOuOTJiygXTQCmP1Ireazn2ur/lBF
 2yWrNW5Ld8285HAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749106581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7DmcrhkNIQ/niQtAcDn0EafwzfBhjs/ITtA0DL8NLk=;
 b=l5HBe9FOwBUnRA+lEFmbj2DncCL3BIjP1q/cFSrThjZysEfU8x8sHJLZHQYWsom5mqUF9r
 LuyTeF+MdspZQpF3xGvaVj7/FFQtKguQpc3tjhjU6rPb9bA14obufhqArDlxEVRGUXrJeV
 Y2uQH3UuIxmqtOAJakKw5z1uVmqYQ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749106581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7DmcrhkNIQ/niQtAcDn0EafwzfBhjs/ITtA0DL8NLk=;
 b=+nC0KmnbW5Sq7AM06TucYHGuADFPsw7horx1e2gnjyOuOTJiygXTQCmP1Ireazn2ur/lBF
 2yWrNW5Ld8285HAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC1E137FE;
 Thu,  5 Jun 2025 06:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SewUApU/QWhuIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 06:56:21 +0000
Date: Thu, 5 Jun 2025 08:56:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250605065615.GA1189701@pevik>
References: <20250515015855.68510-1-liwang@redhat.com>
 <20250515015855.68510-3-liwang@redhat.com>
 <aEA0LYNKcPPeS0Uw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aEA0LYNKcPPeS0Uw@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] lib: moves test infrastructure states into
 a shared context structure
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

Hi all,

...
> >  	case TBROK:
> > -		tst_atomic_inc(&results->broken);
> > +		tst_atomic_inc((int *)&results->broken);
> >  	break;

> This gets ugly. I guess that it would be better to keep the results as
> int unless we change the tst_atomic.h to work with int32_t.

> Maybe we can actually drop the assembly fallbacks from tst_atomic.h
> since as far as I can tell the __atomic_*() functions were added to
> gcc-4.7 and the __sync_*() function were added into gcc-4.1 so unless we
> need to support compiler older than 4.1 we can drop the assembly and
> easily add support for atomic operations for int32_t.

I suppose we can safely remove the fallbacks.  FYI the latest gcc we care about
the oldest SLES 12-SP3 we still support is 4.8.5. And of course, this release
has newer non-default gcc (up to gcc 9).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080E1EB28EC
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 08:33:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F7013CB362
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 09:33:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A94EC3C4E04
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 09:33:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 29904600E48
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 09:33:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 781B93E6DF;
 Fri,  6 Feb 2026 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770366795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sfCXMKTOhggXA7winaYy7EsZcngWVF+B3j2802woLqY=;
 b=h8R2NcJVWt7yyOCbo0TZtUYml2TvPoAFZh2ZM92gCBDbmv19QgLfZHFhcXIArDOmZMkgh+
 uEhHnTuGTD1pf5sBx9RJYhdzyrfIC8kketTJpqHww8zYxb4BPHaM54bz4zFtHIkTApM8EX
 olbATwvvMvZWJ8t7fKzC9JG7ghoKFnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770366795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sfCXMKTOhggXA7winaYy7EsZcngWVF+B3j2802woLqY=;
 b=5wQ1kpm1iGA13nr0dhmThSiWhl77nVgBywh3N92sA0U6RLS2MuqsP9nIx4G5aHQ6fKBNvL
 Vg9M51Mk45PbdpCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770366795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sfCXMKTOhggXA7winaYy7EsZcngWVF+B3j2802woLqY=;
 b=h8R2NcJVWt7yyOCbo0TZtUYml2TvPoAFZh2ZM92gCBDbmv19QgLfZHFhcXIArDOmZMkgh+
 uEhHnTuGTD1pf5sBx9RJYhdzyrfIC8kketTJpqHww8zYxb4BPHaM54bz4zFtHIkTApM8EX
 olbATwvvMvZWJ8t7fKzC9JG7ghoKFnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770366795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sfCXMKTOhggXA7winaYy7EsZcngWVF+B3j2802woLqY=;
 b=5wQ1kpm1iGA13nr0dhmThSiWhl77nVgBywh3N92sA0U6RLS2MuqsP9nIx4G5aHQ6fKBNvL
 Vg9M51Mk45PbdpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53A2E3EA63;
 Fri,  6 Feb 2026 08:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wXPoE0unhWlnPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Feb 2026 08:33:15 +0000
Date: Fri, 6 Feb 2026 09:33:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aYWnRzaz7Luhm26x@yuki.lan>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik> <aYWfNaJeXqut0Isb@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYWfNaJeXqut0Isb@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > utsname01.c:39: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)
> > utsname01.c:40: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)

Maybe we need TTRACE that would print syscall tracing like that and
TDEBUG for the rest of the messages.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23665C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 12:46:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E4CB3E5C57
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 14:46:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 232D93C8484
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:46:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98651600A52
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:46:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D311764B6;
 Fri, 10 Jul 2026 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783687561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iEWB90cJTRwYZpCStkz5w9yrgvxo0fKrm85wPIdqJCg=;
 b=f/z79hvQesrI1VBEYr6Tl6MdAovgii87odvgDoZo8YbH0wIMSBMHa5hm3QDPATP2plGekd
 6+Fhro+OPXcTN5oOKxVdZhIDW8yiwyB6uGDPjqvfgW7Z8idzXsfIFrdMEhNpfrvPulzbQv
 +8E8X17Xj/q7Sg02IbYvrGhJJ/9ZwnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783687561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iEWB90cJTRwYZpCStkz5w9yrgvxo0fKrm85wPIdqJCg=;
 b=1G+bUkv1jGYCCMUDPB68TKY1je03GOPwKgWWBl2WTo1NFTCUO9qK0mgrgUyGEmhlHPYVcw
 EjuxkW+P+JzPXMCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="f/z79hvQ";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1G+bUkv1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783687561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iEWB90cJTRwYZpCStkz5w9yrgvxo0fKrm85wPIdqJCg=;
 b=f/z79hvQesrI1VBEYr6Tl6MdAovgii87odvgDoZo8YbH0wIMSBMHa5hm3QDPATP2plGekd
 6+Fhro+OPXcTN5oOKxVdZhIDW8yiwyB6uGDPjqvfgW7Z8idzXsfIFrdMEhNpfrvPulzbQv
 +8E8X17Xj/q7Sg02IbYvrGhJJ/9ZwnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783687561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iEWB90cJTRwYZpCStkz5w9yrgvxo0fKrm85wPIdqJCg=;
 b=1G+bUkv1jGYCCMUDPB68TKY1je03GOPwKgWWBl2WTo1NFTCUO9qK0mgrgUyGEmhlHPYVcw
 EjuxkW+P+JzPXMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AEA9779BD;
 Fri, 10 Jul 2026 12:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UqGIBYnpUGoXYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jul 2026 12:46:01 +0000
Date: Fri, 10 Jul 2026 14:45:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <alDpW3YzuECdGmG2@rei>
References: <alDlHzYiak61OLRZ@rei> <6a50e884.3829c3bf.f96e.d908@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a50e884.3829c3bf.f96e.d908@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2D311764B6
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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
> > Alternative we may change the core pattern for the duration of the test.
> > Does this patch fixes the issue for you?
> > 
> > diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
> > index 3cf62feae..191587368 100644
> > --- a/testcases/kernel/syscalls/kill/kill11.c
> > +++ b/testcases/kernel/syscalls/kill/kill11.c
> > @@ -126,7 +126,12 @@ static void setup(void)
> >  static struct tst_test test = {
> >         .needs_tmpdir = 1,
> >         .forks_child = 1,
> > +       .needs_root = 1,
> 
> I don't know if it's a good idea to switch to privileged user, since
> we would remove the test from parallel execution.

Well either we do that, or we skip the signals that dump core when we
are dumping into the pipe.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

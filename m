Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5CCC5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 08:50:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 073113D07E0
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:50:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D3B23CB850
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:49:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83DE01000530
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:49:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0273E1F;
 Tue, 11 Aug 2026 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786438193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIxFTgDjSPX9bNlnPH1t383oOESrOy/bbgRS1NNnshk=;
 b=ZFNale6i+ZiOjYGdxk7cN0IfxFZjUqXwuiXbjvUExFRyqC3KVkyI00B6xoXHNG+2EtdMJ2
 MUgfYtpJ+B38EvDugdFyNJn89XKe0KrlPe45qkKWo16qfjmq7/tVEWEMXABoYiFlEWu4XB
 705kKHgy8LUeoeexBTpaSI/YZg7sZyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786438193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIxFTgDjSPX9bNlnPH1t383oOESrOy/bbgRS1NNnshk=;
 b=h+33eeO7Hf9qLDDT679Zs0cs3XhT6z8SzZFnCyMUbA0P5FSV6q5tMuH9Wg8QTgwOUxPVpn
 0URa+Q7xd1FUAFDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dbAORnFz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EI1nyBUP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786438189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIxFTgDjSPX9bNlnPH1t383oOESrOy/bbgRS1NNnshk=;
 b=dbAORnFznb2XFC6UB+hSgu7eF/PmnCHVFBIr19M0V1vTvIJ2Fl2a4z5w+6qsx+F1JFxGJJ
 1rh+NbWwKx/PTj79eBQmr4pKIy+IfUtpZ+XvNDe+54WHp6pkeO9Hce6hh3nmHujv7Q5/eV
 Fagl2ppqkhX3fPeALSgSCvJuhRkX3K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786438189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIxFTgDjSPX9bNlnPH1t383oOESrOy/bbgRS1NNnshk=;
 b=EI1nyBUPVbUeU3KoDyqNc08u0IQX7ac2BbHuyU84iil4bgq9P7YywD45fgovDI5XxDvnLE
 VRdrF1lEYvdKdoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D059E779B2;
 Tue, 11 Aug 2026 08:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rjLqMCziemrDVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 08:49:48 +0000
Date: Tue, 11 Aug 2026 10:49:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260811084943.GA1676037@pevik>
References: <20260810160048.1040517-8-pvorel@suse.cz>
 <6a7acbaf.9099b29d.135d6f.b466@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a7acbaf.9099b29d.135d6f.b466@mx.google.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 0B0273E1F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 7/7] lib: Add 2 basic tests for .min_kver &&
 .max_kver
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

> Hi Petr,

...
> > +static struct tst_test test = {
> > +	.min_kver = "4.4",
> > +	.max_kver = "7.2",
> > +	.test_all = do_test,
> > +};

> this test is a bit weird, it's system dependent and it will TPASS or
> TCONF according to the kernel version. Is there a way to test this
> in a different way? I know it's hacky, but maybe we can use
> __attribute__((constructor)) and fetch uname() info before running
> the maximum kernel version check.

Although this is an interesting idea, I'm not sure if I find time for it. Feel
free to further improve it. For me is in the end trying to fix fanotify20 :).

The point of the test is to at least run something (kind of minimal testing but
better than nothing, because it's naive to expect anybody who touches library
tests it carefully with the real tests).

Anyway, in CI it will be always the same due using container (TPASS on Ubuntu's
6.17.0-1020-azure).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

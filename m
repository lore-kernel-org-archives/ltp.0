Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C77C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 09:42:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E54B3CE5CE
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 10:42:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 071603CB3D4
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 10:42:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 91B49200ADB
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 10:42:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BD11221E8;
 Thu, 14 Dec 2023 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702546943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z1ZM4617J1MG7Jt9GB+B+UAm3Mcw6ApvkWXdEXu6hiY=;
 b=SB6IqMnm92rHqWZ5SYlPrEEbK/559S385daKO6SSsyAJyly7mMKK52/n+4jPL3QOImGipp
 e8Rsyye11R084B0TK6e4WpeAZg4gFkxQAm8bhiyb6JXYR4z5I9Vq851+qCU7rVC2Ppk2/i
 9MT0Mg/ZPyTOTGd3WBGTChJnLNh1LcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702546943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z1ZM4617J1MG7Jt9GB+B+UAm3Mcw6ApvkWXdEXu6hiY=;
 b=uXxydBTMu2RPMVyzvwbQhuj8MSS2PQbU40isZlCi92ISREGFye3nFrpH5ENhwehxVjKx3X
 tJrNVqQHN2ssdVAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702546943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z1ZM4617J1MG7Jt9GB+B+UAm3Mcw6ApvkWXdEXu6hiY=;
 b=SB6IqMnm92rHqWZ5SYlPrEEbK/559S385daKO6SSsyAJyly7mMKK52/n+4jPL3QOImGipp
 e8Rsyye11R084B0TK6e4WpeAZg4gFkxQAm8bhiyb6JXYR4z5I9Vq851+qCU7rVC2Ppk2/i
 9MT0Mg/ZPyTOTGd3WBGTChJnLNh1LcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702546943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z1ZM4617J1MG7Jt9GB+B+UAm3Mcw6ApvkWXdEXu6hiY=;
 b=uXxydBTMu2RPMVyzvwbQhuj8MSS2PQbU40isZlCi92ISREGFye3nFrpH5ENhwehxVjKx3X
 tJrNVqQHN2ssdVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 692D51379A;
 Thu, 14 Dec 2023 09:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wZW0GP/NemVcTgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 14 Dec 2023 09:42:23 +0000
Date: Thu, 14 Dec 2023 10:41:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZXrN3frwGPiLZPgN@rei>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-3-pvorel@suse.cz> <ZXoC6LUE8ePDPRIU@rei>
 <20231213231115.GA768049@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213231115.GA768049@pevik>
X-Spamd-Result: default: False [6.07 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(0.08)[0.026];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 R_SPF_SOFTFAIL(4.60)[~all]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[32.05%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: ++++++
X-Rspamd-Queue-Id: 7BD11221E8
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SB6IqMnm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uXxydBTM;
 dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of chrubis@suse.cz)
 smtp.mailfrom=chrubis@suse.cz
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] lib: Add support for TDEBUG tst_res() flag
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > > index c2f8f503f..f5c87ed9e 100644
> > > --- a/lib/tst_test.c
> > > +++ b/lib/tst_test.c
> > > @@ -60,6 +60,7 @@ static pid_t main_pid, lib_pid;
> > >  static int mntpoint_mounted;
> > >  static int ovl_mounted;
> > >  static struct timespec tst_start_time; /* valid only for test pid */
> > > +static int tdebug;
> 
> > >  struct results {
> > >  	int passed;
> > > @@ -224,6 +225,9 @@ static void print_result(const char *file, const int lineno, int ttype,
> > >  	case TINFO:
> > >  		res = "TINFO";
> > >  	break;
> > > +	case TDEBUG:
> > > +		res = "TDEBUG";
> > > +	break;
> > >  	default:
> > >  		tst_brk(TBROK, "Invalid ttype value %i", ttype);
> > >  		abort();
> > > @@ -352,6 +356,9 @@ void tst_res_(const char *file, const int lineno, int ttype,
> > >  {
> > >  	va_list va;
> 
> > > +	if (ttype == TDEBUG && !tdebug)
> > > +		return;
> > > +
> > >  	va_start(va, fmt);
> > >  	tst_vres_(file, lineno, ttype, fmt, va);
> > >  	va_end(va);
> > > @@ -511,6 +518,7 @@ static struct option {
> > >  	{"h",  "-h       Prints this help"},
> > >  	{"i:", "-i n     Execute test n times"},
> > >  	{"I:", "-I x     Execute test for n seconds"},
> > > +	{"v",  "-v       Prints debug information"},
> 
> > Maybe this should now be called -d since we call it TDEBUG and that will
> > avoid having a bit confusing parameters with both -v and -V used.
> 
> Yes, I didn't like the flag name does not correspond to the option.
> I previously wrote that more tests use -d for something else:
> 
> $ git grep '"d:"' $(git grep -l tst_option)
> testcases/kernel/fs/read_all/read_all.c:                {"d:", &root_dir,
> testcases/kernel/io/ltp-aiodio/aio-stress.c:            { "d:", &str_depth, "Number of pending aio requests for each file (default 64)" },
> testcases/network/netstress/netstress.c:                {"d:", &rpath, "Path to file where result is saved"},
> testcases/network/nfs/nfs_stress/nfs05_make_tree.c:     {"d:", &d_arg, "Number of subdirs to generate, default: 100"},
> testcases/network/stress/route/route-change-netlink.c:          {"d:", &d_opt, "Interface to work on (mandatory)"},
> 
> Hopefully all could be changed to -D in separate commits.

Or we can use -D for TDEBUG. I suppose that we use -V for version for
the same reason.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03217C6FA99
	for <ltp@archiver.kernel.org>; Sat, 11 Mar 2023 02:23:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EB543CCDBC
	for <ltp@archiver.kernel.org>; Sat, 11 Mar 2023 03:23:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BD533C1047
 for <ltp@lists.linux.it>; Sat, 11 Mar 2023 03:23:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 95DD3200FE6
 for <ltp@lists.linux.it>; Sat, 11 Mar 2023 03:23:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2913621EAB;
 Sat, 11 Mar 2023 02:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678501393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JtAXFsfMcP5nfqBCBSTU29Zl03LQh2rfYJ7qK18eO9c=;
 b=WRu4PatJWsh7WNQEjBQlXGsYAwuK3y3kTSL7YORYytBl/klLbkRpcltYDSq+VbqmMUtV0Y
 Ay/p0xnzp/iWaQU1g5TnKZZxyMgvaqRjo8jp6n0DIhqperZZmRk+gjD0kBoOZgrQEKcSUL
 7ITeHMshrP97zJyVbXPjNM5Uu8sgCAY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8193A1377A;
 Sat, 11 Mar 2023 02:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LgHFFhDmC2QhTwAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 11 Mar 2023 02:23:12 +0000
Date: Fri, 10 Mar 2023 21:23:09 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230311022309.GA12553@localhost>
References: <20230310140407.20137-1-wegao@suse.com>
 <ZAtEIClci4QximeK@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZAtEIClci4QximeK@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] madvise11.c:Check loadable module before rmmod
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 10, 2023 at 03:52:16PM +0100, Cyril Hrubis wrote:
> Hi!
> > +static int is_loadable_module(const char *modname)
> > +{
> > +	char command[MAX_BUF];
> > +	char line[MAX_BUF];
> > +	char *token;
> > +
> > +	sprintf(command, "lsmod | grep '^%s'", modname);
> > +
> > +	FILE *fp = popen(command, "r");
> > +
> > +	if (fp == NULL)
> > +		tst_brk(TBROK, "Popen command %s failed", command);
> > +
> > +	if (fgets(line, MAX_BUF, fp) != NULL) {
> > +		token = strtok(line, " \t\n");
> > +		if (strcmp(token, modname) == 0) {
> > +			pclose(fp);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	pclose(fp);
> > +	return 0;
> > +}
> 
> The code already has if (!find_in_file("/proc/modules", HW_MODULE)), you
> are reinventing the wheel.
There is an issue happen during our test, the fail happen with following failed msg.
rmmod: ERROR: Module hwpoison_inject is builtin.
madvise11.c:356: TWARN: rmmod failed (1)

So i think before rmmod we should check this module can be rmmod or not.
And every modules which can show in lsmod output, it means the module can be unload.
I am not sure the output of /proc/modules contain ONLY loadable module, it maybe
also can contain the buildin module so this function created.

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

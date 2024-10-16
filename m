Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176C9D1AD5B
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 13:42:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 665803C686B
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 15:42:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E55843C223D
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 15:41:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E569B7C12C7
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 15:41:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDC0221E65;
 Wed, 16 Oct 2024 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729086115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/a4SbGhpcrmBK90LNrMINLdJWUUBl3AACWNDfYjguw=;
 b=ENqdh9DVfxyREBvkEDt0T1SqD+TO6ys3owciYNkpulMFjz8PQbFnwIJOJ4aD7dHZ9DiIvV
 KGwHzRlZicfY4bBG4720Bv4WbOU2Mawjd3XA5pesl6ie1cVkEAQ9wdDXUG2dDJymIyCESf
 f4+3jlUJqp1R+QJ2JCMyrzXNmAG9uno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729086115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/a4SbGhpcrmBK90LNrMINLdJWUUBl3AACWNDfYjguw=;
 b=+LJAD58ZxSAGpsyzomX0aJeMGbYWNAHIfE0w8nC0ldrmPTEO9CaXZXSKc1RmjHRphrVOIK
 E7XBfSl1+FYFv3Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729086114;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/a4SbGhpcrmBK90LNrMINLdJWUUBl3AACWNDfYjguw=;
 b=CbfdEH1Ce/KXPyzfjEhmzVIXDLGd62Lk7mNBr2s1YLa0ddVlHQG2qWSp1oTizs2ECCrMew
 m2VO8oJ2rofEtQpVAVH2FMmvb0A9nc+aF8WojDM0k5noKIunNT9pa3X+nlPS9gyVvsI4FO
 +AzF8SAnnxRrZy8UzgUFbs6NhhTXCbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729086114;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/a4SbGhpcrmBK90LNrMINLdJWUUBl3AACWNDfYjguw=;
 b=wc4I2lDzn+t0ULy35xB6xMJ7d50Wkqt8e+8HmzDj3j0jz7k7mUYQn21c627KvoALJUgaeh
 bWd/iz520yQehMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA04C1376C;
 Wed, 16 Oct 2024 13:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RvuTK6LCD2eyDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Oct 2024 13:41:54 +0000
Date: Wed, 16 Oct 2024 15:41:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241016134153.GA95272@pevik>
References: <20240918100344.21316-1-wegao@suse.com>
 <20240925035756.14873-1-wegao@suse.com>
 <20241015193958.GC46536@pevik> <Zw8vZlmv2R0BngBY@wegao.216.228.5>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zw8vZlmv2R0BngBY@wegao.216.228.5>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,opensuse.org:url,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei, all,

first, please wait little bit before sending next version.
We might decide to remove these tests.
Below are notes in case we keep them.

> On Tue, Oct 15, 2024 at 09:39:58PM +0200, Petr Vorel wrote:
> > Hi Wei,

> > I suppose the v1 is
> > https://patchwork.ozlabs.org/project/ltp/patch/20240918100344.21316-1-wegao@suse.com/
> Correct

> > To be honest, I would rather to remove this FTP test because FTP protocol is
> > legacy. I know it is supposed to be a smoke test, but maybe using modern tools
> > would be better than keeping test working among various old FTP implementations.
> > (Also nontrivial setup is required just for few FTP tests:
> > https://github.com/linux-test-project/ltp/tree/master/testcases/network )
> > But probably Cyril would be against. @Cyril @Martin WDYT?

> > @Wei I suppose the reason for adding lftp (you did not explain it in the commit
> > message) is that is the only supported client in SLE Micro? Or something else?
> Adding lftp is used for fix SLE test such as SLE-15SP6, on SLE Micro will result TCONF
> since no any ftp command support currently.

> BTW: there is another PR on openqa side to setup local ssh network env.
> https://github.com/os-autoinst/os-autoinst-distri-opensuse/pull/20278 

> All detail discussion can be also found in:
> https://progress.opensuse.org/issues/165848


> > > Signed-off-by: Wei Gao <wegao@suse.com>
> > > ---
> > >  testcases/network/tcp_cmds/ftp/ftp01.sh | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)

> > > diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
> > > index 53d1eec53..12d32a9a9 100755
> > > --- a/testcases/network/tcp_cmds/ftp/ftp01.sh
> > > +++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
> > > @@ -4,6 +4,7 @@
> > >  # Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
> > >  # Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>

> > > +TST_SETUP=setup
> > >  TST_TESTFUNC=do_test
> > >  TST_CNT=4
> > >  TST_NEEDS_CMDS='awk ftp'
> > > @@ -11,6 +12,16 @@ TST_NEEDS_TMPDIR=1

> > >  RUSER="${RUSER:-root}"
> > >  RHOST="${RHOST:-localhost}"
> > > +FTP_CMD="ftp -nv"
> > > +
> > > +setup()
> > > +{
> > > +    if tst_cmd_available lftp; then
> > > +        FTP_CMD="lftp --norc"
> > > +    else
> > > +        tst_brkm TCONF "No FTP client found"
> > Test was converted to the new API, it must be tst_brk.
> > Also, this code basically means that testing is done only for lftp,
> > otherwise TCONF.
> Thanks for point out this. it should replace to following code as Martin suggested:

> if tst_cmd_available ftp; then
> 	FTP_CMD="ftp -nv"
> elif tst_cmd_available lftp; then
> 	FTP_CMD="lftp --norc"
> else
> 	tst_brk TCONF "No FTP client found"
> fi

Yes, this would work.

> > + You keep requiring ftp in TST_NEEDS_CMDS, but at least on Tumbleweed and
> > current Debian testing lftp does not provide symlink to ftp, only tnftp does
> > this. Therefore you require both lftp and tnftp for testing.

> I suppose ONLY requiring ftp in TST_NEEDS_CMDS is enough, lftp is specific case for sle check.
> For Tumbleweed and other OS will directly use ftp(TW only contain ftp by default).

IMHO no. TST_NEEDS_CMDS should not contain ftp. On Tumbleweed with lftp
installed there is no ftp symlink:

$ lftp --version
LFTP | Version 4.9.2 | Copyright (c) 1996-2020 Alexander V. Lukyanov
...

$ ftp

The program 'ftp' can be found in following packages:
  * ftp [ path: /usr/bin/ftp, repository: OSS ]
  * tnftp [ path: /usr/bin/ftp, repository: OSS ]

Try installing with:
    sudo zypper install <selected_package>

Kind regards,
Petr

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

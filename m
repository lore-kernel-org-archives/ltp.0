Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44634C7113C
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 21:43:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5F793D27A7
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 23:43:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92EE23D27A3
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 23:43:39 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B6DBC237989
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 23:43:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E73621B73;
 Wed, 28 Aug 2024 21:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724881417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ei45DXpITIz72d5Nu8E6fFiyTn03IKK4P9lAYJLE6g=;
 b=JSLZaVdoJDwhncU5gw+uyhIF5kdVJSsuhFvIPfE/Ac6XtqlyE8VHKQacW+6TgKIySzBCxe
 pBo53n8LYe3TDFYsoA4EQRgG5LIRuJMjMjIshqVPfRtdjgTUfj2st8j0nn3WtkJEWbL3ji
 fOtuKAvwA6VcTn+2G34316F+yB8H6PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724881417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ei45DXpITIz72d5Nu8E6fFiyTn03IKK4P9lAYJLE6g=;
 b=4rSptgwefAuq/oJ1uOLjMutD6X/jchTvfU5F8IHXU2Pu1RhcJ7EYaAk7yKwV5Ui9NF3vuT
 u0vXZtSPNT5MISDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724881417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ei45DXpITIz72d5Nu8E6fFiyTn03IKK4P9lAYJLE6g=;
 b=JSLZaVdoJDwhncU5gw+uyhIF5kdVJSsuhFvIPfE/Ac6XtqlyE8VHKQacW+6TgKIySzBCxe
 pBo53n8LYe3TDFYsoA4EQRgG5LIRuJMjMjIshqVPfRtdjgTUfj2st8j0nn3WtkJEWbL3ji
 fOtuKAvwA6VcTn+2G34316F+yB8H6PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724881417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ei45DXpITIz72d5Nu8E6fFiyTn03IKK4P9lAYJLE6g=;
 b=4rSptgwefAuq/oJ1uOLjMutD6X/jchTvfU5F8IHXU2Pu1RhcJ7EYaAk7yKwV5Ui9NF3vuT
 u0vXZtSPNT5MISDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEE86138D2;
 Wed, 28 Aug 2024 21:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k++5OAiaz2avOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Aug 2024 21:43:36 +0000
Date: Wed, 28 Aug 2024 23:43:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240828214327.GA1767403@pevik>
References: <20240828132325.23111-1-mdoucha@suse.cz>
 <172487956651.4433.5156438688517075305@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <172487956651.4433.5156438688517075305@noble.neil.brown.name>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfsstat01: Read client stats from netns rhost
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
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Wed, 28 Aug 2024, Martin Doucha wrote:
> > On newer kernels, network namespaces have separate NFS stats. Detect
> > support for per-NS files and read stats from the correct NS.

> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>

> Thanks for doing this Martin.  I very much prefer this approach.

> NeilBrown

FYI patch merged. Thanks all for your time.

Kind regards,
Petr


> > ---

> > The /proc/net/rpc/nfs file did not exist in nested network namespaces
> > on older kernels. The per-NS stats patchset adds it so we need to check
> > for its presence to read the correct stats on kernels where it was
> > backported.

> > Kernel devs have also asked for a test that'll ensure the patchset doesn't
> > get accidentaly reverted. Since this test uses namespaces only when
> > the server and client run on the same machine, it'll be better to create
> > a separate test for that. I'll send it later.

> >  testcases/network/nfs/nfsstat01/nfsstat01.sh | 24 +++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)

> > diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > index c2856eff1..8d7202cf3 100755
> > --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > @@ -3,8 +3,19 @@
> >  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
> >  # Copyright (c) International Business Machines  Corp., 2001

> > +TST_SETUP="nfsstat_setup"
> >  TST_TESTFUNC="do_test"
> >  TST_NEEDS_CMDS="nfsstat"
> > +NS_STAT_RHOST=0
> > +
> > +nfsstat_setup()
> > +{
> > +	nfs_setup
> > +
> > +	if tst_net_use_netns && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
> > +		tst_rhost_run -c "test -r /proc/net/rpc/nfs" && NS_STAT_RHOST=1
> > +	fi
> > +}

> >  get_calls()
> >  {
> > @@ -15,15 +26,22 @@ get_calls()
> >  	local calls opt

> >  	[ "$name" = "rpc" ] && opt="r" || opt="n"
> > -	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> > +	[ "$nfs_f" = "nfsd" ] && opt="-s$opt" || opt="-c$opt"
> > +
> > +	if tst_net_use_netns; then
> > +		# In netns setup, rhost is the client
> > +		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
> > +	else
> > +		[ "$nfs_f" != "nfs" ] && type="rhost"
> > +	fi

> >  	if [ "$type" = "lhost" ]; then
> >  		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> > -		ROD nfsstat -c$opt | grep -q "$calls"
> > +		ROD nfsstat $opt | grep -q "$calls"
> >  	else
> >  		calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
> >  			cut -d' ' -f$field)
> > -		tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
> > +		tst_rhost_run -s -c "nfsstat $opt" | grep -q "$calls"
> >  	fi

> >  	if ! tst_is_int "$calls"; then
> > -- 
> > 2.46.0




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

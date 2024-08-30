Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B081CA100C
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 20:27:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D05F63D2889
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 22:27:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 295173C807A
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:27:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 13A601A00CBB
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:27:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE90D21A4F;
 Fri, 30 Aug 2024 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725049622;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NDcGiDnrMmpU7UhZcSXMOBut8UJfGlCyZzGwPyHzJFs=;
 b=w8K9qat9DqXcqSFc0Orle+g76NoT59i6dC5tJiTmegB3fDp9/6PgomvS8cs1INXT4goxyS
 JlYDB9HzwXSyeGQ5q/kiV9B9zBLD4+SdlYD8NBS1uZod6+I7tLWmrGk2BNZ92cgoA55PqE
 BDc1SYWK8+0icrqarlDM5jIVZa8Cklo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725049622;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NDcGiDnrMmpU7UhZcSXMOBut8UJfGlCyZzGwPyHzJFs=;
 b=WLhxQ3JkZw+2bz6z6EyjCN03NEBUdFY2yyHjBnXDYCFS+vYRDyflm0v5mypknCrN8NlRDl
 pJpI0wq5kqQHXKCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LkLHHvjU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7QS6EXkC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725049620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NDcGiDnrMmpU7UhZcSXMOBut8UJfGlCyZzGwPyHzJFs=;
 b=LkLHHvjUbGpWvdC5qp2XnE+teLKmQhZHRKr7jQJqzMMo+1z8pWeM3OLc15u+Zhg2Ywq8e+
 eOdu73DYB7Ux3U14IyhneGnUBMFfTx3a9eVSMlEeQkSkJt6Sl6CDR8xj2QbUYHstNmDkQz
 0iflCXrrxAwv6I3gWE5sgbUEJtBnzlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725049620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NDcGiDnrMmpU7UhZcSXMOBut8UJfGlCyZzGwPyHzJFs=;
 b=7QS6EXkCoEluTmit9sMpGOX197o9biUEFxfNY0gLwwA0BIQb1ABs3ga1kc0f9c7XDdZgzg
 fFk3RNGykILLc2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA6E813A3D;
 Fri, 30 Aug 2024 20:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YBAANBMr0mbITAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 20:26:59 +0000
Date: Fri, 30 Aug 2024 22:26:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>, Martin Doucha <mdoucha@suse.cz>,
 NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Message-ID: <20240830202654.GE90470@pevik>
References: <20240830141453.28379-1-mdoucha@suse.cz>
 <20240830141453.28379-2-mdoucha@suse.cz>
 <ZtILLtHSahuwDiZq@tissot.1015granger.net>
 <20240830200429.GA90470@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830200429.GA90470@pevik>
X-Rspamd-Queue-Id: AE90D21A4F
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[vger:email,suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] nfsstat01: Check that RPC stats don't leak
 between net namespaces
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
Cc: linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi all,

> > On Fri, Aug 30, 2024 at 04:13:40PM +0200, Martin Doucha wrote:
> > > When the NFS server and client run on the same host in different net
> > > namespaces, check that RPC calls from the client namespace don't
> > > change RPC statistics in the root namespace.

> > > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > > ---

> > > I've initially tried to test both NFS and RPC client stats but it appears
> > > that NFS client stats are still shared across all namespaces. Only RPC
> > > client stats are separate for each net namespace. The kernel patchset[1]
> > > which introduced per-NS stats confirms that only RPC stats have been changed.

> Yes, only RPC client stats needed to be fixed in LTP test.

OTOH there is also nfsd stats namespaced [2] as a second part of whole "Make nfs
and nfsd stats visible in network ns" patchset. I suppose we would need to
reverse client and server to detect this (IMHO worth of doing it).

Kind regards,
Petr

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=4b14885411f74b2b0ce0eb2b39d0fffe54e5ca0d
[3] https://lore.kernel.org/linux-nfs/cover.1706212207.git.josef@toxicpanda.com/


> Kind regards,
> Petr

> > I believe that is correct, Josef changed only RPC counters. Which
> > counters did you expect also would be containerized, exactly?
> > Perhaps this issue should be raised on linux-nfs@vger, it could be
> > considered to be another information leak.


> > > If NFS client stats should be separate for each namespace as well, let
> > > me know and I'll return the second set of NS checks in patch v2.

> > > Tested on kernel v5.14 with Neil's backports.

> > > [1] https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

> > >  testcases/network/nfs/nfsstat01/nfsstat01.sh | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)

> > > diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > index 8d7202cf3..3379c4d46 100755
> > > --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > @@ -22,6 +22,7 @@ get_calls()
> > >  	local name=$1
> > >  	local field=$2
> > >  	local nfs_f=$3
> > > +	local netns=${4:-rhost}
> > >  	local type="lhost"
> > >  	local calls opt

> > > @@ -30,7 +31,8 @@ get_calls()

> > >  	if tst_net_use_netns; then
> > >  		# In netns setup, rhost is the client
> > > -		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
> > > +		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && \
> > > +			type="$netns"
> > >  	else
> > >  		[ "$nfs_f" != "nfs" ] && type="rhost"
> > >  	fi
> > > @@ -64,13 +66,14 @@ get_calls()
> > >  do_test()
> > >  {
> > >  	local client_calls server_calls new_server_calls new_client_calls
> > > -	local client_field server_field
> > > +	local client_field server_field root_calls new_root_calls
> > >  	local client_v=$VERSION server_v=$VERSION

> > >  	tst_res TINFO "checking RPC calls for server/client"

> > >  	server_calls="$(get_calls rpc 2 nfsd)"
> > >  	client_calls="$(get_calls rpc 2 nfs)"
> > > +	root_calls="$(get_calls rpc 2 nfs lhost)"

> > >  	tst_res TINFO "calls $server_calls/$client_calls"

> > > @@ -79,6 +82,7 @@ do_test()

> > >  	new_server_calls="$(get_calls rpc 2 nfsd)"
> > >  	new_client_calls="$(get_calls rpc 2 nfs)"
> > > +	new_root_calls="$(get_calls rpc 2 nfs lhost)"
> > >  	tst_res TINFO "new calls $new_server_calls/$new_client_calls"

> > >  	if [ "$new_server_calls" -le "$server_calls" ]; then
> > > @@ -93,6 +97,16 @@ do_test()
> > >  		tst_res TPASS "client RPC calls increased"
> > >  	fi

> > > +	if [ $NS_STAT_RHOST -ne 0 ]; then
> > > +		tst_res TINFO "Root NS client RPC calls: $root_calls => $new_root_calls"
> > > +
> > > +		if [ $root_calls -ne $new_root_calls ]; then
> > > +			tst_res TFAIL "RPC stats leaked between net namespaces"
> > > +		else
> > > +			tst_res TPASS "RPC stats stay within net namespaces"
> > > +		fi
> > > +	fi
> > > +
> > >  	tst_res TINFO "checking NFS calls for server/client"
> > >  	case $VERSION in
> > >  	2) client_field=13 server_field=13
> > > -- 
> > > 2.46.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

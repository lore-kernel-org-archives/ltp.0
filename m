Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D264CA100C
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 20:04:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A69F83D2889
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 22:04:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19BC43C02CD
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:04:36 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5500160235F
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:04:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AB9B21A00;
 Fri, 30 Aug 2024 20:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725048275;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUaRyRR2JX2wUegmlvlrYMrvHzY7d4d5V2LEG9EfGMQ=;
 b=H0KutMCXYEfhjMWb5PO5rHSYkfZulcogmj+mgyGCZP+4eSOIpt4ovB6xRbyO5TKM3pSlVe
 HqpvI7RvGvRRNx99tusA2dFMM4DWIKA13q48p7TOyEZx2LBECrP61JKk6YCxHU2pIY3baw
 YCm8YvHaR/60JHCytf5U1/X++7ds/Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725048275;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUaRyRR2JX2wUegmlvlrYMrvHzY7d4d5V2LEG9EfGMQ=;
 b=mEVzx+4FwTF6JcvzvAyEypmAxO1sc+94ZYk40+Pi4MpgAvTr4D0tr3c+0LdxtyKN1bcxni
 BcdVW7GuwoXgYTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725048275;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUaRyRR2JX2wUegmlvlrYMrvHzY7d4d5V2LEG9EfGMQ=;
 b=H0KutMCXYEfhjMWb5PO5rHSYkfZulcogmj+mgyGCZP+4eSOIpt4ovB6xRbyO5TKM3pSlVe
 HqpvI7RvGvRRNx99tusA2dFMM4DWIKA13q48p7TOyEZx2LBECrP61JKk6YCxHU2pIY3baw
 YCm8YvHaR/60JHCytf5U1/X++7ds/Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725048275;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUaRyRR2JX2wUegmlvlrYMrvHzY7d4d5V2LEG9EfGMQ=;
 b=mEVzx+4FwTF6JcvzvAyEypmAxO1sc+94ZYk40+Pi4MpgAvTr4D0tr3c+0LdxtyKN1bcxni
 BcdVW7GuwoXgYTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0238E13A3D;
 Fri, 30 Aug 2024 20:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NS+eOtIl0maiRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 20:04:34 +0000
Date: Fri, 30 Aug 2024 22:04:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Message-ID: <20240830200429.GA90470@pevik>
References: <20240830141453.28379-1-mdoucha@suse.cz>
 <20240830141453.28379-2-mdoucha@suse.cz>
 <ZtILLtHSahuwDiZq@tissot.1015granger.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtILLtHSahuwDiZq@tissot.1015granger.net>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Fri, Aug 30, 2024 at 04:13:40PM +0200, Martin Doucha wrote:
> > When the NFS server and client run on the same host in different net
> > namespaces, check that RPC calls from the client namespace don't
> > change RPC statistics in the root namespace.

> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > ---

> > I've initially tried to test both NFS and RPC client stats but it appears
> > that NFS client stats are still shared across all namespaces. Only RPC
> > client stats are separate for each net namespace. The kernel patchset[1]
> > which introduced per-NS stats confirms that only RPC stats have been changed.

Yes, only RPC client stats needed to be fixed in LTP test.

Kind regards,
Petr

> I believe that is correct, Josef changed only RPC counters. Which
> counters did you expect also would be containerized, exactly?
> Perhaps this issue should be raised on linux-nfs@vger, it could be
> considered to be another information leak.


> > If NFS client stats should be separate for each namespace as well, let
> > me know and I'll return the second set of NS checks in patch v2.

> > Tested on kernel v5.14 with Neil's backports.

> > [1] https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

> >  testcases/network/nfs/nfsstat01/nfsstat01.sh | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)

> > diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > index 8d7202cf3..3379c4d46 100755
> > --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > @@ -22,6 +22,7 @@ get_calls()
> >  	local name=$1
> >  	local field=$2
> >  	local nfs_f=$3
> > +	local netns=${4:-rhost}
> >  	local type="lhost"
> >  	local calls opt

> > @@ -30,7 +31,8 @@ get_calls()

> >  	if tst_net_use_netns; then
> >  		# In netns setup, rhost is the client
> > -		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
> > +		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && \
> > +			type="$netns"
> >  	else
> >  		[ "$nfs_f" != "nfs" ] && type="rhost"
> >  	fi
> > @@ -64,13 +66,14 @@ get_calls()
> >  do_test()
> >  {
> >  	local client_calls server_calls new_server_calls new_client_calls
> > -	local client_field server_field
> > +	local client_field server_field root_calls new_root_calls
> >  	local client_v=$VERSION server_v=$VERSION

> >  	tst_res TINFO "checking RPC calls for server/client"

> >  	server_calls="$(get_calls rpc 2 nfsd)"
> >  	client_calls="$(get_calls rpc 2 nfs)"
> > +	root_calls="$(get_calls rpc 2 nfs lhost)"

> >  	tst_res TINFO "calls $server_calls/$client_calls"

> > @@ -79,6 +82,7 @@ do_test()

> >  	new_server_calls="$(get_calls rpc 2 nfsd)"
> >  	new_client_calls="$(get_calls rpc 2 nfs)"
> > +	new_root_calls="$(get_calls rpc 2 nfs lhost)"
> >  	tst_res TINFO "new calls $new_server_calls/$new_client_calls"

> >  	if [ "$new_server_calls" -le "$server_calls" ]; then
> > @@ -93,6 +97,16 @@ do_test()
> >  		tst_res TPASS "client RPC calls increased"
> >  	fi

> > +	if [ $NS_STAT_RHOST -ne 0 ]; then
> > +		tst_res TINFO "Root NS client RPC calls: $root_calls => $new_root_calls"
> > +
> > +		if [ $root_calls -ne $new_root_calls ]; then
> > +			tst_res TFAIL "RPC stats leaked between net namespaces"
> > +		else
> > +			tst_res TPASS "RPC stats stay within net namespaces"
> > +		fi
> > +	fi
> > +
> >  	tst_res TINFO "checking NFS calls for server/client"
> >  	case $VERSION in
> >  	2) client_field=13 server_field=13
> > -- 
> > 2.46.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

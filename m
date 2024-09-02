Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4401CCA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 18:16:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DFC33C4C4C
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 20:16:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A40E43C299D
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 20:15:52 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BC0A8600439
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 20:15:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0357B21B14;
 Mon,  2 Sep 2024 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725300949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h1Nz6b7lBS8vwRLeZtSrNKuf0Z8xk9TUoJTIOxE+8SY=;
 b=MXEorC6VAjRG20rpUGYVmLqdF+qaJYEqKU89sYH4pkelCLu73HHYsEvgvIj69V5VN1PRpm
 DNSL6va2ObTcTi0cH0SVJN/XDO3X7RTC5O67jBbSo0RNIB24ikI+YYhw14KWTApUq10Br1
 l+lTxmDFS//OfBGAPowAf5TQCJ34x5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725300949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h1Nz6b7lBS8vwRLeZtSrNKuf0Z8xk9TUoJTIOxE+8SY=;
 b=ENAP8pvBVcuPdW0AToyTyGupIgEC2ikPEFNz2P+qCV9LXma4FkYIiRjlz/l0u9c5yNWYvw
 ED//aKs7eTJoXVBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725300949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h1Nz6b7lBS8vwRLeZtSrNKuf0Z8xk9TUoJTIOxE+8SY=;
 b=MXEorC6VAjRG20rpUGYVmLqdF+qaJYEqKU89sYH4pkelCLu73HHYsEvgvIj69V5VN1PRpm
 DNSL6va2ObTcTi0cH0SVJN/XDO3X7RTC5O67jBbSo0RNIB24ikI+YYhw14KWTApUq10Br1
 l+lTxmDFS//OfBGAPowAf5TQCJ34x5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725300949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h1Nz6b7lBS8vwRLeZtSrNKuf0Z8xk9TUoJTIOxE+8SY=;
 b=ENAP8pvBVcuPdW0AToyTyGupIgEC2ikPEFNz2P+qCV9LXma4FkYIiRjlz/l0u9c5yNWYvw
 ED//aKs7eTJoXVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE88313A21;
 Mon,  2 Sep 2024 18:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vf+lMNQA1mYueAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Sep 2024 18:15:48 +0000
Date: Mon, 2 Sep 2024 20:15:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240902181539.GD400539@pevik>
References: <20240830141453.28379-1-mdoucha@suse.cz>
 <20240830141453.28379-2-mdoucha@suse.cz>
 <20240830201509.GC90470@pevik>
 <b5e0a814-7e02-4dfb-aabd-44ee57f4e0a2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5e0a814-7e02-4dfb-aabd-44ee57f4e0a2@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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
Cc: NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,

> On 30. 08. 24 22:15, Petr Vorel wrote:
> > > @@ -93,6 +97,16 @@ do_test()
> > >   		tst_res TPASS "client RPC calls increased"
> > >   	fi

> > > +	if [ $NS_STAT_RHOST -ne 0 ]; then
> > > +		tst_res TINFO "Root NS client RPC calls: $root_calls => $new_root_calls"
> > > +
> > > +		if [ $root_calls -ne $new_root_calls ]; then
> > > +			tst_res TFAIL "RPC stats leaked between net namespaces"
> > > +		else
> > > +			tst_res TPASS "RPC stats stay within net namespaces"
> > > +		fi

> > Maybe also add TCONF message? (can be added before merge)

> >      else
> > 		tst_res TCONF "Not testing leak between root NS and net NS due old kernel"

> I think the TCONF message doesn't make sense here. There are several cases
> where the new check will be skipped:
> 1) the NFS server runs on another machine ($RHOST is not empty)
> 2) the test is configure to ignore namespaces ($LTP_NFS_NETNS_USE_LO is not
> empty)
> 3) /proc/net/rpc/nfs doesn't exist in nested net namespaces

> You want to print the TCONF message only in case #3. Let's keep the
> condition above simple.

Fair enough. I merged just with adding kernel commit and patchset link in the
first commit. Thanks!

NOTE: I noticed your point about mount namespaces (interesting I wonder if there
will be some change), but merged as it reflects the current kernel code.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

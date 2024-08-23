Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936EFC5321E
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 22:00:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 244B63D239A
	for <ltp@archiver.kernel.org>; Sat, 24 Aug 2024 00:00:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D1CC3D1311
 for <ltp@lists.linux.it>; Sat, 24 Aug 2024 00:00:01 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9EE360072D
 for <ltp@lists.linux.it>; Sat, 24 Aug 2024 00:00:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49D2522726;
 Fri, 23 Aug 2024 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724450399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
 b=tGuMlhjb7CnvfVU0MvsvnWIwv0y3/Gua5JbROZ2qaxSFMgv3ZNWLBkEImrXJi+kqxhURFl
 9kj+JAGzlf5KMKdHevYCnwN03nEarj9V1qIeMLZ9Y3AmPHLt87USCuyegSjydlUKIxugUr
 6lXhrXHt1VH8K+zlje+zgrNhFlSqxbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724450399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
 b=8j2t1iHtPs/5Vx9OVPWPWpsDeF7zCynLOCcZnD4C3Q7ihfOSVE4UuvjQQ3tqXvqaQgptOm
 eHKBKeZ3jlW/clBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724450398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
 b=cbda3XDMoD6/ANsRrOxfa8OHAgrh/pmv1CSt1HS9jDWLa3HPTR4rAyLtGXqHIRyAAlhf7C
 PuEanvVExwApuS1srLgnPupgeycfWvd0S6tPBPxjpZhdkVZ0yJSrRiNZzt2mRJawhJ51Rm
 NEMiLOyKV4rRTtQqFHB3iY0w6MDndRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724450398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
 b=l570JSo+B+WTjGTj2QB2iy+SI5noUjZuMLNG0NqcdTQw4jEbgL2Egp3Oq25e1DkYJnfxj6
 ZWche639d3XPlVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CF831398B;
 Fri, 23 Aug 2024 21:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7tIHBVsGyWbhcwAAD6G6ig
 (envelope-from <neilb@suse.de>); Fri, 23 Aug 2024 21:59:55 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Petr Vorel" <pvorel@suse.cz>
In-reply-to: <20240823064640.GA1217451@pevik>
References: <>, <20240823064640.GA1217451@pevik>
Date: Sat, 24 Aug 2024 07:59:44 +1000
Message-id: <172445038410.6062.6091007925280806767@noble.neil.brown.name>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 noble.neil.brown.name:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
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
Cc: linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 23 Aug 2024, Petr Vorel wrote:
> Hi Chuck, Neil, all,
> 
> > On Wed, Aug 14, 2024 at 10:57:21AM +0200, Petr Vorel wrote:
> > > 6.9 moved client RPC calls to namespace in "Make nfs stats visible in
> > > network NS" patchet.
> 
> > > https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Changes v1->v2:
> > > * Point out whole patchset, not just single commit
> > > * Add a comment about the patchset
> 
> > > Hi all,
> 
> > > could you please ack this so that we have fixed mainline?
> 
> > > FYI Some parts has been backported, e.g.:
> > > d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
> > > to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.
> 
> > > But most of that is not yet (but planned to be backported), e.g.
> > > 93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> > > see Chuck's patchset for 6.6
> > > https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/
> 
> > > Once all kernels up to 5.4 fixed we should update the version.
> 
> > > Kind regards,
> > > Petr
> 
> > >  testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> > > diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > index c2856eff1f..1beecbec43 100755
> > > --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > @@ -15,7 +15,14 @@ get_calls()
> > >  	local calls opt
> 
> > >  	[ "$name" = "rpc" ] && opt="r" || opt="n"
> > > -	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> > > +
> > > +	if tst_net_use_netns; then
> > > +		# "Make nfs stats visible in network NS" patchet
> > > +		# https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> > > +		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"
> 
> > Hello Petr-
> 
> > My concern with this fix is it targets v6.9 specifically, yet we
> > know these fixes will appear in LTS/stable kernels as well.
> 
> Great! I see you already fixed up to 5.15. I suppose the code is really
> backportable to the other still active branches (5.10, 5.4, 4.19).
> 
> We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
> that it works on all kernels. As I note [1]
> 
> 1) either we give up on checking the new functionality still works (if we
> fallback to old behavior)

I don't understand.  What exactly do you mean by "the new
functionality".
As I understand it there is no new functionality.  All there was was and
information leak between network namespaces, and we stopped the leak.
Do you consider that to be new functionality?

> 2) or we need to specify from which kernel we expect new functionality
> (so far it's 5.15, I suppose it will be older).
> 
> I would prefer 2) to have new functionality always tested.
> Or am I missing something obvious?

As I understand it the primary purpose of the test is to confirm that
when an NFS request is made, the client sees an increase the the count
of RPC requests in the client statistics.  and the server sees an
increase in the count of RPC requests in the server statistics.
That test, if performed correctly, should always work.

Is there something else you want to test?
If you want to test that the server DOESN'T see and increase in the
CLIENT statistics, then that is a valid thing to test and it won't work
on early kernels.  I think we only need to test that for kernels since
the fix landed in mainline.

I'm sure one of us is missing something obvious because I am CONFIDENT
that a test for correct functionality can be written to work on all
kernels.  We didn't add any new functionality and didn't break any old
functionality.  We just fixed a bug.

NeilBrown


> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/linux-nfs/172367387549.6062.7078032983644586462@noble.neil.brown.name/
> 
> > Neil Brown suggested an alternative approach that might not depend
> > on knowing the specific kernel version:
> 
> > https://lore.kernel.org/linux-nfs/172078283934.15471.13377048166707693692@noble.neil.brown.name/
> 
> > HTH
> 
> 
> > > +	else
> > > +		[ "$nfs_f" != "nfs" ] && type="rhost"
> > > +	fi
> 
> > >  	if [ "$type" = "lhost" ]; then
> > >  		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> > > -- 
> > > 2.45.2
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

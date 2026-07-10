Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15ABC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:46:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 685F23E26B6
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:46:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33BA83E2699
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:46:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C46562000EF
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:46:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35E4976347;
 Fri, 10 Jul 2026 07:46:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BF4B779BE;
 Fri, 10 Jul 2026 07:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tzNDBVKjUGofOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 07:46:26 +0000
Date: Fri, 10 Jul 2026 09:46:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260710074624.GA1164029@pevik>
References: <20260704085703.618290-1-avinesh.kumar@suse.com>
 <20260708140154.GC125128@pevik>
 <2241dfd8-b2f6-431f-9ced-604e7533a791@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2241dfd8-b2f6-431f-9ced-604e7533a791@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 35E4976347
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test.sh: TCONF on xfrm algorithms rejected
 via netlink extack
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

Hi Avinesh,

> Hi Petr,

> Thank for the review.
Yw!

> > > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > > index 2a83c17a5efb..8701bb390388 100644
> > > --- a/testcases/lib/tst_test.sh
> > > +++ b/testcases/lib/tst_test.sh
> > > @@ -266,13 +266,18 @@ TST_RTNL_CHK()
> > >   	local msg1="RTNETLINK answers: Function not implemented"
> > >   	local msg2="RTNETLINK answers: Operation not supported"
> > >   	local msg3="RTNETLINK answers: Protocol not supported"
> > > +	# Since v6.1 the kernel reports an unknown/removed xfrm algorithm via
> > > +	# netlink extack (-ENOSYS + NL_SET_ERR_MSG), which iproute2 prints as
> > > +	# "Error: Requested AUTH algorithm not found."
> > > +	local msg4="Requested .* algorithm not found"
> > >   	local output="$($@ 2>&1 || echo 'LTP_ERR')"
> > nit: we have in $output also "LTP_ERR" in the end (on error)...

> > > -	local msg
> > > +	local msg match

> > >   	echo "$output" | grep -q "LTP_ERR" || return 0

> > > -	for msg in "$msg1" "$msg2" "$msg3"; do
> > > -		echo "$output" | grep -q "$msg" && tst_brk TCONF "'$@': $msg"
> > > +	for msg in "$msg1" "$msg2" "$msg3" "$msg4"; do
> > > +		match=$(echo "$output" | grep "$msg") && \
> > > +				tst_brk TCONF "'$@': $match"
> > ... now we print error message also with "LTP_ERR" in the end.
> > I wonder if we should bother with removing it, e.g. with sed:

> > -		match=$(echo "$output" | grep "$msg") && \
> > +		match=$(echo "$output" | grep "$msg" | sed 's/LTP_ERR$//') && \
> I tested my patch, and I see atleast the TCONF path is fine, it does not
> print 'LTP_ERR' -

> tcp_ipsec 1 TCONF: 'ip xfrm state add src 10.0.0.2 dst 10.0.0.1 spi 0x1000
> proto esp enc serpent
> 0x5a78724d91fbdab8873e6bc7933816f9bb58b3da90ec2a6e0346ba41c6c18c63 auth
> hmac(rmd160) 0x4b53e65cb2e928d34c0db747782dda0457a3e4ed mode transport sel
> src 10.0.0.2 dst 10.0.0.1': Error: Requested AUTH algorithm not found.

> but we will have it printed in TRBOK cases, as it was before this patch
> also:
> tcp_ipsec 1 TBROK: ip xfrm state add src 10.0.0.2 dst 10.0.0.1 spi 0x1000
> proto esp enc serpent
> 0x40e68502109572c1014d131358bcc38b45ae02e5bbdae35752de32c2b6c68a6e auth
> hmac(rmd160) 0x87658785bf2ffc586ce49e4d31318246429063ef mode tunnel sel src
> 10.0.0.2 dst 10.0.0.1 failed: Error: Requested AUTH algorithm not found.
> LTP_ERR

Good point! OK, in that case I've merged your solution as is and post a
fix for this minor issue myself.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

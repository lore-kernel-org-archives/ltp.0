Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3252DC43334
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 18:44:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85D583C895B
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 20:44:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFB103C00D5
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 20:44:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D33F6017EE
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 20:44:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 175041F8BE;
 Fri,  3 Jun 2022 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654281876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SE1V31GJrNQNiNFkNxBG7QoRM5IKMmI8vAxlDHYXJo=;
 b=OKDcXgbT5qIs5Cjk8ywBAo29oHgD8RbLrN3GnHQc4fZv3hIcqkx/fVOrK86Y2XPUZuFeD3
 1m3rhbLG8Rns4zRwVYjd5scKygX/CV7Ls0rTsa8qkBaZSA0/0K3rZPqGQqALjM2gLX3GAx
 xrYd6zvQtE8H8ID0OS/1BJqEuu3lQW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654281876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SE1V31GJrNQNiNFkNxBG7QoRM5IKMmI8vAxlDHYXJo=;
 b=FweQAoba/35MXSDM09dRY1m9fiLlNhSuVT9LJxZol3INDh9D5Hug+zpQoHxR3ugzce9lR3
 /+EJjqt3S0wunIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5BB413AA2;
 Fri,  3 Jun 2022 18:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gU0JLpNWmmKIcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jun 2022 18:44:35 +0000
Date: Fri, 3 Jun 2022 20:44:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YppWkk6G64E+hpT2@pevik>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-4-pvorel@suse.cz> <YpTS99QLyFfSkrnl@rei>
 <Ypn9kQF7PTM3pA0n@pevik> <YpoLN+fBttUaBDym@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YpoLN+fBttUaBDym@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/8] tst_test.sh: Improve pattern for allowed
 variables
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

> Hi!
> > > >  	if [ -n "$TST_TEST_PATH" ]; then
> > > > -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> > > > +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`'"'"'].*//'); do
> > >                                                                                            ^
> > > 											   Isn't
> > > 											   the
> > > 											   content
> > > 											   between
> > > 											   []
> > > 											   just
> > > 											   set?

> > > Shouldn't adding just ' between the [] suffice? The " is already there.

> > Well, '"'"' was my version of adding ' (quoted with " and ' at the start and end
> > were for ending previous '.

> > But this is shorter: '\'', therefore suggest

> > -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> > +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='\''"} \t\/:`].*//'); do

> I would say that '\'' is stil insane, but I guess that we can't do
> better than that.
IMHO better than using variable:
local _tst_q="'"
for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='$_tst_q'"} \t\/:`].*//'); do

insane: well, POSIX shell is insane :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE95C5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 14:55:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2541D3CFF79
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 15:55:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECD653CC256
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 15:55:41 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C8981011BFE
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 15:55:40 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1357A221C3;
 Fri, 23 Feb 2024 14:55:39 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id ED22013419;
 Fri, 23 Feb 2024 14:55:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 9aDEOOqx2GV5CwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 14:55:38 +0000
Date: Fri, 23 Feb 2024 15:54:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240223145436.GB1486515@pevik>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-5-pvorel@suse.cz> <ZdiVL4Gf8pkqsIW-@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdiVL4Gf8pkqsIW-@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1357A221C3
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/9] metadata: test.sh: Print more info on
 VERBOSE=1
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

> Hi!
> > diff --git a/metadata/tests/test.sh b/metadata/tests/test.sh
> > index 475d721df..a00e32bb4 100755
> > --- a/metadata/tests/test.sh
> > +++ b/metadata/tests/test.sh
> > @@ -3,6 +3,7 @@
> >  fail=0

> >  for i in *.c; do
> > +	[ "$VERBOSE" ] && echo "$0: testing $i"

> Here as well, just use $V instead, and maybe it does not make sense to
> print the $0. Possibly just "parsing $i".

Make sense.

> >  	../metaparse $i > tmp.json
> >  	if ! diff tmp.json $i.json >/dev/null 2>&1; then
> >  		echo "***"
> > @@ -15,4 +16,5 @@ done

> >  rm -f tmp.json

> > +[ "$VERBOSE" ] && echo "$fail"

> Maybe it would make more sense to print pass/fail for each file, i.e.

> Parsing array_size01.c Pass
> Parsing array_size02.c Pass
> Parsing array_size03.c Fail
+1

for i in *.c; do
	../metaparse $i > tmp.json
	[ "$VERBOSE" ] && echo "***** Parsing $i *****"

	if ! diff tmp.json $i.json >/dev/null 2>&1; then
		echo "***"
		echo "$i output differs!"
		diff -u tmp.json $i.json
		echo "***"
		fail=1
		[ "$VERBOSE" ] && echo "$i: FAIL"
	else
		[ "$VERBOSE" ] && echo "$i: PASS"
	fi
done

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

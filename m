Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A6FC83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 19:38:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB78E3CCDB3
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 21:38:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC4963CC935
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:38:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 493831A00901
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:38:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A7DD21961;
 Wed, 23 Jul 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35F2A13ABE;
 Wed, 23 Jul 2025 19:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HcYXDC46gWhsBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Jul 2025 19:38:22 +0000
Date: Wed, 23 Jul 2025 21:38:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250723193820.GC162896@pevik>
References: <20250722125916.74967-1-pvorel@suse.cz>
 <20250722125916.74967-5-pvorel@suse.cz> <aIC1A9yNXKX6QN2N@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aIC1A9yNXKX6QN2N@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5A7DD21961
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/6] tst_res_: Print error to stderr,
 with filename and lineno
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

Hi Cyril,

> Hi!
> > Printing to stderr, tst_res_ filename and lineno helps debugging wrong
> > code. Best would be if it prints either code which invoked it or the
> > original message, but at least this is an improvement.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > * New in v4

> >  testcases/lib/tst_res_.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)

> > diff --git a/testcases/lib/tst_res_.c b/testcases/lib/tst_res_.c
> > index c09d689ee5..5b255d4d54 100644
> > --- a/testcases/lib/tst_res_.c
> > +++ b/testcases/lib/tst_res_.c
> > @@ -16,7 +16,7 @@ int main(int argc, char *argv[])
> >  	int type, i;

> >  	if (argc < 5) {
> > -		printf("argc = %i expected 5\n", argc);
> > +		fprintf(stderr, "%s:%d: argc = %i expected 5\n", __FILE__, __LINE__, argc);
> >  		goto help;
> >  	}

> > @@ -35,7 +35,7 @@ int main(int argc, char *argv[])
> >  	} else if (!strcmp(argv[3], "TBROK")) {
> >  		type = TBROK;
> >  	} else {
> > -		printf("Wrong type '%s'\n", argv[3]);
> > +		fprintf(stderr, "%s:%d: Wrong type '%s'\n", __FILE__, __LINE__, argv[3]);

> In this case we cantually have file and line in argv[1] and argv[2] and
> we can print that as well.

Thanks for a hint! I see I was blind (it's used below :)).

Because I really want whole functionality merged, I merged all but this patch.
And for this single patch I'll send v6.

> And possibly in the case that argc < 5 we can attempt to print argv[1]
> and argv[2] as well, but it's likely going to be wrong data since the
> number of arguments does not match in that case.

Maybe to detect if argv[2] is a number and then use argv[1] and argv[2],
otherwise use __FILE__ and __LINE__ ? But since atoi() does not detect errors,
we would have to use something smarter - safe_strtol() if possible to use LTP
API otherwise strtol()?

Or is it just too complicated and we can use argv[1] and argv[2] if argc > 2
and fallback to __FILE__ and __LINE__ otherwise?

Anyway, thanks a lot for your work and help to slowly move shell tests to shell
loader.  Hopefully we are getting closer to have shell tests more reliable
without a need to rewrite everything to C.

Kind regards,
Petr

> >  		goto help;
> >  	}

> > -- 
> > 2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

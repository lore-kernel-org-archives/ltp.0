Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895C7C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:42:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D984A3CF04A
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 13:42:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2D853CBB62
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:42:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 88C071401629
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:42:27 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A96801FB4E;
 Thu,  7 Dec 2023 12:42:26 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 73584139E3;
 Thu,  7 Dec 2023 12:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id P1ScGbK9cWX7BAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 12:42:26 +0000
Date: Thu, 7 Dec 2023 13:42:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20231207124224.GA241307@pevik>
References: <20231207111223.234170-1-pvorel@suse.cz>
 <20231207111844.GA234785@pevik> <ZXGrB76MCu0-0K0y@yuki>
 <aecb0e4c-9042-463d-9888-7f4508e277fb@suse.com>
 <ZXG5x8R56fISvCLW@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXG5x8R56fISvCLW@rei>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: A96801FB4E
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsx-linux: Reduce log output
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
> > more than TVERB, it would be nice to add a "verbose_flag". Something like:
@Cyril: Or maybe TDEBUG to be more obvious?

I'll enable them on "-v" or on LTP_VERBOSE=1 parameter.
Also, do we want to add it also to the shell API? -v parameter is used
nfs_lib.sh, I wonder into which to rename (-V is used for LTP version in C API,
I guess I should have add it to shell API as well).

> > tst_res(TINFO, "my message %s", my_param, verbose_flag)

> That's technically impossible, because the printf() like messages have
> variable number of parameters.

+1

> Also it's really hard to extend the API at this point without really
> breaking it. We would have to also rewrite a few thousands of test if we
> introduce such change, which may be possible with coccinelle, but I
> would rather avoid such hassle.

+1

@Andrea, I also don't see a big problem with having TVERB flag.
All of them are somehow informative, although most of them also quit.

Kind regards,
Petr

> > And then with a -v we filter out messages which are verbose or not.
> > In this way we don't add T-flags and we can handle any kind of messages 
> > in verbose mode.

> If you are worried about the output, we can easily produce TINFO
> messages for the TVERB flag too.

> Or possibly name the flags as TINFO with a debug level appended e.g. we
> can add TINFO0, TINFO1 and TINFO2 and define TINFO to TNFO0 for
> backwards compatibility.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

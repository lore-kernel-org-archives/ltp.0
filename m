Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940B0C3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:28:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33EF73CBFF8
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:28:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 064DE3CBF46
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:28:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A20B1000761
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:28:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B8312121C;
 Wed,  7 May 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75BBA13882;
 Wed,  7 May 2025 15:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jJ1GGxd8G2j4aAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 07 May 2025 15:28:23 +0000
Date: Wed, 7 May 2025 17:29:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <aBt8PJNmiJNuSEB5@yuki.lan>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <4428939d-dc71-488b-9728-030accaca3e8@suse.cz>
 <aBh9Z4QA2YcdOFq1@rei.lan> <20250506080520.GA64990@pevik>
 <20250507151148.yhrnckco7zkrpfzw@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250507151148.yhrnckco7zkrpfzw@lida.tpb.lab.eng.brq.redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8B8312121C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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
Cc: Mark Wielaard <mark@klomp.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > > > It also opens some interesting questions, i.e. how do we make comparing
> > > > > results from two different tests easier. Currently they grep the test
> > > > > results for a summary, but maybe we can do better.
> >
> > > > One option is to extract all TPASS/TFAIL/TWARN/TBROK/TCONF messages,
> > > > discard any message contents past the file:line header and then compare
> > > > whether the sanitized output is identical. That'll take care of random
> > > > values in the output while ensuring that the test went through the same
> > > > code paths as before. We could provide a sanitizer script for that.
> >
> > > Maybe we can even add an option to the test library to supress the
> > > messages in output, that would be fairly simple.
> >
> > @Martin @Mark: feel free to comment what we can do for you :).
> > Whole thread:
> > https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t
> 
> Nice to see you noticed!  Primarily we're trying to identify
> valgrind gaps and bugs.  For our use-case it's good to have
> reproducible test runs in a sense of identical test results for
> repeated test runs.  We got pretty close to this by only taking
> into account the testcase summaries at the very end of the test
> logs.  Any steps to get closer to reproducible test runs on the
> LTP side are interesting for us, and we'll try to reflect those!

I've proposed a simple solution that would cut the message from tests
only to contain the line numbers and results in:

https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#m98317262b25ede62704b005fcefc63c62198bb90

If that works for you we can get this in LTP before the next release.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

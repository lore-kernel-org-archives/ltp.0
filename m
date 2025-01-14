Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557D1E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 16:20:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7FB23C7B15
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 17:20:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DF013C79FA
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 17:20:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8946661614E
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 17:20:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0E8E21167;
 Tue, 14 Jan 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D81A51384C;
 Tue, 14 Jan 2025 16:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nYfOM86OhmdwBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 16:20:30 +0000
Date: Tue, 14 Jan 2025 17:20:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250114162028.GB619334@pevik>
References: <20250109132334.212281-1-pvorel@suse.cz>
 <9cda6edd-6644-46f6-980e-b8939f6f2240@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9cda6edd-6644-46f6-980e-b8939f6f2240@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: F0E8E21167
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] [RFC] macros: Remove TEST_VOID()
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

> I'm kinda surprised something so ugly even existed :-) Thanks for cleaning
> up.
> Feel free to merge the whole patch-set.

Yeah, there are many dark sides in LTP :). Fortunately, thanks to you and others
it's getting much better.

Kind regards,
Petr

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

> Andrea

> On 1/9/25 14:23, Petr Vorel wrote:
> > TEST_VOID() macro was meant for syscalls whose return type is void, e.g.
> > sync(). It was used only sync03.c, which was later merged to sync01.c
> > and later removed. Now it's unused, therefore remove it.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   include/old/usctest.h     | 14 --------------
> >   include/tst_test_macros.h |  7 -------
> >   2 files changed, 21 deletions(-)

> > diff --git a/include/old/usctest.h b/include/old/usctest.h
> > index 2d46c40451..b984c343fd 100644
> > --- a/include/old/usctest.h
> > +++ b/include/old/usctest.h
> > @@ -60,20 +60,6 @@ extern int TEST_ERRNO;
> >   		TEST_ERRNO = errno; \
> >   	} while (0)
> > -/***********************************************************************
> > - * TEST_VOID: calls a system call
> > - *
> > - * parameters:
> > - *	SCALL = system call and parameters to execute
> > - *
> > - * Note: This is IDENTICAL to the TEST() macro except that it is intended
> > - * for use with syscalls returning no values (void syscall()).  The
> > - * Typecasting nothing (void) into an unsigned integer causes compilation
> > - * errors.
> > - *
> > - ***********************************************************************/
> > -#define TEST_VOID(SCALL) do { errno = 0; SCALL; TEST_ERRNO = errno; } while (0)
> > -
> >   /***********************************************************************
> >    * TEST_PAUSE: Pause for SIGUSR1 if the pause flag is set.
> >    *	       Just continue when signal comes in.
> > diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> > index b2ca32f771..b2b446b70c 100644
> > --- a/include/tst_test_macros.h
> > +++ b/include/tst_test_macros.h
> > @@ -16,13 +16,6 @@
> >   		TST_ERR = errno; \
> >   	} while (0)
> > -#define TEST_VOID(SCALL) \
> > -	do { \
> > -		errno = 0; \
> > -		SCALL; \
> > -		TST_ERR = errno; \
> > -	} while (0)
> > -
> >   extern long TST_RET;
> >   extern int TST_ERR;
> >   extern int TST_PASS;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

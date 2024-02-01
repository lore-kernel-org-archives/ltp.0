Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF40C4828C
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 11:52:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93CDB3CF8D7
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 12:52:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C1E3CE0A4
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 12:51:56 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0EF4200C75
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 12:51:55 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A188D1F385;
 Thu,  1 Feb 2024 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706788314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjP2GlQ3H5mEcp/9UpbTSFlJTbGldNMos7DWNwfo3Ns=;
 b=28AGwKHKj6zB65tjPFDBd6Ut41cWzIRGP4oPXDDfNey1pmPosNHerclA071tyacdon4OyQ
 X70GNQgvu1Hwg0Pu8pxfE6EXmK4IOw+LkCUlO9888Jju5slPBP7v6hjEvKbFZRXtgzJ5yv
 jUFPGhR4tLOdcHYhJN3TqylTWY8thlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706788314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjP2GlQ3H5mEcp/9UpbTSFlJTbGldNMos7DWNwfo3Ns=;
 b=f5oddmsaKbPw7PLqcmkaeN39j2xBpQSXoMVPvOyeCrJkmomOdBPxo9nhXwLPs2t/mwpmXV
 QNggz+8B0ugm30Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706788314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjP2GlQ3H5mEcp/9UpbTSFlJTbGldNMos7DWNwfo3Ns=;
 b=28AGwKHKj6zB65tjPFDBd6Ut41cWzIRGP4oPXDDfNey1pmPosNHerclA071tyacdon4OyQ
 X70GNQgvu1Hwg0Pu8pxfE6EXmK4IOw+LkCUlO9888Jju5slPBP7v6hjEvKbFZRXtgzJ5yv
 jUFPGhR4tLOdcHYhJN3TqylTWY8thlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706788314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RjP2GlQ3H5mEcp/9UpbTSFlJTbGldNMos7DWNwfo3Ns=;
 b=f5oddmsaKbPw7PLqcmkaeN39j2xBpQSXoMVPvOyeCrJkmomOdBPxo9nhXwLPs2t/mwpmXV
 QNggz+8B0ugm30Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7844C13594;
 Thu,  1 Feb 2024 11:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id WwJRG9qFu2XzbwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 01 Feb 2024 11:51:54 +0000
Date: Thu, 1 Feb 2024 12:51:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240201115153.GB78772@pevik>
References: <20240131135026.1562-1-mdoucha@suse.cz>
 <20240131172148.GA5570@pevik>
 <435a79e2-fe53-4eca-b344-20044f2a398c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <435a79e2-fe53-4eca-b344-20044f2a398c@suse.cz>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=28AGwKHK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f5oddmsa
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A188D1F385
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitpid04: Convert to new API
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

Hi Martin,

> On 31. 01. 24 18:21, Petr Vorel wrote:
> > > Convert waitpid() error state checks to new API, fix bugs in the original
> > > test and add ESRCH subtest.

> > Very nice cleanup.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > BTW what were these bugs? It looks like old test uses pid O for the first ECHILD
> > test (not sure how it got defined to 0).

> The first subtest used uninitialized pid value in the first iteration and
> then it'd test only pid=1 in all other iterations.

Thanks for info.

> > >   #include <sys/signal.h>
> > nit: this should be <signal.h>
> > warning: #warning redirecting incorrect #include <sys/signal.h> to <signal.h> [-Wcpp]

> > Can be fixed before merge.

> Yes, please fix. Strangely, I didn't get this warning during compilation.

The problem is visible only on pedantic MUSL. Not a big issue, it would work:

cat /usr/include/sys/signal.h
#include <signal.h>

but it's just better to use the standard header, not the fallback one
(one day MUSL might removes the fallback).

> > >   #include <sys/types.h>
> > >   #include <sys/wait.h>
> > ...
> > > +#include "tst_test.h"
> > > +
> > > +#define TCFMT "waipid(%d, NULL, 0x%x)"
> > > +#define TCFMTARGS(tc) (tc)->pid, (tc)->flags

> > checkpatch.pl complains:
> > waitpid04.c:19: ERROR: Macros with complex values should be enclosed in parentheses

> > I guess we can ignore this unless you see a quick fix (I guess macro which runs
> > tst_res() inside would be needed.

> The warning is expected, the macro should expand to multiple arguments.
> Parentheses would prevent that. I could fix it by tst_res(TINFO,
> "waitpid($args)"); before each test.

Yep, that's what I would do - just to print params before test:

tst_res(TINFO, "waipid(%d, NULL, 0x%x)", tc->pid, tc->flags);
TEST(waitpid(tc->pid, NULL, tc->flags));

> > > +static struct testcase {
> > > +	pid_t pid;
> > > +	int flags;
> > > +	int err;
> > > +} testcase_list[] = {
> > > +	{-1, 0, ECHILD},	/* Wait for any child when none exist */
> > > +	{1, 0, ECHILD},		/* Wait for non-child process */
> > > +	{-1, -1, EINVAL},	/* Invalid flags */
> > > +	{INT_MIN, 0, ESRCH},	/* Wait for invalid process group */
> > > +};
> > > +
> > > +void run(unsigned int n)
> > >   {
> > ...
> > > +	const struct testcase *tc = testcase_list + n;

> > > -		if (FORK_OR_VFORK() == 0)
> > > -			exit(0);
> > > +	TEST(waitpid(tc->pid, NULL, tc->flags));
> > How about using TST_EXP_FAIL2() to avoid code below? It would also help to avoid
> > macros, right?  Or you want to explicitly state what failed?

> The waitpid() call would be converted to a string that gives no useful
> information about which testcase is actually running and there isn't any
> good error message if the call succeeds.

Indeed plain TST_EXP_FAIL2() would do it:
	TST_EXP_FAIL2(waitpid(tc->pid, NULL, tc->flags), tc->err);

waitpid04.c:38: TFAIL: waitpid(tc->pid, NULL, tc->flags) expected ESRCH: ECHILD (10)
...
waitpid04.c:38: TFAIL: waitpid(tc->pid, NULL, tc->flags) expected EINVAL: ECHILD (10)

I definitely don't want to push for it, but the output is similar:

	TST_EXP_FAIL2(waitpid(tc->pid, NULL, tc->flags), tc->err,
				  "waipid(%d, NULL, 0x%x)", tc->pid, tc->flags);

When testing that with 2 broken testcase values:

	{-1, 0, ESRCH},		/* pvorel: changed from ECHILD */
	{1, 0, ECHILD},		/* Wait for non-child process */
	{-1, 0, EINVAL},	/* Invalid flags */
	{INT_MIN, 0, ESRCH},  /* pvorel: flag changed from -1 */

waitpid04.c:38: TFAIL: waipid(-1, NULL, 0x0) expected ESRCH: ECHILD (10) /* new */
waitpid04.c:49: TFAIL: waipid(-1, NULL, 0x0): expected error ESRCH, got: ECHILD (10) /* orig */
...

waitpid04.c:38: TFAIL: waipid(-1, NULL, 0x0) expected EINVAL: ECHILD (10) /* new */
waitpid04.c:49: TFAIL: waipid(-1, NULL, 0x0): expected error EINVAL, got: ECHILD (10) /* orig */

But no problem to merge it as is. Sooner or later we should add test specific
checkpatch.pl options to ignore certain warnings.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

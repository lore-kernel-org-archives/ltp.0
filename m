Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7332BCDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 13:50:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84C913CEE3F
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 15:50:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3C433C8712
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:50:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBC4B601239
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:50:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EDF621FD99;
 Fri, 13 Oct 2023 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697205032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d07iYvMCfftnx4gLaFe6kch+nUlNhGJyeIJo2IvoYFo=;
 b=rNTbJXGUFtwkisyrF806pNqZ6GcVzRMVzvIqlPAGetZvWJGY1e7ZIlNBIfNYa6nbKh+g6w
 FYNbzgT4WluGHWhHOvYpXQHxoLnf4xCj2DWulfyFlVUn8/2Z5AMba5Q49IY9d20xhAiRvc
 rTJRPT4GbH/WlO4c7RPs8+CY3pSX7Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697205032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d07iYvMCfftnx4gLaFe6kch+nUlNhGJyeIJo2IvoYFo=;
 b=yFH7iHRt8DRqiNsv+rFMrhETw727tR6itlTvoiAXHuk6dQVpGerlOLafpGuSasxzkZXXA/
 j0O2rZGcj3R0U+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D414F1358F;
 Fri, 13 Oct 2023 13:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Po2UMihLKWVlHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Oct 2023 13:50:32 +0000
Date: Fri, 13 Oct 2023 15:50:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231013135031.GA740264@pevik>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <20231013123056.GC733568@pevik>
 <CAEemH2es0i-=V5W=2ZhZnN7OOq9BnFkkkSPyU1EUDWj0XHu1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2es0i-=V5W=2ZhZnN7OOq9BnFkkkSPyU1EUDWj0XHu1WA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.47 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.17)[69.85%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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


Hi Li,

thanks for your input!

> > Hi all,

> > maybe .modprobe is too short name, but I'm not sure what would be better.
> > Maybe .modprobe_module ?


> .modprobe_module sounds better.
+1

> Also, I think that maybe we can support modprobe some
> third-party modules (written by users) in test case, there are
> a few managed by shell scripts, but if .modprobe_module
> manages them unify in C, it would be nice for test variety.

+1. Also I plan to move some of the LTP kernel modules - tests which use kernel
modules from LTP (e.g. delete_module, init_module, ...)to KUnit or kselftest (to
solve problem with signed modules required by distro kernels, kernel modules
from LTP are then untestable on lockdown).  But maybe these modules can stay in
LTP and also be added to KUnit.
But these modules use tst_module_exists_() and SAFE_OPEN(). So you might mean
3rd party modules like nvidia or other proprietary modules, right?

Then, some of the tests in testcases/kernel/device-drivers/ might be obsolete or
also be more suitable in kselftest or KUnit or elsewhere.

...
> > > +     if (tst_test->modprobe) {
> > > +             const char *name;
> > > +             int i;
> > > +
> > > +             for (i = 0; (name = tst_test->modprobe[i]); ++i) {
> > > +                     /* only load module if not already loaded */
> > > +                     if (!module_loaded(name) &&
> > tst_check_builtin_driver(name)) {

> > Also we could make it independent on modules.builtin (NixOS based problem -
> > missing these files). I.e. we would keep only module_loaded(), remove
> > tst_check_builtin_driver(). But then we could not run rmmod / modprobe -r,
> > or we would have to ignore it's exit code (rmmod on builtin module) fails.


> Or we add one step to detect modules.builtin file, if no,
> then just print a Warning at unload in fails?

Unloading shouldn't be problem since it's in cleanup (thus TBROK => TWARN).
But I'll test it.

Or do you mean that on missing modules.builtin would test itself be working as
module is presented (have warning on that modules.* files are missing and
warning on rmmod?).

Would you do it for both .modprobe_module and .needs_drivers? Or just one
of them?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

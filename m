Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D972C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:52:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FDBB3C0294
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:52:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58EA23C0294
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:51:52 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B06F71001184
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:51:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1347B1F387;
 Fri, 17 Jan 2025 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737111110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qae7nUUXOSx3HVF0LkdiQFdoxbFCvvybO4+27Giq5V0=;
 b=Np1ef0SFulgY+HJAG5kFA/h5ncqHT7eku3kL4IILyDS0aA2EkvGWo/kiVMSnbNMxV1I3fK
 kxsAQZ1bxr97fpRZekZmHsaBFmy07BM03fXBpusQC2Zs7MEkyLb2SiRR+K0JeyadWtdQrK
 stKGGoQN74+tAmGQzZ/WnKRKYjTMg20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737111110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qae7nUUXOSx3HVF0LkdiQFdoxbFCvvybO4+27Giq5V0=;
 b=vODGL0BOGMAhBY3g/fhZntSoPUtoRR8nv9GSRN9B5sZmMnX5fdnMQ5MaXwKBewAhnN7o3K
 zFzn+jTXBYLmwGBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737111109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qae7nUUXOSx3HVF0LkdiQFdoxbFCvvybO4+27Giq5V0=;
 b=hcu6LaQLZl5RSSyA1q+gjt9KmHyu7TkG54p1gz/2PCiiyrigO6Iku1A9A7zR0nbrHHS8Uv
 cd4l9II1/C+0rs3iNmwt+PNbsFGD/vRHjGExHLxjCXviiiM4hHTOKAr490CFmobic7Iow6
 94AAHiuBZE+5bX6KNai33A3SFqFNUhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737111109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qae7nUUXOSx3HVF0LkdiQFdoxbFCvvybO4+27Giq5V0=;
 b=HBVbsTrZAQ2Y7rK4dLf24AVvQk9JIflJ97a+o/USj4kKKFO4E/v0hWFG3tZNH2avH1AuEo
 OtjtBMeuXbHgkjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9797D13332;
 Fri, 17 Jan 2025 10:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q5GPIkQ2imdXagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 10:51:48 +0000
Date: Fri, 17 Jan 2025 11:51:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250117105147.GA754426@pevik>
References: <20250117084118.740225-1-pvorel@suse.cz>
 <Z4oln8S422XIUExH@yuki.lan> <20250117095742.GA749338@pevik>
 <Z4otgs7iVe3sZ63C@yuki.lan> <20250117102825.GA750951@pevik>
 <Z4oxlVP5VCVpO0mc@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4oxlVP5VCVpO0mc@yuki.lan>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.com,redhat.com,suse.de,suse.cz];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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
> > > diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
> > > index 6a8e39339..989bb8910 100644
> > > --- a/testcases/lib/tst_ns_exec.c
> > > +++ b/testcases/lib/tst_ns_exec.c
> > > @@ -100,7 +100,12 @@ int main(int argc, char *argv[])
> > >         for (i = 0; i < ns_fds; i++)
> > >                 SAFE_SETNS(ns_fd[i], 0);

> > > -       pid = SAFE_CLONE(&args);
> > > +       pid = tst_clone(&args);
> > > +       if (pid < 0) {
> > > +               printf("clone() failed");
> > > +               return 1;
> > > +       }
> > > +
> > >         if (!pid)
> > >                 SAFE_EXECVP(argv[3], argv+3);

> > Thanks, it works! Could you please merge it? Maybe update the comment?

> > -       .forks_child = 1, /* Needed by SAFE_CLONE */
> > +       .forks_child = 1, /* Needed by safe_clone() */

> I guess that we do not need that one anymore. Does the helper work if
> we remove it?

Good catch, it works (I didn't notice we're using tst_clone(), not
safe_clone()). I tested it on the patch below.

Thanks!

Kind regards,
Petr

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Fixes: 893ca0abe7 ("lib: multiply the timeout if detect slow kconfigs")

+++ testcases/lib/tst_ns_exec.c
@@ -20,12 +20,6 @@
 #include "tst_test.h"
 #include "tst_ns_common.h"
 
-extern struct tst_test *tst_test;
-
-static struct tst_test test = {
-	.forks_child = 1, /* Needed by SAFE_CLONE */
-};
-
 static int ns_fd[NS_TOTAL];
 static int ns_fds;
 
@@ -71,8 +65,6 @@ int main(int argc, char *argv[])
 	int i, status, pid;
 	char *token;
 
-	tst_test = &test;
-
 	if (argc < 4) {
 		print_help();
 		return 1;
@@ -100,7 +92,12 @@ int main(int argc, char *argv[])
 	for (i = 0; i < ns_fds; i++)
 		SAFE_SETNS(ns_fd[i], 0);
 
-	pid = SAFE_CLONE(&args);
+	pid = tst_clone(&args);
+	if (pid < 0) {
+		printf("clone() failed");
+		return 1;
+	}
+
 	if (!pid)
 		SAFE_EXECVP(argv[3], argv+3);
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

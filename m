Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DE1C02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:14:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBB983C7C2C
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:14:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FACB3C4CED
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:14:37 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B3CA021DCA6
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:14:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF34B2116E;
 Fri, 17 Jan 2025 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737108874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ms144eCTvZYJVaQ8Op+Yrt1PUuexEVkMDX9xw8S4sKU=;
 b=AM0ymFbgk6CLYAnMlIs4xmp//S5Z32mb088W9ek51J/N0rOhgv8vtO5RuQwHuHwTWO8fCh
 nt6ZcuWtrbsx6lg6vWnn5qxXO/Fr2ZKF0WrV8gcB7EnsN+2sN/D8UVOBmMoEtPQid9PJEK
 JuuLfiiTlk2nWSukLI+fdHZy2ngtX/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737108874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ms144eCTvZYJVaQ8Op+Yrt1PUuexEVkMDX9xw8S4sKU=;
 b=0Uprb4P7rXmxlSEVB3mbd27FJ0T5jUs7691cFlJDA20nGxBXEmw6V6uVNUbPOJVjmPhcoO
 NaBsXo7OL9SbJcAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737108874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ms144eCTvZYJVaQ8Op+Yrt1PUuexEVkMDX9xw8S4sKU=;
 b=AM0ymFbgk6CLYAnMlIs4xmp//S5Z32mb088W9ek51J/N0rOhgv8vtO5RuQwHuHwTWO8fCh
 nt6ZcuWtrbsx6lg6vWnn5qxXO/Fr2ZKF0WrV8gcB7EnsN+2sN/D8UVOBmMoEtPQid9PJEK
 JuuLfiiTlk2nWSukLI+fdHZy2ngtX/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737108874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ms144eCTvZYJVaQ8Op+Yrt1PUuexEVkMDX9xw8S4sKU=;
 b=0Uprb4P7rXmxlSEVB3mbd27FJ0T5jUs7691cFlJDA20nGxBXEmw6V6uVNUbPOJVjmPhcoO
 NaBsXo7OL9SbJcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFDCC139CB;
 Fri, 17 Jan 2025 10:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NWvuKYotimf2LQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jan 2025 10:14:34 +0000
Date: Fri, 17 Jan 2025 11:14:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4otgs7iVe3sZ63C@yuki.lan>
References: <20250117084118.740225-1-pvorel@suse.cz>
 <Z4oln8S422XIUExH@yuki.lan> <20250117095742.GA749338@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117095742.GA749338@pevik>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.com,redhat.com,suse.de,suse.cz];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This looks like there is something fundamentally wrong there. If there
> > is a TST_NO_DEFAULT_MAIN defined in the test, the test does not call
> > tst_run_tcases() and the timeout shouln't be set up.
> 
> FYI tst_test.c:510 safe_clone(): call tst_multiply_timeout()

Found that one as well. I guess that we need to switch to tst_clone():

diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
index 6a8e39339..989bb8910 100644
--- a/testcases/lib/tst_ns_exec.c
+++ b/testcases/lib/tst_ns_exec.c
@@ -100,7 +100,12 @@ int main(int argc, char *argv[])
        for (i = 0; i < ns_fds; i++)
                SAFE_SETNS(ns_fd[i], 0);

-       pid = SAFE_CLONE(&args);
+       pid = tst_clone(&args);
+       if (pid < 0) {
+               printf("clone() failed");
+               return 1;
+       }
+
        if (!pid)
                SAFE_EXECVP(argv[3], argv+3);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

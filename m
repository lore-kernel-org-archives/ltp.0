Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE1EC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 12:40:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B92E83CA0F1
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 13:40:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E7F73C9533
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 13:40:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB8652013DC
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 13:40:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB1981F37D;
 Fri, 18 Feb 2022 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645188031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FB3oRP44EYnA2kykBq0VTPIi4ije2E1ewCF6rOCeWwk=;
 b=GuVVZdUBuAdYvq7O/RDu1lzWqOBag3XyoA9bSEW7G6NpHhyp3S0gx4VqcNO5YZfaz4XW+C
 TpYFd4wf+KlgKubfgHpuifPnBDxGXaUMBRrSgUtgRq4M7tTvbndmwJALIHG5l1g7+3U638
 u0k5wO25Wz3ZXHtkQfqoUQrSAuLLhEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645188031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FB3oRP44EYnA2kykBq0VTPIi4ije2E1ewCF6rOCeWwk=;
 b=+uS+PhweRnDgqhgLNjD8f3nts+PazQIXh0CQMj60WzO3a5EyzhSejguq+cPiDi6NqSzrb9
 PpYmJVckImnqZuBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C763B13C84;
 Fri, 18 Feb 2022 12:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IeR3L7+TD2KATQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Feb 2022 12:40:31 +0000
Date: Fri, 18 Feb 2022 13:42:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yg+UQM+YCmNU1ShF@yuki>
References: <20220211114401.24663-1-mdoucha@suse.cz> <YgZcu4frLBaKVXL2@yuki>
 <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
 <CAEemH2fqy3_t=-dbqE9Bx3VH6sZbNvM_bMon4zMukOh+rmw42Q@mail.gmail.com>
 <Yg+RXbUTOxK56iZa@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg+RXbUTOxK56iZa@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 72b1728674 causing regressions [ [PATCH v2] Terminate
 leftover subprocesses when main test process crashes]
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
Cc: LTP List <ltp@lists.linux.it>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > >> --- a/lib/tst_test.c
> > > >> +++ b/lib/tst_test.c
> > > >> @@ -1495,6 +1495,9 @@ static int fork_testrun(void)
> > > >>              return TFAIL;
> > > >>      }
> 
> > > >> +    if (tst_test->forks_child)
> > > >> +            kill(-test_pid, SIGKILL);
> FYI This broke all LTP network tests which use netstress.c binary,
> they now randomly fails after "tst_test.c:1499: TINFO: Killed the leftover descendant processes"
> 
> I was thinking whether it's not actually kernel bug which is now visible,
> but the behavior is the same on various kernels: SLES 5.14, openSUSE 5.16.8,
> older Debian 5.3. and different VM setup (but disabled firewall, also randomly
> failing means it's not a firewall issue).
> 
> Not sure now whether netstress.c should be altered or we should add flag to the
> API to not run this cleanup.
> 
> DEBUGGING:
> 
> The reason is hidden, because netstress.c output is redirected and printed only
> on error.
> 
> Sometimes it's just a warning:

I guess that it's a race between the SETSID() and exit(0) in the
move_to_background() function. If the main test process calls exit(0)
before the newly forked child managed to do SETSID() it's killed by the
test library because it's still in the old process group.

Try this:

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 0914c65bd..04a850134 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -713,11 +713,15 @@ static void server_cleanup(void)

 static void move_to_background(void)
 {
-       if (SAFE_FORK())
+       if (SAFE_FORK()) {
+               pause();
                exit(0);
+       }

        SAFE_SETSID();

+       SAFE_KILL(getppid(), SIGUSR1);
+
        close(STDIN_FILENO);
        SAFE_OPEN("/dev/null", O_RDONLY);
        close(STDOUT_FILENO);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

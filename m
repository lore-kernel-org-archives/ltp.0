Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD67C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:02:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A310961168
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A310961168
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB0093C8617
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:02:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6D0D3C1C6E
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:02:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 056F41400C49
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:01:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 11037201D0;
 Wed, 22 Sep 2021 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632301319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8HRCq5znSmDN1/9yvqnjY9MJZzZgNHXMzx31PFvjW20=;
 b=hJ/Fh22YSZe4azcpvSmM57CLSg5wG9pUVVlmcM6GsepAV191K2bdsN3PNat2xrkLdv31MH
 UB/tq0Ub0As3q0BBM9aZo8XOerPmN+c6/QOe82bFn1jb2Lsq8XTEPoJIo2U0L60LtEFkQ4
 rOnCMWDIUG3gPDvPZ4rF9zvuydK9RJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632301319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8HRCq5znSmDN1/9yvqnjY9MJZzZgNHXMzx31PFvjW20=;
 b=/8sasW81O5QZDT8/lLMbGYkc613sT30irwhEi7sEEWWiH358i3mPopiqG83mrJ6plNU5tq
 UjYhSF73rgGr4SDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7B0B13D64;
 Wed, 22 Sep 2021 09:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OmcvLAbxSmFvIQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Sep 2021 09:01:58 +0000
Date: Wed, 22 Sep 2021 11:02:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YUrxJfAOO3+B8//7@yuki>
References: <20210920122146.31576-1-chrubis@suse.cz>
 <CAEemH2eRgUDNLmmzNF5cDaAXp7kMgPOBHeJeWqyStOiAq7QLHw@mail.gmail.com>
 <YUnCYvtAZkO/LZIP@yuki>
 <CAEemH2e0kHun++Y2w99N68WAhjFdQkSvkF-1UaDxjbkA1sBrAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e0kHun++Y2w99N68WAhjFdQkSvkF-1UaDxjbkA1sBrAw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: shell: Fix timeout process races
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > This 'pid' is the parent shell process id, so it obviously that
> > > tst_timeout_kill
> > > process would get signal SIGTERM as well.
> > >
> > > I'm thinking maybe we should let tst_timeout_kill itself ignore SIGTERM
> > > otherwise we have no chance to perform the following double-check code?
> >
> > I guess that signal(SIGTERM, SIG_IGN) a the start of the main() should
> > fix it.
> >
> 
> It works, but better put it behind of sleep(timeout).
> 
> Because we still need to guarantee tst_timeout_kill can be
> stopped by _tst_cleanup_timer before timeout happening.

Right, of course we want the timeout killer to be killable before the
timeout.

> --- a/testcases/lib/tst_timeout_kill.c
> +++ b/testcases/lib/tst_timeout_kill.c
> @@ -44,6 +44,8 @@ int main(int argc, char *argv[])
>         if (timeout)
>                 sleep(timeout);
> 
> +       signal(SIGTERM, SIG_IGN);
> +
>         print_msg("Test timed out, sending SIGTERM!");
>         print_msg("If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1");
> 
> @@ -57,12 +59,12 @@ int main(int argc, char *argv[])
> 
>         i = 10;
> 
> -       while (!kill(-pid, 0) && i-- > 0) {
> +       while (!kill(pid, 0) && i-- > 0) {
>                 print_msg("Test is still running...");
>                 sleep(1);
>         }
> 
> -       if (!kill(-pid, 0)) {
> +       if (!kill(pid, 0)) {
>                 print_msg("Test is still running, sending SIGKILL");
>                 ret = kill(-pid, SIGKILL);
>                 if (ret) {

Hmm, and of course this does not work since the timeout kill process is
around. Maybe we should make this process a separate process group from
the start, what about calling setpgid(0, 0) instead of setting up the
signal handler? That way we can send the signals to the whole process
group and make sure everything has been cleaned up.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

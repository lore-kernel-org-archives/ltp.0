Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4C6C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 15:32:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 600D93CA125
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 16:32:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FC573CA0CB
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 16:32:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 92CE260177A
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 16:32:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B285B1F37E;
 Fri, 18 Feb 2022 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645198349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7w9LwvNtfW3W5AJKZ2UJvCmfn8T/XZb4ShocBLQx9w=;
 b=J6/XSJX4vBBs8eFkQpnAw05MqNMZTS8qrC/X2+QU6BXUy1Vq2i8Iu2SjyYHrODLVYbnl9U
 f+DLKv80G/dI7eAwvilL57Gpfmi0PUnpyFIGk+5GZNVjPYMYMHHy5W3g6yWwsly18uWMl0
 hLWeyQqog1LHJGMLGbnwI8bQz6Y8q7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645198349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7w9LwvNtfW3W5AJKZ2UJvCmfn8T/XZb4ShocBLQx9w=;
 b=stptGDCdptwBjmdwPF9zo7yQNjAaujstzbjpRaGfgqkvAdGlr57b+BeSkwmjKA1hSBIT9m
 2bNNo5B1CDYd4rCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5880513C9B;
 Fri, 18 Feb 2022 15:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FsEiEw28D2KWJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 15:32:29 +0000
Date: Fri, 18 Feb 2022 16:32:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yg+8Crn3EIkHC0MG@pevik>
References: <20220211114401.24663-1-mdoucha@suse.cz> <YgZcu4frLBaKVXL2@yuki>
 <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
 <CAEemH2fqy3_t=-dbqE9Bx3VH6sZbNvM_bMon4zMukOh+rmw42Q@mail.gmail.com>
 <Yg+RXbUTOxK56iZa@pevik> <Yg+UQM+YCmNU1ShF@yuki>
 <Yg+wPtDfI4+bn1ww@pevik> <Yg+xwn2UsG8CxmnQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg+xwn2UsG8CxmnQ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > I guess that it's a race between the SETSID() and exit(0) in the
> > > move_to_background() function. If the main test process calls exit(0)
> > > before the newly forked child managed to do SETSID() it's killed by the
> > > test library because it's still in the old process group.

> > Thanks!  Yep, it'll probably be a race.

> > Your patch causes server being killed:
> > tst_test.c:1511: TBROK: Test killed by SIGUSR1!

> > (no big surprise)

> Ah right, we have to set up a dummy handler for SIGUSR1 since default
> handler for SIGUSR1 will terminate the process.


Yep, with with adding it it works as expected.
(I wasn't sure if you plan to somehow align with the cleanup from tst_test.c,
which also uses SIGUSR1 for cleanup, but right we're masking it).

static void sig_handler(int sig LTP_ATTRIBUTE_UNUSED)
{
}

and setting it in setup()
SAFE_SIGNAL(SIGUSR1, sig_handler);

> Or set the .needs_checkpoints in the tst_test structure and use WAKE and
> WAIT pair to synchronize.
As signal handler works, I'd go for it unless this preferred.
Going to send proper patch.

I wonder if it's just netstress.c which suffers this problem.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

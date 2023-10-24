Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E22C00A8F
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 19:19:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE0543CEEE1
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 21:19:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDE273C6D29
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 21:19:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 98C201A00891
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 21:19:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 197FD21C58;
 Tue, 24 Oct 2023 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698175149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06csNpFUhsdigLj00ugEnzLxo05EzQCPNlnKb0tOMTw=;
 b=bnIT6Y4oHh+039TfTC8zBSNNuo0gQqawGiqSoLL92TIAeTdW2kryfDedUl4urHRpEoW2Xx
 C1lNr2RICqUF2xOYxcNfChjMEyZ/AatMAxrkcrYx9L1Mo0yNwcbOrUeAHcIT3scx4rb22m
 qJiF7eCpKYXhJaZ3O4wAKPZHwlime98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698175149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06csNpFUhsdigLj00ugEnzLxo05EzQCPNlnKb0tOMTw=;
 b=K0Q8IbMrpQUxYqqlVHwgXNq+BexQ1qcObtrfSP+B73MyP2odcPFLeUN8ciG0yVGCzRc+zo
 dXK7ItyEK8bdXQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 471F2134F5;
 Tue, 24 Oct 2023 19:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /X1XDKwYOGV2OgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Oct 2023 19:19:08 +0000
Date: Tue, 24 Oct 2023 21:19:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20231024191906.GA256397@pevik>
References: <20231020150749.21165-1-mdoucha@suse.cz>
 <20231020150749.21165-3-mdoucha@suse.cz>
 <CAOQ4uxgV-PoXQ6Aeimn8T5tUbXX_8RRMwXtAqzUix7ro=BmV-g@mail.gmail.com>
 <5f74b10f-2a97-9cdc-69c0-5e90f1d5d986@suse.cz>
 <CAOQ4uxh+JDVXEipwF2XCe=5RRTk22HZB65_BeKNEM6Vm0okPcw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh+JDVXEipwF2XCe=5RRTk22HZB65_BeKNEM6Vm0okPcw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FREEMAIL_TO(0.00)[gmail.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.41)[77.92%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: Improve check for unsupported
 init flags
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > >>   static int pipes[2] = {-1, -1};
> > >>   static int fanotify_fd;
> > >> -static int fan_report_target_fid_unsupported;
> > >>   static int ignore_mark_unsupported;
> > >> +static unsigned int supported_init_flags;

> > >>   struct test_case_flags_t {
> > >>          unsigned long long flags;
> > >> @@ -246,9 +246,8 @@ static void do_test(unsigned int number)
> > >>          tst_res(TINFO, "Test case %d: fanotify_init(%s, O_RDONLY)", number,
> > >>                  tc->init.desc);

> > >> -       if (fan_report_target_fid_unsupported && tc->init.flags & FAN_REPORT_TARGET_FID) {
> > >> -               FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
> > >> -                                           fan_report_target_fid_unsupported);
> > >> +       if (tc->init.flags & ~supported_init_flags) {
> > >> +               tst_res(TCONF, "Unsupported init flags"

> > > suggest to preserve the information printed by
> > > FANOTIFY_INIT_FLAGS_ERR_MSG, you can use tc->init.desc
> > > the for the flag name string.

> > tc->init.desc gets printed by the TINFO message at the start of the
> > patch chunk. The return value from fanotify_init_flags_supported_on_fs()
> > is not preserved anywhere by the new fanotify_get_supported_init_flags()
> > helper function so I have nothing to pass as the second argument of
> > FANOTIFY_INIT_FLAGS_ERR_MSG().


> OK.

Amir, thanks for your ack of this final issue. I merged the patchset.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12404C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 05:07:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2777760240
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 05:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2777760240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 601343C89D0
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 07:07:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C9393C1D8F
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 07:06:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 852E7200DA8
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 07:06:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80B521FDB5;
 Tue, 14 Sep 2021 05:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631596013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4noCOo03fHQU7WiE/QNaSp+PgatjwhePT2eYhlScHn4=;
 b=2uHA7xJ5P+qtFWuZKkrxzL0bw4U7atoRb0N6ZFipXNmg2z/pTDTWZKfHhhuQGEVcZf2AKh
 5W2IPBeQb1R9T8WOLFGGVunwsHDAQYa5Hx37QGauisEj+13Cw5rSVSFbQbw8EpLL+r5C9l
 WKKZ2raJPgNhR2BiXsM1Ve0isHD5sLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631596013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4noCOo03fHQU7WiE/QNaSp+PgatjwhePT2eYhlScHn4=;
 b=NOQBIhLFAQq0adbvfEWKE2enWLrsa3vxkPNRe3MWPbM/7IqB7jhQ/pSECABROwE/KyrP4c
 XNhD5D+8ESK074Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CAA613B56;
 Tue, 14 Sep 2021 05:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l3MTFe0tQGHKRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Sep 2021 05:06:53 +0000
Date: Tue, 14 Sep 2021 07:06:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YUAt6/LvtDTVENJB@pevik>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de>
 <3b789dc4-5232-a6d6-d864-7f75c5a0a030@suse.cz>
 <YT9laHIulnmtBSgK@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YT9laHIulnmtBSgK@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
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
Message-ID: <20210914050651.9N0oKXbVfWoIgaePrkdB8ghGMiOxjuhfxNIunbKITNQ@z>

> Hi!
> > >> -?????? if (getpwnam("bin") == NULL) {
> > >> -?????????????? tst_brkm(TBROK, NULL, "bin must be a valid user.");
> > >> +?????? if (TST_ERR != tc->exp_errno) {
> > > nit: checkpatch complains (TST_ERR should be second)

> > checkpatch.pl wrongly assumes that TST_ERR is a constant.

> Good catch, I guess that we will have to patch checkpatch to ignore
> macros that start with TST_, what about?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 88cb294dc..87572b2f4 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5462,7 +5462,9 @@ sub process {
>                         my $comp = $3;
>                         my $to = $4;
>                         my $newcomp = $comp;
> -                       if ($lead !~ /(?:$Operators|\.)\s*$/ &&
> +
> +                       if ($const !~ /^\QTST_/ &&
> +                           $lead !~ /(?:$Operators|\.)\s*$/ &&
>                             $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
>                             WARN("CONSTANT_COMPARISON",
>                                  "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&

Yep, that works, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

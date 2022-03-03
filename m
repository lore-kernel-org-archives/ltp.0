Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE04C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 13:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DB3B3CA32C
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:44:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C8643C93D2
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:44:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 038F3600CC5
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:44:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 247E2218B8;
 Thu,  3 Mar 2022 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646315059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5h6PhZkZVkImb/Kg+DH+jKdsYSfBkNGMeRBt1kpBkV8=;
 b=Bqr+ROybMtA4eyr0QDUzYW5pvSAVq/F940uBuCZmlLDUqxNV1VLifKgE0isVXz/CGbEwRU
 OIKx+5bE62wGXCr3zIyZsRfcvjv+F6MuX3U8ZwqrCEgbYlX0h108njj+nnTRcQZOIunJHl
 H3AWVqr2zDJ8VuGLKm88Fy+X5dvjAXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646315059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5h6PhZkZVkImb/Kg+DH+jKdsYSfBkNGMeRBt1kpBkV8=;
 b=NoASqYIbBUPHz7uELqT0BraHKB4xITt94tWFKXWXIbmLtxiGnCfrkGEwIQumQOy5TV6bxl
 hKbosJtydOvZOkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD01113C23;
 Thu,  3 Mar 2022 13:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JV6tLTLGIGICYwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Mar 2022 13:44:18 +0000
Date: Thu, 3 Mar 2022 14:46:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YiDGvzETiI/nxwW/@yuki>
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik> <YiC4Pj1sH8UIHY7k@yuki>
 <YiDB7wO3Se/vN15+@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiDB7wO3Se/vN15+@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
Cc: linux-integrity@vger.kernel.org, Yael Tzur <yaelt@google.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > > I this case I guess that in this case the change is so minimal that we
> > > > can add this test into LTP once it reaches Linus tree.
> > > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > > and put keyctl09 into runtest/staging now.
> 
> > I guess that we still did not agree on exactly how this should be
> > handled or did we?
> 
> Isn't it enough "Once a feature is part of the stable kernel ABI the associated
> test must be moved out of staging." ?

The main problem is that someone has to make sure that it happens and
the process would be prone to errors. What I proposed instead was a flag
that would set a kernel version in which the ABI is going to be merged
and put the test right into the final runtest files. Then we can simply
skip the test on older kernels or do anything else we see as a
reasonable solution. At the same time we can easily add automatic
checker that would look for these flags in metadata into the CI which
would, for instance, send email to the ML once the flag is supposed to
be removed.

In this case it does not actually matter, since the test is guarded by a
kernel config option that is introduced by the patchset and the change
is fairly miniminal, so I do not think that there would be any changes
to the ABI anyways.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

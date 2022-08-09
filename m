Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68C4C19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 06:00:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8064C3C9503
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 08:00:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 328433C1B37
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 08:00:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1A4FA1A0080C
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 08:00:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6264033CD4;
 Tue,  9 Aug 2022 06:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660024816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNgHyJZG3r0n7GqOPwwXi/fLSQ8OnicxYnCk9IrZSLY=;
 b=iqr8c7g77KZ+Iw1h0NFMvwso3IleoCd8lP/4PElCHzSUgxigC+UpFU7eam7fG7MpvxYLM4
 W4ZWZ0qGEWJrIQXp7Ilx4SVRcBhFzqXLvb1vkipXDxdqCLGKCrPmxdaiMWA+YiZvb1Yvir
 onaP6c6PAZgC5zf9S9jcz9xMkdVVuFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660024816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNgHyJZG3r0n7GqOPwwXi/fLSQ8OnicxYnCk9IrZSLY=;
 b=Gq+XxkV+VRVtWVGR3rWCVNhJ1zutij3cj+t2AcPHPTA42lEbYjRvQ26EMugsGMGcNsf67L
 FwndoCVnruiDB+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3278C13AA1;
 Tue,  9 Aug 2022 06:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1kuiCvD38WIUUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 09 Aug 2022 06:00:16 +0000
Date: Tue, 9 Aug 2022 08:00:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YvH37lGsfy1a8KRT@pevik>
References: <20220701213749.3744031-1-edliaw@google.com>
 <CAEemH2cQBinVjFP27NkRQJpEVCvfA08=gxdb5tk1nDRo0eN_nA@mail.gmail.com>
 <CADS1e3eAZ13nKP4Yq2MX0Xz5dOFR3ZuzF+HVJF7CsptSUgmbkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADS1e3eAZ13nKP4Yq2MX0Xz5dOFR3ZuzF+HVJF7CsptSUgmbkQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] controllers.memcg_regression: add trap to
 clean up directories
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hey,

> On Tue, Jul 5, 2022 at 11:00 PM Li Wang <liwang@redhat.com> wrote:

> > Hi Edward,

> > Thanks for your patch and I believe it makes sense.
> > But the whole memcg test has been re-written by Luke's patchset which is
> > still reviewing.
> > https://lists.linux.it/pipermail/ltp/2022-April/028777.html

> > @Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> > Luke, I guess V3 should be the final version (if you take the time to do
> > rebase/modification) and we'll happy to help merge those patches next:).


> Let me finally get around to putting up the (hopefully) final revision so
> that people don't start doing things I already did :)

Thanks Luke!

Edward, FYI Luke fixed this in his big cleanup
https://patchwork.ozlabs.org/project/ltp/list/?series=311414&state=*

Therefore closing this in patchwork as "Not Applicable".

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

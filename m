Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F4EC7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 17:29:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 375333CE4E0
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 19:29:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3F9E3CB653
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 19:29:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1F0871400B9A
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 19:29:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32E2A1FDD6;
 Wed, 26 Apr 2023 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682530184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Nf+uKcv3oE7OaTQkQBlxX9VfNKSvzRt8zS8DCDfp6E=;
 b=k3yudZW6bZASfksMDwEGV3eF084QQTxoVG+I6TkN6q1ueAOD51EAaDLHTV75D87gzXvjVe
 e0NNobWPOKDkeWLzkdQ97E9sZgk8NReX0NRXf7A9Zv7xvThrYl//UylhRUGEWaMuIg+wGl
 Sej8KpSJg8QFWV+zbE8bqjSRAtnCMok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682530184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Nf+uKcv3oE7OaTQkQBlxX9VfNKSvzRt8zS8DCDfp6E=;
 b=A398tWZUxPMCywGuNtQanSmgh3N9GsSciSJyxkNmj/yVRAotcul5LNS/LDON0LVvljXreE
 c8GAyFcZWcSfgTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B4A213421;
 Wed, 26 Apr 2023 17:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YrSkHodfSWQNRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Apr 2023 17:29:43 +0000
Date: Wed, 26 Apr 2023 19:29:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230426172952.GA3089461@pevik>
References: <20230412073953.1983857-1-pvorel@suse.cz>
 <CAEemH2eGHMkUCZXJRmPBXM=qqVFA37eyEecNb8cn6j_F3dSO2g@mail.gmail.com>
 <20230413080210.GB2072620@pevik>
 <CAEemH2fSrefp5pSbajkhbpHNyp2NCYY94pP-HfdO0BGCVbRavw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fSrefp5pSbajkhbpHNyp2NCYY94pP-HfdO0BGCVbRavw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Remove possible double/trailing
 slashes from TMPDIR
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

> > > > NFS tests have problem when TMPDIR path contains double slashes,
> > > > because they grep exportfs output which is normalized.


> > > I'm ok to remove redundant slashes, I just wondering where
> > > is the second slash comes from?
> > > Is that added by accident when env variable definition?

> > Yes, that's the last slash in TMPDIR=/var/tmp/.
> > TMPDIR=/var/tmp would work.


> Ok, I agree with the secondary treatment inside lib (includes C API),
> as we can't grantee the all users to remember this trivial.

> Reviewed-by: Li Wang <liwang@redhat.com>

thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

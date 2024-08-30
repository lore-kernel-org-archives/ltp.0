Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D7CA100C
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 20:09:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B623F3D2871
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 22:09:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C5DA3C655D
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:09:39 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 925911400769
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:09:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A62341F7EC;
 Fri, 30 Aug 2024 20:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725048575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1ARkpOFSn5d1lnuZ+mIekVsBU58nOZjWyGJRRUtUKE=;
 b=C99P5NysomTG7TRdf5U7mp62/Y9jzfehGe1Oox2GUZKcOknIFzZC+UVSulNzkpuxGOC7VE
 hA9xCu4yKk2FfQ2g/MVheGiuLuwYhKS1wLFkSwHos+X4NUk5LKegxYWDMzPg6KhYsaGJ0v
 DTjSM0C+MF/kOc5vuAEsQh1pABjHg0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725048575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1ARkpOFSn5d1lnuZ+mIekVsBU58nOZjWyGJRRUtUKE=;
 b=27NsEIWXkMh5H4nP6nzulccw51uHxLgkqzSyaP7muVc4UGFtCU22M8eYiPCCrZUrfPaVVE
 g3zLD7xBMrkqxoAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725048575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1ARkpOFSn5d1lnuZ+mIekVsBU58nOZjWyGJRRUtUKE=;
 b=C99P5NysomTG7TRdf5U7mp62/Y9jzfehGe1Oox2GUZKcOknIFzZC+UVSulNzkpuxGOC7VE
 hA9xCu4yKk2FfQ2g/MVheGiuLuwYhKS1wLFkSwHos+X4NUk5LKegxYWDMzPg6KhYsaGJ0v
 DTjSM0C+MF/kOc5vuAEsQh1pABjHg0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725048575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1ARkpOFSn5d1lnuZ+mIekVsBU58nOZjWyGJRRUtUKE=;
 b=27NsEIWXkMh5H4nP6nzulccw51uHxLgkqzSyaP7muVc4UGFtCU22M8eYiPCCrZUrfPaVVE
 g3zLD7xBMrkqxoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4866613A3D;
 Fri, 30 Aug 2024 20:09:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /Q2aDv8m0ma5SAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 20:09:35 +0000
Date: Fri, 30 Aug 2024 22:09:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240830200933.GB90470@pevik>
References: <20240830141453.28379-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830141453.28379-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Add test for per-NS NFS client statistics
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Chuck Lever III <chuck.lever@oracle.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Check that /proc/net/rpc/nfs file exists in nested network namespaces.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Only do the minimal check here. If the file exists in namespaces,
> nfsstat01.sh will take care of functional testing.

>  runtest/net.nfs                              |  2 ++
>  testcases/network/nfs/nfsstat01/nfsstat02.sh | 23 ++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100755 testcases/network/nfs/nfsstat01/nfsstat02.sh

> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index 929868a7b..7f84457bc 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -116,6 +116,8 @@ nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
>  nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
>  nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp

> +nfsstat02 nfsstat02.sh
> +
>  fsx_v30_ip4u fsx.sh -v 3 -t udp
>  fsx_v30_ip4t fsx.sh -v 3 -t tcp
>  fsx_v40_ip4t fsx.sh -v 4 -t tcp
> diff --git a/testcases/network/nfs/nfsstat01/nfsstat02.sh b/testcases/network/nfs/nfsstat01/nfsstat02.sh
> new file mode 100755
> index 000000000..1e1bebe97
> --- /dev/null
> +++ b/testcases/network/nfs/nfsstat01/nfsstat02.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024 SUSE LLC <mdoucha@suse.cz>
> +
> +TST_TESTFUNC="do_test"
> +
> +# PURPOSE:  Check that /proc/net/rpc/nfs exists in nested network namespaces
I would point here a commit which added it or a patchset.

Shell API does not have functionality to point out missing kernel git commit,
but that might change. But even without it a comment is useful.

Maybe point out d47151b79e32 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
and whole patchset
https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested on 6.8 and 6.11 mainline
Tested-by: Petr Vorel <pvorel@suse.cz>

Thanks for this test!

Kind regards,
Petr

> +do_test()
> +{
> +	local procfile="/proc/net/rpc/nfs"
> +
> +	if tst_rhost_run -c "test -e '$procfile'"; then
> +		tst_res TPASS "$procfile exists in net namespaces"
> +	else
> +		tst_res TFAIL "$procfile missing in net namespaces"
> +	fi
> +}
> +
> +# Force use of nested net namespace
> +unset RHOST
> +
> +. nfs_lib.sh
> +tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

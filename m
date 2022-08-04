Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51006C19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 20:25:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CFD93C945E
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 22:25:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E93A3C1BBA
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 22:25:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C99D20035D
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 22:25:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 51CB9225F5;
 Thu,  4 Aug 2022 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659644673;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mX2pVowatUGhma8lkomeb+U7Bp7NNQJSP4qd6j4+tsw=;
 b=A3SUneLlLoRQaIVZftHbJqPlqqR2/CzOk/5nLPc8DJG649C1SnZ5EX+PDufbT5J96EoneN
 Bmzt8yC+FfoOg5pcMBY4ZkeoOcKtbNsPc2D9sQR/ECh5SuLS9nsyZ9Z6ph7kTBGtzF2e8m
 5X0cWn9m8D/b90Yf7Tx4CQVr6wgUuVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659644673;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mX2pVowatUGhma8lkomeb+U7Bp7NNQJSP4qd6j4+tsw=;
 b=o7cYHRyqrIJamJ34l56r4zUh3BZ1DQbGjtz1KTcq16LTbV9MlY6vqQ3tWty5bgFYZsKFGi
 mXLNRD3F69qezuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D3FC13434;
 Thu,  4 Aug 2022 20:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ma69BQEr7GKLdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 20:24:33 +0000
Date: Thu, 4 Aug 2022 22:24:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yuwq/rrb6iWiRI9A@pevik>
References: <20220803175752.19015-1-pvorel@suse.cz>
 <2fd92c3d-a67e-3cfc-aaf8-ca35176cf399@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2fd92c3d-a67e-3cfc-aaf8-ca35176cf399@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] generate_lvm_runfile.sh: Fix bashism
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
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,
> `trap ... EXIT` cannot be used to emulate `trap ... ERR`. The latter
> behaves as if every command/pipeline in the script (except conditions)
> were wrapped in ROD. So `trap ... ERR` will trigger exit on any failure,
Ah, thx for info. OK, we also need to add set -e (or #!/bin/sh -e).
Because using ERR would require to change shebang to #!/bin/bash.

Kind regards,
Petr

> while `trap ... EXIT` will let the script continue after all errors and
> then check exit code of only the very last command. That's not what we
> want here.

> On 03. 08. 22 19:57, Petr Vorel wrote:
> > ERR is not on dash (tested on 0.5.11).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/misc/lvm/generate_lvm_runfile.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
> > index 72b286a69..5bf5d91d6 100755
> > --- a/testcases/misc/lvm/generate_lvm_runfile.sh
> > +++ b/testcases/misc/lvm/generate_lvm_runfile.sh
> > @@ -13,7 +13,7 @@ LVM_TMPDIR="$LVM_DIR/ltp/growfiles"

> >  generate_runfile()
> >  {
> > -	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
> > +	trap '[ $? -eq 0 ] && exit 0 || tst_brk TBROK "Cannot create LVM runfile"' EXIT
> >  	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
> >  	OUTFILE="$LTPROOT/runtest/lvm.local"
> >  	FS_LIST=`tst_supported_fs`

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

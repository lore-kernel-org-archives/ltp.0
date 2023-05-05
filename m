Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFC9C77B7C
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 17:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60DA03CB6D7
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 19:46:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D7AB3CB678
 for <ltp@lists.linux.it>; Fri,  5 May 2023 19:46:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 902041000992
 for <ltp@lists.linux.it>; Fri,  5 May 2023 19:46:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD9EA22400;
 Fri,  5 May 2023 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683308763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vyh6tEEzN9N6Vo08QSc3YqgdtHluGvGX48tVnOkmk9c=;
 b=oC769frvYGvMZanrbH+1O9umfFLwQTWXjzYbco8FMR/14vRFjEqvaHAVwBrHvsvLFj+DQG
 uWL7I+zgIiBjPwXVo/clMAvYXrVpgp36owCqq660Ei0BvJKcmQkJdXR6fpFBzo0VH0/KWg
 Uf6VIFBxNoKtJuPB412olLDbEi0WbkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683308763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vyh6tEEzN9N6Vo08QSc3YqgdtHluGvGX48tVnOkmk9c=;
 b=DR84H+0uw7kbIKT2kgkA4Zddsc0bXVnQP8PYdMw1BxzMoIesGHSls6LCbLUGuhEF98O2CY
 yIG5W2GyF3xM6zCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A7EB13488;
 Fri,  5 May 2023 17:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Gk9JHNtAVWR+SQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 May 2023 17:46:03 +0000
Date: Fri, 5 May 2023 19:45:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230505174553.GA37086@pevik>
References: <20230502151348.3677809-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230502151348.3677809-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfs08.sh: Skip on vfat
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
 Jeff Layton <jlayton@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,


> vfat does not see '2' on various distros:
> * openSUSE Tumbleweed 20230427 (kernel 6.2.12-1-default, nfs-utils 2.6.3,
>   mkfs.fat 4.2 (2021-01-31))
> * Debian 12 bookworm (kernel 6.1.0-6-amd64, nfs-utils 2.6.2, mkfs.fat 4.2
>   (2021-01-31))

Again, because we don't test on vfat in the end, I did not merge this and I'm
setting this in patchwork as rejected.

Kind regards,
Petr

> NOTE: on it fails completely (on all filesystems) on Debian 11 bullseye
> (kernel 5.10.0-8-amd64, nfs-utils 1.3.3, mkfs.fat 4.2 (2021-01-31)) -
> likely due 1.3.3, thus skip the test completely.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

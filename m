Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3358EEB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 13:16:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41DAB3CB6E5
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 15:16:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 584A63C036A
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 15:16:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51B8A600F33
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 15:16:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A78E1FDD3;
 Fri, 14 Jul 2023 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689340561;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b19fPAzhbPUQK5rO+cTyys7DEmODBBfZFyK1RZ4h9ng=;
 b=tN1fTM3F0soUz3TYJnmZrj/IrK7oG1rLKMXSODJPwfZ4fGAKTu6euWguJ0IsWw+rPkF1hS
 iO3dqKt94M+r9p0jVuHCMoPN3HJLaNWNUlq9rMxM0Psepo3uAbt3yES3oLG8HPSK/Xk3rA
 5VDKlFj0d4KYG5gkAYYwsojhFUHdn+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689340561;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b19fPAzhbPUQK5rO+cTyys7DEmODBBfZFyK1RZ4h9ng=;
 b=3ZatBNi1KDRgcmEuUomyba5E3VUMXrcphnE+wQc/qX1C1JqSaVyXgqSw4HUmbK5IryDNxx
 ckZvd2NPxXxAhyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2ADEA138F8;
 Fri, 14 Jul 2023 13:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bE/kB5FKsWQJbgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jul 2023 13:16:01 +0000
Date: Fri, 14 Jul 2023 15:15:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230714131559.GB965391@pevik>
References: <20230714114244.32109-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230714114244.32109-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statx09: Set fs-verity blocksize to FS
 blocksize
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

Hi Martin,

> The kernel requires that fs-verity blocksize must be at most equal
> to the filesystem blocksize. Testing on small loop device means that
> mkfs.ext4 will very likely default to blocksize of 1024. Set fs-verity
> blocksize to the filesystem blocksize to avoid errors.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Setting filesystem blocksize to pagesize would require moving the mkfs
> command to setup(). We can do that later to fix support for kernels
> before v6.3 but let's fix the failure on latest kernel version first.

Makes sense.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

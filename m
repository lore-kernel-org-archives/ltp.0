Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6578C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 14:08:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E16DF3C8D9F
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 16:08:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A1E13C0775
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 16:07:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A8FD1A00659
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 16:07:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 440CB1FDE5;
 Fri, 17 Jun 2022 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655474878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Muo4pFI8p4KNmoA3ofO5dMv9wOznN8GBeoBdD7xtNA=;
 b=tp7Iyc4xmmpkVrOuhW+dbs8l1u4vAVHY6xr9KN1Pqtq2sHyj3Xo+QlTT5sv3jpKSpq+c2m
 BMnhKOqYbp6otDuqC5ua/fwjJN6rDO0rAdK3FOaNUGfMnZEZIHdo6jVYAIaOS8AgT595TC
 eNy//TS0np1lfx39UDeRAk270SQ8trI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655474878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Muo4pFI8p4KNmoA3ofO5dMv9wOznN8GBeoBdD7xtNA=;
 b=g/RVfHeS8EdJ8IWArg/jcFuVuJew/ZUTGK1jJ7neIVHM4adYbz2vfHgQcIg6mI/fdXA/GZ
 AYFxt6kpwwEhB7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0802013458;
 Fri, 17 Jun 2022 14:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CKUqO72KrGK1JgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jun 2022 14:07:57 +0000
Date: Fri, 17 Jun 2022 16:07:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YqyKu2Gi7SbeplMs@pevik>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-6-pvorel@suse.cz> <YqyHNFkJdC0q2Vxs@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqyHNFkJdC0q2Vxs@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/9] tst_test.sh: Add $TST_ALL_FILESYSTEMS
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

Hi Cyril,

> Generally the code looks good, there is still a minor difference between
> C API and this changes though. As we do call the _tst_cleanup_timer at
> the end of this function the script runs without a timeout for a short
> while (which includes tst_mkfs call).

> I guess that instead of stopping the timer at the end of the
> _tst_run_iterations() we can simply reset it (on the top of this patch):

Good catch, thanks for providing a patch.
LGTM, I'll have a deeper look later.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

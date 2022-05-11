Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CF7C433F5
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 14:48:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A78EB3CA998
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 16:48:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D00303CA932
 for <ltp@lists.linux.it>; Wed, 11 May 2022 16:48:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3D0EA1A00CC6
 for <ltp@lists.linux.it>; Wed, 11 May 2022 16:48:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 603681F8B4
 for <ltp@lists.linux.it>; Wed, 11 May 2022 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652280482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sb3RkZz8XqYZ+w5IOEtAvm5FIruBObiCFOZ5nwJZLMI=;
 b=I/oFFwmc+S6IWWBz2L94N9aaJe3S8q9gY6CE56T9BcJ8BkkUu/aOuKyueG1MQuMmWrYTh4
 DLp84IyfnCs3MdL3Row/jRExt39U6VzEN8HXhuGEWVB0tGwUHruaBEJ2XSrYQzZU9MaG2T
 mRQPbXykY3V8GswN1p85KVQolM3WihU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652280482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sb3RkZz8XqYZ+w5IOEtAvm5FIruBObiCFOZ5nwJZLMI=;
 b=0EPhu2nEOpct0RMRv3EYlUFaqn5XRGB1NWX3J2vpuywZ16DAuXncRgMgTyc3sSVXTaFGXE
 HvcvQC6PF4H+AAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 445CA139F9
 for <ltp@lists.linux.it>; Wed, 11 May 2022 14:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mFytDqLMe2I/JwAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 11 May 2022 14:48:02 +0000
Date: Wed, 11 May 2022 16:48:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YnvMoJE2pCvQtBf7@pevik>
References: <20220510155438.15754-1-pvorel@suse.cz>
 <20220510155438.15754-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220510155438.15754-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] df01.sh: Use TST_MOUNT_DEVICE=1
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
...
> @@ -13,7 +14,7 @@ TST_OPTS="f:"
>  TST_USAGE=usage
>  TST_PARSE_ARGS=parse_args
>  TST_NEEDS_ROOT=1
> -TST_FORMAT_DEVICE=1
> +TST_MOUNT_DEVICE=1

I forget to remove TST_CLEANUP=tst_umount.

Therefore there is an error:
df01 13 TINFO: The '/tmp/LTP_df01.UaDhMw4Ifq/mntpoint' is not mounted, skipping umount

If this is the only error, I'll fix it during merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

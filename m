Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10000C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 11:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8A973CAD8F
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 13:02:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 642283CAD30
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 13:01:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 68E3F200926
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 13:01:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E50021A57;
 Fri, 23 Sep 2022 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663930908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mk54Ee30P2OvMx1AF757YAf5SQ1JjgZ5hoJj9aGtAHo=;
 b=uoCSaq6hDFvkbVMpJC9w4Poi830RO9eshh01/XSPvNdeKzitSWrNGOsdaMpIqbuYyW1tJe
 iFlm/qmZIcsXELdHx6H/PuYtfoQJTfCBeCmKD6BB9eJhNExasPiDY0Ohp03xROjw50M86+
 KlQwGvX+9ftQ28jYmLpE77joNnqYJwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663930908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mk54Ee30P2OvMx1AF757YAf5SQ1JjgZ5hoJj9aGtAHo=;
 b=euSLqNSzsEUMcnBcB+JLPCz/o2eEbRVhUClUu3AcORZNJ1mb23TjhOEiC/2BubAR/mWXc2
 L5q0JvFSSrC9zMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B17513AA5;
 Fri, 23 Sep 2022 11:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Nw6CGBySLWMTTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 11:01:48 +0000
Date: Fri, 23 Sep 2022 13:01:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, LTP List <ltp@lists.linux.it>
Message-ID: <Yy2SGpSyfDeApR5o@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <YyiLZoSRWPgs8Cfh@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyiLZoSRWPgs8Cfh@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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

Hi all,

> ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_keys 1 TINFO: Formatting ext3 with opts='/dev/loop0'
> ima_keys 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_keys.YArl935DCg/mntpoint
> ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
> tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long

FYI I've fixed this in patchset "IMA + shell API fixes on umount" [1] [2]
which depends on 2 other patchsets.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220923105554.28942-1-pvorel@suse.cz/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=319753&state=*

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

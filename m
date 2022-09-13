Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22753C6FA86
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 06:42:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5CF03CABA6
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:42:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B854A3CA306
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:42:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A2BAD200B96
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:42:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B541B21E81;
 Tue, 13 Sep 2022 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663051327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nEC1VYNtvWAGAGMjPq4JqF4kpmH4nlYiQ5cUj013FXg=;
 b=oc7UdqtUk0BjnjNa3gurVZD6mjMF0UoMYSN9GrC7YUICzUvOnBytAd2XkQxpPcStK4j4Pm
 74Hijcan1No70ZQihStP+qRoJS4B5IUZvBQHJNA+Z33o7pZZN//k2dQw+Tov2S3KirxViX
 u2L9uf8RuRXR1T1qOVDC4mU9WAq4NYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663051327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nEC1VYNtvWAGAGMjPq4JqF4kpmH4nlYiQ5cUj013FXg=;
 b=APcSh0lh2tcgK3n2T+AvjxVIQlkkYGkdtNYSoHu19Fif9oVRoArVpSCkvdKFEfKdzQRGSm
 rOJXvMNESRk+JuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96FF4139B3;
 Tue, 13 Sep 2022 06:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 93BZIz8mIGMFbgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 06:42:07 +0000
Date: Tue, 13 Sep 2022 08:42:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Message-ID: <YyAmPYZ2iaraxraN@pevik>
References: <20220905061425.22852-1-luoxiaoyu9@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220905061425.22852-1-luoxiaoyu9@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty04.c/pidfd_send_signal03.c: Drop redundant
 tst_reap_children()
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

Hi Luo,

> Drop redundant calling of tst_reap_children() in cleanup() since
> it has been called in the API (run_tests()).

LGTM, I suppose that was a mistake.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

NOTE: this patch is broken:
patch: **** malformed patch at line 100: 

Please be careful next time.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

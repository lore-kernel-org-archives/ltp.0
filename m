Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33CCC433F5
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 14:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BCBE3CA6FF
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 16:12:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9BCE3C8765
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 16:11:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7BE381400DF4
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 16:11:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7ACDE212C2;
 Fri, 22 Apr 2022 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650636710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAzXUHAfKoJc0vskkhW9AJo6Cy2P7LJcwn2YF1DUqbc=;
 b=FvgdpukwfU+0WM13tHJWBG6W3+HJ2lb3gpV5/PBuwX7fvaOQM2Q+2DyqSudPTpD0q1W7RK
 h5BkJb0uL3tnH4oAstM9GeC1EeSNVqNo4G1Sw3Vz0fcLxWov50aYcyfBMbtq4vDQnCOxlv
 120FPv8XHH7YCcpDBZMCdWd1U+DYcSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650636710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAzXUHAfKoJc0vskkhW9AJo6Cy2P7LJcwn2YF1DUqbc=;
 b=mZYOqwr8CkGE1j2SwaNcDR9W2LvHnIzrkLVOHh8UGD/HZYmdXOc5fFXaqIWTYRibM1P99S
 LrHz6Ix4QDZJ7FCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 402E4131BD;
 Fri, 22 Apr 2022 14:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZOCVC6a3YmIvfgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 22 Apr 2022 14:11:50 +0000
Date: Fri, 22 Apr 2022 16:11:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
Message-ID: <YmK3pJ4HPsZeAPt4@pevik>
References: <20220420102926.866-1-chenhx.fnst@cn.fujitsu.com>
 <YmBwWqS0GEuwnb/d@pevik>
 <OS3PR01MB644958457FD5DD0B37BF2A83E6F79@OS3PR01MB6449.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OS3PR01MB644958457FD5DD0B37BF2A83E6F79@OS3PR01MB6449.jpnprd01.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?5Zue5aSNOiAgW1BBVENIIHYyXSBzeXNjYWxscy9tb3VudF9z?=
 =?utf-8?q?etattr01=3A_Add_basic_functional_test?=
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Chen,

> > I guess we need SAFE_ variants for not having to check it all the time.

> It's hard for a SAFE_MOUNT_SETATTR:
> mount_setattr(2) need:
> #include <linux/mount.h> /* Definition of MOUNT_ATTR_* constants */

> But linux/mount.h have some conflicts with sys/mount.h, which is widely used in LTP.
> If we really want SAFE_MOUNT_SETATTR, we may need a big refactor.

Well, you don't have to bother with SAFE_MOUNT_SETATTR() unless you have time
for it. That will not block this patchset.

FYI I did some cleanup of include/lapi/mount.h and include/lapi/fsmount.h:
c0cb5d1962 ("lapi/mount.h: Include kernel/libc header")
8ae596f8b5 ("lapi/fsmount.h: Include lapi/mount.h instead libc header")

FYI we include kernel header and if missing, we include libc header:
#ifdef HAVE_LINUX_MOUNT_H
# include <linux/mount.h>
#else
# include <sys/mount.h>
#endif

If kernel header is old enough (theoretically we support compilation on 3.10 [1]),
we just include it and don't bother about checks.

If you want to work on SAFE_*(): not only SAFE_MOUNT_SETATTR(), but more
functions could be defined:
SAFE_MOVE_MOUNT() (could be used in fs{config,mount,open} tests), maybe
SAFE_OPEN_TREE() (it'd be used only in this test as open_tree tests should
probably keep using TEST(open_tree(...)).

I'd put it/them into new file lib/tst_safe_fsmount.c and include/tst_safe_fsmount.h.

NOTE: Although we have SAFE_MOUNT() in lib/safe_macros.c, IMHO we should keep it
there, instead of creating lib/tst_safe_mount.c, because lib/safe_macros.c
supports also legacy API (which we don't want to continue developing) and we
don't want to put many include/tst_safe_mount.h.

TODO for myself: SAFE_STATVFS() and SAFE_FSTATVFS()


> Sure, I'll post v3 soon.
+1

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

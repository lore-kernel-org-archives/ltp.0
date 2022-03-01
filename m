Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE10C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 07:59:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D42323CA305
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 08:59:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEB923CA2A9
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 08:58:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 39A0BA4AA87
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 08:58:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5AEB1F37D;
 Tue,  1 Mar 2022 07:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646121532;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4e7BDi6IiWap4fad/BgDorReT1aYnfmJg21NKuy7PWo=;
 b=abbIuwCy2Uecg6DM0COyPe2+IDkO9wfpXE2UdmqZZtmnfc9UnwoGl2JK74CyC4OaHagPYP
 PzeStxe/YHCO+e4CJNG2ge+kPw3L8MpSn1TtcSeTisVPYVfIB3guI/cCKTGuyKMRpVAypE
 IEVfgu+ZaL7cLeqG7y5kJhdcJASKXmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646121532;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4e7BDi6IiWap4fad/BgDorReT1aYnfmJg21NKuy7PWo=;
 b=Qswd8mf963tB3/ne0eKmBNZv4xizpWfJi0AQjkUpQaUDGKmRMmgPSaEJdcSjQmeHOGVZGE
 OzsnhTQzb6Jtp2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A55B13B08;
 Tue,  1 Mar 2022 07:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wdoQJDzSHWKNMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Mar 2022 07:58:52 +0000
Date: Tue, 1 Mar 2022 08:58:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yh3SOwogWwWQdZ4O@pevik>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz>
 <6216E3ED.1050700@fujitsu.com> <Yhz1+H3SAlwPaO8H@pevik>
 <621D72EF.50500@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <621D72EF.50500@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr
> > Hi Xu,

> >> Hi Petr
> >>> to change
> >>> quotactl08.c:160: TBROK: mount(/dev/loop0, mntpoint, ext4, 0, (nil)) failed: ESRCH (3)
> >> I doubt why fs quota is not supported on this case since we have check
> >> kernel config?

> > There is probably bug on the SUT, thus it might be correct it fails.

> > But how about martin's fix 4aab31e4c7 ("syscalls/quotactl: Skip tests if FS
> > quota is not supported") - quotactl04.c also checks for CONFIG_QFMT_V2 and uses
> > do_mount(). I'll check whether it was another bug on the system.
> Maybe we miss check the following kernel config?
In my case it's probably a problem with mkfs.

> CONFIG_QUOTA=y
Selected by [m]:
  - OCFS2_FS [=m] && BLOCK [=y] && INET [=y] && SYSFS [=y] && CONFIGFS_FS [=m]
=> very unlikely not to be selected (but we might want to check also corner case
configurations; but I guess also CONFIG_QUOTA=m would be ok)

> CONFIG_QUOTA_TREE=y
Selected by [m]:
  - OCFS2_FS [=m] && BLOCK [=y] && INET [=y] && SYSFS [=y] && CONFIGFS_FS [=m]
Selected by [n]:
  - QFMT_V2 [=n] && QUOTA [=y]
ditto

> CONFIG_QUOTACTL=y
Selected by [y]:
  - QUOTA [=y]
Selected by [m]:
  - XFS_QUOTA [=y] && BLOCK [=y] && XFS_FS [=m]
  - GFS2_FS [=m] && BLOCK [=y]
even more likely to be selected.

Kind regards,
Petr

> Best Regards
> Yang Xu

> > Kind regards,
> > Petr

> >> Best Regards
> >> Yang Xu

> >>> to TCONF if FS quota is not supported (the same fix as 4aab31e4c7).

> >>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> >>> ---
> >>>    testcases/kernel/syscalls/quotactl/quotactl08.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)

> >>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> >>> index 3793867f23..9f54bebcc0 100644
> >>> --- a/testcases/kernel/syscalls/quotactl/quotactl08.c
> >>> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> >>> @@ -157,7 +157,7 @@ static void setup(void)
> >>>    	quotactl_info();

> >>>    	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> >>> -	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> >>> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> >>>    	mount_flag = 1;

> >>>    	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

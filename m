Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309DBC6FA83
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 09:35:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 558453CADF2
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 11:35:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E05FA3CACD9
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:35:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 028D4600C35
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:35:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9C781FD57;
 Mon, 26 Sep 2022 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664184908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ss4jWBiqdYoOvLwX5djn2vAZ5c+UIY3L92dKlEDhgys=;
 b=AkPvH1ELGXy6CgWShFgwU5mEbQD+IQU9EJWByvbDTOa/bfTcS2lw6c0mGQ4/iki357jQ4Z
 UO1ceQLb0zcy5+ROdj2WJInbl1JhdQZmyfxRstKr4vy45e0GcFnb5byyUX4GqWQVXQeIyY
 Lj+HJ2+kgwKNntza6ssTiUVvv1A9TdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664184908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ss4jWBiqdYoOvLwX5djn2vAZ5c+UIY3L92dKlEDhgys=;
 b=ZV3P+bXb4tl0bGQXXSPuqoxnjPVAR7edAem2b39Vq2pd0gAEt1/sMNJS+z3G5ZIC0qKhct
 gZNQI0ap/cvwEUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BE76139BD;
 Mon, 26 Sep 2022 09:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IfsqIExyMWM5egAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 26 Sep 2022 09:35:08 +0000
Date: Mon, 26 Sep 2022 11:34:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YzFyPmAS5o2iKRYh@pevik>
References: <20220922210931.23982-1-pvorel@suse.cz>
 <20220922210931.23982-4-pvorel@suse.cz> <Yy3QzoD5kRFdVzVR@yuki>
 <Yy3gmoOYDOTLxfwh@pevik> <YzFtSVl0FqzngbmW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzFtSVl0FqzngbmW@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3 v2] tst_test.sh: Fix filesystem support
 detection
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

> Hi!
> > Broken were actually all shell tests which did not use TST_SKIP_FILESYSTEMS:
> > e.g. all tests in net_stress.ipsec_* did run whole filesystem check:

> > tst_supported_fs_types.c:93: TINFO: Kernel supports ext2
> > tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
> > tst_supported_fs_types.c:93: TINFO: Kernel supports ext3
> > tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
> > tst_supported_fs_types.c:93: TINFO: Kernel supports ext4
> > tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
> > tst_supported_fs_types.c:93: TINFO: Kernel supports xfs
> > tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
> > tst_supported_fs_types.c:93: TINFO: Kernel supports btrfs
> > tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
> > tst_supported_fs_types.c:93: TINFO: Kernel supports vfat
> > tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
> > tst_supported_fs_types.c:93: TINFO: Kernel supports exfat
> > tst_supported_fs_types.c:55: TINFO: mkfs.exfat does exist
> > tst_supported_fs_types.c:123: TINFO: FUSE does support ntfs
> > tst_supported_fs_types.c:55: TINFO: mkfs.ntfs does exist
> > tst_supported_fs_types.c:93: TINFO: Kernel supports tmpfs
> > tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
> > sctp_ipsec 1 TINFO: timeout per run is 0h 5m 0s
> > sctp_ipsec 1 TINFO: IPsec[ah/transport]
> > sctp_ipsec 1 TINFO: run server 'netstress -T sctp -S 10.0.0.1 -D ltp_ns_veth1 -R 500000 -B /tmp/LTP_sctp_ipsec.hC471AeJ9L'
> > ...

> > instead checking just filesystem in TMPDIR due empty $TST_FS_TYPE (I should have
> > quoted it).

> > + there are IMA tests had this + specific problem.

> Ah right, so it did useless checks and printed out a lot of lines too.

Also IMA fixes patchset needs this, otherwise it gets: tst_supported_fs.c:134: TCONF: tmpfs is skipped

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

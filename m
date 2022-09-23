Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC97C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 16:36:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40B223CADA6
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 18:36:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5200D3CA756
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 18:36:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E059C140052D
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 18:36:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EAAF11F8D3;
 Fri, 23 Sep 2022 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663951004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=stoR12bFdT8zcy3jTnmxfXufjK+q89/3aRz3s9vEpEE=;
 b=vfgNV/DY4Q3k28bsmnUImEOww/5QS2oA6Itam70K2rbmaS+zym/2oThO37odDOMultE7bG
 grI77Gtk1YtmjY5m4jwX2JlaCJE1O5/eElbUj+SYRF5zapw8zUZ5lpcbt56NxTafibH/Oz
 zaTyrIw/EtT5Mj+ILIl06gz3SvcooYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663951004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=stoR12bFdT8zcy3jTnmxfXufjK+q89/3aRz3s9vEpEE=;
 b=gCrtLudRixoB+Yjx7OrpNAkhhg39GAZV8OQw462+tykbgPZW47795J+8tJMAIZzfKSkgSN
 ZDX8WWfdceL+bTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F23C13A00;
 Fri, 23 Sep 2022 16:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S8UzIJzgLWN5VQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 16:36:44 +0000
Date: Fri, 23 Sep 2022 18:36:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yy3gmoOYDOTLxfwh@pevik>
References: <20220922210931.23982-1-pvorel@suse.cz>
 <20220922210931.23982-4-pvorel@suse.cz> <Yy3QzoD5kRFdVzVR@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy3QzoD5kRFdVzVR@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
> > Fixes: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")

> > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Looks like this is the only real fix in the series, right?

> The actual change looks good, but I do wonder what exactly has been
> broken, git grpe TST_SKIP_FILESYSTEMS does not show any real tests
> that would use that variable.

Broken were actually all shell tests which did not use TST_SKIP_FILESYSTEMS:
e.g. all tests in net_stress.ipsec_* did run whole filesystem check:

tst_supported_fs_types.c:93: TINFO: Kernel supports ext2
tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:93: TINFO: Kernel supports ext3
tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:93: TINFO: Kernel supports ext4
tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:93: TINFO: Kernel supports xfs
tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:93: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:93: TINFO: Kernel supports vfat
tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:93: TINFO: Kernel supports exfat
tst_supported_fs_types.c:55: TINFO: mkfs.exfat does exist
tst_supported_fs_types.c:123: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:55: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:93: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
sctp_ipsec 1 TINFO: timeout per run is 0h 5m 0s
sctp_ipsec 1 TINFO: IPsec[ah/transport]
sctp_ipsec 1 TINFO: run server 'netstress -T sctp -S 10.0.0.1 -D ltp_ns_veth1 -R 500000 -B /tmp/LTP_sctp_ipsec.hC471AeJ9L'
...

instead checking just filesystem in TMPDIR due empty $TST_FS_TYPE (I should have
quoted it).

+ there are IMA tests had this + specific problem.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

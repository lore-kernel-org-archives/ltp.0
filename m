Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186D9C77B71
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 10:30:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C9A33CBC1E
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 12:30:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ABD83CB30B
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 12:30:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5796E1A0061A
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 12:29:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 549D81FDA6;
 Tue, 25 Apr 2023 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682418598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5Pl854vOoDZtv0CHQa6qbCgSEDBT3YwmdX581qycGk=;
 b=tYKjIJj2SR1PVZ9e18mJeFjWWdvSHLdVd86WGrXt0AxhjW8QBSpE8YxHnfW/8er+FgWvcE
 DRtjjkhzs/Z80/2Amy9lwrOhJe6TeLA2IK7NP/eT5r1+71h4QwK+VvVarDag3Jsfd+Zh16
 GAaQdTEhBOC1TILqk7NvrNmgcqNgNm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682418598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5Pl854vOoDZtv0CHQa6qbCgSEDBT3YwmdX581qycGk=;
 b=vWAT59+umvjQyPAjmMZiOoMO/HXOErnAe0klbQpT3izRDKWBWIGwpUuNAw5mO23lX082eu
 Am9ErGbkPC0nDlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08D12138E3;
 Tue, 25 Apr 2023 10:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ri8VAaarR2R8KgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Apr 2023 10:29:58 +0000
Date: Tue, 25 Apr 2023 12:30:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230425103006.GA2926981@pevik>
References: <20230424210818.2885479-1-pvorel@suse.cz>
 <20230424210818.2885479-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230424210818.2885479-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] nfs: Run on all filesystems
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

unfortunately nfs05.sh fails for some reason (the only test which fails).
It works on various filesystems:

nfs05 1 TINFO: using not default LTP netns: 'tst_ns_exec 31811 net,mnt'
nfs05 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfs05 1 TINFO: add local addr 10.0.0.2/24
nfs05 1 TINFO: add local addr fd00:1:1:1::2/64
nfs05 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfs05 1 TINFO: add remote addr 10.0.0.1/24
nfs05 1 TINFO: add remote addr fd00:1:1:1::1/64
nfs05 1 TINFO: Network config (local -- remote):
nfs05 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfs05 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfs05 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:90: TINFO: Kernel supports ext2
tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext3
tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports vfat
tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:157: TINFO: Skipping exfat as requested by the test
tst_supported_fs_types.c:120: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:55: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
nfs05 1 TINFO: === Testing on ext2 ===
nfs05 1 TINFO: Formatting ext2 with opts='/dev/loop0'
nfs05 1 TINFO: Mounting device: mount -t ext2 /dev/loop0 /tmp/LTP_nfs05.BXqm4Onw7z/mntpoint 
nfs05 1 TINFO: timeout per run is 0h 10m 0s
nfs05 1 TINFO: mount.nfs: (linux nfs-utils 2.6.2)
nfs05 1 TINFO: setup NFSv4, socket type tcp
nfs05 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4 10.0.0.2:/tmp/LTP_nfs05.BXqm4Onw7z/mntpoint/4/tcp /tmp/LTP_nfs05.BXqm4Onw7z/4/0
nfs05 1 TINFO: start nfs05_make_tree -d 10 -f 30 -t 8
tst_test.c:1558: TINFO: Timeout per run is 0h 11m 00s
nfs05_make_tree.c:211: TPASS: 'make' successfully build and clean all targets

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
nfs05 1 TPASS: test finished
nfs05 2 TINFO: Cleaning up testcase
nfs05 2 TINFO: === Testing on ext3 ===
...

But later it fails for btrfs:
nfs05 5 TINFO: === Testing on btrfs ===
nfs05 5 TINFO: Formatting btrfs with opts='/dev/loop0'
nfs05 5 TINFO: Mounting device: mount -t btrfs /dev/loop0 /tmp/LTP_nfs05.BXqm4Onw7z/mntpoint 
nfs05 5 TINFO: timeout per run is 0h 10m 0s
nfs05 5 TINFO: mount.nfs: (linux nfs-utils 2.6.2)
nfs05 5 TINFO: setup NFSv4, socket type tcp
nfs05 5 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4 10.0.0.2:/tmp/LTP_nfs05.BXqm4Onw7z/mntpoint/4/tcp /tmp/LTP_nfs05.BXqm4Onw7z/4/0
nfs05 5 TINFO: start nfs05_make_tree -d 10 -f 30 -t 8
tst_test.c:1558: TINFO: Timeout per run is 0h 11m 00s
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: 1021.2.5: final close failed: No space left on device
collect2: error: ld returned 1 exit status
make[2]: *** [makefile:7: 1021.2.5] Error 1
make[1]: *** [makefile:9: dir] Error 2
make: *** [makefile:9: dir] Error 2
tst_cmd.c:121: TBROK: 'make' exited with a non-zero code 2 at tst_cmd.c:121

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
nfs05 5 TBROK: nfs05_make_tree -d 10 -f 30 -t 8 failed
nfs05 5 TINFO: Cleaning up testcase
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: 1015.2.9: final close failed: No space left on device

I expect the problem is not with btrfs itself, but with somehow broken cleanup
of the space.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

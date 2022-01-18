Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD1DC433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 15:27:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B25493C9670
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 16:26:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0833C3C71B8
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 16:26:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 75ECA200041
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 16:26:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B83A1F3BB;
 Tue, 18 Jan 2022 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642519607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=pISiuQNXvK9RwVRhtGimkQU0Qq0IlFXZAYS9c6WH+lo=;
 b=ItRpTvT6cl/39P2xG0WErztkWwVfTpmCyJcH8HCL1HOEyv/50eACyhwXRbUWaEx/AavWyv
 i/GEy1azJQJMjwt4ow+Gcj3A5fz80NdHVxz6miV2X6qnP9huzKmZVIas9iBBuif9MjcE/n
 dx52PdW+Hzx5Be05QZxi8ghrDV1idnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642519607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=pISiuQNXvK9RwVRhtGimkQU0Qq0IlFXZAYS9c6WH+lo=;
 b=FMrd7SwJzJ2RgV5jLa4I8KuP1T+FDVAH2X8D6YWlM5T+UouOT4ScmXKyVnMffdlCCxxfwL
 9C8MJnaJYiTnKfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CFCC13B41;
 Tue, 18 Jan 2022 15:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id swZsCDfc5mGVYAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jan 2022 15:26:47 +0000
Date: Tue, 18 Jan 2022 16:26:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Message-ID: <YebcNQg0u5cU1QyQ@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP nfslock01 test failing on NFS v3 (lockd: cannot monitor
 10.0.0.2)
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
Cc: Neil Brown <neilb@suse.de>, Steve Dickson <SteveD@redhat.com>,
 Anna Schumaker <anna.schumaker@netapp.com>,
 "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfslock01
looks to be failing on NFS v3:

"not unsharing /var makes AF_UNIX socket for host's rpcbind to become available
inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd for
ltpns, and ports for that instance leak to host's rpcbind and overwrite ports
for lockd already active for root namespace. This breaks nfs3 file locking."

This error has been hidden, showing only with extra patch from Nikita [2].
Because the patch has not been merged, in case you want to verify yourself,
feel free to use my LTP fork branch nfs_flock/fail-on-error to get this patch +
strace debugging [3]:

# PATH="/opt/ltp/testcases/bin:$PATH" /opt/ltp/testcases/bin/nfslock01 -t tcp -v 3
...
nfslock01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfslock01 1 TINFO: add local addr 10.0.0.2/24
nfslock01 1 TINFO: add local addr fd00:1:1:1::2/64
nfslock01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfslock01 1 TINFO: add remote addr 10.0.0.1/24
nfslock01 1 TINFO: add remote addr fd00:1:1:1::1/64
nfslock01 1 TINFO: Network config (local -- remote):
nfslock01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfslock01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfslock01 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
nfslock01 1 TINFO: timeout per run is 0h 5m 0s
nfslock01 1 TINFO: setup NFSv3, socket type tcp
nfslock01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfslock01.PAYCDFih75/3/tcp /tmp/LTP_nfslock01.PAYCDFih75/3/0
nfslock01 1 TINFO: creating test files
nfslock01 1 TINFO: Testing locking
nfslock01 1 TINFO: locking 'flock_idata' file and writing data
nfslock01 1 TINFO: waiting for pids: 2022 2023
execve("/opt/ltp/testcases/bin/nfs_flock", ["nfs_flock", "0", "flock_idata"], 0x7ffd4dae5880 /* 206 vars */execve("/opt/ltp/testcases/bin/nfs_flock", ["nfs_flock", "1", "flock_idata"], 0x7ffee8d52690 /* 206 vars */) = 0
brk(NULL)                               = 0x555ad67cc000
...
openat(AT_FDCWD, "flock_idata", O_RDWR) = 3
) = 3
fcntl(3, F_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=64, l_len=64}fcntl(3, F_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=64}) = -1 ENOLCK (No locks available)
newfstatat(1, "", {st_mode=S_IFCHR|0600, st_rdev=makedev(0x88, 0x1), ...}, AT_EMPTY_PATH) = 0
brk(NULL)                               = 0x55aefc2d5000
brk(0x55aefc2f6000)                     = 0x55aefc2f6000
write(1, "failed in writeb_lock, Errno = 3"..., 34failed in writeb_lock, Errno = 37
) = 34
exit_group(1)                           = ?
+++ exited with 1 +++
) = -1 ENOLCK (No locks available)
newfstatat(1, "", {st_mode=S_IFCHR|0600, st_rdev=makedev(0x88, 0x1), ...}, AT_EMPTY_PATH) = 0
brk(NULL)                               = 0x555ad67cc000
brk(0x555ad67ed000)                     = 0x555ad67ed000
write(1, "failed in writeb_lock, Errno = 3"..., 34failed in writeb_lock, Errno = 37
) = 34
exit_group(1)                           = ?
+++ exited with 1 +++
nfslock01 1 TFAIL: nfs_lock process failed
...

Dmesg shows: "lockd: cannot monitor 10.0.0.2", test fails on
fcntl(fd, F_SETLKW, &lock), lock.l_whence is SEEK_SET.

Running other NFS versions (-v 4 or -v 4.1 or -v 4.2) works ok.
Also tested only on TCP due UDP being recently disabled by default.

I found this behaviour on various kernels (openSUSE 5.16, Debian: 5.16, 5.10,
SLES 5.14 and 5.3 - both heavily patched).

Is it a bug in lockd or in a test? Is there some limitation on v3?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

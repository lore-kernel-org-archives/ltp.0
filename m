Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33739CCF9F1
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 11:04:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F5793CBA3F
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 12:04:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E85CF3CB322
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 12:04:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22B72601D47
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 12:04:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 558BB336EE;
 Thu, 30 Oct 2025 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761822262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j45zA0yrT5Dk0d4wI6EixTsHIvAz0LQPF41WoTsot7A=;
 b=XwbHouS4xD929qMqOarU8CRgLEx2ZOs11UCq6GP+G2Idk5ccf9TH4oIC+c9kr1ZHTJljOM
 XX+7qSQUhH9e3A/FIYh8/QszAxb8CXZ9AXi3UbF+AzNhQkgj8a29OXKP7qgvvX4MYSX9D6
 3tfHsdwg4uVGgFrXwWK4SVgxIOId354=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761822262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j45zA0yrT5Dk0d4wI6EixTsHIvAz0LQPF41WoTsot7A=;
 b=kSknL5WpuT7WCYD4dBDruqtWosofF/Ih2el/aJ/KlmhyEFg7tgE53p3Xw0DPZzoCQCHN1t
 RikuNA1aQoO5A3Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761822260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j45zA0yrT5Dk0d4wI6EixTsHIvAz0LQPF41WoTsot7A=;
 b=ES6rUdNxPWlukAXQ0n+lWOBzFiFBepbWeJ6Y+S3TBRbry03jNJd8h6uSPkK/NtmnY4zQkR
 FiIwK6U5RCXZTePcXBi+wLAbL904yTvh8nls0vhLAWrEI9XgJb97v//3jo6ddMyLO2qSWl
 Bmj90ImlbcgZYNDQR9itSbbaKYDV6nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761822260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j45zA0yrT5Dk0d4wI6EixTsHIvAz0LQPF41WoTsot7A=;
 b=Na/5xb8FNIb6acWItlv4sHDqhRG8k7nD/UEdVtS6mVp/27Dl3V+Li84qCUARjILISD56EZ
 l2fKGt80tvV4aMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1B3D13AAD;
 Thu, 30 Oct 2025 11:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IALOIzNGA2mEUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Oct 2025 11:04:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Oct 2025 12:04:11 +0100
Message-ID: <20251030110412.722758-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,virt_lib.sh:url,imap1.dmz-prg2.suse.org:helo,tst_net.sh:url,nfs10.sh:url];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] nfs_lib.sh: Document LTP_NFS_NETNS_USE_LO=1 in
 help
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Debugging on loopback device can be useful, make users avare.

Due LTP shell API limitations is output a bit inconsistent
(test specific options are printed first, API does not expect test
specific environment variables):

    # nfs10.sh -h
    ...
    Test Specific Environment Variables
    -----------------------------------
    LTP_NFS_NETNS_USE_LO=1    NFS traffic will go through loopback
    interface instead of ltp_ns_veth* netns interfaces (useful for debugging
    whether test failures are related to veth/netns)

    -t x    Socket type, tcp or udp, default is udp
    -v x    NFS version, default is '3'
    -6      IPv6 tests
    -h      Prints this help
    -i n    Execute test n times

    Environment Variables
    ---------------------
    KCONFIG_PATH             Specify kernel config file
    KCONFIG_SKIP_CHECK       Skip kernel config check if variable set (not set by default)
    LTPROOT                  Prefix for installed LTP (default: /opt/ltp)
    LTP_COLORIZE_OUTPUT      Force colorized output behaviour (y/1 always, n/0: never)
    LTP_DEV                  Path to the block device to be used (for .needs_device)
    LTP_DEV_FS_TYPE          Filesystem used for testing (default: ext2)
    LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for TST_ALL_FILESYSTEMS=1)
    LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist
    LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1, ceiled to int)
    TMPDIR                   Base directory for template directory (for .needs_tmpdir, default: /tmp)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

There are other tests which use environment variables (at least
virt_lib.sh and tst_net.sh) but we probably don't want to touch
tst_test.sh to add another function for printing test specific
environment variables.

When thinking about the future (shell loader): I suppose getopts can't
be part of shell loader (i.e. specified via JSON), but environment
variables documentation could be part of JSON doc part.  Or we could
have something specific to environment variables. Generally, JSON
comment has a limitation that it's only for the metadata, not for a
runtime - we need to duplicate to have it both in 1) metadata doc (the
JSON and sphinx readthedoc Test catalog page) and 2) printed in runtime
via -h.

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 14425898f9..4628b4ba6e 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -11,6 +11,13 @@ NFS_TYPE=${NFS_TYPE:=nfs}
 
 nfs_usage()
 {
+	echo "Test Specific Environment Variables"
+	echo "-----------------------------------"
+	echo "LTP_NFS_NETNS_USE_LO=1    NFS traffic will go through loopback
+interface instead of ltp_ns_veth* netns interfaces (useful for debugging
+whether test failures are related to veth/netns)"
+
+	echo
 	echo "-t x    Socket type, tcp or udp, default is udp"
 	echo "-v x    NFS version, default is '3'"
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

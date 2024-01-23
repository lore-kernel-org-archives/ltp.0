Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB1C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:27:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98DD83CFB7E
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 17:27:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84F4D3CE208
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:54 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 81E4B140B033
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3AA18222D5;
 Tue, 23 Jan 2024 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0IR7SnAfBRTkTOdGhikW1PQ3TdnbZpAbKpPIGgfjUxM=;
 b=Ws2iBfXXDsVdshtjA1ndzhD25dD9wURVXS/LxPHJMNLyrbSFZWhS3+yi9L/SqEP+h6jpn/
 HaOYe6GjfmGTPyJqjiv5TFVR8HiG3IHY5lIRdpbOHvQCmdxezp2UU4VoZi6KhkMva31WsU
 rARAxyO7tKGKo8dmaGZ4gR4cnwZ18Z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0IR7SnAfBRTkTOdGhikW1PQ3TdnbZpAbKpPIGgfjUxM=;
 b=2IWg/vToOSEg6kkhWckkSZ987ZmvrnQpg9Yn5Cw22IQ9tVm8SZWyVMOS8C7pJox8JbUTOK
 ju/Gv+EW1LYZGzBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0IR7SnAfBRTkTOdGhikW1PQ3TdnbZpAbKpPIGgfjUxM=;
 b=Ws2iBfXXDsVdshtjA1ndzhD25dD9wURVXS/LxPHJMNLyrbSFZWhS3+yi9L/SqEP+h6jpn/
 HaOYe6GjfmGTPyJqjiv5TFVR8HiG3IHY5lIRdpbOHvQCmdxezp2UU4VoZi6KhkMva31WsU
 rARAxyO7tKGKo8dmaGZ4gR4cnwZ18Z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0IR7SnAfBRTkTOdGhikW1PQ3TdnbZpAbKpPIGgfjUxM=;
 b=2IWg/vToOSEg6kkhWckkSZ987ZmvrnQpg9Yn5Cw22IQ9tVm8SZWyVMOS8C7pJox8JbUTOK
 ju/Gv+EW1LYZGzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD45713786;
 Tue, 23 Jan 2024 16:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xN71K8vor2V+CwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 16:26:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 17:26:43 +0100
Message-ID: <20240123162647.210424-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ws2iBfXX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="2IWg/vTo"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-0.981];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[19.67%]
X-Rspamd-Queue-Id: 3AA18222D5
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] shell: fix regression since 1878502f6
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

Hi all,

various tests fails since 1878502f6:

TBROK: tst_brk can be called only with TBROK or TCONF

This should be merged before the release.
(or revert 1878502f6).

Kind regards,
Petr

Petr Vorel (4):
  tst_test.sh: Improve info on wrong tst_brk param
  commands: Fix tst_brk TFAIL
  kernel: Fix tst_brk TFAIL
  network: Fix tst_brk TFAIL

 testcases/commands/gzip/gzip_tests.sh         |  3 +-
 testcases/commands/mv/mv_tests.sh             |  3 +-
 .../cpuset/cpuset_regression_test.sh          | 18 +++++++----
 .../kernel/device-drivers/zram/zram01.sh      |  3 +-
 .../kernel/device-drivers/zram/zram_lib.sh    | 30 ++++++++++++-------
 .../fs/quota_remount/quota_remount_test01.sh  |  3 +-
 .../security/integrity/ima/tests/ima_tpm.sh   |  3 +-
 testcases/lib/tst_test.sh                     |  2 +-
 testcases/network/nfs/nfs_stress/nfs06.sh     |  5 +++-
 testcases/network/stress/route/route-lib.sh   |  8 +++--
 testcases/network/stress/ssh/ssh-stress.sh    | 16 +++++++---
 testcases/network/tcp_cmds/host/host01.sh     |  5 ++--
 .../network/tcp_cmds/ipneigh/ipneigh01.sh     | 21 ++++++++-----
 testcases/network/virt/virt_lib.sh            | 12 +++++---
 testcases/network/xinetd/xinetd_tests.sh      |  7 +++--
 15 files changed, 93 insertions(+), 46 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

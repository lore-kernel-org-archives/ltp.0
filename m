Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C588C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:35:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 888253D0387
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:34:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A36363D029D
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F32251000EC1
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EB8E1FB62;
 Mon, 27 May 2024 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s6iQ8oVK4ZSZsIbs3E8XiOL5U5bPyR1kBVjiTVtbito=;
 b=bIl/tXYuqfUSzY0hyc8rj6lMYNbDF5wWLWfBgmW+fe6upXvlaHzp+eW3G5lRvOyKF8Ze0d
 7LgXYx9hiYCm6iqtqkI4RQE7sUGrNE9e9j1lbAWGpgJueNV6eZMFIKWBKqUmU2mq6Me9zk
 YaFSklfkgW8cBNnDKLhRSlo30TXazKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s6iQ8oVK4ZSZsIbs3E8XiOL5U5bPyR1kBVjiTVtbito=;
 b=5/CU68XmWyMTX+s3zwQhNuxBtaQkdoUUs4JprKvyTDmnJjZ1lGTG51bdFdUatApPcw4XBN
 TVhp+af6YBA37jCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="bIl/tXYu";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="5/CU68Xm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s6iQ8oVK4ZSZsIbs3E8XiOL5U5bPyR1kBVjiTVtbito=;
 b=bIl/tXYuqfUSzY0hyc8rj6lMYNbDF5wWLWfBgmW+fe6upXvlaHzp+eW3G5lRvOyKF8Ze0d
 7LgXYx9hiYCm6iqtqkI4RQE7sUGrNE9e9j1lbAWGpgJueNV6eZMFIKWBKqUmU2mq6Me9zk
 YaFSklfkgW8cBNnDKLhRSlo30TXazKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s6iQ8oVK4ZSZsIbs3E8XiOL5U5bPyR1kBVjiTVtbito=;
 b=5/CU68XmWyMTX+s3zwQhNuxBtaQkdoUUs4JprKvyTDmnJjZ1lGTG51bdFdUatApPcw4XBN
 TVhp+af6YBA37jCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17C1413A56;
 Mon, 27 May 2024 06:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TivVBFQpVGZAFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 06:33:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 08:33:31 +0200
Message-ID: <20240527063346.289771-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2EB8E1FB62
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/15] Remove kernel >= 3.x checks
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

Hi,

since 9e9654cf2 LTP supports kernel >= 4.4.
This removes all kernel >= 3.x checks.
I deliberately kept kernel >= 4.0 && kernel < 4.4 checks
(in case we worry somebody is using LTP master on these kernels).

Kind regards,
Petr

Petr Vorel (15):
  fallocate04: Remove kernel >= 3.15 check
  recv{,from,msg}01: Remove kernel >= 3.17 check
  renameat2*: Remove kernel >= 3.15 check
  sched_{g,setattr}: Remove kernel >= 3.14 check
  netstress: Remove kernel >= 3.11 check
  fs_bind_lib.sh: Remove kernel >= 2.6.15 check
  quota_remount_test01.sh: Remove kernel >= 2.6.26 check
  dctcp01.sh: Remove kernel >= 3.18 check
  busy_poll: Remove kernel >= 3.11 check
  cpuset_regression_test: Remove kernel >= 3.18 check
  tcp_fastopen: Remove kernel >= 3.7 and 3.16 check
  fcntl{34,36}: Remove kernel >= 3.15 check
  bpf: Remove kernel >= 3.18 or 3.19 check
  fanout01: Remove kernel >= 3.19 check
  cgroup_xattr: Remove kernel >= 3.15 check

 .../kernel/controllers/cgroup_xattr/cgroup_xattr.c     | 10 +---------
 .../controllers/cpuset/cpuset_regression_test.sh       |  1 -
 testcases/kernel/fs/fs_bind/fs_bind_lib.sh             |  1 -
 .../kernel/fs/quota_remount/quota_remount_test01.sh    |  1 -
 testcases/kernel/syscalls/bpf/bpf_map01.c              |  1 -
 testcases/kernel/syscalls/bpf/bpf_prog01.c             |  1 -
 testcases/kernel/syscalls/bpf/bpf_prog02.c             |  1 -
 testcases/kernel/syscalls/bpf/bpf_prog03.c             |  1 -
 testcases/kernel/syscalls/bpf/bpf_prog04.c             |  1 -
 testcases/kernel/syscalls/bpf/bpf_prog05.c             |  1 -
 testcases/kernel/syscalls/fallocate/fallocate04.c      |  5 -----
 testcases/kernel/syscalls/fcntl/fcntl34.c              |  1 -
 testcases/kernel/syscalls/fcntl/fcntl36.c              |  1 -
 testcases/kernel/syscalls/recv/recv01.c                |  8 --------
 testcases/kernel/syscalls/recvfrom/recvfrom01.c        |  8 --------
 testcases/kernel/syscalls/recvmsg/recvmsg01.c          |  7 -------
 testcases/kernel/syscalls/renameat2/renameat201.c      |  5 -----
 testcases/kernel/syscalls/renameat2/renameat202.c      |  5 -----
 .../kernel/syscalls/sched_getattr/sched_getattr01.c    |  3 ---
 .../kernel/syscalls/sched_getattr/sched_getattr02.c    |  3 ---
 .../kernel/syscalls/sched_setattr/sched_setattr01.c    |  3 ---
 testcases/network/busy_poll/busy_poll_lib.sh           |  1 -
 testcases/network/netstress/netstress.c                |  3 ---
 testcases/network/packet/fanout01.c                    |  1 -
 testcases/network/tcp_cc/dctcp01.sh                    |  1 -
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh     |  5 -----
 26 files changed, 1 insertion(+), 78 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

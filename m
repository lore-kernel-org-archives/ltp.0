Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E48C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 14:41:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 849DE3C93DA
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:41:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDBCE3C14B2
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:40:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E68DF140013A
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:40:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18F1E218E6;
 Tue, 25 Jan 2022 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643121649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8kRLYijuPY19Mf2QdCWIJRUO6bh/Nz0ACiJcsOT3ElU=;
 b=R5mI5r1ahEzl9HTxuZUM6Te1QjmnwVJZlRWi4lAHJB8M80wON4dqQ88CItTZ7KZTdrgbmZ
 8+P/J5rAtBP+uJ5La05JM+hUKBXp/ArboocZAZOPP01MChbIGB24o7WS4X+BtAeA+sSFb1
 NYxwBuh5dfyEBKP121pbEqhWeoUWZkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643121649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8kRLYijuPY19Mf2QdCWIJRUO6bh/Nz0ACiJcsOT3ElU=;
 b=lbP2Xtv9q838khvyk7XGMD3flgJTMeLIaN54wpXB96x3Q60zIpZRifIuWlbK0zRF58cNHp
 4gZyMy1byHaATmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4C6813DEB;
 Tue, 25 Jan 2022 14:40:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nLYBNvAL8GGFdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 14:40:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Jan 2022 15:40:39 +0100
Message-Id: <20220125144043.31798-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] sched_{g,s}etattr01: Add missing policies
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

changes v1->v2:
3 new commits

sched_getattr and sched_setattr are 99% identical (2 values are
different). I was thinking to use the same approach from e197796f22
("sethostname: Convert to new API"), but not sure if it's a good
approach.

Do we want to reduce files needed to be updated after new policy is
added? If yes, shouldn't there be just a single directory?
(what name should be using to show 2 syscalls are in sources in this
directory?)

Also docparse expect source file to be just for one binary, thus not
sure whether it should just document both binaries (and thus also
rename source file to show 2 syscalls are for this source?)

Kind regards,
Petr

Petr Vorel (4):
  lapi/sched.h: Add include <sched.h>
  lapi: Move SCHED_DEADLINE definition from tests
  sched_get_priority_min01: Add missing policies
  sched_get_priority_max01: Add missing policies

 include/lapi/sched.h                             | 16 +++++++++++-----
 testcases/kernel/syscalls/kcmp/kcmp03.c          |  1 -
 .../sched_get_priority_max01.c                   | 13 +++++++++----
 .../sched_get_priority_min01.c                   | 13 +++++++++----
 .../syscalls/sched_getattr/sched_getattr01.c     |  3 ---
 .../syscalls/sched_getattr/sched_getattr02.c     |  2 --
 .../syscalls/sched_setattr/sched_setattr01.c     |  2 --
 7 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

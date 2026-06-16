Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED20DCD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:30:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EA203C96A5
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:30:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C269A3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:30:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DCABC10009EC
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:30:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8ECCB6C6A3;
 Tue, 16 Jun 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781598606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0dJhIP9icTIqPosHXDJDXdWbLs0X1JCgOKzySzgJ/tA=;
 b=SQtZCO5co4rHAFoNs/gJO3jGJyVR2pIeqMJp47Xa7MEdLcGq3AJk9e5GYB2QHUWOb00cg2
 lw6aCDr2sJ+mvUdnQiWxXr8r8NjLTddSD6O8mB86yEOlcTC/SMVYNk01gxQo606Ur3rX8Q
 VW3u8rTpI6ujGgBF2MwIpLEdUKGdaSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781598606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0dJhIP9icTIqPosHXDJDXdWbLs0X1JCgOKzySzgJ/tA=;
 b=JVmbTKq6oyyIGh8bVtUlVFaF0SQWnMs0Id/cv2R4qUUrgXqtlbtP3omX8h454ZLVaAqkvD
 KX0bIgBONIHSkICA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SQtZCO5c;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JVmbTKq6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781598606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0dJhIP9icTIqPosHXDJDXdWbLs0X1JCgOKzySzgJ/tA=;
 b=SQtZCO5co4rHAFoNs/gJO3jGJyVR2pIeqMJp47Xa7MEdLcGq3AJk9e5GYB2QHUWOb00cg2
 lw6aCDr2sJ+mvUdnQiWxXr8r8NjLTddSD6O8mB86yEOlcTC/SMVYNk01gxQo606Ur3rX8Q
 VW3u8rTpI6ujGgBF2MwIpLEdUKGdaSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781598606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0dJhIP9icTIqPosHXDJDXdWbLs0X1JCgOKzySzgJ/tA=;
 b=JVmbTKq6oyyIGh8bVtUlVFaF0SQWnMs0Id/cv2R4qUUrgXqtlbtP3omX8h454ZLVaAqkvD
 KX0bIgBONIHSkICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CFFA779A8;
 Tue, 16 Jun 2026 08:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MmLJGI4JMWqAfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 16 Jun 2026 08:30:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 16 Jun 2026 10:30:05 +0200
Message-Id: <20260616-fix_pids_errors-v2-0-a1e1d377f8b7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI0JMWoC/3WNwQrCMBBEf6Xs2UgSm9J48j+klJCudg82ZVeDU
 vLvxt49vmHmzQaCTChwbjZgzCSUlgr20ECcw3JHRVNlsNp2ujNO3eg9rjTJiMyJRRl/8r41Pva
 IUFcrY63sxutQeSZ5Jv7sB9n80v+ubJRW3gfXBqud6fVFXoLHmB4wlFK+mpr6na0AAAA=
X-Change-ID: 20260615-fix_pids_errors-19399419c8ee
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781598606; l=688;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=gDTbcCJV8taszZkIdyCqk+40Spaer15zDLUQRgYhhrc=;
 b=mxGgRLwN5oKqjCUj/qWGxz4pYZ91kb8j6HaUAis/FAiHXFedusI+6iMEPIs9g7l1DTJSpRgFS
 4Q7p350Qo9GDcSuaUi0DGhdb8XARdQcWOo3si0POHiRX6ZGE5xTXROO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8ECCB6C6A3
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Fix sporadic failures in pids shell tests
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- handle ESRCH only when ret < 0
- Link to v1: https://lore.kernel.org/r/20260615-fix_pids_errors-v1-0-99a54a205180@suse.com

---
Andrea Cervesato (2):
      pids: fix cleanup of orphaned pids_task1 children
      tst_cgroup: tolerate ESRCH in cgroup_drain()

 lib/tst_cgroup.c                          | 6 +++++-
 testcases/kernel/controllers/pids/pids.sh | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: b4d31ea5d5c16628b9c45932fc98b929ca2ceece
change-id: 20260615-fix_pids_errors-19399419c8ee

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

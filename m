Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1B0C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 07:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318693C6987
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 09:45:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 838EC3C0746
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 09:44:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E56141A0433F
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 09:44:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1132D1F8AE;
 Thu, 11 Jul 2024 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720683851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4tIBWXw6PtY9uCKF+/pgSg5oVaQZlRdjx96+piF+y4=;
 b=J654SL8wV1yb7iR8nYobSy9i+aJtiUHyQPClu/JfqtLYxc+1FaUMrO9vKEq8P4dJYGeU59
 RonV9IktZd0vu68u2G5uxBzXk1DlKdXlC5PXnYUrovHYVD5OBRtxMGqAUbYsLmK0r9NpMk
 1ynyPN8UsT+4SyodWi5ht5H4DTqsv8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720683851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4tIBWXw6PtY9uCKF+/pgSg5oVaQZlRdjx96+piF+y4=;
 b=eKv4NhFClpmGKkPebqGLzkAOSZsJNz8/kpXLxEndVK7VTjsSHTiPcazj8+QqTBBIpoFUzB
 iQNCugedbYpxKJBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J654SL8w;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eKv4NhFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720683851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4tIBWXw6PtY9uCKF+/pgSg5oVaQZlRdjx96+piF+y4=;
 b=J654SL8wV1yb7iR8nYobSy9i+aJtiUHyQPClu/JfqtLYxc+1FaUMrO9vKEq8P4dJYGeU59
 RonV9IktZd0vu68u2G5uxBzXk1DlKdXlC5PXnYUrovHYVD5OBRtxMGqAUbYsLmK0r9NpMk
 1ynyPN8UsT+4SyodWi5ht5H4DTqsv8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720683851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4tIBWXw6PtY9uCKF+/pgSg5oVaQZlRdjx96+piF+y4=;
 b=eKv4NhFClpmGKkPebqGLzkAOSZsJNz8/kpXLxEndVK7VTjsSHTiPcazj8+QqTBBIpoFUzB
 iQNCugedbYpxKJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFA18139E0;
 Thu, 11 Jul 2024 07:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vixJNUqNj2a3FQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 07:44:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 09:43:52 +0200
Message-Id: <20240711-stat04-v4-0-d30c26fdaf5a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADiNj2YC/2XMTQ7CIBCG4as0rMUMA/3BlfcwLiiMloWtgUo0T
 e8u7aJpdPlN5nknFil4iuxUTCxQ8tEPfR7qUDDbmf5O3Lu8GQIqqAF5HM0IiluitmzaBrQAlp+
 fgW7+vYYu17w7H8chfNZuEsv1L5EEB05YO61LiQLcOb4iHe3wYEsh4V7pTWFWWGlpVC0NmvZHy
 Z0SsCmZla0agxKVcVrt1DzPX9I2Jx0HAQAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=PczOOoBs1d+KiLnTB6S80ZEA/mXkIjEyjGQ0PuoKJnI=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj407dNDwSVTRh65t74tHmanuc4JM0HixXpLwn
 /XxmXpYM+uJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+NOwAKCRDLzBqyILPm
 RsGfC/4x+LDV/X0BFJuyaZwgV6yBGyxmprIMVIqXhvbxxSVbrmDv7aVsYlAaNeDjsJg8ngxFdM8
 uSq0bmgKpjIo2jLZO/M3sJVNjghtDrmGJf4431GTG+N9c1HFQMMR+/PrYQT83HJelZ++iF7xv47
 Fv6fmvjv785TdoIjC/zyKtvNjQdO4+n3rxzQeeZK+bbzMPIanjgp1dMJTrxUvfQ08HrxJAbxB28
 4b2Gzg2wsdx61yJMnSmR0pk3AWtgiViubzoz5igGNT800zYEOOr0EMCdbiYnH13/3PBM0FHBf22
 2/4+iUIzG9oznPjShp1FKGnh6AEWaVtfc6bpuLGDRQ3IWU1RdkIYEXlgKl6YpPU31xIW7lZa8nQ
 5Fkfy5r8j7WqUtP8Q9G5wXE7k813WenRQwuq1Etem5w6Cf3C11lfyRz7xkyH/60YCTTzMdSJshW
 6vci5VqksV+v7ipArguuklyNam7PA5194I00wUQw+mwiULq9J7egWs8+by+YfKGLgKemY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 1132D1F8AE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] symlink01 split
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

This is a developement series (requested by Petr Vorel) that handle
symlink01 split, which has been already merged in the master branch.

In this series we face the next part of symlink01 split that
includes stat04, lstat03, open15 and chmod08.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- stat04: use asprintf
- stat04: remove unlink() from cleanup
- lstat04: remove unlink() from cleanup
- Link to v3: https://lore.kernel.org/r/20240710-stat04-v3-0-c68a2324ad94@suse.com

Changes in v3:
- stat04: smarter cleanup
- lstat03: smarter cleanup
- open15: fix algorithm, read/write from/to symlink
- Link to v2: https://lore.kernel.org/r/20240709-stat04-v2-0-2693a473a2ab@suse.com

Changes in v2:
- update TST_EXP_EXTR to support stringification
- call stat() inside the test run() routine
- call lstat() inside the test run() routine
- simplify chmod08
- simplify open15
- Link to v1: https://lore.kernel.org/r/20240702-stat04-v1-0-e27d9953210d@suse.com

---
Andrea Cervesato (4):
      Add stat04 test
      Add lstat03 test
      Add chmod08 test
      Add open15 test

 runtest/smoketest                          |   4 +-
 runtest/syscalls                           |  11 +--
 testcases/kernel/syscalls/chmod/.gitignore |   1 +
 testcases/kernel/syscalls/chmod/chmod08.c  |  45 ++++++++++++
 testcases/kernel/syscalls/lstat/.gitignore |   2 +
 testcases/kernel/syscalls/lstat/lstat03.c  |  99 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/open/.gitignore  |   1 +
 testcases/kernel/syscalls/open/open15.c    |  75 ++++++++++++++++++++
 testcases/kernel/syscalls/stat/.gitignore  |   2 +
 testcases/kernel/syscalls/stat/stat04.c    | 109 +++++++++++++++++++++++++++++
 10 files changed, 341 insertions(+), 8 deletions(-)
---
base-commit: afd3ac1d0f2d28960de073bca7e7d4c71a61dd00
change-id: 20240702-stat04-ceeb58b80910

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

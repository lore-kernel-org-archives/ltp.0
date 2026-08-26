Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E6BC61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 13:35:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A9E73CDE70
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 15:35:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9906B3C2603
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 15:35:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DADBE60093F
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 15:35:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 049F6874DB;
 Wed, 26 Aug 2026 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787751298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4dAW68J14uZQq3fLwmSOr8J+biThRymWZBVTXxUJaEE=;
 b=JCOoIkCWNGfs63pgccjRUiOUTvJUnLnf6z8dyVFCfjBngxILPxWcDmrfJNJ4o9SVMfM763
 A8bUbQIQJ0uETUEPzYcHPMIyWqUI7qX6OHV9U9UEBXvGMPuJzPA83p0hccNqeKCJNWfwPo
 WOogTm/iCX2goYm7/4kszl4KBoBIdR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787751298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4dAW68J14uZQq3fLwmSOr8J+biThRymWZBVTXxUJaEE=;
 b=oDRsq//eM5y1+QBUBacxjxMHGWF5AfETXEycTX1+tdg3zsfkua1KVLTLvVaCEKoiVGZpXz
 k0i1fi9Nhk3F/nAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787751294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4dAW68J14uZQq3fLwmSOr8J+biThRymWZBVTXxUJaEE=;
 b=LfwN08IQ2b9L2jBBbs6/cwlwFOY5cxEFkispmX91Izr68J+g/hkuBOvOLourQIJf0BeBfk
 D1fm/GVaY9kh/+Be91PTImtg6gqODCBdQaFJX6hwTHkADNQ3cPaFFS6JnV6cDMklekv3Fd
 aIL/ET0HLrU31uMNvznWAbXHqUrCpeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787751294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4dAW68J14uZQq3fLwmSOr8J+biThRymWZBVTXxUJaEE=;
 b=dfyxyfCdwGqDdl4EAvd2JK+x1FyBQblXMm3zE9fjaGceq1+lbCXR/u1anEMjRD15LJ6VXl
 bw3yeizQlquz4DAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E10F613533;
 Wed, 26 Aug 2026 13:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tdZsNX3rjmqmbQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 26 Aug 2026 13:34:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 26 Aug 2026 15:34:52 +0200
Message-Id: <20260826-convert_fallocate_suite-v3-0-1286ede0493d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHzrjmoC/4XNQQ7CIBCF4as0rMXAIKVx5T2MaSgOlqQWA5Rom
 t5d2o1ujMv/JfPNTCIGh5Ecq5kEzC46P5YQu4qYXo83pO5amgCDmilg1PgxY0it1cPgjU7Yxsk
 lpA0wwcF2Vkgg5foR0LrnJp8vpXsXkw+v7VHm6/rfzJwyKpnGRhpZGyZOcYq4N/5OVjLDh2mY+
 s1AYYSquVWdOnTcfjHLsrwBfpY+NQQBAAA=
X-Change-ID: 20260720-convert_fallocate_suite-820312fbf352
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751293; l=1288;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=K2YbSDHuOVVHqwXMs1BVxDwQm4WCcJO5L/7yC3YWxos=;
 b=l83D9aYU1FxbqWC2VDDGkfmV8ezlyTGkLDZo+yZLrKkLL5V03w8l9T63Wroo88ovo02X0TO7f
 jFkQxMb4XxABRXErndJrOdnV0W3utBWFSSXGEAxEbXqKyef/O++xdB6
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Convert fallocate testing suite
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

Testing a new multi-agent converter that does a deep analysis on the
code, evaluate if it needs to be converted line by line or it only needs
a complete rewrite, then it spawn an agent for writing the test, one for
reviewing and it iterates until test is out of issues.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- fallocate01: all filesystems, check for ENOSYS/ENOTSUPP, use TST_EXP_*
- fallocate02: check for ENOSYS/ENOTSUPP
- Link to v2: https://lore.kernel.org/20260807-convert_fallocate_suite-v2-0-3761f7b74b1f@suse.com

Changes in v2:
- fix fname size
- simplify commit messages
- Link to v1: https://lore.kernel.org/20260720-convert_fallocate_suite-v1-0-50ae85c56c03@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      fallocate01: Convert to new API
      fallocate02: Convert to new API

 testcases/kernel/syscalls/fallocate/fallocate01.c | 328 ++++++----------------
 testcases/kernel/syscalls/fallocate/fallocate02.c | 192 ++++---------
 2 files changed, 149 insertions(+), 371 deletions(-)
---
base-commit: 9118a480cc68700f27944aab817e0202e9e6136c
change-id: 20260720-convert_fallocate_suite-820312fbf352

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

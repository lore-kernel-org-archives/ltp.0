Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B06C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 06:59:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2AF3E27F8
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 08:59:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76F73E138E
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:59:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E1DA1000984
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:59:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE8D63E02;
 Fri,  7 Aug 2026 06:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786085956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F1iKc9AAyJ+EgcEeHAeo1THXFrm9ZnNk2jnRNLqaSoQ=;
 b=p+MqX36rSUNSYs/0Ve1ofcXHV6Mw04PxTJIpztHKjSzDr4SipRAcMdJNLUFsHYXjDihxjO
 Nf0hVsmHjMfZJfl+uhGXNqeTTKK9szgPlCO41uVr1Iq688EGwJKe26/PIDqZKSD1Tbaw1W
 njcyx9XzLFFZ4TND+I/sb+1ITd/ET0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786085956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F1iKc9AAyJ+EgcEeHAeo1THXFrm9ZnNk2jnRNLqaSoQ=;
 b=d+aqlHoX+CFqrZYpVGrdLjMx+rrqAmZ9jlJwNDkT7TXoZMhC32hmn9vnjc0vxX7Gn3gOK+
 WqEATHdYJ/SDqODg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Yc/zzlRi";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4t79tXz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786085951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F1iKc9AAyJ+EgcEeHAeo1THXFrm9ZnNk2jnRNLqaSoQ=;
 b=Yc/zzlRitPhDz2MevWMYB8/a1Aj14a/FQlR+QxhwLojeLlWu8BhLvTto30M3tD4YqgmS9U
 AYAwT1YG6qwGlLI/i+RJXOdLWW3NZfjKF83bY/AibfuWauA9z/51tfmp3GRhrJDf6Eu5O0
 i7oeKowbXUo1+pQF5wMe28gawu3V4nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786085951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F1iKc9AAyJ+EgcEeHAeo1THXFrm9ZnNk2jnRNLqaSoQ=;
 b=4t79tXz/UT6DjiKIFK8Vbzf1fUWylMQQZybmfOVTkc6/DKx0z0EBPjRr3EPu+CSYNlR3J4
 KxglxJfpRWsw98CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4EE8779B6;
 Fri,  7 Aug 2026 06:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QcsjKT+CdWrkcwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 06:59:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 08:59:05 +0200
Message-Id: <20260807-rewrite_mremap_testing_suite-v2-0-1760ae8e3b8b@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADmCdWoC/33Nyw6CMBCF4Vchs7amFIPoyvcwpKllCrPgkpmCG
 sK7W0ncuvzP4jsrCDKhwDVbgXEhoXFIYQ4Z+M4NLSpqUoPRptRnoxXjkymi7Rl7N9mIEmlorcx
 pVI3TF1c9fFWUDhIxMQZ67fy9Tt2RxJHf+9uSf9cfnP+Hl1xphd74wodQojvdZBY8+rGHetu2D
 +MepRfHAAAA
X-Change-ID: 20260720-rewrite_mremap_testing_suite-da09a8bc836a
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786085951; l=1629;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=lSIPwPPMrrLRrZA5AdwOmtBc6Q+j7Qy8x3S4JYyVuHY=;
 b=+Hrn/8+ekKz+aUaMdNoIG/wRlexUg6OxXK4IGUoXXCcg+tLsmXYbfu8i2unjReaFwe9jzwaLz
 ZGAWUCVg2ohBXrbRnwslswOOeqW9EdXbncOWx+Cujjx+f7QEwF05UXx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EE8D63E02
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] Rewrite mremap testing suite
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

This rewrite has been done using multi-agent configuration that is now
present in ltp-agent project.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- mremap05: remove MREMAP_FIXED | MMAP_MAYMOVE
- mremap04: remove SysV stuff
- mremap01: ftruncate every run() cycle
- mremap02: reset bad address when mremap goes well
- Link to v1: https://lore.kernel.org/20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (6):
      mremap01: Convert to new API
      mremap02: Convert to new API
      mremap03: Convert to new API
      mremap04: Convert to new API
      mremap05: Convert to new API
      mremap08: Extract test from mremap05

 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/Makefile   |   4 +-
 testcases/kernel/syscalls/mremap/mremap01.c | 281 +++++++++-------------------
 testcases/kernel/syscalls/mremap/mremap02.c | 201 +++++---------------
 testcases/kernel/syscalls/mremap/mremap03.c | 203 ++++----------------
 testcases/kernel/syscalls/mremap/mremap04.c | 265 +++++---------------------
 testcases/kernel/syscalls/mremap/mremap05.c | 278 ++++++++-------------------
 testcases/kernel/syscalls/mremap/mremap08.c | 128 +++++++++++++
 9 files changed, 413 insertions(+), 949 deletions(-)
---
base-commit: 12fcadf63a99fc4bec76f9b4715cda626256562f
change-id: 20260720-rewrite_mremap_testing_suite-da09a8bc836a

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

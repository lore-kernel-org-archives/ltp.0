Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E04CEBF8C
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:51:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8D3A3C5281
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:51:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 938F43C4F64
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 696B86067A2
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72E911FD9D
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HVmtBy+gUI6Q5gG06PqMpD2XHxxHLgaifp2umDhZJ9U=;
 b=zQdALdPD7WtaN/2Wrh/1CnXONodug6gX52WJsrmGdQjtOFwahykVCAYEI96notc6h9N5De
 7K4LKfetxeK0WgcBmizVrl8G6quN7xsHr8qSskx+B41BaVFsj0O9dhHvQSJlk0ViGBXDot
 S7wZn4Hbqz/HL7yy1/i80hXowVmSIlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HVmtBy+gUI6Q5gG06PqMpD2XHxxHLgaifp2umDhZJ9U=;
 b=dPpxIwMJJ7uSSFPvIp3H5CNGeo2oUVEQ5NtyiVJ1TizKMqCMFB05jvto25xA/dqZvbHpJk
 n+XBDmpVbqaDr4Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HVmtBy+gUI6Q5gG06PqMpD2XHxxHLgaifp2umDhZJ9U=;
 b=zQdALdPD7WtaN/2Wrh/1CnXONodug6gX52WJsrmGdQjtOFwahykVCAYEI96notc6h9N5De
 7K4LKfetxeK0WgcBmizVrl8G6quN7xsHr8qSskx+B41BaVFsj0O9dhHvQSJlk0ViGBXDot
 S7wZn4Hbqz/HL7yy1/i80hXowVmSIlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HVmtBy+gUI6Q5gG06PqMpD2XHxxHLgaifp2umDhZJ9U=;
 b=dPpxIwMJJ7uSSFPvIp3H5CNGeo2oUVEQ5NtyiVJ1TizKMqCMFB05jvto25xA/dqZvbHpJk
 n+XBDmpVbqaDr4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DEF813A73
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XnoXFat/9ma9TQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 27 Sep 2024 11:49:20 +0200
Message-Id: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKB/9mYC/22NQQrCMBBFr1JmbSQZK7WuvIcUSZOxHaipZGqxl
 NzdWHDn8j34768gFJkEzsUKkWYWHkMG3BXgehs6UuwzA2osdY0H1VGgaCe6ySLODoOo6qS9Q8S
 q9S3k3TPSnd9b89pk7lmmMS7bxWy+9lcr/9Rmo7SqS3PUla2dt+4iL6G9Gx/QpJQ+zIbJCLEAA
 AA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727430571; l=3187;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2cZLhsNXknwCs+jI6zROutSRJpbx8Qqc7humoJDWr5U=;
 b=BDBLHrShjUuix/+p3q2JeYVHNrxl2TP7/kUXJi5Kc1VkjshyIHGn8TZNNMtF/KhduLDvDCTxU
 9popcUOV43iD9gi12I7Co1+Qyh35i+MwPJG+C2xdSVVC4p0ewI8f6L2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] Automatically generate syscalls.h
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

The problem we have at the moment is that all syscalls input files must
be changed by hand each time we need to test a new syscall. The idea is
to simplify this process, providing a script that is able to read from
kernel sources and to generate all syscalls files we need.

This patch set adds a new command inside the syscalls folder and
it refactors the previous regen.sh code.
The new way we have to generate the syscalls.h file is the following:

	include/lapi/syscalls/generate_arch.sh 		path/to/kernel/source
	include/lapi/syscalls/generate_syscalls.sh 	path/to/syscalls.h

Scripts are independent and they can be run separately.
generate_syscalls.sh is the equivalent of regen.sh, but its code has
been cleaned up.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- refactor regen.sh
- split syscalls.h and syscalls .in files creation
- updated syscalls .in files
- Link to v1: https://lore.kernel.org/r/20240924-generate_syscalls-v1-0-941507a9cdac@suse.com

---
Andrea Cervesato (5):
      Refactor regen.sh script to generate syscalls
      Add script to generate arch(s) dependant syscalls
      Update ia64.in syscalls file
      Delete obsolete strip_syscall.awk file
      Update syscalls files

 configure.ac                                       |   2 +-
 include/lapi/syscalls/aarch64.in                   | 306 -------
 include/lapi/syscalls/arc.in                       | 325 -------
 include/lapi/syscalls/arm.in                       | 404 ---------
 include/lapi/syscalls/blacklist-syscalls.txt       |   6 +
 include/lapi/syscalls/generate_arch.sh             | 182 ++++
 include/lapi/syscalls/generate_syscalls.sh         | 115 +++
 include/lapi/syscalls/hppa.in                      |  52 --
 include/lapi/syscalls/i386.in                      | 439 ----------
 include/lapi/syscalls/ia64.in                      | 956 +++++++++++++--------
 include/lapi/syscalls/loongarch.in                 | 310 -------
 include/lapi/syscalls/mips_n32.in                  | 379 --------
 include/lapi/syscalls/mips_n64.in                  | 355 --------
 include/lapi/syscalls/mips_o32.in                  | 425 ---------
 include/lapi/syscalls/powerpc.in                   | 432 ----------
 include/lapi/syscalls/powerpc64.in                 | 432 ----------
 include/lapi/syscalls/regen.sh                     | 129 ---
 include/lapi/syscalls/s390.in                      | 419 ---------
 include/lapi/syscalls/s390x.in                     | 367 --------
 include/lapi/syscalls/sh.in                        | 413 ---------
 include/lapi/syscalls/sparc.in                     | 418 ---------
 include/lapi/syscalls/sparc64.in                   | 383 ---------
 include/lapi/syscalls/strip_syscall.awk            |  19 -
 .../lapi/syscalls/{order => supported-arch.txt}    |   2 +-
 include/lapi/syscalls/x86_64.in                    | 396 ---------
 25 files changed, 909 insertions(+), 6757 deletions(-)
---
base-commit: 08cb938197e82eddce146662a47ff990827ff60a
change-id: 20240923-generate_syscalls-780dc2227bdb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

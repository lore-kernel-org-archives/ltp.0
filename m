Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D40AE77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8B23C4BE7
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:27:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F0C13C4BC7
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:24 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 16A2E225B7C
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C0F21F399;
 Mon,  6 Jan 2025 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wm9KQcMBUln+PpRhHhihlqx8UeV9AF36ixy+v9c35OM=;
 b=YzlAL+Q2ZjhFm61uj8Jhwbl0YtEayXtnDo6wgpAxsDb/CeDcqam2nCXgi67vtP/JbxPlxi
 bRBl8oaIB5Xp4w5Ypt47ff05ePUlwJXvS3eFk7rS/C/usxb/xCVjk8DNv+IO9ihrjRydeH
 53FYr7M/ZHB6CL29rmLqurOsntyTBBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wm9KQcMBUln+PpRhHhihlqx8UeV9AF36ixy+v9c35OM=;
 b=9+8rNPsnW4D2z4i/dKl+XdI5FMoI62wEvnFHoq1eeYZetsKy1BnhRrPWQSHAXGcFAXVU8I
 NNCDCfnGmDqZfFBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wm9KQcMBUln+PpRhHhihlqx8UeV9AF36ixy+v9c35OM=;
 b=WUXxg7FOsDLSDTg36IhIhj8gtNZjmzMVuOiFDoALwCGWKm/lzW8540lb74atHq/XNPK/SW
 HQfH97BuDQhVcn6t5Usa0aJ4CEyQF0SoNJ9mC6O5NRe5BX4ZZbJ9/9J6oU1ycLs+MPNAGh
 8f+pIseXmU/uXGGldLrJsOpUlcjGCVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wm9KQcMBUln+PpRhHhihlqx8UeV9AF36ixy+v9c35OM=;
 b=s5ZRnEQdWe9EAiwy64Tl9sDE2T0M09fy06o2jc0lHlwRSqbx3IjhLw+qXPmO46JT8d85uS
 Ka9vXxfjUxfVP6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88603139AB;
 Mon,  6 Jan 2025 13:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HHQAIf3Ze2e8KgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 13:26:21 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Jan 2025 14:26:01 +0100
Message-ID: <20250106132607.25627-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,vma05.sh:url,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] First new shell library converted test
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

This patchset contains a few fixes for the new shell library and first
converted test.

Changes in v2:

- The save_restore parser now matches the C metadata format
  (after the metadata metaparse fixes I've send in another patchset)

- Added one more patch to make the tst_test structure in tst_res_ static

- the vma05.sh now uses the second argument for the values that are
  supposed to be written to these files

- restored the unset DEBUGINFOD_URLS in vma05.sh added by an accident
  (this may possibly fix the timeouts reported by pvorel)

Cyril Hrubis (6):
  tst_run_shell: Add save_restore parser
  tst_run_shell: Make the tst_test struct static
  libs/ujson: Fix "Garbage after JSON string!" in strict mode
  tst_run_shell: Better errors for metadata extractor
  lib/tst_res_.c: Add TBROK handler + more verbose errors
  mem/vma05.sh: Convert to the new shell library

 libs/ujson/ujson_reader.c         |   6 +-
 testcases/kernel/mem/vma/vma05.sh |  96 +++++++++++++------------
 testcases/lib/tst_res_.c          |  22 +++---
 testcases/lib/tst_run_shell.c     | 114 ++++++++++++++++++++++++++++--
 4 files changed, 177 insertions(+), 61 deletions(-)

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A9BCA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:26:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D38A53E5440
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C18773E4E4B
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D19A1A00706
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E39D61F453;
 Mon,  5 Oct 2026 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X3cDGOnKoSp1RKu7hGSBQ8ZuRrQ5In8O39XxczPiodA=;
 b=hyMzSuk0mYgq/AZhQXHtDtKrXAAJmxqKDqQFcCSYnICD0iMBk94F7Xrvdx1WXXw8P00JtX
 +dST/ngA0fO6N2WicxFPrOSL5uOxTYyYSqULTW07XHpfo4Y84Jzw55Cje3QypCk1JylYWS
 aFWB98NxQ8OJUOOqaj5BhwuZAEL3u64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X3cDGOnKoSp1RKu7hGSBQ8ZuRrQ5In8O39XxczPiodA=;
 b=VRf0Q/tlJV7837hwlQIaRPs0arNdJ+vYjmJMRK2JyhLaId314CJ+a4AvSzScDjtvNhiRCj
 /YSVWlf1R4iGY5Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X3cDGOnKoSp1RKu7hGSBQ8ZuRrQ5In8O39XxczPiodA=;
 b=dQUIG5FRNIrWkKFHhZT9bdEvvIkFYkV414tuo1ntDW+ESZC1DTjd5TFEQPx4xUhdo/3UVR
 m8E8exVn/XQ497wDuwMBgMx4ZemxV0w1yK4Wo8MhYutTRbYEiNxo0KPaPo7W4vB6N8BGu4
 0zBFXWtLV+a8WrANE1RUCyFm5uEJdUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X3cDGOnKoSp1RKu7hGSBQ8ZuRrQ5In8O39XxczPiodA=;
 b=oypry69ROEmYLE/W60+37E3VCYtXn2GInEwZW1LVW7Ef8yvG69anWKlS7rK+JRvvGXM+ST
 L/2yNAHyskTm+rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC4AA132D3;
 Mon,  5 Oct 2026 13:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:28 +0200
Message-Id: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEmlw2oC/yXMUQqDMBCE4avIPjcQA6nRq0gJJk7bVVHJtqUg3
 r3RPn4w828kSAyhptgo4cPCy5xRXgqKz25+QHGfTUabq66NVXf++rgk+ImD74FVgFGZ0NW6dLG
 yzlH+rgl5eHbb29/yDgPi64jRvv8AEqRq9HkAAAA=
X-Change-ID: 20260925-fix_core_lib_deepseek-2ba9018c7588
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1952;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=CVuqLVHLHwp35oDHAEwJZDVeWB5ixQ6KpasK//LFsL0=;
 b=sPYFBpBe3dyzWX4qbHKEoql6xOEMQjVUnrRjVuqtnW0HI7ymhDA4q2un3mlkjUluRxSoPg/vl
 V1Yr7amFZYEA6dc+Hw6SlA6y/EbYLIpY85XsYQ0sia8DpKfXScI724d
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.11)[-0.556]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/15] Fix ujson bugs
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

- fix 4-byte UTF-8 sequence decoding in ujson_utf8_next()
- fix out-of-bounds read on invalid UTF-8 in ujson_writer
- prevent infinite loop when read() returns 0 in ujson_reader
- fix inverted open() error check in ujson_writer_file_open()
- combine UTF-16 surrogate pairs and reject lone surrogates
- check for signed integer overflow when parsing numbers
- fix error propagation when newline() fails in ujson_writer
- check output return values in ESC_FLUSH macro
- avoid skewing recursion depth on overflow in ujson_reader
- unescape object ID strings in ujson_reader
- support reading files with zero lseek size such as procfs

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (15):
      ujson: Fix 4-byte UTF-8 sequence decoding
      ujson: writer: Fix OOB read on invalid UTF-8
      ujson: reader: Prevent infinite loop on EOF
      ujson: writer: Fix open() return value check
      ujson: reader: Combine UTF-16 surrogate pairs
      ujson: reader: Check for signed integer overflow
      ujson: writer: Return error when newline() fails
      ujson: writer: Check return value in ESC_FLUSH
      ujson: reader: Do not increment depth on overflow
      ujson: reader: Parse escape sequences in object IDs
      ujson: reader: Support files with zero lseek size
      ujson: reader: Reject \u0000 escape in strings
      ujson: writer: Set errno when a flush fails
      ujson: writer: Advance buffer on short write
      ujson: writer: Flush buffer before direct writes

 include/ujson_utf.h       |   6 +--
 libs/ujson/ujson_reader.c | 127 ++++++++++++++++++++++++++++++----------------
 libs/ujson/ujson_writer.c |  37 ++++++++++----
 3 files changed, 114 insertions(+), 56 deletions(-)
---
base-commit: 78e6353fdff663b2fc2f77704ceec6c3ca786b96
change-id: 20260925-fix_core_lib_deepseek-2ba9018c7588

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

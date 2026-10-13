Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129D1CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:04:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA5B43EA828
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:04:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94F9F3EA827
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41BC36008AE
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A473621E52;
 Tue, 13 Oct 2026 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sfufz7MNtqECHVF+6muwPVnHvoahcFOFBFkvNbGm+jk=;
 b=veu3qILPzV/8ty4Lf6ZxZ7WQ1cM1MO/DThaTlHVmwEo4JGqF7/KccQ1PUXPzCKjrfQaso7
 d/EjLlaD/DWgPFxBPDDL/DoKl1pqbSIoqNTywFJHDg7sMuEPwswqGx55CPpjF7KBY+koHR
 hH9rk0NF4Mh5BXB1LSReBJ5YDOKca4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sfufz7MNtqECHVF+6muwPVnHvoahcFOFBFkvNbGm+jk=;
 b=AdsAwFNJlqZhz9aOrpy9FEeoUJvqD0YtHSfYMxRsTgb/PXCYa6C1DiIGwhmj7yib8CwXex
 SbZgehFue1wUf8AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nH+ktwVg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TMwXPd1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sfufz7MNtqECHVF+6muwPVnHvoahcFOFBFkvNbGm+jk=;
 b=nH+ktwVgv5VN6kkayvXPUnqhrWBUAPeIyYtXwSd8plTfLrYBwrZpBHxGTcRNh0Qgi9FySB
 ZVuC5eeGOni1OCvc6t7yJN1fMotXqu3/auykDHh6Ndr/iffOK8TiyM6FHIHNJntB7DLAP7
 gVEWSdkChSxdPMVOCCPFuW/+QBrfQlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sfufz7MNtqECHVF+6muwPVnHvoahcFOFBFkvNbGm+jk=;
 b=TMwXPd1j73US3CXLACWSe8Yh9JYbk2+5lYDE95Ice9TPsMinf7w0455uxDlgtkPQYXkHWY
 VA6tgYRPnx4167AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63C8F13341;
 Tue, 13 Oct 2026 12:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:01:56 +0200
Message-Id: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALQdzmoC/3WNTQ6CMBgFr0K6tqYtosWV9zCE0PKQ+kNJPyAaw
 t0tuHY5ybw3MyMEB2LnZGYBkyPnuwhqlzDbVt0N3NWRmRLqKHKV8ca9S+sDyqczZQ30BDy4MlU
 upLanTGsWt31AFLffa/FjGs0ddljPVqN1NPjw2cKTXL2tIYX415gkF7yBTdODhYYWFxoJe+tfr
 FiW5Qsedg1DywAAAA==
X-Change-ID: 20260925-fix_core_lib_deepseek-2ba9018c7588
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=3495;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=CQ/r+bS62qZITgTodEYs0ghtW7YHK4+/rmHOOExNS/w=;
 b=eHu2/bPMsDa03N2mhYBBf0kvjLBGCSMT5LoqlZdyvmE1oradMeN8nK4GeNPzbpbl3rh8HcJBq
 54JkDcMIoKDDKjinT1g/nZRdkOaLDUJTBFiNvJZyhkX46r4mRFP0VAH
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A473621E52
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/15] Fix ujson bugs
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
- return UTF-8 length when calculating string size in ujson_reader
- combine UTF-16 surrogate pairs and reject lone surrogates
- check for signed integer overflow when parsing numbers
- fix error propagation when newline() fails in ujson_writer
- check output return values in esc_flush() helper
- unescape object IDs and reset type on error in ujson_reader
- reject empty and zero-sized files in ujson_reader_load()
- reject \u0000 escape sequences in string values
- set errno when a file flush fails in ujson_writer
- advance buffer pointer on short write in ujson_writer
- flush buffered data before direct writes in ujson_writer

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- ujson: reader: Prevent infinite loop on EOF: fail load on premature
  EOF instead of accepting truncated file.
- ujson: reader: Return UTF-8 length when !str: split out UTF-8 length
  calculation when !str into separate commit before surrogate handling.
- ujson: reader: Combine UTF-16 surrogate pairs: reorder checks to
  inspect unpaired low surrogates first.
- ujson: reader: Check for signed integer overflow: assign negative
  integers with -(long)val.
- ujson: writer: Check return value in esc_flush(): replace ESC_FLUSH
  macro with esc_flush() helper function and check return values.
- ujson: reader: Do not increment depth on overflow: dropped from
  series.
- ujson: reader: Parse escape sequences in object IDs: reset res->type
  to UJSON_VOID on key parsing failure.
- ujson: reader: Reject files with zero size: reject zero-sized and
  empty files in ujson_reader_load() instead of dynamic reallocation.
- ujson: writer: Set errno when a flush fails: distinguish ret == 0
  with a dedicated error message and errno = EAGAIN.
- ujson: writer: Flush buffer before direct writes: move !buf_len
  check into out_writer_file_write().
- Link to v1: https://lore.kernel.org/20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com

---
Andrea Cervesato (15):
      ujson: Fix 4-byte UTF-8 sequence decoding
      ujson: writer: Fix OOB read on invalid UTF-8
      ujson: reader: Prevent infinite loop on EOF
      ujson: writer: Fix open() return value check
      ujson: reader: Return UTF-8 length when !str
      ujson: reader: Combine UTF-16 surrogate pairs
      ujson: reader: Check for signed integer overflow
      ujson: writer: Return error when newline() fails
      ujson: writer: Check return value in esc_flush()
      ujson: reader: Parse escape sequences in object IDs
      ujson: reader: Reject files with zero size
      ujson: reader: Reject \u0000 escape in strings
      ujson: writer: Set errno when a flush fails
      ujson: writer: Advance buffer on short write
      ujson: writer: Flush buffer before direct writes

 include/ujson_utf.h       |   6 +--
 libs/ujson/ujson_reader.c | 101 ++++++++++++++++++++++++++++++++--------------
 libs/ujson/ujson_writer.c |  75 ++++++++++++++++++++++++----------
 3 files changed, 126 insertions(+), 56 deletions(-)
---
base-commit: 07da37cf3dbda876b33ad820168a33b9deacbddb
change-id: 20260925-fix_core_lib_deepseek-2ba9018c7588

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

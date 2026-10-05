Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F52CA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:28:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9FEA3E4E38
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:28:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 453333E6B50
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD9691A00706
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DE1B21E93;
 Mon,  5 Oct 2026 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKa9ZMZbDInLY2OPU/fbaMduMYC9z0ZLJxOqTz9CAlI=;
 b=iGyRAbF7PYtWFggZ107ehgSPxnAOkkD2xZQtJrtR4FxIdYCgPQ5EjdDTtAuUrJCAB/gsRw
 fKpcr/3N4ya0+9QfSUfHMLTj488RY66RFmPBvvPH9uYYdEMOW0+EADjQa0xiO7sRxo8rYE
 qO1Ei7Ha7VMVe2NKWnFuKJ3cmWJCG9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKa9ZMZbDInLY2OPU/fbaMduMYC9z0ZLJxOqTz9CAlI=;
 b=K69Wh+L+xSpqJsPtS4c3rZvHgR3yHu/0yIbieNAjLHhwtueiDmbLtCjQc5ZoGfT5Fleo6P
 VFyhTvLrETfl/8BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKa9ZMZbDInLY2OPU/fbaMduMYC9z0ZLJxOqTz9CAlI=;
 b=zLEUo1i6R3ip3cdtP6t16ISPTu884xnZhs3MCf3ZlqWDVQrt9tWf1IjVEj514stgiYTRGD
 1ZootecpvpvmLXz38wLjgtz1gSoYVyPRpGByIWW3JUyPU9NtQS/zHS5APZs6uOG24xS0wx
 MOcZdzwegkCNAHtK48YFCNCEf10nz4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKa9ZMZbDInLY2OPU/fbaMduMYC9z0ZLJxOqTz9CAlI=;
 b=KaPnu+ks9AE2nOFuVCkHwXGmbsmva1YfKi+F47qkFZFV8UhWGQvVQaqelhxzW05uCZbODZ
 QWV4aFRHIBL/gPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A7BB13AF5;
 Mon,  5 Oct 2026 13:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T14
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:41 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-13-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1114;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nULkpoGyY04J4dXPkzFFWzHLcZQXBYcTXPrvwnSLBEw=;
 b=ubbz8+9+CYoiPeoD64la3NsILjOZdDFry8qHgjftvPfGWDcmAgUnfpkAplRwXKmCnl+jC+rHZ
 kf0I9oWWeWdChWngDXvyZCFI4gWrlYBemyz/yz0t+GUW0j8iMXVr+Nu
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.11)[-0.555]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/15] ujson: writer: Set errno when a flush fails
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

ujson_writer_file_close() uses errno to decide whether flushing the
buffered data failed. out_writer_file_write() can fail without setting
errno, when write() returns 0 or more bytes than requested, so close
could report success even though data was lost. Set errno to EIO in
these cases.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index 15faca9be..49f73e436 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -399,11 +399,15 @@ static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ss
 		ssize_t ret = write(fd, buf, buf_len);
 		if (ret <= 0) {
 			err(self, "Failed to write to a file");
+			/* ujson_writer_file_close() relies on errno */
+			if (!ret)
+				errno = EIO;
 			return 1;
 		}
 
 		if (ret > buf_len) {
 			err(self, "Wrote more bytes than requested?!");
+			errno = EIO;
 			return 1;
 		}
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

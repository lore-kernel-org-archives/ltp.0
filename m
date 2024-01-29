Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBC7C47422
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 10:15:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91C053CE114
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 11:15:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 448F13C8E4D
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 11:14:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72571600691
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 11:14:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DB1A22045;
 Mon, 29 Jan 2024 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706523296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U8fGsatEoENC1/ZVCCb2a8ZMEVT4BHhsXnr14bifO4s=;
 b=mkqyyYI2ZnfCzFtnB231VjDvsmQ351VnSUkbxa4OJtu88+Vdvtqe+o4ZKd49ORl5oOWvsx
 Ewgnu/3c4+2QgnZvw6dAZCZVjKUk1wXrX8fw24CA7L9kMyBWMwXSMFRBg4LFjYpAh4qeSB
 eC/+sB+MaecKO/6q1GknHZjZjqRoEpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706523296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U8fGsatEoENC1/ZVCCb2a8ZMEVT4BHhsXnr14bifO4s=;
 b=3jv+fZNc+VsbUDM/YLRPFAjkOksQdzyRoaHzax4fNHU62oJkRNwdOr9Eid+1Qomoijhtg0
 Hu9ibFk1NXjK9aDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706523296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U8fGsatEoENC1/ZVCCb2a8ZMEVT4BHhsXnr14bifO4s=;
 b=mkqyyYI2ZnfCzFtnB231VjDvsmQ351VnSUkbxa4OJtu88+Vdvtqe+o4ZKd49ORl5oOWvsx
 Ewgnu/3c4+2QgnZvw6dAZCZVjKUk1wXrX8fw24CA7L9kMyBWMwXSMFRBg4LFjYpAh4qeSB
 eC/+sB+MaecKO/6q1GknHZjZjqRoEpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706523296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U8fGsatEoENC1/ZVCCb2a8ZMEVT4BHhsXnr14bifO4s=;
 b=3jv+fZNc+VsbUDM/YLRPFAjkOksQdzyRoaHzax4fNHU62oJkRNwdOr9Eid+1Qomoijhtg0
 Hu9ibFk1NXjK9aDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05C8412FF7;
 Mon, 29 Jan 2024 10:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bF0vNp96t2XheAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 29 Jan 2024 10:14:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 29 Jan 2024 11:14:48 +0100
Message-Id: <20240129101448.14463-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mkqyyYI2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3jv+fZNc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.40 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.09)[64.85%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 8DB1A22045
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix synchronization problem with dio tests
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

When system is really fast processing I/O syscalls, multiple childrean
running I/O operations might lock the parent, causing
tst_reap_childrean() to stuck. By adding a small usleep at the
end of the reading I/O operations, which are used by dio_append and
dio_read tests, we ensure that system has enough breath to end tests
correctly and to process children exit.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 200bbe18e..281072c3b 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -90,6 +90,8 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 			if (!*run_child || !tst_remaining_runtime())
 				goto exit;
 		}
+
+		usleep(100);
 	}
 
 exit:
@@ -121,6 +123,8 @@ static inline void io_read_eof(const char *filename, volatile int *run_child)
 				break;
 			}
 		}
+
+		usleep(100);
 	}
 
 	SAFE_CLOSE(fd);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

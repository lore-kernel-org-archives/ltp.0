Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1681090242
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 16:04:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 128A43C23AC
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 17:04:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D8903E490C
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:03:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BD5C600FBC
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:03:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5010E4D2AB;
 Thu, 19 Mar 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773936212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjmsJEDhdNVnfcZqajgQCQ9SQk1ok2KAI/+S+tNpFm0=;
 b=O6Mr/KrF5TrOkslPLy6DyZlsGPLBn+a+eV2hdV6Gdo6lyCdZ1RcUHI7UknVzsxUPLeVsmG
 cdaG+OcWHZ6Os+m2IdueC+nkbDYMP2W697U0zLKdDa+lUgKBJue+Hs/as/doTfXGMNRrl7
 FjrDPhyUKxuZtCGhi3JpsXBhyNkcP9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773936212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjmsJEDhdNVnfcZqajgQCQ9SQk1ok2KAI/+S+tNpFm0=;
 b=RoqDr/jro3HyQtDm2Y8fXL2M/wvCea7bcEMDEdv02DCU0hoVVapYj89T42Wh/DGbJzpl+u
 +viznMwOBLM91UAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773936212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjmsJEDhdNVnfcZqajgQCQ9SQk1ok2KAI/+S+tNpFm0=;
 b=O6Mr/KrF5TrOkslPLy6DyZlsGPLBn+a+eV2hdV6Gdo6lyCdZ1RcUHI7UknVzsxUPLeVsmG
 cdaG+OcWHZ6Os+m2IdueC+nkbDYMP2W697U0zLKdDa+lUgKBJue+Hs/as/doTfXGMNRrl7
 FjrDPhyUKxuZtCGhi3JpsXBhyNkcP9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773936212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjmsJEDhdNVnfcZqajgQCQ9SQk1ok2KAI/+S+tNpFm0=;
 b=RoqDr/jro3HyQtDm2Y8fXL2M/wvCea7bcEMDEdv02DCU0hoVVapYj89T42Wh/DGbJzpl+u
 +viznMwOBLM91UAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 348344273B;
 Thu, 19 Mar 2026 16:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nRSUClQevGnvWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Mar 2026 16:03:32 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 19 Mar 2026 17:03:17 +0100
Message-ID: <20260319160318.6867-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319160318.6867-1-chrubis@suse.cz>
References: <20260319160318.6867-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.975];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] runtest/ltp-aidio.part4: Remove dio_sparse
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

After a discussion we agreed that there is a sufficient coverage for
dio_sparse in ltp-aiodio.part2 already. There is no point in running
these tests again in part4.

CC: Jan Kara <jack@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltp-aiodio.part4 | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
index de00b8a78..5d3028bf5 100644
--- a/runtest/ltp-aiodio.part4
+++ b/runtest/ltp-aiodio.part4
@@ -1,38 +1,6 @@
 aio01 aio01
 aio02 aio02
 
-#Running dio_sparse & dirty tests
-DI000 dirty
-DS000 dio_sparse
-DI001 dirty
-DS001 dio_sparse
-DI002 dirty
-DS002 dio_sparse
-DI003 dirty
-DS003 dio_sparse
-DI004 dirty
-DS004 dio_sparse
-DI005 dirty
-DS005 dio_sparse
-DI006 dirty
-DS006 dio_sparse
-DI007 dirty
-DS007 dio_sparse
-DI008 dirty
-DS008 dio_sparse
-DI009 dirty
-DS009 dio_sparse
-#iteration on dio_sparse
-DIO00 dio_sparse
-DIO01 dio_sparse
-DIO02 dio_sparse
-DIO03 dio_sparse
-DIO04 dio_sparse
-DIO05 dio_sparse
-DIO06 dio_sparse
-DIO07 dio_sparse
-DIO08 dio_sparse
-DIO09 dio_sparse
 #Running aiodio_append
 AD000 aiodio_append
 AD001 aiodio_append
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

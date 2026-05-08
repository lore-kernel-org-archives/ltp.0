Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0ACCD342F
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 09:17:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA1463E2460
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 11:17:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D16D23E1F3A
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4811C1A00201
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E7CB5C489;
 Fri,  8 May 2026 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6O388E6quPOuUJohvTjCY3iY475jdv0vHUA4Uxri2I=;
 b=PDEEtkpLkvavdXtHbXQ2xhPXBLO67iREWms8552NUeDVZW8QFUwIqExwn++f4v1dHUPaag
 xq11WOZDjQMMpFtaoRClvCRJU4SD47+wPEwanXdUAzn8GWIqGIbn3N37ZR6npYBic6XREV
 rKp33oDDH1Ju8MYhZPrw23OCmgjEtCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6O388E6quPOuUJohvTjCY3iY475jdv0vHUA4Uxri2I=;
 b=3lDHRgFCDWQt+S2HEP6V6UxuUVoCUJXI0cgF4QUEEKkOT2yM1Ncpg+JEAv8tXkqsNy5Djp
 4mJfYQVJWIQr6tBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6O388E6quPOuUJohvTjCY3iY475jdv0vHUA4Uxri2I=;
 b=PDEEtkpLkvavdXtHbXQ2xhPXBLO67iREWms8552NUeDVZW8QFUwIqExwn++f4v1dHUPaag
 xq11WOZDjQMMpFtaoRClvCRJU4SD47+wPEwanXdUAzn8GWIqGIbn3N37ZR6npYBic6XREV
 rKp33oDDH1Ju8MYhZPrw23OCmgjEtCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6O388E6quPOuUJohvTjCY3iY475jdv0vHUA4Uxri2I=;
 b=3lDHRgFCDWQt+S2HEP6V6UxuUVoCUJXI0cgF4QUEEKkOT2yM1Ncpg+JEAv8tXkqsNy5Djp
 4mJfYQVJWIQr6tBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05E39593A7;
 Fri,  8 May 2026 09:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kOKSOy+q/WnsCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 May 2026 09:17:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 08 May 2026 11:17:35 +0200
MIME-Version: 1.0
Message-Id: <20260508-cve-2026-43284-v1-2-bf2549d2430d@suse.com>
References: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
In-Reply-To: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778231855; l=624;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=tTnBFL19es33ZqDzEK9PTS9QwrAl22zBfrgLdRsBHRE=;
 b=/hEHGRM570U6fSZSpw3KDjIRj9OIVRBnesMAjsTi27PeUCMFIE7IAhVX4S1r2TEbNcq6ik2cj
 nvZz3XiDv3ZBxhg31YSwwqkC8+jIKb5WOfZdTxM6PLPJvTsQ2uh19IF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] lapi: fallback UDP_ENCAP and UDP_ENCAP_ESPINUDP
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/udp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/lapi/udp.h b/include/lapi/udp.h
index 5c73dd36989c40c6dbb8b90d2f0c5bd8cd986b5d..93b24fc3ee984dc02c894cb1b5d6d0a40492d873 100644
--- a/include/lapi/udp.h
+++ b/include/lapi/udp.h
@@ -15,4 +15,12 @@
 # define UDPLITE_RECV_CSCOV   11 /* receiver partial coverage (threshold ) */
 #endif
 
+#ifndef UDP_ENCAP
+# define UDP_ENCAP 100
+#endif
+
+#ifndef UDP_ENCAP_ESPINUDP
+# define UDP_ENCAP_ESPINUDP 2
+#endif
+
 #endif	/* LAPI_UDP_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

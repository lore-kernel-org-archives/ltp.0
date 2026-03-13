Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74517105F79A
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:09:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A3383E23A3
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:09:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B04F3E52B2
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 25988600AC1
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F142D5BD72;
 Fri, 13 Mar 2026 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBbsIu8/rH+vvk5OWlxpnUWfAuUhUgEMfIC4uE/2WjY=;
 b=QxyB+38E4VcdqgMLRmmTi2QrqSH5CLBDWWKbr+CruEDGHc+RNpNuai/qb9ZSpUQkDO/itw
 WpUZ9bXd5DE+y+2v3RFuseFJGwko++Ax1Lv7DF84Z+vNYqDju+llZN2LFJiMw0HCRYVlad
 AtLEH2ensIW3Ojd2JWwUJcNNss+ArRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBbsIu8/rH+vvk5OWlxpnUWfAuUhUgEMfIC4uE/2WjY=;
 b=0M4WxLSi1PGVyoMkZiqjUb9Urp2/F3Qf0hxvVCivqYlgSutcS9FPuqxZFQw1wCoUSmE+/0
 NlcX0mNbLd5NBMDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBbsIu8/rH+vvk5OWlxpnUWfAuUhUgEMfIC4uE/2WjY=;
 b=1FlcFj74JxA2Wy+PiLDJFn62nfCECImsJM0uWeunAzhbgD0qPrcNiyHO4qxjSjYyzgU60c
 w03/zW4+tPkIMJ8aHof+T/FNxABwTSP0fWJDeoQq8c/ugPeE8oIIt9e1qjxiC9xsVhZsC2
 Pj6ynJ+/Di3K5fD85Wp9i4Jco9onc8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBbsIu8/rH+vvk5OWlxpnUWfAuUhUgEMfIC4uE/2WjY=;
 b=UUFXr6YzmgAF/KGiW+9TR1p7JXiH8VzgmN3YM+H5m1kPST+rrKZg4SkXF6Ij/IoMZpvFBz
 LZFBhWkBJVkryRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B12404BD;
 Fri, 13 Mar 2026 11:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YB5tMvHvs2ndbAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:07:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:07:29 +0100
MIME-Version: 1.0
Message-Id: <20260313-listns-v1-3-04ef0081a377@suse.com>
References: <20260313-listns-v1-0-04ef0081a377@suse.com>
In-Reply-To: <20260313-listns-v1-0-04ef0081a377@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773400049; l=592;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=MRVeWHEhjIxKQfE5p3YEttn7tSCII1EVWh723QEy2U0=;
 b=wn67cziFVU3Wa6/BCS0jdTG9jU78MxwAnQUW1HXfUDcI4sXECkgW0wGnZC9MkLQJP42i9OcqL
 GmreqmxrMMXB6kdZnvVfzBXEsQuYBhpzcthpWLivCLFzr8dvxBbVdnc
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] Add NS_GET_ID fallback
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
 include/lapi/ioctl_ns.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/lapi/ioctl_ns.h b/include/lapi/ioctl_ns.h
index 37fc5371681995fad5d955838b80153d5dd227f1..753c7657101a2c4442dfff9f36a15fc4cb5b6607 100644
--- a/include/lapi/ioctl_ns.h
+++ b/include/lapi/ioctl_ns.h
@@ -27,5 +27,8 @@
 #ifndef NS_GET_MNTNS_ID
 #define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, uint64_t)
 #endif
+#ifndef NS_GET_ID
+#define NS_GET_ID		_IOR(NSIO, 13, uint64_t)
+#endif
 
 #endif /* LAPI_IOCTL_NS_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

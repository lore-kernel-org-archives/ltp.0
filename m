Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F0FC28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 11:43:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE65C3CA3DD
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 12:43:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 378B63CA273
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:43:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C848600750
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:43:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 66D191F388;
 Fri, 28 Mar 2025 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAZ1VJWPyuQf2UtkBVrWzjLPu3q6f3Kr0Hu+FF8r53U=;
 b=d7Msjlgk6Ofkec6m3pVcbxjboNuGjszaLoj28qwJJhDYKvo18DrUuTqtTXrc/1k+DvVn8K
 5fmFjCAwi2r8LqAk0mmf76i1Is9yVStxWG7jga4CuwO4vLo9g+5e+JXIVi4a0pRPCQ2lrG
 +WQqe43/qWvnTXjaXRs8g3SnhSX/7Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAZ1VJWPyuQf2UtkBVrWzjLPu3q6f3Kr0Hu+FF8r53U=;
 b=Faeina/OWlRKnuv+L+wvhidEXJL2DgyYUgGQcfPMmkcKwOoUkMWV6dHYruN6ag03jlOcvq
 60TR7rS0mJNh0qBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAZ1VJWPyuQf2UtkBVrWzjLPu3q6f3Kr0Hu+FF8r53U=;
 b=d7Msjlgk6Ofkec6m3pVcbxjboNuGjszaLoj28qwJJhDYKvo18DrUuTqtTXrc/1k+DvVn8K
 5fmFjCAwi2r8LqAk0mmf76i1Is9yVStxWG7jga4CuwO4vLo9g+5e+JXIVi4a0pRPCQ2lrG
 +WQqe43/qWvnTXjaXRs8g3SnhSX/7Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAZ1VJWPyuQf2UtkBVrWzjLPu3q6f3Kr0Hu+FF8r53U=;
 b=Faeina/OWlRKnuv+L+wvhidEXJL2DgyYUgGQcfPMmkcKwOoUkMWV6dHYruN6ag03jlOcvq
 60TR7rS0mJNh0qBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFE9713A64;
 Fri, 28 Mar 2025 11:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EB2CN1aL5mdqQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 11:43:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 12:43:10 +0100
Message-ID: <20250328114311.187541-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328114311.187541-1-pvorel@suse.cz>
References: <20250328114311.187541-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 1/2] libs: Add safe_get_nodemap()
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

This requires to add also tst_numa_type_name().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_numa.h   | 41 +++++++++++++++++++++++++++++++++++++++--
 libs/numa/tst_numa.c | 14 ++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/tst_numa.h b/include/tst_numa.h
index a1f9616300..191a57fa6b 100644
--- a/include/tst_numa.h
+++ b/include/tst_numa.h
@@ -106,8 +106,30 @@ enum tst_numa_types {
 };
 
 /**
- * tst_get_nodemap() - Allocates and returns numa node map, which is an array of numa nodes which
- * contain desired resources e.g. memory.
+ * tst_numa_type_name() - Convert enum tst_numa_types to a description of a NUMA type.
+ *
+ * @type Bitflags of enum tst_numa_types specifying desired resources.
+ *
+ * @return a string describing a NUMA type.
+ */
+static inline const char *tst_numa_type_name(int type)
+{
+	if (type & ~(TST_NUMA_MEM))
+		tst_brk(TBROK, "Invalid type %i\n", type);
+
+	switch (type) {
+	case TST_NUMA_MEM:
+		return " memory";
+	case TST_NUMA_ANY:
+		return "";
+	default:
+		return " unknown";
+	}
+}
+
+/**
+ * tst_get_nodemap() - Allocates and returns numa node map, which is an array of
+ * NUMA nodes which contain desired resources e.g. memory.
  *
  * @type:       Bitflags of enum tst_numa_types specifying desired resources.
  * @min_mem_kb: Minimal free RAM on memory nodes, if given node has less than
@@ -119,4 +141,19 @@ enum tst_numa_types {
  */
 struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
 
+/**
+ * safe_get_nodemap() - Calls tst_get_nodemap() with check for minimal required
+ * NUMA nodes. Call tst_brk(TCONF) if not enough NUMA nodes.
+ *
+ * @type:       Bitflags of enum tst_numa_types specifying desired resources.
+ * @min_mem_kb: Minimal free RAM on memory nodes, if given node has less than
+ *             requested amount of free+buffers memory it's not included in
+ *             the resulting list of nodes.
+ * @required:   Minimal number of a required NUMA nodes.
+ *
+ * return: On success returns allocated and initialized struct tst_nodemap which contains
+ *         array of numa node ids that contains desired resources.
+ */
+struct tst_nodemap *safe_get_nodemap(int type, size_t min_mem_kb, size_t required);
+
 #endif /* TST_NUMA_H__ */
diff --git a/libs/numa/tst_numa.c b/libs/numa/tst_numa.c
index c3297013be..f004e29014 100644
--- a/libs/numa/tst_numa.c
+++ b/libs/numa/tst_numa.c
@@ -221,4 +221,18 @@ struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb)
 	return nodes;
 }
 
+struct tst_nodemap *safe_get_nodemap(int type, size_t min_mem_kb, size_t required)
+{
+	struct tst_nodemap *nodes;
+
+	nodes = tst_get_nodemap(type, min_mem_kb);
+
+	if (nodes->cnt < required) {
+		tst_brk(TCONF, "Test requires at least %zi NUMA%s node%s",
+				required, tst_numa_type_name(type), required > 1 ? "s" : "");
+	}
+
+	return nodes;
+}
+
 #endif
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

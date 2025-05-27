Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BE1C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44ACC3C5788
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 12:55:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22D5B3C5788
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:54:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B159C1400332
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:54:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5AE021EB6;
 Tue, 27 May 2025 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjdbQy4TBJj3L6uH2kX2fThdGYDTY/yThCTiuGTCR5U=;
 b=EJufLMHvR2GTu1zqQhRSWeAGXWkTrKj2epSziiSq/LaI7s475vzURsPiC63xoeiPrT8h8N
 NvBzlyg5YzRzd/OUnrWAO4llYSJjzQAcDckAEc0Gx06iqcta4IpWovkxIk/7KXRZhnobXr
 wFpZ8TinLZN2KbRXguX97VOG8OOeKPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjdbQy4TBJj3L6uH2kX2fThdGYDTY/yThCTiuGTCR5U=;
 b=HO9XpAKbJWKtuOwj2ZJTXfIF7wjpdiHOQgFST+EopAd1aaD9vaGxGttVlYUPjnH3WsC7fd
 z6jsrooCgyNATHCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjdbQy4TBJj3L6uH2kX2fThdGYDTY/yThCTiuGTCR5U=;
 b=yFoMyuCHpCHcgrpqAvdfBWbNtr1qWtsSoP15EmOA5qj0Ifz8msamarEZXQKtLNAS3JhB4r
 W4zswBPefiAlUf6ha7+Ncdo6Q6D3MLniNFGikYHLTApWTmGmVw5gyav47T1UuAUcXKEHWI
 N2i05Cq/T9f2kQeViS8kztdafoHD+PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjdbQy4TBJj3L6uH2kX2fThdGYDTY/yThCTiuGTCR5U=;
 b=Rwb2M/tSh7+PqG+7tfBvLoWda8xi3tJf1H7LYNwpooLQhasD5L1CzdaqRTEeSUmBsyD4oF
 JeUfMWp21Y7n8tCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D32613A62;
 Tue, 27 May 2025 10:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IG58IviZNWihdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 May 2025 10:54:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 27 May 2025 12:54:37 +0200
MIME-Version: 1.0
Message-Id: <20250527-landlock_unix_socket-v4-1-80d3d579094b@suse.com>
References: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
In-Reply-To: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748343288; l=1824;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=djlfNKJeXRBdXG8bxC1T3GXTH5Ws1RpcGTK7pGzPp9U=;
 b=7k4xCIgmS6gvhKxDbFi/IpzmuildfcQEfzezDUUoSkqbZaWfUAGvDlHd3Z2RMi/1sATtcrqjN
 MspMUFgNMRjDo6hLxJxBcJn37HvxiRD8OIhTlX0MRKnSaqEHAiDHPsv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-1.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] Add landlock ABI v6 fallback
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

The new ABI v6 is defining the following IPC scoped operations:

* LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
* LANDLOCK_SCOPE_SIGNAL

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/landlock.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
index b3c8c548e661680541cdf6e4a8fb68a3f5029fec..e579500ec26cdc0a568620bc35386f3d2b68952e 100644
--- a/include/lapi/landlock.h
+++ b/include/lapi/landlock.h
@@ -15,15 +15,19 @@
 
 #include "lapi/syscalls.h"
 
-struct tst_landlock_ruleset_attr_abi1
-{
+struct tst_landlock_ruleset_attr_abi1 {
 	uint64_t handled_access_fs;
 };
 
-struct tst_landlock_ruleset_attr_abi4
-{
+struct tst_landlock_ruleset_attr_abi4 {
+	uint64_t handled_access_fs;
+	uint64_t handled_access_net;
+};
+
+struct tst_landlock_ruleset_attr_abi6 {
 	uint64_t handled_access_fs;
 	uint64_t handled_access_net;
+	uint64_t scoped;
 };
 
 #ifndef HAVE_STRUCT_LANDLOCK_PATH_BENEATH_ATTR
@@ -43,8 +47,7 @@ struct landlock_path_beneath_attr
 #endif
 
 #ifndef HAVE_STRUCT_LANDLOCK_NET_PORT_ATTR
-struct landlock_net_port_attr
-{
+struct landlock_net_port_attr {
 	uint64_t allowed_access;
 	uint64_t port;
 };
@@ -126,6 +129,14 @@ struct landlock_net_port_attr
 # define LANDLOCK_ACCESS_NET_CONNECT_TCP	(1ULL << 1)
 #endif
 
+#ifndef LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
+# define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
+#endif
+
+#ifndef LANDLOCK_SCOPE_SIGNAL
+# define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
+#endif
+
 static inline int safe_landlock_create_ruleset(const char *file, const int lineno,
 	const void *attr, size_t size , uint32_t flags)
 {

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

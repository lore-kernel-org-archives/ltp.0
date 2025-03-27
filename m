Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7056AC3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:08:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3E4C3C9E4E
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:08:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EB553C9E4E
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:07 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 842D61A00CA1
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97BA42118D;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvUQHcSozB+zOt6mB8bODDVnq78tfGNw/yH06ACUh8w=;
 b=cUUMWrsxO2GKpvSHgu5hQWJaMesQ4PyfxkyHfmPRj7BsYWyxlXUJdRoXBgFP68awOaLXqP
 uX+QFGcmYK1I1gM59m1T6zubNwK2AbygidQ9z1BheNkiokCYhHHyt0S/BWCtNUKfIt4m7U
 gZmavB31zpIHBqcfoSgxY7zX3nZZfSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvUQHcSozB+zOt6mB8bODDVnq78tfGNw/yH06ACUh8w=;
 b=+/aElBS/BQTc3DyoyN9CDp3Gw91KkyF5N+jv3rOKxJ/JlQ3e3rw0WWOennEUsxIRpvy2ed
 NuW1TDXm8aCvMGCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cUUMWrsx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="+/aElBS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvUQHcSozB+zOt6mB8bODDVnq78tfGNw/yH06ACUh8w=;
 b=cUUMWrsxO2GKpvSHgu5hQWJaMesQ4PyfxkyHfmPRj7BsYWyxlXUJdRoXBgFP68awOaLXqP
 uX+QFGcmYK1I1gM59m1T6zubNwK2AbygidQ9z1BheNkiokCYhHHyt0S/BWCtNUKfIt4m7U
 gZmavB31zpIHBqcfoSgxY7zX3nZZfSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvUQHcSozB+zOt6mB8bODDVnq78tfGNw/yH06ACUh8w=;
 b=+/aElBS/BQTc3DyoyN9CDp3Gw91KkyF5N+jv3rOKxJ/JlQ3e3rw0WWOennEUsxIRpvy2ed
 NuW1TDXm8aCvMGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CC0E13A41;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iKLMHJAx5WfnIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Mar 2025 11:08:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Mar 2025 12:07:58 +0100
MIME-Version: 1.0
Message-Id: <20250327-landlock_unix_socket-v1-1-584653f66d9c@suse.com>
References: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
In-Reply-To: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743073680; l=1779;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=nOa9D+DVtoslbc/Bi/pHsfU8GXzOiAgGa7KEfCOPzvE=;
 b=5yRcRZANnto+EyWVuw8V/ItwMNiJrseqIhsjKIororrQovQ9xJFT+SWFoiQs/GAcI9uuFEYNm
 89gk/0LgLSVDlttT2heQsH4fS7Bc+gpIk2p5s3I8rLaad5CZ8ZNqdWB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 97BA42118D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] Add landlock ABI v6 fallback
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

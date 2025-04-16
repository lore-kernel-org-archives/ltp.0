Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98B3C369C2
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 12:19:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 063083CB972
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 14:19:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292A83CB5B0
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 14:19:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F0B4E100014B
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 14:19:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3457D211A8;
 Wed, 16 Apr 2025 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744805954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8dwMt/EbA+bF/jbdSyIJzH7he3sY5UuTkjPWhZBogJQ=;
 b=NNY2cyxfSllsOVUQCHMbfeQehCKbf7bd5l5Bz5TXu/CxzrN735W+8xSCpAz9GCB+WNslz9
 twauudP4iYSokJ3jBU2iIzg9SBrsqXVJ75lszl8R1dgxZ1psonL06uIBabJPu0GEIxmkQn
 WMIgjvl+rbODq1618o1ROe3hTNKDr4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744805954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8dwMt/EbA+bF/jbdSyIJzH7he3sY5UuTkjPWhZBogJQ=;
 b=dFCkwP9iQDcjnB7YnhFPszXn58YjRp6EPMib8HNrlmhRPCzipTUQxiHyymSytJaNws0G7R
 ylzUaF/mQuUeriCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="QuUHh/E9";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nrg+JEj4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744805953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8dwMt/EbA+bF/jbdSyIJzH7he3sY5UuTkjPWhZBogJQ=;
 b=QuUHh/E99WgxFGQ1jwJlZ4HRYTWW7KQjmC97etRzQ6ab2Vn7IHsAFy0BBDgpXfWwF2H3C/
 SBHslp6JfywJi1H6ZO+hVU3MNDC8mvBWewdKDzOTUeLpJmaB3Ym1FiyKtbQzp718/igFl1
 pgWXjEFsCXD9Hs1VUQMCQ8mNHIsIEkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744805953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8dwMt/EbA+bF/jbdSyIJzH7he3sY5UuTkjPWhZBogJQ=;
 b=Nrg+JEj4g+Je7STTSB8tH1F/gt0Mkf66PR/OEFVzNaeGjCyxeWUf5zpQ5kaJXDSQWUulbB
 /xpev1cuoO9AroBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18270139A1;
 Wed, 16 Apr 2025 12:19:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gnIFBEGg/2crJgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 16 Apr 2025 12:19:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 16 Apr 2025 14:19:12 +0200
MIME-Version: 1.0
Message-Id: <20250416-fix_docs_stats-v1-1-2423b7602690@suse.com>
X-B4-Tracking: v=1; b=H4sIAD+g/2cC/x2MQQqAIBAAvxJ7TtAwsb4SIaJb7aXClQjEvycdB
 2amAGMiZJi7AgkfYrrOBqrvIBz+3FFQbAyDHEaplREbvS5egR1nn1loI62V0esJDbToTtiMf7i
 stX6fHrdoYAAAAA==
X-Change-ID: 20250416-fix_docs_stats-460880da49e6
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744805953; l=1892;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MKELJGIMbDd5+Uq6IzgOX4Bo9qb/lMfLfvZjmfb1fa8=;
 b=RHJVSHRanCdw4hOeenHuu2NYNwbPXtLFgBOx4MEfGQrbfF31jd4MWPu3WL4e56sDt5xaEhubG
 gG5IzISRWRdBTLhMpkCYCBvxlggryF+4hfrPWdhFiqtLZfCtPvdyyC3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 3457D211A8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: fix stats page
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

In the last documentation builds we faced syscalls file download error.
In particular, git.kernel.org communication started to fail with 403.
The reason seems to be realted to the server configuration, that is now
requiring a specific User-Agent. Set User-Agent to 'curl/8.6.0' to avoid
this issue.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Fix the following error during 'make':

	WARNING: Can't download syscall_n64.tbl from kernel sources (HTTP Error 403: Forbidden)
---
 doc/conf.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 8cc890fcc8d0650aac82adabbbd434c55c7b8ad3..23fe7a1b9742f604a5b97f0db62b29ed9c64c445 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -126,8 +126,18 @@ def generate_syscalls_stats(_):
     error = False
     try:
         socket.setdefaulttimeout(3)
-        urllib.request.urlretrieve(
-            f"{syscalls_url}/syscall_n64.tbl", "syscalls.tbl")
+
+        # kernel.org doesn't always allow to download syscalls file, so we need
+        # to emulate a different client in order to download it. Browser
+        # emulation might fail due to captcha request and for this reason we
+        # use the 'curl' command instead
+        req = urllib.request.Request(
+            f"{syscalls_url}/syscall_n64.tbl",
+            headers={'User-Agent': 'curl/8.6.0'})
+
+        with urllib.request.urlopen(req) as response:
+            with open("syscalls.tbl", 'wb') as out_file:
+                out_file.write(response.read())
     except urllib.error.URLError as err:
         error = True
         logger = sphinx.util.logging.getLogger(__name__)

---
base-commit: 8e0d3347944b2044a198ddd69d4be186fcda65ef
change-id: 20250416-fix_docs_stats-460880da49e6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

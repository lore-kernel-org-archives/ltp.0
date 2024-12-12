Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B56E7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 10:33:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5A923E88A3
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 11:33:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88A4B3E8891
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 11:33:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9827F65BAF9
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 11:33:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2951F46E
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733999590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bmlSUPFbFh22PNDLoHbcCq/EIIcrDWaUfh3GSaKnRk=;
 b=KaiYgvEgd86OyHmivY74f2LGTFRFP+WswRw/tIaE1n1PFoXA1rNz60OlM2UKW7lw2HgkB1
 OdssMR8h+uLrCm/9ffcmngCP6Y87NFEIhsqNVycJyR8mF1qEVUp9n4cq7yEstCRK3x888c
 cZnMp9LGLRW5CcWnOEBgOFNPvr7LR/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733999590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bmlSUPFbFh22PNDLoHbcCq/EIIcrDWaUfh3GSaKnRk=;
 b=CXgTluMg+qIZEPYe0pxT00++UX5ERSvy3Wt8D77dd22W/MtwtmOjsFxy4pXdcz3CsF+HG+
 aJKavK7mM+dxyzAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KaiYgvEg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CXgTluMg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733999590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bmlSUPFbFh22PNDLoHbcCq/EIIcrDWaUfh3GSaKnRk=;
 b=KaiYgvEgd86OyHmivY74f2LGTFRFP+WswRw/tIaE1n1PFoXA1rNz60OlM2UKW7lw2HgkB1
 OdssMR8h+uLrCm/9ffcmngCP6Y87NFEIhsqNVycJyR8mF1qEVUp9n4cq7yEstCRK3x888c
 cZnMp9LGLRW5CcWnOEBgOFNPvr7LR/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733999590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bmlSUPFbFh22PNDLoHbcCq/EIIcrDWaUfh3GSaKnRk=;
 b=CXgTluMg+qIZEPYe0pxT00++UX5ERSvy3Wt8D77dd22W/MtwtmOjsFxy4pXdcz3CsF+HG+
 aJKavK7mM+dxyzAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4874013A3D
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wAucC+a7WmcuJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 12 Dec 2024 11:33:07 +0100
MIME-Version: 1.0
Message-Id: <20241212-doc_syscalls_link-v1-1-69a916958ba9@suse.com>
References: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
In-Reply-To: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733999589; l=4422;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=94/BF1k5qigMdj89QYshuXbAhF2vjwgX8ynRCBMqy8g=;
 b=ox5AiGIQSqyexZ1Nyr3jCHvk3v2kkinJmnj2EOnPPN0nmxkNme8KT/iPQv2x5FqQe6c2Zhv3M
 dobIl6NEsx0BuUVLRC7rbu0eWsH7P5iFabG2Ms+E1w+miTrbSwOAUNH
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 8B2951F46E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] doc: cleanup conf.py script
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

Cleanup code in the documentation building script which is using
bad patters and overcomplicating certain parts of the code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 789a0db6e726dba450d4089477ffe3d9a5b0a69f..1c6a7f74c9401842c01f33dd34a5171d5328248c 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -5,9 +5,9 @@
 
 import os
 import re
-import sphinx
 import socket
 import urllib.request
+import sphinx
 
 # -- Project information -----------------------------------------------------
 # https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information
@@ -116,19 +116,19 @@ def generate_syscalls_stats(_):
     ]
 
     # fetch syscalls file
+    syscalls_url = "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/arch/mips/kernel/syscalls"
     error = False
     try:
         socket.setdefaulttimeout(3)
         urllib.request.urlretrieve(
-            "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/arch/mips/kernel/syscalls/syscall_n64.tbl",
-            "syscalls.tbl")
-    except Exception as err:
+            f"{syscalls_url}/syscall_n64.tbl", "syscalls.tbl")
+    except urllib.error.URLError as err:
         error = True
         logger = sphinx.util.logging.getLogger(__name__)
-        msg = "Can't download syscall_n64.tbl from kernel sources"
+        msg = f"Can't download syscall_n64.tbl from kernel sources ({err})"
         logger.warning(msg)
 
-        with open(output, 'w+') as stats:
+        with open(output, 'w+', encoding='utf-8') as stats:
             stats.write(f".. warning::\n\n    {msg}")
 
     if error:
@@ -142,7 +142,7 @@ def generate_syscalls_stats(_):
     # collect all available kernel syscalls
     regexp = re.compile(r'\d+\s+n64\s+(?P<syscall>\w+)\s+\w+')
     ker_syscalls = []
-    with open("syscalls.tbl", 'r') as data:
+    with open("syscalls.tbl", 'r', encoding='utf-8') as data:
         for line in data:
             match = regexp.search(line)
             if match:
@@ -150,7 +150,7 @@ def generate_syscalls_stats(_):
 
     # collect all LTP tested syscalls
     ltp_syscalls = []
-    for root, _, files in os.walk('../testcases/kernel/syscalls'):
+    for _, _, files in os.walk('../testcases/kernel/syscalls'):
         for myfile in files:
             if myfile.endswith('.c'):
                 ltp_syscalls.append(myfile)
@@ -196,41 +196,47 @@ def generate_syscalls_stats(_):
         '    :header-rows: 0\n\n',
     ]
 
+    max_columns = 3
+
     for sysname, tested in syscalls.items():
         if tested:
-            if (index_tested % 3) == 0:
+            if (index_tested % max_columns) == 0:
                 table_tested.append(f'    * - {sysname}\n')
             else:
                 table_tested.append(f'      - {sysname}\n')
 
             index_tested += 1
         else:
-            if (index_untest % 3) == 0:
+            if (index_untest % max_columns) == 0:
                 table_untest.append(f'    * - {sysname}\n')
             else:
                 table_untest.append(f'      - {sysname}\n')
 
             index_untest += 1
 
-    left = index_tested % 3
+    left = index_tested % max_columns
     if left > 0:
-        for index in range(0, 3 - left):
-            table_tested.append(f'      -\n')
+        for _ in range(0, max_columns - left):
+            table_tested.append('      -\n')
 
-    left = index_untest % 3
+    left = index_untest % max_columns
     if left > 0:
-        for index in range(0, 3 - left):
-            table_untest.append(f'      -\n')
+        for _ in range(0, max_columns - left):
+            table_untest.append('      -\n')
 
     text.extend(table_tested)
     text.append('\n')
     text.extend(table_untest)
 
     # write the file
-    with open(output, 'w+') as stats:
+    with open(output, 'w+', encoding='utf-8') as stats:
         stats.writelines(text)
 
 
 def setup(app):
+    """
+    Setup the current documentation, using self generated data and graphics
+    customizations.
+    """
     app.add_css_file('custom.css')
     app.connect('builder-inited', generate_syscalls_stats)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

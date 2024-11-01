Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B51E6B240
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:50:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A535A3CD2E9
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 11:50:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A082B3CD2D5
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:49:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE7E722B43A
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:49:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AE1221CF0
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33DcN4kNBUeh53nZToc6rba5sMRr32zP+u+zuz5fc9E=;
 b=P4CY/rqP+Fcf3R7G3dFhNQEZjQjYXQDsXhBbefCJqxGhbMJztPpUdCGw7zsVM1A8lzXA9p
 GvNeyhA3PFlgfmJin3/Y9QGm6xehBoGk1YVzwQjIV5advbqMbL8h7uMlWGn4H4CmYjLXmX
 71PBbFUMcWlOJCSH/dZLVSnRrlAaxjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33DcN4kNBUeh53nZToc6rba5sMRr32zP+u+zuz5fc9E=;
 b=u7CQtcoA8ESeriCPZSm/RuEkZQFhmWzWLnOv1SHn2IdeCF2ZgrI/Us477y/s7gYGWeR65L
 oXMMwRq3QTsuk7DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="P4CY/rqP";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u7CQtcoA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33DcN4kNBUeh53nZToc6rba5sMRr32zP+u+zuz5fc9E=;
 b=P4CY/rqP+Fcf3R7G3dFhNQEZjQjYXQDsXhBbefCJqxGhbMJztPpUdCGw7zsVM1A8lzXA9p
 GvNeyhA3PFlgfmJin3/Y9QGm6xehBoGk1YVzwQjIV5advbqMbL8h7uMlWGn4H4CmYjLXmX
 71PBbFUMcWlOJCSH/dZLVSnRrlAaxjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33DcN4kNBUeh53nZToc6rba5sMRr32zP+u+zuz5fc9E=;
 b=u7CQtcoA8ESeriCPZSm/RuEkZQFhmWzWLnOv1SHn2IdeCF2ZgrI/Us477y/s7gYGWeR65L
 oXMMwRq3QTsuk7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B35ED13ACC
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wC2nJCCyJGcIUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 10:49:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 01 Nov 2024 11:48:30 +0100
MIME-Version: 1.0
Message-Id: <20241101-generate_syscalls-v9-5-d2c3820b0323@suse.com>
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
In-Reply-To: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730458133; l=2704;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=L7Ef9mVBu4HRbNe5X/13Lyb6azdXiQGa+UAwLBZ0Sxw=;
 b=ZOCb2fA7cH7is2CTRcQdYxuWbOabNbyPxArFxQ49MkxDHM3Cb6sgKZ2Lw2QOQKCrMFVMGKwuR
 ztZC0gVui5zADJVNDNC2HY6YK9HlB2ZhhiS1Husi2udiVeDKsinZy1I
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 9AE1221CF0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 5/5] Add documentation about syscalls.h generator
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
 doc/developers/test_case_tutorial.rst | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index be9a0ea8bac1d690b4ed4879d110f87c3f2a381a..97f385e5853a9041ac3e5ded7fb99e8355d84742 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -302,24 +302,27 @@ for a distribution's C library version to be older than its kernel or it may use
 cut down C library in comparison to the GNU one. So we must call ``statx()``
 using the general ``syscall()`` interface.
 
-The LTP contains a library for dealing with the ``syscall`` interface, which is
+LTP contains a library for dealing with the ``syscall`` interface, which is
 located in :master:`include/lapi`. System call numbers are listed against the relevant
 call in the ``*.in`` files (e.g. ``x86_64.in``) which are used to generate
-``syscalls.h``, which is the header you should include. On rare occasions you
-may find the system call number is missing from the ``*.in`` files and will need
-to add it (see :master:`include/lapi/syscalls/strip_syscall.awk`).
-
+``syscalls.h``, the header you should include.
 System call numbers vary between architectures, hence there are multiple
-``*.in`` files for each architecture. You can find the various values for the
-``statx`` system call across a number of ``unistd.h`` files in the Linux kernel.
+``*.in`` files for each architecture.
+
+On rare occasions, you may find that system call number is missing from ``*.in``
+files. In these cases, they will need to be updated using
+:master:`include/lapi/syscalls/generate_arch.sh` script as following:
+
+.. code-block:: bash
+
+    $ include/lapi/syscalls/generate_arch.sh /path/to/Linux/sources
 
-Note that we don't use the system-call-identifier value available in
-``/usr/include/linux/uinstd.h`` because the kernel might be much newer than the
-user land development packages.
+The script will generate all the needed ``*.in`` files accordingly to the Linux
+source code which has been used. Make sure that your Linux source code has
+been updated to the latest version.
 
-For ``statx`` we had to add ``statx 332`` to :master:`include/lapi/syscalls/x86_64.in`,
-``statx 383`` to :master:`include/lapi/syscalls/powerpc.in`, etc.  Now lets look at
-the code, which I will explain in more detail further down.
+Once the new syscalls files have been updated, to rebuild our ``syscalls.h``
+file, please re-run ``./configure`` script.
 
 .. code-block:: c
 

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

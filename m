Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E26D767DF
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 16:01:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6969E3CC39D
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 17:01:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0352F3CBCC1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:01:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 384C910338F8
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:01:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D35AD1FC0D
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730390471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiN7MmbmKOXBZoM3hrYgvl9qvrKK1URIbuaj05lmFYg=;
 b=JehbIN7uKMGFr8QBy6vUFiamRI9FcufTzrQXovlG7pljst9J2qhwragzU1m4GRER/i3l4t
 t8cW8IOoZ1HnDYskEEayOrPqTiHyd6fpR5Ayu6m3ySpMsSKNQPsER1nsALcaTeiw4htril
 FJ/4r2Rvj7SCaZpMnYKjWw2sbuMiBUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730390471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiN7MmbmKOXBZoM3hrYgvl9qvrKK1URIbuaj05lmFYg=;
 b=7NsEzWON6w1J3Ri8InuTukhgbcne6nc20y0bIvm0GWTPRAUhjwZZjKiUYf70LVEpHCy3/L
 u3481r5rULmjABDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JehbIN7u;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7NsEzWON
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730390471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiN7MmbmKOXBZoM3hrYgvl9qvrKK1URIbuaj05lmFYg=;
 b=JehbIN7uKMGFr8QBy6vUFiamRI9FcufTzrQXovlG7pljst9J2qhwragzU1m4GRER/i3l4t
 t8cW8IOoZ1HnDYskEEayOrPqTiHyd6fpR5Ayu6m3ySpMsSKNQPsER1nsALcaTeiw4htril
 FJ/4r2Rvj7SCaZpMnYKjWw2sbuMiBUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730390471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiN7MmbmKOXBZoM3hrYgvl9qvrKK1URIbuaj05lmFYg=;
 b=7NsEzWON6w1J3Ri8InuTukhgbcne6nc20y0bIvm0GWTPRAUhjwZZjKiUYf70LVEpHCy3/L
 u3481r5rULmjABDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACE3113A53
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 16:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YOX2J8epI2eNLAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 16:01:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 31 Oct 2024 17:01:10 +0100
MIME-Version: 1.0
Message-Id: <20241031-generate_syscalls-v8-4-8e35a9d6783b@suse.com>
References: <20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com>
In-Reply-To: <20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730390470; l=2647;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=3XQkoRbEpDQSeykAdArghNEG6x1l25QJsrILZcYybpo=;
 b=Zp6j7mL1Fu8Ryn6Cj6yD1MRFS8ZzSFZrPQtbZlxi15ysOQ/UUn8YtpAcPpELsEyvc0ZQOqRtO
 9FI6IkLTG77D4cgp4FFmge5gpm4M+wjRc8oCgkyA+1t1OlK6UCzXPqw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: D35AD1FC0D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 4/4] Add documentation about syscalls.h generator
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
 doc/developers/test_case_tutorial.rst | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index be9a0ea8bac1d690b4ed4879d110f87c3f2a381a..b48ea4a7a3594266466fcca364f5d0ff1e42d235 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -302,24 +302,25 @@ for a distribution's C library version to be older than its kernel or it may use
 cut down C library in comparison to the GNU one. So we must call ``statx()``
 using the general ``syscall()`` interface.
 
-The LTP contains a library for dealing with the ``syscall`` interface, which is
+LTP contains a library for dealing with the ``syscall`` interface, which is
 located in :master:`include/lapi`. System call numbers are listed against the relevant
 call in the ``*.in`` files (e.g. ``x86_64.in``) which are used to generate
-``syscalls.h``, which is the header you should include. On rare occasions you
-may find the system call number is missing from the ``*.in`` files and will need
-to add it (see :master:`include/lapi/syscalls/strip_syscall.awk`).
+``syscalls.h``, the header you should include.
 
-System call numbers vary between architectures, hence there are multiple
-``*.in`` files for each architecture. You can find the various values for the
-``statx`` system call across a number of ``unistd.h`` files in the Linux kernel.
+On rare occasions, you may find that system call number is missing from ``*.in``
+files. In these cases, they will need to be updated using
+`include/lapi/syscalls/generate_arch.sh` script as following:
 
-Note that we don't use the system-call-identifier value available in
-``/usr/include/linux/uinstd.h`` because the kernel might be much newer than the
-user land development packages.
+.. code-block:: bash
+
+    $ include/lapi/syscalls/generate_arch.sh /path/of/linux/sources
+
+The script will generate all the needed ``*.in`` files according to the Linux
+source code which has been used. Make sure that your Linux source code has
+been updated to the latest version.
 
-For ``statx`` we had to add ``statx 332`` to :master:`include/lapi/syscalls/x86_64.in`,
-``statx 383`` to :master:`include/lapi/syscalls/powerpc.in`, etc.  Now lets look at
-the code, which I will explain in more detail further down.
+Once the new syscalls files have been updated, to rebuild our ``syscalls.h``
+file, please use ``./configure`` command.
 
 .. code-block:: c
 

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

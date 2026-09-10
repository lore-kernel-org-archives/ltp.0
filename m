Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC727C79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:35:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43B4E3E72B9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:35:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B45B63E4863
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF5DA140098E
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEB7B1FDC0;
 Thu, 10 Sep 2026 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IcAdJqqWSHIzx/irRyvw93Kdb2ag8InMaMfEEyOIc=;
 b=XBzGqJ05kpu/i2jE6yU+60jK2buXbmVfzlglx9L+qk2HxpeN1KJk2OWZ26Bp0JczldD+B9
 /sFJFKIFbrln5rmnA7+eKkAUCqznax91Rl6EeR0wxDu4lHBuJjT0ooJc2APoWnnUg7474L
 U1Pyo2qF9115ogs1Rs1cZHZXKDFSeXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IcAdJqqWSHIzx/irRyvw93Kdb2ag8InMaMfEEyOIc=;
 b=Kyb1pkdTyPf5Ii8ATSLlCsxceyVhBsoskLTAJNxvTAsVUglkaCVXYvlt5/YTwm8OCr3k9W
 l6feTZ/l7YWb1YAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EUU5AAj6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="gN/ZzITS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IcAdJqqWSHIzx/irRyvw93Kdb2ag8InMaMfEEyOIc=;
 b=EUU5AAj6JzUyfZ63AOtyx2rCP1w4J0JSJuqe6X8TkBGyJBGappnBi+4sGvbJAYclpEqMYn
 kztzuwICMn5dmRsPy4Rs8yiWnL4yz9jZMyw7T1CIivG3E7o0XlOBu44q4mrnarEyqH0qwE
 PEVrlw+Q0PL2nlOLEhECfomC7Zm7C1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IcAdJqqWSHIzx/irRyvw93Kdb2ag8InMaMfEEyOIc=;
 b=gN/ZzITSX+lJoFdIFS336Tz2HqCMnEVwP+SBzS/gNZwjI60WpK1tH3wyEJ1fGuR7O57PVJ
 GL8gH1OFvx1tWeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9492A137FD;
 Thu, 10 Sep 2026 08:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0PaYImdromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:41 +0200
MIME-Version: 1.0
Message-Id: <20260910-fix_documentation-v1-1-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
In-Reply-To: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=3255;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nMc6yZTVV68E+O15zwOO6js1y+SjNjzsipcivf095R0=;
 b=Wpw/N/PQgxIHvjVFR7lGyCrm3ZepAumbz1QKQ8UZxt2gD95YTvcOtxUml4d+sTD1oWljsqwDQ
 Le8LIwwnvYtC5lJJcZsz1gehEW3QqlyNTqrbqu6bXBduJqIluldNjnO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CEB7B1FDC0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/9] doc: Fix examples and generated links
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

Correct invalid tags array syntax and the missing block terminator in
the shell API example. Fix the musl git commit URL and the getdents64
path in Sphinx configuration. Replace a hardcoded HTML anchor with a
Sphinx reference so it resolves across all documentation builders.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py                        | 4 ++--
 doc/developers/api_shell_tests.rst | 5 +++--
 doc/users/testers_guide.rst        | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index c28db7af1..2854fe199 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -89,7 +89,7 @@ def generate_supported_syscalls(_):
         'file_getattr': f'{ltp_syscalls_path}/file_attr',
         'file_setattr': f'{ltp_syscalls_path}/file_attr',
         'futex': f'{ltp_syscalls_path}/futex',
-        'getdents64': f'{ltp_syscalls_path}/gettdents',
+        'getdents64': f'{ltp_syscalls_path}/getdents',
         'inotify_add_watch': f'{ltp_syscalls_path}/inotify',
         'inotify_init': f'{ltp_syscalls_path}/inotify',
         'inotify_rm_watch': f'{ltp_syscalls_path}/inotify',
@@ -293,7 +293,7 @@ def _generate_tags_table(tags):
         "linux-git": "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=",
         "linux-stable-git": "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=",
         "glibc-git": "https://sourceware.org/git/?p=glibc.git;a=commit;h=",
-        "musl-git": "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id=",
+        "musl-git": "https://git.musl-libc.org/cgit/musl/commit/?id=",
         "CVE": cve_url + 'CVE-',
     }
 
diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
index 937ffee2e..22cab6803 100644
--- a/doc/developers/api_shell_tests.rst
+++ b/doc/developers/api_shell_tests.rst
@@ -41,10 +41,11 @@ when it's empty.
    #  "needs_root": true,
    #  "needs_tmpdir": true,
    #  "needs_kconfigs": ["CONFIG_NUMA=y"],
-   #  "tags": {
+   #  "tags": [
    #   ["linux-git", "432fd03240fa"]
-   #  }
+   #  ]
    # }
+   # ---
 
 After the documentation and environment has been laid out we finally import the
 :shell_lib:`tst_loader.sh`. This will, among other things, start the
diff --git a/doc/users/testers_guide.rst b/doc/users/testers_guide.rst
index c0eba64bf..b30b7ac7a 100644
--- a/doc/users/testers_guide.rst
+++ b/doc/users/testers_guide.rst
@@ -61,8 +61,8 @@ devices for these testcases, that can be changed with environment variables as
 well. Lastly but not least a few testcases repeat the test for all supported
 filesystem, if you are interested in testing on a single filesystem only, you
 can limit these tests to a single filesystem too. See the tests setup for a
-comprehensive list of the `environment variables
-<setup_tests.html#library-environment-variables>`_.
+comprehensive list of the :ref:`environment variables
+<users/setup_tests:Library environment variables>`.
 
 Then you also have to decide if you are going to run tests in virtual machine
 e.g. `qemu-kvm`, on bare metal or both. Testing in virtual machine will give you

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B47AC79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:05:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F27893E7274
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:05:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3392B3E2EFF
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 166191A00A35
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E16B1FBF2;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qB1RSlXR3ov3NgyHpwsRfD0n3DXYtydgbdyLuUiU5M=;
 b=d6x0xSqE1T2PVsGueqDeCiZluFDWKoDF7aXo7TyTlFEXCUPnSGZW0Lh65oKmdFMKwlfc6Z
 9eCmX1cuQcDP6U9+IYE+eTSllPpH1hQFRGwHXOnfohy1KhnS5LcCjXQ+R8qQNLsOKpbJcp
 iXj+P8K83Pgh+LNYu4n+skZBof4l5Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qB1RSlXR3ov3NgyHpwsRfD0n3DXYtydgbdyLuUiU5M=;
 b=xCGbRskR0geJVWSJHwoeaXuVOS2Uw2yIihyYxy6YDxiJRMuaPT+GT72z08Dt0S+0aWKY59
 woVqkq+jLMBcbpAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WDGI6Jv9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DKBRV7lQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qB1RSlXR3ov3NgyHpwsRfD0n3DXYtydgbdyLuUiU5M=;
 b=WDGI6Jv9wiTdyR5gHFQ7+W33mcsVAeXeUhtYrt9PRInUnizPqKl1jHfqUGLcLJrW7QPkqQ
 ofpuY0q+Eoq+QitYdSju1lndwGmPu5pwlFE26drUWNFAz2rbcNTDcip03JdAox1S0Eb8xM
 axs2mioJ8Fz9xLB4XVVsi2aOQzEvxeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qB1RSlXR3ov3NgyHpwsRfD0n3DXYtydgbdyLuUiU5M=;
 b=DKBRV7lQYXlYTtR1WtvctyqtGcM3rD3ztT8oGm8rm3vXZKj1YEc+TKrnpoKpZ48dv0aUKs
 Mm98ntw2YC8hRJAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A14EC13715;
 Fri, 11 Sep 2026 07:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EMeoJfSno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:17 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_documentation-v2-1-716b2613c477@suse.com>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=3366;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=sbcoKYhixgbd5q35Aia2/KRjdlUk4hEU2jyc2ZGxJQY=;
 b=gS57jSbXzekvBb4bdRbwhKqpaGWNGZoVMpgyYgsoJLBPYJvPQqAlu9xx50TNyTp3CWwUbc2lM
 HMAq9rQpsF4AxttmAVSBOk2YTFZw6g8u1Rq/fMPMxkzaOb3SD7hZCYg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E16B1FBF2
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,sourceware.org:url,suse.de:dkim,suse.com:email,suse.com:mid,musl-libc.org:url];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/9] doc: Fix examples and generated links
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py                        | 4 ++--
 doc/developers/api_shell_tests.rst | 7 ++++---
 doc/users/testers_guide.rst        | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

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
index 937ffee2e..a972900b1 100644
--- a/doc/developers/api_shell_tests.rst
+++ b/doc/developers/api_shell_tests.rst
@@ -41,10 +41,11 @@ when it's empty.
    #  "needs_root": true,
    #  "needs_tmpdir": true,
    #  "needs_kconfigs": ["CONFIG_NUMA=y"],
-   #  "tags": {
-   #   ["linux-git", "432fd03240fa"]
-   #  }
+   #  "tags": [
+   #   ["linux-git", "cf01fb9985e8deb25ccf0ea54d916b8871ae0e62"]
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

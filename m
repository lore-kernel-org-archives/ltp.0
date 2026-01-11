Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303B6D2502E
	for <ltp@archiver.kernel.org>; Sun, 11 Jan 2026 23:58:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38FE83C84C0
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 00:58:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78A393C7F6A
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 00:58:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B6DF61000465
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 00:57:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F174336B3;
 Sun, 11 Jan 2026 23:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768175877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3umoH7xtBguBSlqZeQf3bwOcOZXGt1kPV8//ZLo3uNs=;
 b=bwJxUeDJPRe/dwF4dTH4zd1EDMV2Z2YKh/8L4qeIl0awb04Dgf7x7Um/pG9uDXA0q+8PK7
 MPyMIAOVZiKfFUAznA/zB/MFi0ypQtCQMExgQDcjNbb88BT9AdO07ceJlAEdx6kBb5iqUt
 1HwpRkRJM7e1u204u2GeRn8GWWehBRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768175877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3umoH7xtBguBSlqZeQf3bwOcOZXGt1kPV8//ZLo3uNs=;
 b=34O0c5KI3fd1MAdcsvb+2VTe1pVa0RpvIDP8eawOm7/rffy2jNIDt6AfcXW2goGvhasnFx
 GbWr2ekqEBKTeTBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bwJxUeDJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=34O0c5KI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768175877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3umoH7xtBguBSlqZeQf3bwOcOZXGt1kPV8//ZLo3uNs=;
 b=bwJxUeDJPRe/dwF4dTH4zd1EDMV2Z2YKh/8L4qeIl0awb04Dgf7x7Um/pG9uDXA0q+8PK7
 MPyMIAOVZiKfFUAznA/zB/MFi0ypQtCQMExgQDcjNbb88BT9AdO07ceJlAEdx6kBb5iqUt
 1HwpRkRJM7e1u204u2GeRn8GWWehBRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768175877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3umoH7xtBguBSlqZeQf3bwOcOZXGt1kPV8//ZLo3uNs=;
 b=34O0c5KI3fd1MAdcsvb+2VTe1pVa0RpvIDP8eawOm7/rffy2jNIDt6AfcXW2goGvhasnFx
 GbWr2ekqEBKTeTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 079B53EA63;
 Sun, 11 Jan 2026 23:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AfdlAAU5ZGmcKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 11 Jan 2026 23:57:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 12 Jan 2026 00:57:51 +0100
Message-ID: <20260111235751.201056-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,suse.com:url,man7.org:url,git-scm.com:url,sphinx-doc.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sphinx-doc.org:url,suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,man7.org:url];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 6F174336B3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Use :manpages_url: for man pages links
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

Use sphinx internal way to link man pages to https://man7.org/
https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-manpages_url

This is much better than using extlinks sphinx extension.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Scripted:
for i in $( git grep -l -i -n -E -I 'man[1-3]'); do sed -i 's/:man\([1-3]\):`\([^`]\+\)`/:manpage:`\2(\1)`/g' $i; done

 doc/conf.py                                            |  5 +++--
 include/tst_cmd.h                                      |  4 ++--
 include/tst_kvercmp.h                                  |  4 ++--
 testcases/cve/stack_clash.c                            |  4 ++--
 testcases/kernel/mem/tunable/max_map_count.c           |  2 +-
 testcases/kernel/syscalls/clone/clone11.c              |  2 +-
 testcases/kernel/syscalls/clone3/clone304.c            |  2 +-
 testcases/kernel/syscalls/execve/execve01.c            |  2 +-
 testcases/kernel/syscalls/execve/execve02.c            |  4 ++--
 testcases/kernel/syscalls/execve/execve03.c            |  2 +-
 testcases/kernel/syscalls/execve/execve04.c            |  2 +-
 testcases/kernel/syscalls/execve/execve05.c            |  2 +-
 testcases/kernel/syscalls/execve/execve06.c            |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod06.c            |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl01.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl04.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl05.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl06.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl07.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl08.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl09.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl10.c              |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c      |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c      |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c      |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c      |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c         |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_loop02.c         |  4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop03.c         |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_loop04.c         |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c         |  4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop06.c         |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_loop07.c         |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c        |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c        |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c        |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c        |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c        |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c        |  2 +-
 testcases/kernel/syscalls/mmap/mmap22.c                |  2 +-
 testcases/kernel/syscalls/mount/mount07.c              |  4 ++--
 testcases/kernel/syscalls/open/open13.c                |  6 +++---
 testcases/kernel/syscalls/select/select01.c            |  2 +-
 testcases/kernel/syscalls/select/select02.c            |  2 +-
 testcases/kernel/syscalls/select/select03.c            |  2 +-
 testcases/kernel/syscalls/select/select04.c            |  2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit02.c      |  2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit03.c      |  2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit05.c      |  2 +-
 testcases/kernel/syscalls/swapon/swapon03.c            |  2 +-
 testcases/kernel/syscalls/umount/umount01.c            |  2 +-
 testcases/kernel/syscalls/umount/umount02.c            |  4 ++--
 testcases/kernel/syscalls/umount/umount03.c            |  2 +-
 testcases/kernel/syscalls/umount2/umount2_02.c         | 10 +++++-----
 testcases/kernel/syscalls/unlink/unlink05.c            |  6 +++---
 testcases/kernel/syscalls/unlink/unlink07.c            |  2 +-
 testcases/kernel/syscalls/unlink/unlink08.c            |  2 +-
 testcases/kernel/syscalls/unlink/unlink09.c            |  2 +-
 testcases/kernel/syscalls/unlink/unlink10.c            |  2 +-
 testcases/kernel/syscalls/unlinkat/unlinkat01.c        |  2 +-
 testcases/kernel/syscalls/unshare/unshare01.c          |  4 ++--
 testcases/kernel/syscalls/unshare/unshare02.c          |  2 +-
 testcases/kernel/syscalls/userfaultfd/userfaultfd01.c  |  2 +-
 testcases/network/lib6/asapi_02.c                      |  4 ++--
 66 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index b8ec1c31c2..d49cb4e77e 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -36,14 +36,15 @@ extlinks = {
     'master': (f'{ltp_repo}/blob/master/%s', '%s'),
     'shell_lib': (f'{ltp_repo}/blob/master/testcases/lib/%s', '%s'),
     'git_man': ('https://git-scm.com/docs/git-%s', 'git %s'),
-    'man2': ('https://man7.org/linux/man-pages/man2/%s.2.html', '%s(2)'),
-    'man3': ('https://man7.org/linux/man-pages/man3/%s.3.html', '%s(3)'),
     # TODO: allow 2nd parameter to show page description instead of plain URL
     'kernel_doc': ('https://docs.kernel.org/%s.html', 'https://docs.kernel.org/%s.html'),
     'kernel_tree': ('https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/%s', '%s'),
     'kselftest': ('https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/%s', '%s (kselftest)'),
 }
 
+# Link to man pages
+manpages_url = 'https://man7.org/linux/man-pages/man{section}/{page}.{section}.html'
+
 spelling_lang = "en_US"
 spelling_warning = True
 spelling_exclude_patterns = ['users/stats.rst']
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index bda74ec911..3bdd764dc9 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -33,7 +33,7 @@ int tst_cmd_(void (cleanup_fn)(void),
 
 #ifdef TST_TEST_H__
 /**
- * tst_cmd_fds() - :man2:`vfork` + :man3:`execvp` specified program.
+ * tst_cmd_fds() - :manpage:`vfork(2)` + :manpage:`execvp(3)` specified program.
  *
  * @argv: A list of two (at least program name + NULL) or more pointers that
  * represent the argument list to the new program. The array of pointers
@@ -98,7 +98,7 @@ static inline int tst_cmd(void (cleanup_fn)(void),
 #endif
 
 /**
- * tst_system() - Wrapper function for :man3:`system`, ignorcing ``SIGCHLD``
+ * tst_system() - Wrapper function for :manpage:`system(3)`, ignorcing ``SIGCHLD``
  * signal.
  *
  * @command: The command to be run.
diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
index 95eff0bc48..7c991c746a 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -54,7 +54,7 @@ const char *tst_kvcmp_distname(const char *cur_kver);
  * @tst_exv: The tested kernel version string (struct utsname.release).
  * @cur_kver: The current version in string (struct utsname.release).
  *
- * The return value is similar to the :man3:`strcmp` function, i.e. zero means
+ * The return value is similar to the :manpage:`strcmp(3)` function, i.e. zero means
  * equal, negative value means that the kernel is older than the expected value
  * and positive means that it's newer.
  *
@@ -69,7 +69,7 @@ int tst_kvexcmp(const char *tst_exv, const char *cur_kver);
  * @r2: Minor kernel version.
  * @r3: Kernel patch level.
  *
- * Parse the output from :man2:`uname` and compare it to the passed values.
+ * Parse the output from :manpage:`uname(2)` and compare it to the passed values.
  * This is shortcut for calling tst_kvcmp() with ``uname -r`` as str_kver.
  *
  * Return: Negative if older, 0 if the same and positive if newer.
diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 19da449dde..0584b2f7a4 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -12,12 +12,12 @@
  * gap which is considered hard to hop above. Code is based on a reproducer from
  * https://bugzilla.suse.com/show_bug.cgi?id=CVE-2017-1000364.
  *
- * The code :man2:`mmap` region close to the stack end. The code then allocates
+ * The code :manpage:`mmap(2)` region close to the stack end. The code then allocates
  * memory on stack until it hits guard page and SIGSEGV or SIGBUS is generated
  * by the kernel. The signal handler checks that fault address is further than
  * THRESHOLD from the mmapped area.
  *
- * We read /proc/self/maps to examine exact top of the stack and :man2:`mmap`
+ * We read /proc/self/maps to examine exact top of the stack and :manpage:`mmap(2)`
  * our region exactly GAP_PAGES * PAGE_SIZE away. We read /proc/cmdline to
  * see if a different stack_guard_gap size is configured. We set stack limit
  * to infinity and preallocate REQ_STACK_SIZE bytes of stack so that no calls
diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index e58bc2ffe0..429b9c81cc 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -18,7 +18,7 @@
  * indicates a map entry, so it can caculate the amount of maps by reading
  * the file lines' number to check the tunable performance.
  *
- * The program tries to invoke :man2:`mmap` endlessly until it triggers
+ * The program tries to invoke :manpage:`mmap(2)` endlessly until it triggers
  * ``MAP_FAILED``, then reads the process's maps file /proc/[pid]/maps, save
  * the line number to map_count variable, and compare it with
  * ``/proc/sys/vm/max_map_count``, map_count should be greater than
diff --git a/testcases/kernel/syscalls/clone/clone11.c b/testcases/kernel/syscalls/clone/clone11.c
index 68c28481e9..f9f5545f9d 100644
--- a/testcases/kernel/syscalls/clone/clone11.c
+++ b/testcases/kernel/syscalls/clone/clone11.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`clone` fails with EPERM when CAP_SYS_ADMIN
+ * This test verifies that :manpage:`clone(2)` fails with EPERM when CAP_SYS_ADMIN
  * has been dropped.
  */
 
diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
index 26d42c59e0..9faaf44bb2 100644
--- a/testcases/kernel/syscalls/clone3/clone304.c
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`clone3` fails with EPERM when CAP_SYS_ADMIN
+ * This test verifies that :manpage:`clone3(2)` fails with EPERM when CAP_SYS_ADMIN
  * has been dropped and ``clone_args.set_tid_size`` is greater than zero.
  */
 
diff --git a/testcases/kernel/syscalls/execve/execve01.c b/testcases/kernel/syscalls/execve/execve01.c
index 777dad5cef..362c5a9b6d 100644
--- a/testcases/kernel/syscalls/execve/execve01.c
+++ b/testcases/kernel/syscalls/execve/execve01.c
@@ -11,7 +11,7 @@
 #include "tst_test.h"
 
 /*\
- * Test :man2:`execve` passes correctly argv[1] and environment variable to the
+ * Test :manpage:`execve(2)` passes correctly argv[1] and environment variable to the
  * executed binary.
  */
 
diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
index 7cbd2c0346..2bf172125f 100644
--- a/testcases/kernel/syscalls/execve/execve02.c
+++ b/testcases/kernel/syscalls/execve/execve02.c
@@ -9,8 +9,8 @@
  */
 
 /*\
- * Attempt to :man2:`execve` an executable owned by root with no execute
- * permissions for the other users, fails when :man2:`execve` is used as
+ * Attempt to :manpage:`execve(2)` an executable owned by root with no execute
+ * permissions for the other users, fails when :manpage:`execve(2)` is used as
  * a non-root user, the errno should be EACCES.
  */
 
diff --git a/testcases/kernel/syscalls/execve/execve03.c b/testcases/kernel/syscalls/execve/execve03.c
index 7a47c985df..a3e1b240a1 100644
--- a/testcases/kernel/syscalls/execve/execve03.c
+++ b/testcases/kernel/syscalls/execve/execve03.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * Test to check :man2:`execve` sets the following errnos correctly:
+ * Test to check :manpage:`execve(2)` sets the following errnos correctly:
  *
  * 1. ENAMETOOLONG -- the file name is greater than VFS_MAXNAMELEN
  * 2. ENOENT -- the filename does not exist
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index 90ceccaeb1..35ec882a07 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -9,7 +9,7 @@
  */
 
 /*\
- * Attempt to :man2:`execve` a file which is being opened by another process for
+ * Attempt to :manpage:`execve(2)` a file which is being opened by another process for
  * writing fails with ETXTBSY.
  */
 
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index d3a9d947bc..352c73c38a 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * This tests the functionality of the execve(2) :man2:`execve` call by spawning
+ * This tests the functionality of the execve(2) :manpage:`execve(2)` call by spawning
  * a few children, each of which would execute "execve_child" binary simultaneously,
  * and finally the parent ensures that they terminated correctly.
  */
diff --git a/testcases/kernel/syscalls/execve/execve06.c b/testcases/kernel/syscalls/execve/execve06.c
index 5b58515506..55f5d71163 100644
--- a/testcases/kernel/syscalls/execve/execve06.c
+++ b/testcases/kernel/syscalls/execve/execve06.c
@@ -5,7 +5,7 @@
 
 /*\
  * Test that kernel adds dummy argv[0] if empty argument list was passed to
- * :man2:`execve`. This fixes at least one CVE where userspace programs start to
+ * :manpage:`execve(2)`. This fixes at least one CVE where userspace programs start to
  * process argument list blindly from argv[1] such as polkit pkexec
  * CVE-2021-4034.
  *
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 458239a2ef..37314e7d09 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * Verify that :man2:`fchmod` fails and sets the proper errno values:
+ * Verify that :manpage:`fchmod(2)` fails and sets the proper errno values:
  *
  * - EPERM -- the effective UID does not match the owner of the file, and the process is not privileged
  * - EBADF -- file descriptor was closed
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 4fae026670..62f977ec12 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -8,7 +8,7 @@
  */
 
 /*\
- * Testcase to check the errnos set by the :man2:`ioctl` system call.
+ * Testcase to check the errnos set by the :manpage:`ioctl(2)` system call.
  *
  * - EBADF: Pass an invalid fd to ioctl(fd, ...) and expect EBADF
  * - EFAULT: Pass an invalid address of arg in ioctl(fd, ..., arg)
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index e38d9d365f..0465aa70fe 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Basic test for :man2:`ioctl` with BLKROSET and BLKROGET .
+ * Basic test for :manpage:`ioctl(2)` with BLKROSET and BLKROGET .
  *
  * - Set the device read only, read the value back.
  * - Try to mount the device read write, expect failure.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl05.c b/testcases/kernel/syscalls/ioctl/ioctl05.c
index 92ea6f8fee..daeec20d96 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl05.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Basic test for :man2:`ioctl` with BLKGETSIZE and BLKGETSIZE64.
+ * Basic test for :manpage:`ioctl(2)` with BLKGETSIZE and BLKGETSIZE64.
  *
  * - BLKGETSIZE returns size in 512 byte blocks BLKGETSIZE64 in bytes
  *   compare that they return the same value.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index 8d49d4773d..6e4323b37f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Basic test for :man2:`ioctl` with BLKRASET and BLKRAGET.
+ * Basic test for :manpage:`ioctl(2)` with BLKRASET and BLKRAGET.
  *
  * Sets device read-ahead, reads it back and compares the values.
  *
diff --git a/testcases/kernel/syscalls/ioctl/ioctl07.c b/testcases/kernel/syscalls/ioctl/ioctl07.c
index 4afb3a1d6b..f4acb7f892 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl07.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Very basic test for the RND* :man2:`ioctl`.
+ * Very basic test for the RND* :manpage:`ioctl(2)`.
  *
  * Reads the entropy available from both /proc and the ioctl and compares
  * they are similar enough (within a configured fuzz factor).
diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 520becf7d9..dd64065503 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Tests :man2:`ioctl` functionality to deduplicate fileranges using
+ * Tests :manpage:`ioctl(2)` functionality to deduplicate fileranges using
  * btrfs filesystem.
  *
  * 1. Sets the same contents for two files and deduplicates it.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index c046d89595..61a8d83554 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Basic test for :man2:`ioctl` with BLKRRPART, it is the same as blockdev
+ * Basic test for :manpage:`ioctl(2)` with BLKRRPART, it is the same as blockdev
  * --rereadpt command.
  */
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/syscalls/ioctl/ioctl10.c
index 85c20e76fe..b668c9e938 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl10.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Test PROCMAP_QUERY :man2:`ioctl` for /proc/$PID/maps.
+ * Test PROCMAP_QUERY :manpage:`ioctl(2)` for /proc/$PID/maps.
  *
  * Test based on :kselftest:`proc/proc-pid-vm.c`.
  *
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
index 86fdbd931e..91683396f2 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`ioctl` FICLONE feature clones file content
+ * This test verifies that :manpage:`ioctl(2)` FICLONE feature clones file content
  * from one file to an another.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
index d4265147d6..8a550b8f8c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`ioctl` FICLONE/FICLONERANGE feature correctly
+ * This test verifies that :manpage:`ioctl(2)` FICLONE/FICLONERANGE feature correctly
  * raises EOPNOTSUPP when an unsupported filesystem is used. In particular,
  * filesystems which don't support copy-on-write.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index a52f0d1f26..ba06e2d8e3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`ioctl` FICLONE/FICLONERANGE feature correctly
+ * This test verifies that :manpage:`ioctl(2)` FICLONE/FICLONERANGE feature correctly
  * raises exceptions when it's supposed to.
  */
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
index 48321e9f31..e62863b038 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`ioctl` FICLONE/FICLONERANGE feature raises the
+ * This test verifies that :manpage:`ioctl(2)` FICLONE/FICLONERANGE feature raises the
  * right error according with bad file descriptors.
  */
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
index 79143ba160..8dab9f3447 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`ioctl` FICLONERANGE feature clones file
+ * This test verifies that :manpage:`ioctl(2)` FICLONERANGE feature clones file
  * content from one file to an another.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
index 701a63284c..5c9d8afb70 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * This test verifies that :man2:`ioctl` FICLONERANGE feature correctly raises
+ * This test verifies that :manpage:`ioctl(2)` FICLONERANGE feature correctly raises
  * EINVAL when:
  *
  * - filesystem does not support overlapping reflink ranges in the same file
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index 9fbdbb1f2b..0d39d2987e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Tests :man2:`ioctl` on loopdevice with LO_FLAGS_AUTOCLEAR and
+ * Tests :manpage:`ioctl(2)` on loopdevice with LO_FLAGS_AUTOCLEAR and
  * LO_FLAGS_PARTSCAN flags.
  *
  * For LO_FLAGS_AUTOCLEAR flag, only checks autoclear field value in sysfs
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index a401056c34..a5398ba0a5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -6,14 +6,14 @@
  */
 
 /*\
- * Tests :man2:`ioctl` on loopdevice with LO_FLAGS_READ_ONLY (similar as losetup
+ * Tests :manpage:`ioctl(2)` on loopdevice with LO_FLAGS_READ_ONLY (similar as losetup
  * -r) and LOOP_CHANGE_FD flags.
  *
  * For LOOP_CHANGE_FD, this operation is possible only if the loop device
  * is read-only and the new backing store is the same size and type as the
  * old backing store.
  *
- * When using LOOP_CONFIGURE :man2:`ioctl`, it can set LO_FLAGS_READ_ONLY
+ * When using LOOP_CONFIGURE :manpage:`ioctl(2)`, it can set LO_FLAGS_READ_ONLY
  * flag even though backing file with write mode.
  */
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
index db2d16ced0..56a7174761 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Tests :man2:`ioctl` on loopdevice with LOOP_CHANGE_FD flag.
+ * Tests :manpage:`ioctl(2)` on loopdevice with LOOP_CHANGE_FD flag.
  *
  * Tests whether LOOP_CHANGE_FD can not succeed (get EINVAL error)
  * when loop_dev is not read only.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
index b3b4b6a9a9..38134fb701 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Tests :man2:`ioctl` on loopdevice with LOOP_SET_CAPACITY flag.
+ * Tests :manpage:`ioctl(2)` on loopdevice with LOOP_SET_CAPACITY flag.
  *
  * Tests whether LOOP_SET_CAPACITY can update a live
  * loop device size after change the size of the underlying
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 64b121fb3b..88db7d168c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Tests :man2:`ioctl` on loopdevice with LOOP_SET_DIRECT_IO flag.
+ * Tests :manpage:`ioctl(2)` on loopdevice with LOOP_SET_DIRECT_IO flag.
  *
  * Tests whether LOOP_SET_DIRECT_IO can update a live loop device dio mode.
  * It requires the backing file also supports dio mode and the lo_offset is
@@ -16,7 +16,7 @@
  * return error when it coudln't be enabled, some silently fall back to regular
  * buffered I/O.
  *
- * The LOOP_SET_DIRECT_IO :man2:`ioctl` may ignore all checks if it cannot get
+ * The LOOP_SET_DIRECT_IO :manpage:`ioctl(2)` may ignore all checks if it cannot get
  * the logical block size which is the case if the block device pointer in the
  * backing file inode is not set. In this case the direct I/O appears to be
  * enabled but falls back to buffered I/O later on. This is the case at least
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 23204086f6..94f9bcdc6e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Tests invalid block size of loopdevice by using :man2:`ioctl` with
+ * Tests invalid block size of loopdevice by using :manpage:`ioctl(2)` with
  * LOOP_SET_BLOCK_SIZE and LOOP_CONFIGURE flags.
  */
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
index 31e9c7c04a..0a210038b7 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Tests :man2:`ioctl` on loopdevice with LOOP_SET_STATUS64 and
+ * Tests :manpage:`ioctl(2)` on loopdevice with LOOP_SET_STATUS64 and
  * LOOP_GET_STATUS64 flags.
  *
  * Tests lo_sizelimit field. If lo_sizelimit is 0, it means max
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
index 216af2ea30..95c0e8f3fa 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that :man2:`ioctl` raises the right errors when an application
+ * Verify that :manpage:`ioctl(2)` raises the right errors when an application
  * provides wrong file descriptor.
  */
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
index 7eb60e7fc6..c6f8a02fe3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Check if the :man2:`ioctl` function allows retrieval of a child's exit code
+ * Check if the :manpage:`ioctl(2)` function allows retrieval of a child's exit code
  * using PIDFD_INFO_EXIT from a process that can be isolated or not from the
  * child.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
index 8f2779be2e..2c785004c0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that :man2:`ioctl` returns ESRCH when a process attempts to access the
+ * Verify that :manpage:`ioctl(2)` returns ESRCH when a process attempts to access the
  * exit status of an isolated child using PIDFD_GET_INFO and PIDFD_INFO_EXIT
  * is not defined in struct pidfd_info.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
index cf8393dec4..ff43160680 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that :man2:`ioctl` permits to obtain the exit code of an isolated
+ * Verify that :manpage:`ioctl(2)` permits to obtain the exit code of an isolated
  * signaled child via PIDFD_INFO_EXIT from within a process.
  */
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index 31439f0b77..278e64cefc 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that :man2:`ioctl` raises an EINVAL or ENOTTY (since v6.18-rc1) error
+ * Verify that :manpage:`ioctl(2)` raises an EINVAL or ENOTTY (since v6.18-rc1) error
  * when PIDFD_GET_INFO is used. This happens when:
  *
  * - info parameter is NULL
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 2a8bc14325..95c09dbdaa 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that :man2:`ioctl` doesn't allow to obtain the exit status of an isolated
+ * Verify that :manpage:`ioctl(2)` doesn't allow to obtain the exit status of an isolated
  * process via PIDFD_INFO_EXIT in within an another isolated process, which
  * doesn't have any parent connection.
  */
diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
index 221fd5d286..0b95c578ff 100644
--- a/testcases/kernel/syscalls/mmap/mmap22.c
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Test :man2:`mmap` with MAP_DROPPABLE flag.
+ * Test :manpage:`mmap(2)` with MAP_DROPPABLE flag.
  *
  * Test based on :kselftest:`mm/droppable.c`.
  *
diff --git a/testcases/kernel/syscalls/mount/mount07.c b/testcases/kernel/syscalls/mount/mount07.c
index 325e0daa68..f1b890fd6f 100644
--- a/testcases/kernel/syscalls/mount/mount07.c
+++ b/testcases/kernel/syscalls/mount/mount07.c
@@ -10,8 +10,8 @@
  *
  * It tests to make sure that symlink traversal fails with ELOOP when
  * 'nosymfollow' is set, but symbolic links can still be created, and
- * :man2:`readlink` and :man3:`realpath` still work properly. It also verifies
- * that :man2:`statfs` correctly returns ST_NOSYMFOLLOW.
+ * :manpage:`readlink(2)` and :manpage:`realpath(3)` still work properly. It also verifies
+ * that :manpage:`statfs(2)` correctly returns ST_NOSYMFOLLOW.
  */
 
 #include <limits.h>
diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
index aea9ec4b2b..40b6fa851e 100644
--- a/testcases/kernel/syscalls/open/open13.c
+++ b/testcases/kernel/syscalls/open/open13.c
@@ -6,12 +6,12 @@
  */
 
 /*\
- * Basic test for O_PATH flag of :man2:`open`:
+ * Basic test for O_PATH flag of :manpage:`open(2)`:
  *
  *    Obtain a file descriptor that can be used to perform operations
  *    that act purely at the file descriptor level, the file itself is
- *    not opened, the operations :man2:`read`, :man2:`write`, :man2:`fchmod`,
- *    :man2:`fchown` and :man2:`fgetxattr` fail with the error EBADF.
+ *    not opened, the operations :manpage:`read(2)`, :manpage:`write(2)`, :manpage:`fchmod(2)`,
+ *    :manpage:`fchown(2)` and :manpage:`fgetxattr(2)` fail with the error EBADF.
  *
  * The operations include but are not limited to the syscalls above.
  */
diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index 58a4774da1..7b597a69f9 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * :man2:`select` with no I/O and small timeout to file descriptor of a
+ * :manpage:`select(2)` with no I/O and small timeout to file descriptor of a
  *
  * - regular file
  * - system pipe
diff --git a/testcases/kernel/syscalls/select/select02.c b/testcases/kernel/syscalls/select/select02.c
index 541d9367f6..da8b250524 100644
--- a/testcases/kernel/syscalls/select/select02.c
+++ b/testcases/kernel/syscalls/select/select02.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Check that :man2:`select` timeouts correctly.
+ * Check that :manpage:`select(2)` timeouts correctly.
  */
 
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index 6ad1d051e0..1154e457d7 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * :man2:`select` failure tests:
+ * :manpage:`select(2)` failure tests:
  *
  * - negative nfds (EINVAL)
  * - invalid readfds (EBADF)
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 87791c9205..ddff1528f5 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Test to check if fd set bits are cleared by :man2:`select`.
+ * Test to check if fd set bits are cleared by :manpage:`select(2)`.
  *
  * [Algorithm]
  *  - Check that writefds flag is cleared on full pipe
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit02.c b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
index 41d8e8007b..92600da4a4 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit02.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Testcase to test the different errnos set by :man2:`setrlimit` system call.
+ * Testcase to test the different errnos set by :manpage:`setrlimit(2)` system call.
  */
 
 #include <pwd.h>
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index d0eefb3c22..0e1f83a1e8 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Test :man2:`setrlimit` errnos:
+ * Test :manpage:`setrlimit(2)` errnos:
  *
  * - EPERM when the super-user tries to increase RLIMIT_NOFILE  beyond the
  *   system limit.
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
index b35d8ea085..831ccfc204 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Test :man2:`setrlimit` for EFAULT when rlim points outside the accessible
+ * Test :manpage:`setrlimit(2)` for EFAULT when rlim points outside the accessible
  * address space.
  */
 
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 53c5750de4..61a455f319 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Test checks whether :man2:`swapon` system call returns EPERM when the maximum
+ * Test checks whether :manpage:`swapon(2)` system call returns EPERM when the maximum
  * number of swap files are already in use.
  *
  * NOTE: test does not try to calculate MAX_SWAPFILES from the internal
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 0381d08d30..bbce647ffd 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Check the basic functionality of the :man2:`umount` system call.
+ * Check the basic functionality of the :manpage:`umount(2)` system call.
  */
 
 #include <sys/mount.h>
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index 5797f506be..eacf49d945 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -7,9 +7,9 @@
  */
 
 /*\
- * Check for basic errors returned by :man2:`umount` system call.
+ * Check for basic errors returned by :manpage:`umount(2)` system call.
  *
- * Verify that :man2:`umount` returns -1 and sets errno to
+ * Verify that :manpage:`umount(2)` returns -1 and sets errno to
  *
  * 1. EBUSY if it cannot be umounted, because dir is still busy.
  * 2. EFAULT if specialfile or device file points to invalid address space.
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index b0568becb3..5a0f73c2c1 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Verify that :man2:`umount` returns -1 and sets errno to EPERM if the user
+ * Verify that :manpage:`umount(2)` returns -1 and sets errno to EPERM if the user
  * is not the super-user.
  */
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 377e47c203..990157d1a9 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -5,14 +5,14 @@
  */
 
 /*\
- * Test for feature MNT_EXPIRE of :man2:`umount2`:
+ * Test for feature MNT_EXPIRE of :manpage:`umount2(2)`:
  *
  * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
- * - EAGAIN when initial call to :man2:`umount2` with MNT_EXPIRE
- * - EAGAIN when :man2:`umount2` with MNT_EXPIRE after :man2:`access`
- * - succeed when second call to :man2:`umount2` with MNT_EXPIRE
+ * - EAGAIN when initial call to :manpage:`umount2(2)` with MNT_EXPIRE
+ * - EAGAIN when :manpage:`umount2(2)` with MNT_EXPIRE after :manpage:`access(2)`
+ * - succeed when second call to :manpage:`umount2(2)` with MNT_EXPIRE
  *
- * Test for feature UMOUNT_NOFOLLOW of :man2:`umount2`:
+ * Test for feature UMOUNT_NOFOLLOW of :manpage:`umount2(2)`:
  *
  * - EINVAL when target is a symbolic link
  * - succeed when target is a mount point
diff --git a/testcases/kernel/syscalls/unlink/unlink05.c b/testcases/kernel/syscalls/unlink/unlink05.c
index 0424218979..8de2d8bc25 100644
--- a/testcases/kernel/syscalls/unlink/unlink05.c
+++ b/testcases/kernel/syscalls/unlink/unlink05.c
@@ -5,10 +5,10 @@
  */
 
 /*\
- * Test the basic functionality of :man2:`unlink`:
+ * Test the basic functionality of :manpage:`unlink(2)`:
  *
- * - :man2:`unlink` can delete regular file successfully
- * - :man2:`unlink` can delete fifo file successfully
+ * - :manpage:`unlink(2)` can delete regular file successfully
+ * - :manpage:`unlink(2)` can delete fifo file successfully
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index f53f58af55..b4b70d2704 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Verify that :man2:`unlink`: fails with:
+ * Verify that :manpage:`unlink(2)`: fails with:
  *
  * - ENOENT when file does not exist
  * - ENOENT when pathname is empty
diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index efc5753be5..c1fa8f31d0 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Verify that :man2:`unlink`: fails with:
+ * Verify that :manpage:`unlink(2)`: fails with:
  *
  * - EACCES when no write access to the directory containing pathname
  * - EACCES when one of the directories in pathname did not allow search
diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index 5f943cf521..10d4e8a448 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Verify that :man2:`unlink`: fails with EPERM when target file is marked as
+ * Verify that :manpage:`unlink(2)`: fails with EPERM when target file is marked as
  * immutable or append-only.
  */
 
diff --git a/testcases/kernel/syscalls/unlink/unlink10.c b/testcases/kernel/syscalls/unlink/unlink10.c
index 46a167e1bd..2d6ec8ce14 100644
--- a/testcases/kernel/syscalls/unlink/unlink10.c
+++ b/testcases/kernel/syscalls/unlink/unlink10.c
@@ -6,7 +6,7 @@
  */
 
 /*\
- * Verify that :man2:`unlink`: fails with EROFS when target file is on
+ * Verify that :manpage:`unlink(2)`: fails with EROFS when target file is on
  * a read-only filesystem.
  */
 
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index eddd6e3d24..f46690892c 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * Basic :man2:`unlinkat` test.
+ * Basic :manpage:`unlinkat(2)` test.
  */
 
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index 32d64b9552..f3d9fca7ba 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -6,11 +6,11 @@
  */
 
 /*\
- * Basic tests for the :man2:`unshare` syscall.
+ * Basic tests for the :manpage:`unshare(2)` syscall.
  *
  * [Algorithm]
  *
- * Calls :man2:`unshare` for different CLONE_* flags in a child process and
+ * Calls :manpage:`unshare(2)` for different CLONE_* flags in a child process and
  * expects them to succeed.
  */
 
diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
index e5a16977f1..b8d51c701a 100644
--- a/testcases/kernel/syscalls/unshare/unshare02.c
+++ b/testcases/kernel/syscalls/unshare/unshare02.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * Basic tests for the :man2:`unshare` errors.
+ * Basic tests for the :manpage:`unshare(2)` errors.
  *
  * - EINVAL on invalid flags
  * - EPERM when process is missing required privileges
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index c7a7767204..569207c51a 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -5,7 +5,7 @@
  */
 
  /*\
- * Force a pagefault event and handle it using :man2:`userfaultfd`
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
  * from a different thread.
  */
 
diff --git a/testcases/network/lib6/asapi_02.c b/testcases/network/lib6/asapi_02.c
index 6bffde03df..27a2e7c030 100644
--- a/testcases/network/lib6/asapi_02.c
+++ b/testcases/network/lib6/asapi_02.c
@@ -14,7 +14,7 @@
  * larger number of messages may be potentially received on an ICMPv6 socket.
  * Input filters may therefore be used to restrict input to a subset of the
  * incoming ICMPv6 messages so only interesting messages are returned by the
- * :man2:`recv` family of calls to an application.
+ * :manpage:`recv(2)` family of calls to an application.
 
  * The icmp6_filter structure may be used to refine the input message set
  * according to the ICMPv6 type. By default, all messages types are allowed
@@ -41,7 +41,7 @@
  * ``int ICMP6_FILTER_WILLBLOCK(int, const struct icmp6_filter *)``
  * Determine if the given filter will ignore an ICMPv6 message of the given type.
  *
- * The :man2:`getsockopt` and :man2:`setsockopt` calls may be used to obtain and
+ * The :manpage:`getsockopt(2)` and :manpage:`setsockopt(2)` calls may be used to obtain and
  * install the filter on ICMPv6 sockets at option level ``IPPROTO_ICMPV6`` and
  * name ``ICMP6_FILTER`` with a pointer to the icmp6_filter structure as the
  * option value.
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

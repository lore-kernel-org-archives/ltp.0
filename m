Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B299FE7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 10:34:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BD573E88AF
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 11:34:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC5A33E8891
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 11:33:12 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B6D5140E5EA
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 11:33:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E55B62116E
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733999591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x89nbaRoLrdy/vIv4CJmIEqt2l9nL1fmdCAYtXYk+Y=;
 b=LZksCEoxHcq5lbDhpyUU/3MfZBzyusMSvMHmac8XnhWFAJmoadEbA9X9OuYrvk1C5pnCDC
 s8HzOJjiIsjxf8hX785eZBdRtVfMd9yck0QGI8O0S+dP53LJmOBLJ7I4T8NmEED1KNNDTm
 CR+pWhtSV1ELXLvZfZBSzPufwigeOWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733999591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x89nbaRoLrdy/vIv4CJmIEqt2l9nL1fmdCAYtXYk+Y=;
 b=gHlupfu3IFyMxu90F3Io6V66P0PbaCWPMaK4/PUSke3lc6Wx686cH3Zsm8kAw3c+JQJImc
 O3U4KP3jlz8KUABQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WXDCLwOL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1D7BKttF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733999590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x89nbaRoLrdy/vIv4CJmIEqt2l9nL1fmdCAYtXYk+Y=;
 b=WXDCLwOLggwbTkWJbqWP3isE4aIyBswB2tbk7n8PNtYB7QhDTAnL9SA3PKh7/GEtUzx9rM
 UFClsBFBV2TooK7MJlkhvpFwpdvG2UtYTuZm/DvbrPstPugbhGBcew3nhzYMUSw/7nkP7o
 gU/TOlwpdya5j6DBJDdX89tg5ew7Mfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733999590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x89nbaRoLrdy/vIv4CJmIEqt2l9nL1fmdCAYtXYk+Y=;
 b=1D7BKttFqXkHi2NbMIEfMYUCbQOdq4RIEnQUccc2KVUN0cbk6AJNkCJUemGp0v5hCWda/E
 WGtczH1hN1kU5kAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC69C13939
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +BMRJOa7WmcuJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 12 Dec 2024 11:33:08 +0100
MIME-Version: 1.0
Message-Id: <20241212-doc_syscalls_link-v1-2-69a916958ba9@suse.com>
References: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
In-Reply-To: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733999589; l=6932;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=/rxowo2RoUtyaTd68SCycN4pvAIudbaJAPqcGCQqhxk=;
 b=hnAu6YMWaqj3jX8gce0kTOn16RJobXDTQLa9S3gD9wKQUAOmHA1TbPf4+mXDhhbZk0ZW6f1S5
 sa4Gz5PG6EMCrwviTtWRoOjzqB/chX/C2XdeDKTmIdaqYrzL9jEBn3q
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E55B62116E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: support for clickable syscalls under stats
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

Under statistics tab, add possibility to click on a syscalls and
being redirected to the source code which is testing them.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 120 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 51 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 1c6a7f74c9401842c01f33dd34a5171d5328248c..258a1b9e285581e40c03caaf643e295fb90cb0c5 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -61,39 +61,38 @@ def generate_syscalls_stats(_):
     # because in some cases (i.e. io_ring) syscalls are tested, but they are
     # part of a more complex scenario. In the following list, we define syscalls
     # which we know they are 100% tested already.
-    white_list = [
-        'epoll_pwait2',
-        'fadvise64',
-        'fanotify_init',
-        'fanotify_mark',
-        'getdents64',
-        'getmsg',
-        'getpmsg',
-        'inotify_add_watch',
-        'inotify_rm_watch',
-        'io_uring_enter',
-        'io_uring_register',
-        'io_uring_setup',
-        'landlock_add_rule',
-        'landlock_create_ruleset',
-        'landlock_restrict_self',
-        'lsetxattr',
-        'newfstatat',
-        'putmsg',
-        'putpmsg',
-        'pkey_alloc',
-        'pkey_free',
-        'pkey_mprotect',
-        'prlimit64',
-        'pread64',
-        'pselect6',
-        'pwrite64',
-        'quotactl_fd',
-        'rt_sigpending',
-        'seccomp',
-        'semtimedop',
-        'sethostname',
-    ]
+    ltp_syscalls_path = "testcases/kernel/syscalls"
+    white_list = {
+        'bpf': f'{ltp_syscalls_path}/bpf',
+        'epoll_pwait2': f'{ltp_syscalls_path}/epoll_pwait',
+        'fadvise64': f'{ltp_syscalls_path}/fadvise',
+        'fanotify_init': f'{ltp_syscalls_path}/fanotify',
+        'fanotify_mark': f'{ltp_syscalls_path}/fanotify',
+        'futex': f'{ltp_syscalls_path}/futex',
+        'getdents64': f'{ltp_syscalls_path}/gettdents',
+        'inotify_add_watch': f'{ltp_syscalls_path}/inotify',
+        'inotify_init': f'{ltp_syscalls_path}/inotify',
+        'inotify_rm_watch': f'{ltp_syscalls_path}/inotify',
+        'io_uring_enter': f'{ltp_syscalls_path}/io_uring',
+        'io_uring_register': f'{ltp_syscalls_path}/io_uring',
+        'io_uring_setup': f'{ltp_syscalls_path}/io_uring',
+        'landlock_add_rule': f'{ltp_syscalls_path}/landlock',
+        'landlock_create_ruleset': f'{ltp_syscalls_path}/landlock',
+        'landlock_restrict_self': f'{ltp_syscalls_path}/landlock',
+        'lsetxattr': f'{ltp_syscalls_path}/lgetxattr',
+        'newfstatat': f'{ltp_syscalls_path}/fstatat',
+        'pkey_alloc': f'{ltp_syscalls_path}/pkeys',
+        'pkey_free': f'{ltp_syscalls_path}/pkeys',
+        'pkey_mprotect': f'{ltp_syscalls_path}/pkeys',
+        'prlimit64': f'{ltp_syscalls_path}/getrlimit',
+        'pread64': f'{ltp_syscalls_path}/pread',
+        'pselect6': f'{ltp_syscalls_path}/pselect',
+        'pwrite64': f'{ltp_syscalls_path}/pwrite',
+        'quotactl_fd': f'{ltp_syscalls_path}/quotactl',
+        'rt_sigpending': f'{ltp_syscalls_path}/sigpending',
+        'semtimedop': f'{ltp_syscalls_path}/ipc/semop',
+        'sethostname': f'{ltp_syscalls_path}/sethostname'
+    }
 
     # populate with not implemented, reserved, unmaintained syscalls defined
     # inside the syscalls file
@@ -134,6 +133,7 @@ def generate_syscalls_stats(_):
     if error:
         return
 
+    syscalls_base_dir = "https://github.com/linux-test-project/ltp/tree/master"
     text = [
         'Syscalls\n',
         '--------\n\n',
@@ -145,15 +145,33 @@ def generate_syscalls_stats(_):
     with open("syscalls.tbl", 'r', encoding='utf-8') as data:
         for line in data:
             match = regexp.search(line)
-            if match:
-                ker_syscalls.append(match.group('syscall'))
+            if not match:
+                continue
+
+            ker_syscalls.append(match.group('syscall'))
 
     # collect all LTP tested syscalls
-    ltp_syscalls = []
-    for _, _, files in os.walk('../testcases/kernel/syscalls'):
+    name_patterns = [
+        re.compile(r'(?P<name>[a-zA-Z_]+[^_])\d{2}\.c'),
+        re.compile(r'(?P<name>[a-zA-Z_]+[1-9])_\d{2}\.c'),
+    ]
+    ltp_syscalls = {}
+    for dirpath, _, files in os.walk(f'../{ltp_syscalls_path}'):
         for myfile in files:
-            if myfile.endswith('.c'):
-                ltp_syscalls.append(myfile)
+            match = None
+            for pattern in name_patterns:
+                match = pattern.search(myfile)
+                if match:
+                    break
+
+            if not match:
+                continue
+
+            # we need to use relative path from the project root
+            path = dirpath.replace('../', '')
+            name = match.group('name')
+
+            ltp_syscalls[name] = f'{syscalls_base_dir}/{path}'
 
     # compare kernel syscalls with LTP tested syscalls
     syscalls = {}
@@ -163,19 +181,19 @@ def generate_syscalls_stats(_):
 
         if kersc not in syscalls:
             if kersc in white_list:
-                syscalls[kersc] = True
+                syscalls[kersc] = f'{syscalls_base_dir}/{white_list[kersc]}'
                 continue
 
-            syscalls[kersc] = False
+            syscalls[kersc] = None
 
-        for ltpsc in ltp_syscalls:
-            if ltpsc.startswith(kersc):
-                syscalls[kersc] = True
+        for ltpsc, ltpsp in ltp_syscalls.items():
+            if ltpsc == kersc:
+                syscalls[kersc] = ltpsp
 
     # generate the statistics file
-    tested_syscalls = [key for key, val in syscalls.items() if val]
-    text.append(
-        'syscalls which are tested under :master:`testcases/kernel/syscalls`:\n\n')
+    tested_syscalls = [key for key, val in syscalls.items() if val is not None]
+    text.append('syscalls which are tested under '
+                ':master:`testcases/kernel/syscalls`:\n\n')
     text.append(f'* kernel syscalls: {len(ker_syscalls)}\n')
     text.append(f'* tested syscalls: {len(tested_syscalls)}\n\n')
 
@@ -198,12 +216,12 @@ def generate_syscalls_stats(_):
 
     max_columns = 3
 
-    for sysname, tested in syscalls.items():
-        if tested:
+    for sysname, path in syscalls.items():
+        if path is not None:
             if (index_tested % max_columns) == 0:
-                table_tested.append(f'    * - {sysname}\n')
+                table_tested.append(f'    * - `{sysname} <{path}>`_\n')
             else:
-                table_tested.append(f'      - {sysname}\n')
+                table_tested.append(f'      - `{sysname} <{path}>`_\n')
 
             index_tested += 1
         else:

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

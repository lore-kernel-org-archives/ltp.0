Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3524ED6DDC6
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 03:39:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 538FB3D726D
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 04:39:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 055A83D71FA
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 04:39:23 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7A1D661816
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 04:39:22 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so11064425e9.3
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 19:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731641962; x=1732246762; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dNkyh4KVAS3FMMjvSTvx8lVYPwTa0pBLLceM2H7HPY=;
 b=J1H7R+JOg83Ihn4Oh+Pv1/uDogr60vivRX1Kkh1vV92jDMQUjSUXd5DLPQSSMKjrkT
 MYWnRVpo4y/h/OTZlrCo/Z7ClpFxzdL5A0fglhk4ApuyowRmqQKDSW6L2CInq6/XK9mm
 JIEfddpmqYUnNXIVlLDSzheBXVpOkH0a0gy/lRBpnK8FRpPwGNmltnqUvPtGSHB7shFu
 sBgnOE4GPARfKlzQKZdvrBuJE2N/lE8+sSVZ4PjREyDJT1R0lYOROTgdw3oZuVB+ZYoZ
 aGFY85YMhn6x/Yree99b4Phxh7GI7MJwvrKuIPXZv4mypfMm9wCoFBH+hQT5V06BX/w6
 Cx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731641962; x=1732246762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dNkyh4KVAS3FMMjvSTvx8lVYPwTa0pBLLceM2H7HPY=;
 b=AjQOtA4QdGNlezdUBz9rYvcOn+ckI34dHF7oXeU0pDwxVxkLQFz8ITAlVVYrVtJQEZ
 fw2K00OHUcHb3oqQ0+ZX96n//bHTpnexws8QokovA8q9n/26DUs88S+FnEEoUcEwlYPD
 pgcPQc75yVicvT5ph7MMEo6Y+drh/gr30NeIrXApVgMPfxwbTOJ5W0GLKa8wFUllQrjS
 PMp2nXDw7idZ45HOqUrBVx4gam32szCDA7O3eDcKIXIeTNJTtw0BBUWFku60dpBYvvxp
 J9vJlGYGPMagZmGa8OFYeiwN8Z1ARoricBAMKEG2HTUnRIIUV//Qla6w4OHsDPd0Z+GV
 XZLw==
X-Gm-Message-State: AOJu0YzG17m+yViM6jfHZ9uJD6jdzhXMp0nBtSfy2SG2/6vH3uyC1O9Q
 n/BThRYWbfy0fcgyNMA8P/Xb3vzKX4y+mV7+hRid+XJNROzWoowv2hIXAA==
X-Google-Smtp-Source: AGHT+IHp1wVbzkDjpjifZZulg19Xk+16O+kR7GN9tcy6SSQ+0ZftMCoMn7alfnxBLii10MI7EGikmA==
X-Received: by 2002:a05:600c:4691:b0:432:c774:2e2b with SMTP id
 5b1f17b1804b1-432df79914dmr6452755e9.32.1731641962146; 
 Thu, 14 Nov 2024 19:39:22 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da29ffe9sm43609375e9.44.2024.11.14.19.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 19:39:21 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 04:39:16 +0100
Message-ID: <20241115033916.1707627-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115033916.1707627-1-petr.vorel@gmail.com>
References: <20241115033916.1707627-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: Add URL to the sources in syscalls list
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

From: Petr Vorel <pvorel@suse.cz>

Provide links to the sources of all tested syscalls.
Users can inspect the test coverage :).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py | 107 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 39 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index e14c1387d0..7c3da9e112 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -28,9 +28,11 @@ extensions = [
 ]
 
 exclude_patterns = ["html*", '_static*']
+github = 'https://github.com/linux-test-project/ltp'
+master = f'{github}/blob/master'
 extlinks = {
-    'repo': ('https://github.com/linux-test-project/ltp/%s', '%s'),
-    'master': ('https://github.com/linux-test-project/ltp/blob/master/%s', '%s'),
+    'repo': (f'{github}/%s', '%s'),
+    'master': (f'{master}/%s', '%s'),
     'git_man': ('https://git-scm.com/docs/git-%s', 'git %s'),
     # TODO: allow 2nd parameter to show page description instead of plain URL
     'kernel_doc': ('https://docs.kernel.org/%s.html', 'https://docs.kernel.org/%s.html'),
@@ -56,39 +58,53 @@ def generate_syscalls_stats(_):
     generate a file that is included in the statistics documentation section.
     """
     output = '_static/syscalls.rst'
+    syscalls_dir = 'testcases/kernel/syscalls'
 
+    # format syscall_name : folder (for URL, optional)
     # sometimes checking testcases/kernel/syscalls file names are not enough,
     # because in some cases (i.e. io_ring) syscalls are tested, but they are
     # part of a more complex scenario. In the following list, we define syscalls
     # which we know they are 100% tested already.
-    white_list = [
-        'epoll_pwait2',
-        'fadvise64',
-        'fanotify_init',
-        'fanotify_mark',
-        'getdents64',
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
-        'pkey_alloc',
-        'pkey_free',
-        'pkey_mprotect',
-        'prlimit64',
-        'pread64',
-        'pselect6',
-        'pwrite64',
-        'quotactl_fd',
-        'rt_sigpending',
-        'semtimedop',
-        'sethostname',
-    ]
+    # Or syscalls are here to get their folder.
+    white_list = {
+        'epoll_pwait2': 'epoll_pwait',
+        'fadvise64': 'fadvise',
+        'fanotify_init': 'fanotify',
+        'fanotify_mark': 'fanotify',
+        'futex_wait': 'futex',
+        'futex_waitv': 'futex',
+        'futex_wake': 'futex',
+        'getdents64': 'getdents',
+        'inotify_add_watch': 'inotify',
+        'inotify_rm_watch': 'inotify',
+        'inotify_init1': 'inotify',
+        'io_uring_enter': 'io_uring',
+        'io_uring_register': 'io_uring',
+        'io_uring_setup': 'io_uring',
+        'ioprio_get': 'ioprio',
+        'ioprio_set': 'ioprio',
+        'landlock_add_rule': 'landlock',
+        'landlock_create_ruleset': 'landlock',
+        'landlock_restrict_self': 'landlock',
+        'lsetxattr': 'lgetxattr', # llistxattr, lremovexattr
+        'newfstatat': 'fstatat',
+        'pkey_alloc': 'pkeys',
+        'pkey_free': 'pkeys',
+        'pkey_mprotect': 'pkeys',
+        'pread64': 'preadv',
+        'prlimit64': 'getrlimit',
+        'process_vm_readv': 'cma',
+        'process_vm_writev': 'cma',
+        'pselect6': 'select',
+        'pwrite64': 'pwrite',
+        'quotactl_fd': 'quotactl',
+        'rt_sigpending': 'sigpending',
+        'semtimedop': 'ipc/semop',
+        'sethostname': 'setdomainname',
+        'timerfd_gettime': 'timerfd',
+        'timerfd_settime': 'timerfd',
+        'timerfd_create': 'timerfd',
+    }
 
     # populate with not implemented, reserved, unmaintained syscalls defined
     # inside the syscalls file
@@ -144,28 +160,38 @@ def generate_syscalls_stats(_):
                 ker_syscalls.append(match.group('syscall'))
 
     # collect all LTP tested syscalls
-    ltp_syscalls = []
-    for root, _, files in os.walk('../testcases/kernel/syscalls'):
+    ltp_syscalls = {}
+    for root, _, files in os.walk('../' + syscalls_dir):
         for myfile in files:
             if myfile.endswith('.c'):
-                ltp_syscalls.append(myfile)
+                ltp_syscalls[myfile] = root[3:]
 
     # compare kernel syscalls with LTP tested syscalls
     syscalls = {}
+    url = {}
     for kersc in ker_syscalls:
         if kersc in black_list:
             continue
 
         if kersc not in syscalls:
-            if kersc in white_list:
+            if kersc in white_list.keys():
                 syscalls[kersc] = True
+                if white_list[kersc]:
+                    url[kersc] = syscalls_dir + '/' + white_list[kersc]
+
                 continue
 
             syscalls[kersc] = False
 
-        for ltpsc in ltp_syscalls:
+        for ltpsc in ltp_syscalls.keys():
             if ltpsc.startswith(kersc):
                 syscalls[kersc] = True
+                if kersc in url:
+                    continue
+                # Be conservative and use only directories which match exactly the syscall.
+                # Otherwise mkdir will be linked to mkdirat, openat to openat2, etc.
+                if os.path.basename(ltp_syscalls[ltpsc]) == kersc:
+                    url[kersc] = ltp_syscalls[ltpsc]
 
     # generate the statistics file
     tested_syscalls = [key for key, val in syscalls.items() if val]
@@ -192,18 +218,21 @@ def generate_syscalls_stats(_):
     ]
 
     for sysname, tested in syscalls.items():
+        name = f'{sysname}'
         if tested:
+            if sysname in url.keys():
+                name = f'`{sysname} <{github}/tree/master/{url[sysname]}>`_'
             if (index_tested % 3) == 0:
-                table_tested.append(f'    * - {sysname}\n')
+                table_tested.append(f'    * - {name}\n')
             else:
-                table_tested.append(f'      - {sysname}\n')
+                table_tested.append(f'      - {name}\n')
 
             index_tested += 1
         else:
             if (index_untest % 3) == 0:
-                table_untest.append(f'    * - {sysname}\n')
+                table_untest.append(f'    * - {name}\n')
             else:
-                table_untest.append(f'      - {sysname}\n')
+                table_untest.append(f'      - {name}\n')
 
             index_untest += 1
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

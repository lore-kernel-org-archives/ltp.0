Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A4D29FEF
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 11:50:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D8CC3C9A54
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:50:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 183423C58A2
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:50:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53C84200AEC
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:50:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A484C33D55;
 Wed, 14 Jan 2026 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768391426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UtOD4bqgwwYyEPw/F5PMaDI2Zx1XvCFlPl9MTh8dB9E=;
 b=HNKfoTsZvYCUbbNxh/xp9uIDpOzEAa0M1CR8auR4x3GqkQBR0XKE1vhi4Tv/7b3veY3g4v
 m3tMgo29UtM+MfHY6Qz/whQmnp00tq2XGoa9iKpLGHwloQvmH2rnjPswX7CU9y0zytefmo
 BNEvVuwSegkyuJd4WRQ7aRCm6+/6+QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768391426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UtOD4bqgwwYyEPw/F5PMaDI2Zx1XvCFlPl9MTh8dB9E=;
 b=3bmRgMfGwqHughT+v5bUU54578aDrMc5jtKz5aGY0qmAWSm3jXDLXM5v1e4Ir/KYXacOXt
 6bXQNrEl0+qjdYDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HNKfoTsZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3bmRgMfG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768391426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UtOD4bqgwwYyEPw/F5PMaDI2Zx1XvCFlPl9MTh8dB9E=;
 b=HNKfoTsZvYCUbbNxh/xp9uIDpOzEAa0M1CR8auR4x3GqkQBR0XKE1vhi4Tv/7b3veY3g4v
 m3tMgo29UtM+MfHY6Qz/whQmnp00tq2XGoa9iKpLGHwloQvmH2rnjPswX7CU9y0zytefmo
 BNEvVuwSegkyuJd4WRQ7aRCm6+/6+QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768391426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UtOD4bqgwwYyEPw/F5PMaDI2Zx1XvCFlPl9MTh8dB9E=;
 b=3bmRgMfGwqHughT+v5bUU54578aDrMc5jtKz5aGY0qmAWSm3jXDLXM5v1e4Ir/KYXacOXt
 6bXQNrEl0+qjdYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 506C23EA63;
 Wed, 14 Jan 2026 11:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JVd0EQKDZ2lRIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 11:50:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Jan 2026 12:50:20 +0100
Message-ID: <20260114115020.348101-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A484C33D55
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Use man7.org also for git man pages
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

https://man7.org/ has also git man pages (although slightly older than
on https://git-scm.com/), it's probably better than to have specific
config via extlinks for them.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py                           |  1 -
 doc/developers/test_case_tutorial.rst | 17 +++++++++--------
 doc/index.rst                         |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index d49cb4e77e..bb6afcbe20 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -35,7 +35,6 @@ extlinks = {
     'repo': (f'{ltp_repo}/%s', '%s'),
     'master': (f'{ltp_repo}/blob/master/%s', '%s'),
     'shell_lib': (f'{ltp_repo}/blob/master/testcases/lib/%s', '%s'),
-    'git_man': ('https://git-scm.com/docs/git-%s', 'git %s'),
     # TODO: allow 2nd parameter to show page description instead of plain URL
     'kernel_doc': ('https://docs.kernel.org/%s.html', 'https://docs.kernel.org/%s.html'),
     'kernel_tree': ('https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/%s', '%s'),
diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index f6495c4d72..08bd1b1519 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -58,8 +58,8 @@ test. At the time of writing there is no test for this call which was
 introduced in Linux kernel version 4.11.
 
 Linux system call specific tests are primarily contained in
-:master:`testcases/kernel/syscalls`, but you should also :git_man:`grep` the
-entire LTP repository to check for any existing usages of a system call.
+:master:`testcases/kernel/syscalls`, but you should also :manpage:`git-grep(1)`
+the entire LTP repository to check for any existing usages of a system call.
 
 One way to find a system call which is not currently tested by the LTP is to
 look at :kernel_tree:`include/linux/syscalls.h` in the Linux kernel tree.
@@ -252,8 +252,8 @@ to the below:
         smtpServer = smtp.server.address
 
 Obviously you need to at least change your name and e-mail. The SMTP server is
-useful for :git_man:`send-email`, which we will discuss later. The editor value is
-used for things like writing commits (without the ``-m`` option).
+useful for :manpage:`git-send-email(1)`, which we will discuss later. The
+editor value is used for things like writing commits (without the ``-m`` option).
 
 .. code-block:: bash
 
@@ -906,7 +906,7 @@ re-committing.
 
 You can also use ``edit`` and ``git commit --amend`` together to change a commit
 deep in your history, but without resetting the 'index'. The 'index' contains
-changes which you have staged with :git_man:`add`, but not yet committed.
+changes which you have staged with :manpage:`git-add(1)`, but not yet committed.
 
 So now that the commit history has been cleaned up, we need to submit a patch
 to the mailing list or make a pull request on GitHub. The mailing list is the
@@ -944,8 +944,8 @@ of the conflict. Usually, all you need to do is remove the lines you don't
 want, stage the changes and continue the ``rebase`` with ``git rebase
 --continue``.
 
-In order to create a patch e-mail we use :git_man:`format-patch`,
-we can then send that e-mail using :git_man:`send-email`.
+In order to create a patch e-mail we use :manpage:`git-format-patch(1)`,
+we can then send that e-mail using :manpage:`git-send-email(1)`.
 It is also possible to import the patch (``mbox``) file into a number of e-mail
 programs.
 
@@ -993,7 +993,8 @@ results. Once someone points out such an error it is usually obvious to
 everyone that it is a bug and needs to be fixed.
 
 Obviously testing the patch is one way of finding errors. You can apply patches
-using :git_man:`am`. Then it is just a case of compiling and running the tests.
+using :manpage:`git-am(1)`. Then it is just a case of compiling and running the
+tests.
 
 Finally, reading and attempting to comment on other peoples patches, gives
 you a better understanding of the reviewers perspective. This is better for
diff --git a/doc/index.rst b/doc/index.rst
index 06b75616fd..f78e7a4480 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -66,7 +66,7 @@ For developers
 .. descriptions here are active
 
 :doc:`developers/setup_mailinglist`
-   How to configure git and to start sending patches via :git_man:`send-email`.
+   How to configure git and to start sending patches via :manpage:`git-send-email(1)`.
 
 :doc:`developers/writing_tests`
    Starting guide on writing tests
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

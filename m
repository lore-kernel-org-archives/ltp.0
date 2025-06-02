Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B293C5AD49
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 17:09:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AF573C9DD1
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 19:08:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C19233C9A81
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 19:08:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 52C8A200261
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 19:08:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92BAD1F799;
 Mon,  2 Jun 2025 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748884119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ai4sFezJHsIU0ZzLJ7yitk03JN4YM5vRP1arHX8CjQA=;
 b=Et9XuEmekxB5xngamgnSLSGV7DYWmv101jyP8es4gJBv+i4uF7Mq/eq/xikMXsvIUfJKdz
 xgNKtl3pNfs0T74F3Wd65E5iV2daBl2+GpsyPDbywE5drdGz4HYQn8NCjNjBI5z4bsHG6u
 hY0W1uxAaBNTcjmbdscxitpvwx0N3xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748884119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ai4sFezJHsIU0ZzLJ7yitk03JN4YM5vRP1arHX8CjQA=;
 b=SORi7jHQ+KEols+QFrTmoW+ASzidE3U6rbG6oWDAKFfoVgJfIKV/tnCSGYV+S6suRFyC77
 1QR/9O4X3MZmMrDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748884119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ai4sFezJHsIU0ZzLJ7yitk03JN4YM5vRP1arHX8CjQA=;
 b=Et9XuEmekxB5xngamgnSLSGV7DYWmv101jyP8es4gJBv+i4uF7Mq/eq/xikMXsvIUfJKdz
 xgNKtl3pNfs0T74F3Wd65E5iV2daBl2+GpsyPDbywE5drdGz4HYQn8NCjNjBI5z4bsHG6u
 hY0W1uxAaBNTcjmbdscxitpvwx0N3xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748884119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ai4sFezJHsIU0ZzLJ7yitk03JN4YM5vRP1arHX8CjQA=;
 b=SORi7jHQ+KEols+QFrTmoW+ASzidE3U6rbG6oWDAKFfoVgJfIKV/tnCSGYV+S6suRFyC77
 1QR/9O4X3MZmMrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 469BE13A63;
 Mon,  2 Jun 2025 17:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aIiUDJbaPWgZHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Jun 2025 17:08:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  2 Jun 2025 19:08:30 +0200
Message-ID: <20250602170831.404641-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,configure.ac:url];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] configure: Fix build on kernel 6.14 headers
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

We decided in a2300dc0f5 to remove <linux/mount.h> in lapi/mount.h and
use only <sys/mount.h>. But later in 5c5411ea8e we add autotools checks
in configure.ac which use <linux/mount.h> for detection, but kept using
lapi/mount.h. This worked until now, because no toolchain used new
header enough. Recent Alpine update broke that.

This fixes CI build on Alpine v3.22 (the default Alpine version in
GitHub action), which uses 6.14.2 kernel headers, which already define
struct mnt_id_req (configure.ac detect it but lapi/mount.h was not using
a correct header):

    listmount.h: In function 'listmount':
    listmount.h:18:16: error: variable 'req' has initializer but incomplete type
       18 |         struct mnt_id_req req = {
	  |                ^~~~~~~~~~

Fixes: 5c5411ea8e ("Add listmount/statmount fallback declarations")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

CI fix (needed to fix already broken CI) for:
https://github.com/linux-test-project/ltp/actions/runs/15395092145/job/43318766502

Alternatively we could use our lapi differently:
lapi/mount.h for <sys/mount.h>
lapi/fsmount.h for <linux/mount.h> (and move there struct mnt_id_req
fallback definition).

If this looks better to you, maybe we should rename these 2 lapi headers
to make it obvious if they use kernel or libc header.

It's not clear to me how we want to use the headers: <sys/mount.h> for
old traditional mount things and <linux/mount.h>? Or do we prefer to
stick with one of them? Probably not, because using <linux/mount.h>
would likely require fallback old things which are only in
<sys/mount.h>.

It's also not clear to me what is more important from testing point:
libc headers or kernel headers.

And we have more mess in <sys/mount.h> vs. <linux/mount.h> use, e.g.
struct mount_attr testing in configure.ac uses the headers differently
than include/lapi/fsmount.h use:

configure.ac
AC_CHECK_TYPES([struct mount_attr],,,[
#ifdef HAVE_MOUNT_SETATTR
# include <sys/mount.h>
#elif HAVE_LINUX_MOUNT_H
# include <linux/mount.h>
#endif
])

include/lapi/fsmount.h
#if !defined(HAVE_FSOPEN) && defined(HAVE_LINUX_MOUNT_H)
# include <linux/mount.h>
#else
# include <sys/mount.h>
#endif

This works now, but it can break any time.

Last, but not least, once we do unification cleanup we could probably
get rid of checking many long existing headers which are part of
AC_CHECK_HEADERS_ONCE. Many of them did existed back then when uapi creation
was done in 3.7-rc1 (and before), but 4.4 we officially support contains
quite a lot of them (e.g. linux/module.h).

Kind regards,
Petr

 configure.ac | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7f475f6b64..13cded692f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -253,8 +253,10 @@ AC_CHECK_TYPES([struct mount_attr],,,[
 
 AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
-AC_CHECK_TYPES([struct mnt_id_req],,,[#include <linux/mount.h>])
-AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
+
+# Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
+AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
+AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
 # Tools knobs
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

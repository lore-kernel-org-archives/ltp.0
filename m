Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8113AC433EF
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD89E61179
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD89E61179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 297E23C8994
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 00:58:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F2F83C0930
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:57:58 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C709600C22
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:57:54 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id A9F981F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637279872; bh=PxhtOZi8FpecU5v9kfXKItkwreg65Wwi4desFZ3Y+10=;
 h=From:To:Cc:Subject:Date:From;
 b=M4ALlR2cuYk6zx0KDFSifzBYMHFKPlSLS0kB/nhfYjjpgCu//emofUTVvejjv7KeQ
 61Ybj6YZgJpyq7ut1hbQz1SABNcJC89FNleK94aSlKT2+R8it37wNA1nXIiToNOLxB
 9fWlb1+yLri+5gfsIUb3do2sw+6zkyvhSz3GMsrkym7XUbQhEayOAAH84ZLhJs6k30
 Qw/MCWrZ7epo/dxQm5lJ9iyC9s0CzFN+wqmvf/lYBKvbs6H/6OKxGVNGjOGILUCeLq
 U/zdRIlkd/PGVvgzSTa02x/RX5vJ0zOnCFQX/DgOVtLk7ToMbAc6l6u7CX2daGIvjV
 Q+iOHspbUjjrg==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: pvorel@suse.cz,
	jack@suse.com,
	amir73il@gmail.com,
	repnop@google.com
Date: Thu, 18 Nov 2021 18:57:35 -0500
Message-Id: <20211118235744.802584-1-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, linux-ext4@vger.kernel.org,
 kernel@collabora.com, ltp@lists.linux.it, khazhy@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

FAN_FS_ERROR was merged into Linus tree, and the PIDFD testcases reached
LTP.  Therefore, I'm sending a new version of the FAN_FS_ERROR LTP
tests.  This is the v4 of this patchset, and it applies the feedback of
the previous version.

Thanks,

---

Original cover letter:

FAN_FS_ERROR is a new (still unmerged) fanotify event to monitor
fileystem errors.  This patchset introduces a new LTP test for this
feature.

Testing file system errors is slightly tricky, in particular because
they are mostly file system dependent.  Since there are only patches for
ext4, I choose to make the test around it, since there wouldn't be much
to do with other file systems.  The second challenge is how we cause the
file system errors, since there is no error injection for ext4 in Linux.
In this series, this is done by corrupting specific data in the
test device with the help of debugfs.

The FAN_FS_ERROR feature is flying around linux-ext4 and fsdevel, and
the latest version is available on the branch below:

    https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-v9

A proper manpage description is also available on the respective mailing
list, or in the branch below:

    https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error

Please, let me know your thoughts.

Gabriel Krisman Bertazi (9):
  syscalls: fanotify: Add macro to require specific mark types
  syscalls: fanotify: Add macro to require specific events
  syscalls/fanotify22: Introduce FAN_FS_ERROR test
  syscalls/fanotify22: Validate the generic error info
  syscalls/fanotify22: Validate incoming FID in FAN_FS_ERROR
  syscalls/fanotify22: Support submission of debugfs commands
  syscalls/fanotify22: Create a corrupted file
  syscalls/fanotify22: Test file event with broken inode
  syscalls/fanotify22: Test capture of multiple errors

 configure.ac                                  |   3 +-
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  65 +++-
 .../kernel/syscalls/fanotify/fanotify03.c     |   4 +-
 .../kernel/syscalls/fanotify/fanotify10.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify22.c     | 314 ++++++++++++++++++
 7 files changed, 385 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify22.c

-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

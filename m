Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD9FC4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 12:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D97063CD13E
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 13:48:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA7173CD10D
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79FDC600681
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F22BD22D14;
 Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668516461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J5cppHZz7NukPWcQDPXBxU0j7aoQ2vistppD0wHBQzY=;
 b=WBqJmTAyCSVKWzhgnBIIM3KMfL1hX/fvaGbaFdVBLMSf0Ul96i/snJcOi2vF7d5mnZEjRf
 f1LZQTf6VLe6IFR3FRtKZUDPy1TsI43tFNv/a0v35jkJEzQNMy+85awmSXDaYDsVJzzZSF
 OY4LhsyqV6mGyg1pZnGs6oK/bFjT86I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668516461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J5cppHZz7NukPWcQDPXBxU0j7aoQ2vistppD0wHBQzY=;
 b=SVJq4zcScu5epWzvH3349xh9vhDXwqi9hVp5BfdfRoZCODum0tR00xFhU0GIu071eF4VwP
 vFpykRFiJmX0emCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E26C313AF8;
 Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wyo8N22Kc2PLTgAAMHmgww
 (envelope-from <jack@suse.cz>); Tue, 15 Nov 2022 12:47:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 457BDA0709; Tue, 15 Nov 2022 13:47:41 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 15 Nov 2022 13:47:35 +0100
Message-Id: <20221115123721.12176-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Make fanotify10 test yet more reliable
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello!

I was debugging with Pengfei Xu why fanotify10 testcase still occasionally
fails in his test setup. After a lot of back and forth we have identified two
causes. One lies within the kernel slab reclaim itself (fix submitted), the
other one is the inherent problem that slab reclaim needs to first reclaim
dentries (which means going through round of LRU aging before dentry is
reclaimed) and then inodes have to go through LRU aging before they are
reclaimed. As a result code dropping slab caches can decide there's not enough
forward progress and stop before the inodes we are interested in are evicted.

This patch modifies fanotify10 testcase to create multiple files / dirs with
ignore marks and return success if at least half of ignore marks got reclaimed.
This both gives slab reclaim code better feel of forward progress as well as
provides some robustness against some inode not being reclaimed for some random
reason.

With the kernel fix and this modification to fanotify10 testcase, Xu cannot
trigger the failure anymore.

								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

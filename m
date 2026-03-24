Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78ACE9A75A
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 10:40:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4018C3E4862
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 11:40:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 364873DDAD6
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 11:40:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC8FE1400C64
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 11:40:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9E214D1D4
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774348819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jjzzzWkh//P16N5GUFjtck/wStalr2nevyKZWtaW9Hs=;
 b=d3nm7cMb6xXGArOP8PA0d6HfRH0nqO3efSm/KJfRA0AL8NecWoc+PnKGkDdBhPQGynaPU8
 RvhiltWLUI8dZmS3iZOW3r9on+4hTiz+rvbDrnVIC/V2Z/pSz3iL4RVgotc+Pv6H4Pl67Q
 GJxTqB5OVWMaqCSp6zHw2y6h+g/gRk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774348819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jjzzzWkh//P16N5GUFjtck/wStalr2nevyKZWtaW9Hs=;
 b=oPRSonGoMlivyH4AfjJ0bQV3zAeh5JuyhV/fPH9Q2dWawprSyczLF+UG1W9k8GtMGdnmZJ
 n2XZsH3wsxAQcyDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="K/uRXX9r";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JDdDEz5U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774348818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jjzzzWkh//P16N5GUFjtck/wStalr2nevyKZWtaW9Hs=;
 b=K/uRXX9riy5qU0P+bQmH4Oub7gNFxPQieqB4Q+JXTCOtEta/sGiD9cv4Wos7yOUudMqMy/
 lwMUSSTVVcrUNvRFbpdCU0lzoRSD3CaIj87NKO540A3tlGSMamZuy1EDk9ChBXGeHbZPfO
 6Qo+Q2EVFAJbaxF68hxkalasJ/8Q8Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774348818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jjzzzWkh//P16N5GUFjtck/wStalr2nevyKZWtaW9Hs=;
 b=JDdDEz5UoaDJHIoAtmmneZ3pFoMGfUhOiSuFYsALpP2LY7fS51x332jhJmAx9Ql0kja/P1
 N2kfvZYlABsU96Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D77CA43DC6
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 10:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eDVmNBJqwmn3cAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 10:40:18 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Mar 2026 11:40:17 +0100
Message-ID: <20260324104018.10834-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E9E214D1D4
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cpuset_memory: Fix hugetlb mntpoint
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

The cpuset_memory test tries to mount hugetlb filesystem on a hardcoded
directory in the root filesystem. This doesn't work on distros with
read-only root. Change the mountpoint to the common temp directory
instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Tested on SLE-Micro 6.

 .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh   | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index d63950f8e..581df5c32 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -44,6 +44,7 @@ HUGEPAGESIZE=$(awk '/Hugepagesize/{ print $2 }' /proc/meminfo)
 HUGEPAGESIZE=$((${HUGEPAGESIZE:-0} * 1024))
 
 MEMORY_RESULT="$CPUSET_TMP/memory_result"
+HUGETLB_MNTPOINT="$CPUSET_TMP/hugetlb"
 
 # simple_getresult
 # $1 - cpuset_memory_test's pid
@@ -181,8 +182,8 @@ test6()
 		return 0
 	fi
 
-	mkdir /hugetlb
-	mount -t hugetlbfs none /hugetlb
+	mkdir "$HUGETLB_MNTPOINT"
+	mount -t hugetlbfs none "$HUGETLB_MNTPOINT"
 
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
 	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
@@ -190,8 +191,8 @@ test6()
 	cpuset_memory_test --shm --hugepage -s $HUGEPAGESIZE --key=7 >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 
-	umount /hugetlb
-	rmdir /hugetlb
+	umount "$HUGETLB_MNTPOINT"
+	rmdir "$HUGETLB_MNTPOINT"
 
 	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
 	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

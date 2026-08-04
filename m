Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD54C55822
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 16:15:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7F633E94AD
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 18:15:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47E533C73AF
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 18:15:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66DFF1A009BE
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 18:14:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99DCA3E7C;
 Tue,  4 Aug 2026 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785860093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xe0XM9HCcdawnuryzftfnDHuaqkfW852o4JKqEzIU8Y=;
 b=FY8IWRQp59zbdpjMI6p9BmusL28Vmv40qyrexh2Y5UEF4yfCrd7E8zyiwP4PAz020he/wZ
 ugyfYGgJnXin3sfpKGGvBeaf8a4WWOsFcCTnMfuFbumR6DN9qh6AW8UV/KfoVOx0eZ7LKM
 NYsWhD3iXJFVCSNc9gUyLvWSMxXjaDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785860093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xe0XM9HCcdawnuryzftfnDHuaqkfW852o4JKqEzIU8Y=;
 b=p44MU830fU33SYY7OREVHutnKTtBvc0ZUg0B/6BFqButXCfGdPK0CwxovosGJZj9db79uo
 OR4NLpFKRwFPcbAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785860089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xe0XM9HCcdawnuryzftfnDHuaqkfW852o4JKqEzIU8Y=;
 b=RS2V033gVNZPjIevgUFYzbVhoXtGXS2GEO/EapsQfW54/3Y5Hc3/79K5tKgiwajXFqWNq9
 kf53Pi5Z62iUqdf2ellnI+csy6P+2Kam/wtf6FIEo9VPuD6oUzOKmqDmASfFetqZh4pAdm
 tm663RycVLtrXH0n9e7Cab6tyFNEv7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785860089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xe0XM9HCcdawnuryzftfnDHuaqkfW852o4JKqEzIU8Y=;
 b=ETg621UtJlCHAV7TdpqRMF8Ufbm+wPwr4m9EGshLUj+S0Xa4C3hDMwA052pDssQpiZRFdX
 UDadtVs3vA/6W2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78F2B779C4;
 Tue,  4 Aug 2026 16:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 90yvG/kPcmokMQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Aug 2026 16:14:49 +0000
Date: Tue, 4 Aug 2026 18:14:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <anIP-a1bkmht2jKm@yuki.lan>
References: <20260717112629.1077734-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717112629.1077734-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap/hugemmap37: migrated task-size-overrun.c
 from libhugetlbfs
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with following diff, thanks.

Changes:

- use TDEBUG for the verbose messages
- use TST_EXP_* macros, on Linux mmap() without MAP_FIXED ignores the
  address hint and always succeeds
- moved the code that locates task_size into the test setup() so that
  it's called exactly once on test with -i 10

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
index c15b4ad33..addd717e3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -34,6 +34,7 @@
 #define MNTPOINT "hugetlbfs/"
 
 static long hpage_size;
+static unsigned long task_size;
 static int fd = -1;
 
 static unsigned long find_last_mapped(void)
@@ -100,10 +101,10 @@ static unsigned long find_task_size(void)
 		p = mmap((void *)addr, page_size, PROT_READ,
 			   MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
 		if (p == MAP_FAILED) {
-			tst_res(TINFO | TERRNO, "Map failed at 0x%lx", addr);
+			tst_res(TDEBUG | TERRNO, "Map failed at 0x%lx", addr);
 			high = pfn;
 		} else {
-			tst_res(TINFO, "Map succeeded at 0x%lx", addr);
+			tst_res(TDEBUG, "Map succeeded at 0x%lx", addr);
 			SAFE_MUNMAP(p, page_size);
 			low = pfn;
 		}
@@ -114,45 +115,35 @@ static unsigned long find_task_size(void)
 
 static void run_test(void)
 {
-	void *p;
-	unsigned long task_size;
 	unsigned long straddle_addr;
 
-	task_size = find_task_size();
-	tst_res(TINFO, "TASK_SIZE = 0x%lx", task_size);
-
 	straddle_addr = task_size - hpage_size;
 	straddle_addr = LTP_ALIGN(straddle_addr, hpage_size);
 
 	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
-	errno = 0;
-	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
-		 MAP_SHARED, fd, 0);
-	if (p == (void *)straddle_addr) {
-		tst_res(TFAIL, "Apparently succeeded in mapping across TASK_SIZE boundary");
-		SAFE_MUNMAP(p, 2*hpage_size);
-	} else if (p != MAP_FAILED) {
-		tst_res(TPASS, "mmap without MAP_FIXED correctly avoided TASK_SIZE boundary");
-		SAFE_MUNMAP(p, 2*hpage_size);
-	} else {
-		tst_res(TPASS, "mmap without MAP_FIXED correctly failed");
-	}
+
+	TST_EXP_PASS_PTR_VOID(mmap((void *)straddle_addr, 2*hpage_size,
+	                      PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0));
+
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, 2*hpage_size);
 
 	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
-	errno = 0;
-	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
-		 MAP_SHARED|MAP_FIXED, fd, 0);
-	if (p != MAP_FAILED) {
-		tst_res(TFAIL, "Apparently succeeded in mapping across TASK_SIZE boundary");
-		SAFE_MUNMAP(p, 2*hpage_size);
-	} else {
-		tst_res(TPASS, "mmap with MAP_FIXED correctly failed");
-	}
+
+	TST_EXP_FAIL_PTR_VOID(mmap((void *)straddle_addr, 2*hpage_size,
+	                      PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, fd, 0), ENOMEM);
+
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, 2*hpage_size);
 }
 
 static void setup(void)
 {
 	hpage_size = tst_get_hugepage_size();
+
+	task_size = find_task_size();
+	tst_res(TINFO, "TASK_SIZE = 0x%lx", task_size);
+
 	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

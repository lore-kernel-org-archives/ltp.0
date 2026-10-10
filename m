Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6213CA6017
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:52:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2843B3E2DF3
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:52:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 830B23E2D2C
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:27 +0200 (CEST)
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com
 [115.124.28.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1939C1000617
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:25 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00470521-3.42876e-05-0.995261;
 FP=8005206433184372203|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037031241;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jYP2TsF_1791625941; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jYP2TsF_1791625941 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 17:52:21 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Sat, 10 Oct 2026 17:51:55 +0800
Message-ID: <20261010095155.117953-4-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261010095155.117953-1-yehuaisheng@open-hieco.net>
References: <20261010095155.117953-1-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] hugemmap10: Account for memory policy in
 private fault checks
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

Kernels without private mmap-time reservations or with flags MAP_NORESERVE
create the reservation when the private VMA first faults. With MPOL_BIND,
globally free hugepages can be outside the allowed nodes, so this fault
can create surplus pages even when the global counters appear sufficient.

    $ numactl --cpunodebind=0 --membind=2 ./hugemmap10 -n
    tst_hugepage.c:84: TINFO: 3 hugepage(s) reserved
    tst_tmpdir.c:308: TINFO: Using /tmp/LTP_hugdeSTgL as tmpdir (xfs filesystem)
    tst_test.c:1218: TINFO: Mounting none to /tmp/LTP_hugdeSTgL/hugetlbfs fstyp=hugetlbfs flags=0
    tst_test.c:2048: TINFO: LTP version: 20260529-237-g132c8b0a8
    tst_test.c:2051: TINFO: Tested kernel: 7.3.0-rc1-test-32+ #33 SMP PREEMPT Mon Sep  7 11:50:02 CST 2026 x86_64
    tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
    tst_test.c:1876: TINFO: Overall timeout per run is 0h 00m 30s
    hugemmap10.c:498: TINFO: Base pool size: 0
    hugemmap10.c:425: TINFO: Clean...
    hugemmap10.c:476: TINFO: OK
    hugemmap10.c:425: TINFO: Untouched, shared...
    hugemmap10.c:476: TINFO: OK
    hugemmap10.c:425: TINFO: Untouched, private...
    hugemmap10.c:476: TINFO: OK
    hugemmap10.c:425: TINFO: Touched, shared...
    hugemmap10.c:476: TINFO: OK
    hugemmap10.c:425: TINFO: Touched, private...
    hugemmap10.c:476: TINFO: OK
    hugemmap10.c:498: TINFO: Base pool size: 1
    hugemmap10.c:425: TINFO: Clean...
    hugemmap10.c:448: TFAIL: While touching the addr after mmap private: Bad HugePages_Total: expected 1, actual 2
    hugemmap10.c:448: TFAIL: While touching the addr after mmap private: Bad HugePages_Free: expected 0, actual 1
    hugemmap10.c:448: TFAIL: While touching the addr after mmap private: Bad HugePages_Surp: expected 0, actual 1

    Summary:
    passed   0
    failed   3
    broken   0
    skipped  0
    warnings 0

Get free hugepages on allowed nodes before touching an unreserved
private mapping and use the maximum of the global and allowed-node
shortfalls to calculate the expected counters.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
Reviewed-by: Li Wang <li.wang@linux.dev>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 43aca50e1..b29c55a4f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -363,7 +363,7 @@ static int unmap_(int s, int hpages, int flags, char *desc, int line)
 	 * reservation.  If those pages were not touched, then they will
 	 * not have been freed by the code above.  Free them here.
 	 */
-	if ((flags & MAP_SHARED) || private_resv) {
+	if (mapping_creates_reservation(flags)) {
 		int unused_surplus = MIN(hpages - touched[s], es);
 
 		et -= unused_surplus;
@@ -378,10 +378,16 @@ static int unmap_(int s, int hpages, int flags, char *desc, int line)
 
 static int touch_(int s, int hpages, int flags, char *desc, int line)
 {
+	unsigned long allowed_free = 0;
 	long et, ef, er, es;
+	int creates_reservation = mapping_creates_reservation(flags);
 	int nr;
 	char *c;
 
+	/* An unreserved private mapping creates its reservation on fault. */
+	if (!creates_reservation)
+		allowed_free = read_allowed_free_hugepages();
+
 	for (c = map_addr[s], nr = hpages;
 			hpages && c < map_addr[s] + map_size[s];
 			c += hpage_size, nr--)
@@ -403,19 +409,18 @@ static int touch_(int s, int hpages, int flags, char *desc, int line)
 	 * which could elevate total, free, and surplus counts.  resv is
 	 * unchanged but free must be decreased.
 	 */
-	if (flags & MAP_SHARED || private_resv) {
+	if (creates_reservation) {
 		et = prev_total;
 		ef = prev_free - hpages;
 		er = prev_resv - hpages;
 		es = prev_surp;
 	} else {
-		if (hpages + prev_resv > prev_free)
-			et = prev_total + (hpages - prev_free + prev_resv);
-		else
-			et = prev_total;
+		unsigned long shortfall = surplus_pages_needed(hpages, allowed_free);
+
+		et = prev_total + shortfall;
 		er = prev_resv;
-		es = prev_surp + et - prev_total;
-		ef = prev_free - hpages + et - prev_total;
+		es = prev_surp + shortfall;
+		ef = prev_free - hpages + shortfall;
 	}
 	return verify_counters(line, desc, et, ef, er, es);
 }
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

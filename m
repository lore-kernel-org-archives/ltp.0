Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01FBE9B249
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99DAE3D0F8C
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 11:46:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D4EC3C7721
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:45:58 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71DB320098E
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 11:45:57 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61O98ZnT2236900; Tue, 24 Feb 2026 10:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=kQC127hTWxNRx7xURppD46UoPWFXtU+wsNtUD2TF1
 NY=; b=CqkFPuk4BO5MYiNlWJi/yjlmn9QGj9vsf1x2di050Ia2qtYAO99F0vzRd
 BAJN8V5YXGLCqeBHp/KKongIszsRUY2JtmHeDvAzgdo9h8xz1hrnXIuCiD5aPzc5
 O1yFMpnmWc0ScJAsQ09fBkLWckd6VAxG4lCmM52idl3EtLLIHLwntNdto14EcYrt
 Mid0C/X6BC6y6DxaKpnjIgoPoT8Jn+acX3qJY7XnHGT+WHEjAEBthuEU8yKnjNTb
 3k51kshSLpwEwNO2/8/W4xpFE5//Glh+nIxH21jDpbjIK2dX7MYcLpSsv/U33naf
 wP9FYl0LQHkcu4Oqjy8OXzwg64YoQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brth3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 10:45:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61O8fih5003386;
 Tue, 24 Feb 2026 10:45:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jravu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 10:45:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61OAjqB546072276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Feb 2026 10:45:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89D5C20049;
 Tue, 24 Feb 2026 10:45:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F4DA20040;
 Tue, 24 Feb 2026 10:45:52 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.aag-de.ibm.com (unknown
 [9.52.197.53]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Feb 2026 10:45:52 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz, jstultz@google.com
Date: Tue, 24 Feb 2026 11:45:44 +0100
Message-ID: <20260224104544.101292-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jaBoNcx91vxDZ6kHHvwkESenQjyPZiA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX540/pjCcKH1C
 i3sH79gWKCAbwX7v1A5WOzb+3WIOJdGl6QwO/9bBiGVavpvSWmup7Px7d1II8AYzUpRPolzVa+m
 VV4ZoUacJNfwPDqet+7gFcRqZO2jxGkCnriCdftlOnGtjPgkrksEh97x3odkMaGlsJ0dRQ083iO
 vLHr1bYUd6zAb3xBBalLX8mhv5cGwQCJ0zf+pyenW3ISuONgn16O6+vs/XqHTlFBP0CCcQim9Za
 l8vDiJO+n2XMwsJRFTP5dsYVS9uISCH385hJU56uQdjY6WN5x7Kts4xYLkUSa0OByZZlUwnZv/5
 iOSk5UuCpKeyFtLZDIpOZjF1Ql/naiQWZTdF/EffJLCQtaQ4ddkqfP2qL/GLZf33nGk1oEbIj3l
 wN1DiYue2Fs5al/ZLiIVokKZWpK1gJL+v7U1OcyCeSvI/v+IUcAcj13QPlvZmTEZnxBRwPPYqOS
 B0/HUCCRNHvQfpfx8dA==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699d8163 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=FgdYrcXGbhF60YLTsMQA:9
X-Proofpoint-GUID: gRWDLBXI76zLEDu4uOUdpoQyYAV3jgDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240087
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] sched_football: harden kickoff synchronization
 on high-CPU systems
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The sched_football test has been intermittently failing, most noticeably
on systems with many CPUs and/or under load, due to a startup ordering
hole around kickoff.

At game start the referee can transition into kickoff while not all
defense threads have reliably reached their blocking path yet. This
creates a window where offense threads may run and increment the_ball.

Fix the startup protocol:

- Introduce a dedicated defense_ready_barrier to rendezvous all defense
  threads with the referee before kickoff.
- Increase the pre-kickoff settle time (RT: 100 ms, non-RT: 2.5 s) to
  account for large CPU counts and loaded systems.
- Add a compiler barrier in the defense busy-loop to prevent it from
  being optimized away.
- Add an additional barrier step after the initial start phase so all
  threads are positioned deterministically before the game begins.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 .../func/sched_football/sched_football.c      | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 2cb85322d782..08cdc2fd8b4e 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -50,6 +50,7 @@ static tst_atomic_t game_over;
 static char *str_game_length;
 static char *str_players_per_team;
 static pthread_barrier_t start_barrier;
+static pthread_barrier_t defense_ready_barrier;
 
 /* These are fans running across the field. They're trying to interrupt/distract everyone */
 void *thread_fan(void *arg LTP_ATTRIBUTE_UNUSED)
@@ -81,11 +82,13 @@ void *thread_defense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "defense", 0, 0, 0);
 	pthread_barrier_wait(&start_barrier);
+	pthread_barrier_wait(&defense_ready_barrier);
 	while (!tst_atomic_load(&kickoff_flag))
 		;
 
-	/*keep the ball from being moved */
+	/* Keep the ball from being moved using a compiler barrier */
 	while (!tst_atomic_load(&game_over)) {
+		__asm__ __volatile__("" ::: "memory");
 	}
 
 	return NULL;
@@ -124,14 +127,18 @@ void referee(int game_length)
 	/* Start the game! */
 	atrace_marker_write("sched_football", "Game_started!");
 	pthread_barrier_wait(&start_barrier);
-	usleep(200000);
+
+	/* Wait for defense to be ready before starting the game */
+	pthread_barrier_wait(&defense_ready_barrier);
+
+	/* Give defense threads time to establish */
+	if (tst_check_preempt_rt())
+		usleep(100000);
+	else
+		usleep(2500000);
 
 	tst_atomic_store(0, &the_ball);
 	tst_atomic_store(1, &kickoff_flag);
-	if (tst_check_preempt_rt())
-		usleep(20000);
-	else
-		usleep(2000000);
 
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
@@ -170,6 +177,9 @@ static void do_test(void)
 	sched_setscheduler(0, SCHED_FIFO, &param);
 	tst_atomic_store(0, &kickoff_flag);
 
+	/* Defense ready barrier: defense threads + referee */
+	pthread_barrier_init(&defense_ready_barrier, NULL, players_per_team + 1);
+
 	/*
 	 * Start the offense
 	 * They are lower priority than defense, so they must be started first.
@@ -197,6 +207,7 @@ static void do_test(void)
 	referee(game_length);
 
 	pthread_barrier_destroy(&start_barrier);
+	pthread_barrier_destroy(&defense_ready_barrier);
 }
 
 static void do_setup(void)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

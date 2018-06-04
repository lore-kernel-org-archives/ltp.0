From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Mon, 4 Jun 2018 15:27:31 +0800
Subject: [LTP] [PATCH] sctp: change the layout of tst_brkm()
Message-ID: <20180604072731.5409-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The statement tst_brkm(TBROK, tst_exit, "a b"
                   "c");
which will error output "a bc", and this layout do not good for git grep.

Reported-by: Wei Xingshen <weixshen@gmail.com>
Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 utils/sctp/testlib/sctputil.c | 71 +++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/utils/sctp/testlib/sctputil.c b/utils/sctp/testlib/sctputil.c
index 564925ce9..d1a1ae988 100644
--- a/utils/sctp/testlib/sctputil.c
+++ b/utils/sctp/testlib/sctputil.c
@@ -185,29 +185,29 @@ test_check_buf_notification(void *buf, int datalen, int msg_flags,
 	union sctp_notification *sn;
 	
 	if (!(msg_flags & MSG_NOTIFICATION))
-		tst_brkm(TBROK, tst_exit, "Got a datamsg, expecting "
-			 "notification");
+		tst_brkm(TBROK, tst_exit,
+			 "Got a datamsg, expecting notification");
 	
 	if (expected_datalen <= 0)
 		return;
 
 	if (datalen != expected_datalen)
-		tst_brkm(TBROK, tst_exit, "Got a notification of unexpected "
-			 "length:%d, expected length:%d", datalen,
-			 expected_datalen);
+		tst_brkm(TBROK, tst_exit,
+		     "Got a notification of unexpected length:%d, expected length:%d",
+		      datalen, expected_datalen);
 		
 	sn = (union sctp_notification *)buf;
 	if (sn->sn_header.sn_type != expected_sn_type)
-		tst_brkm(TBROK, tst_exit, "Unexpected notification:%d"
-			 "expected:%d", sn->sn_header.sn_type,
-			  expected_sn_type);
+		tst_brkm(TBROK, tst_exit,
+             "Unexpected notification:%d expected:%d",
+              sn->sn_header.sn_type, expected_sn_type);
 	
 	switch(sn->sn_header.sn_type){
 	case SCTP_ASSOC_CHANGE:
 		if (sn->sn_assoc_change.sac_state != expected_additional)
-			tst_brkm(TBROK, tst_exit, "Unexpected sac_state:%d "
-				 "expected:%d", sn->sn_assoc_change.sac_state,
-				  expected_additional);
+			tst_brkm(TBROK, tst_exit,
+                 "Unexpected sac_state:%d expected:%d",
+                  sn->sn_assoc_change.sac_state, expected_additional);
 		break;
 	default:
 		break;
@@ -237,35 +237,38 @@ test_check_buf_data(void *buf, int datalen, int msg_flags,
 		    uint32_t expected_ppid)
 {
 	if (msg_flags & MSG_NOTIFICATION)
-		tst_brkm(TBROK, tst_exit, "Got a notification, expecting a"
-			 "datamsg");
+		tst_brkm(TBROK, tst_exit,
+			 "Got a notification, expecting a datamsg");
 
 	if (expected_datalen <= 0)
 		return;
 
 	if (datalen != expected_datalen)
-		tst_brkm(TBROK, tst_exit, "Got a datamsg of unexpected "
-			 "length:%d, expected length:%d", datalen,
-			 expected_datalen);
+		tst_brkm(TBROK, tst_exit,
+             "Got a datamsg of unexpected length:%d, expected length:%d",
+              datalen, expected_datalen);
 
 	if ((msg_flags & ~0x80000000) != expected_msg_flags)
-		tst_brkm(TBROK, tst_exit, "Unexpected msg_flags:0x%x "
-			 "expecting:0x%x", msg_flags, expected_msg_flags);
+		tst_brkm(TBROK, tst_exit,
+             "Unexpected msg_flags:0x%x expecting:0x%x",
+              msg_flags, expected_msg_flags);
 
 	if ((0 == expected_stream) && (0 == expected_ppid))
 		return; 
 
 	if (!sinfo)
-		tst_brkm(TBROK, tst_exit, "Null sinfo, but expected "
-			 "stream:%d expected ppid:%d", expected_stream,
-			 expected_ppid);
+		tst_brkm(TBROK, tst_exit,
+             "Null sinfo, but expected stream:%d expected ppid:%d",
+              expected_stream, expected_ppid);
 
 	if (sinfo->sinfo_stream != expected_stream)
-		tst_brkm(TBROK, tst_exit, "stream mismatch: expected:%x "
-			 "got:%x", expected_stream, sinfo->sinfo_stream);
+		tst_brkm(TBROK, tst_exit,
+             "stream mismatch: expected:%x got:%x",
+              expected_stream, sinfo->sinfo_stream);
 	if (sinfo->sinfo_ppid != expected_ppid)
-		tst_brkm(TBROK, tst_exit, "ppid mismatch: expected:%x "
-			 "got:%x\n", expected_ppid, sinfo->sinfo_ppid);
+		tst_brkm(TBROK, tst_exit,
+             "ppid mismatch: expected:%x got:%x\n",
+              expected_ppid, sinfo->sinfo_ppid);
 }
 
 /* Check if a message corresponds to data, its length, msg_flags, stream and
@@ -356,8 +359,8 @@ static int cmp_addr(sockaddr_storage_t *addr1, sockaddr_storage_t *addr2)
 		return memcmp(&addr1->v4.sin_addr, &addr2->v4.sin_addr,
 			      sizeof(addr1->v4.sin_addr));
 	default:
-		tst_brkm(TBROK, tst_exit, "invalid address type %d",
-			 addr1->sa.sa_family);
+		tst_brkm(TBROK, tst_exit,
+             "invalid address type %d", addr1->sa.sa_family);
 		return -1;
 	}
 }
@@ -375,13 +378,15 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 
 	error = sctp_getpaddrs(sk, asoc, &addrs);
 	if (-1 == error) {
-		tst_brkm(TBROK, tst_exit, "sctp_getpaddrs: %s", strerror(errno));
+		tst_brkm(TBROK, tst_exit,
+             "sctp_getpaddrs: %s", strerror(errno));
 		return error;
 	}
 	if (error != count) {
 		sctp_freepaddrs(addrs);
-		tst_brkm(TBROK, tst_exit, "peer count %d mismatch, expected %d",
-			 error, count);
+		tst_brkm(TBROK, tst_exit,
+             "peer count %d mismatch, expected %d",
+			   error, count);
 	}
 	addrbuf = addrs;
 	for (i = 0; i < count; i++) {
@@ -398,7 +403,8 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 		default:
 			errno = EINVAL;
 			sctp_freepaddrs(addrs);
-			tst_brkm(TBROK, tst_exit, "sctp_getpaddrs: %s", strerror(errno));
+			tst_brkm(TBROK, tst_exit,
+                 "sctp_getpaddrs: %s", strerror(errno));
 			return -1;
 		}
 		for (j = 0; j < count; j++) {
@@ -410,7 +416,8 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
 	}
 	for (j = 0; j < count; j++) {
 		if (found[j] == 0) {
-			tst_brkm(TBROK, tst_exit, "peer address %d not found", j);
+			tst_brkm(TBROK, tst_exit,
+                 "peer address %d not found", j);
 		}
 	}
 	sctp_freepaddrs(addrs);
-- 
2.17.0




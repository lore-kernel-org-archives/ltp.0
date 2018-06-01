From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 13:49:53 +0200
Subject: [LTP] [PATCH 4/7] net/ftp: Replace $ipver by $TST_IPVER from
	tst_net.sh
In-Reply-To: <20180601114956.17265-1-pvorel@suse.cz>
References: <20180601114956.17265-1-pvorel@suse.cz>
Message-ID: <20180601114956.17265-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ftp/ftp-download-stress | 3 +--
 testcases/network/stress/ftp/ftp-upload-stress   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/network/stress/ftp/ftp-download-stress b/testcases/network/stress/ftp/ftp-download-stress
index 13ecbd067..159529ff6 100644
--- a/testcases/network/stress/ftp/ftp-download-stress
+++ b/testcases/network/stress/ftp/ftp-download-stress
@@ -45,8 +45,7 @@ setup()
 	tst_check_cmds pkill vsftpd
 	tst_tmpdir
 
-	ipver=${TST_IPV6:-'4'}
-	tst_resm TINFO "run FTP over IPv$ipver"
+	tst_resm TINFO "run FTP over IPv$TST_IPVER"
 
 	trap "tst_brkm TBROK 'test interrupted'" INT
 
diff --git a/testcases/network/stress/ftp/ftp-upload-stress b/testcases/network/stress/ftp/ftp-upload-stress
index 402f50f65..8dc2219b3 100644
--- a/testcases/network/stress/ftp/ftp-upload-stress
+++ b/testcases/network/stress/ftp/ftp-upload-stress
@@ -45,8 +45,7 @@ setup()
 	tst_check_cmds pkill vsftpd
 	tst_tmpdir
 
-	ipver=${TST_IPV6:-'4'}
-	tst_resm TINFO "run FTP over IPv$ipver"
+	tst_resm TINFO "run FTP over IPv$TST_IPVER"
 
 	trap "tst_brkm TBROK 'test interrupted'" INT
 
-- 
2.16.3


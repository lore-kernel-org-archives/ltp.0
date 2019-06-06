From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Jun 2019 13:34:30 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/fstat{01,02}: rewrote testcases
In-Reply-To: <20190606090009.31124-1-camann@suse.com>
References: <20190606090009.31124-1-camann@suse.com>
Message-ID: <20190606113430.GA13068@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

The fstat01 was in the quickhit runtest file as well,, removed that.

And as for the test, we don't have to print another TFAIL message on
failure and we should be more strict about checking the return value
(the test would pass if fstat returned garbage that != -1)

 static void run(void)
 {
-	int fail;
+	int fail = 0;
 
 	TEST(fstat(fildes, &stat_buf));
 
-	if (TST_RET == -1) {
+	if (TST_RET != 0) {
 		tst_res(TFAIL | TTERRNO, "fstat() failed");
 		return;
 	}
@@ -61,10 +61,8 @@ static void run(void)
 		fail++;
 	}
 
-	if (fail) {
-		tst_res(TFAIL, "fstat() reported wrong values.");
+	if (fail)
 		return;
-	}
 
 	tst_res(TPASS, "fstat() reported correct values.");
 }

-- 
Cyril Hrubis
chrubis@suse.cz

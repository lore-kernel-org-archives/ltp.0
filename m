From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Feb 2021 07:48:46 +0100
Subject: [LTP] [PATCH 2/2] close_range02: Add simpler test and Check
 invalid params
In-Reply-To: <20210215155322.32623-1-rpalethorpe@suse.com>
References: <20210215155322.32623-1-rpalethorpe@suse.com>
Message-ID: <YCtqzlNKb/GbGXBM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> This adds some coverage for invalid parameters and a min fd above or
> on the limits. There is also some overlap with close_range01, but this
> test is simpler and has less requirements.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, just minor nit: could we close file descriptor?
Otherwise it fails on higher -i (> 50). Something like code below?

Kind regards,
Petr

diff --git testcases/kernel/syscalls/close_range/close_range02.c testcases/kernel/syscalls/close_range/close_range02.c
index 9e099cec4..237b3d759 100644
--- testcases/kernel/syscalls/close_range/close_range02.c
+++ testcases/kernel/syscalls/close_range/close_range02.c
@@ -42,7 +42,7 @@ static void run(unsigned int n)
 		.flags = CLONE_FILES,
 		.exit_signal = SIGCHLD,
 	};
-	int fd, res;
+	int fd = -1, res;
 
 	switch (n) {
 	case 0:
@@ -101,6 +101,9 @@ static void run(unsigned int n)
 
 		TST_EXP_PASS(fcntl(fd, F_GETFD), "%d is open", fd);
 	}
+
+	if (n != 0 && fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {

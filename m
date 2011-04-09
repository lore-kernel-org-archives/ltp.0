Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8RPL-0006nW-ET
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 06:12:31 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8RPK-0004wD-Ig
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 06:12:31 +0000
Received: by pwj9 with SMTP id 9so2240107pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Apr 2011 23:12:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110409032325.GA2578@epc900.nay.redhat.com>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
	<BANLkTimC1VXcu1DTfR+nOK5sx5vvKguZkQ@mail.gmail.com>
	<20110409032325.GA2578@epc900.nay.redhat.com>
Date: Fri, 8 Apr 2011 23:12:24 -0700
Message-ID: <BANLkTimHzFEY8-ECzh7++oK97oboW31zdQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] thp testcase come from CVE reproducer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Han Pingtian <phan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Apr 8, 2011 at 8:23 PM, Han Pingtian <phan@redhat.com> wrote:
> I have updated the patch based on your suggestions. Please review.
>
> Thanks.

An inline diff would have been nice. Anyhow..

...

+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "thp01";
+int TST_TOTAL = 1;
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/types.h>
+#include <sys/wait.h>

Please read the style guide and the example code I've provided in the
style guide. This doesn't conform to those examples.

+int main(int argc, char **argv)
+{
+	int i, lc, st;
+	pid_t pid;
+	char *msg;
+	char *c[257];
+	char cc[32*4096];
+	struct rlimit rl = {
+		.rlim_cur = RLIM_INFINITY,
+		.rlim_max = RLIM_INFINITY,
+	};
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		switch (pid = fork()) {
+			case -1:

Unnecessary indentation.

+				tst_brkm(TBROK|TERRNO, NULL, "fork");
+			case 0:
+				memset(cc, 'c', 32*4096-1);
+				cc[32*4096-1] = '\0';

Make the magic number (32*4096-1) a number. BTW -- did you derive this
from a pagesize or something? If so, you should really use the sysconf
function to derive _SC_PAGESIZE.

+				for (i=0;i<256;i++)

[Lack of] whitespace.

+					c[i] = cc;
+				if (setrlimit(RLIMIT_STACK, &rl) == -1) {
+					perror("setrlimit");
+					exit(1);
+				}
+				if (execve("/bin/true", c, c) == -1) {
+					perror("execve");
+					exit(2);
+				}

So, this isn't supposed to exit I assume? Seems kind of funky (i.e.
would run out of processes).

+			default:
+				if (waitpid(pid, &st, 0) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "waitpid");
+
+				if (!WIFEXITED(st))
+					tst_brkm(TBROK, NULL, "child exits abnormally");

*exited.

+				if (WEXITSTATUS(st) == 2)
+					tst_brkm(TBROK, NULL, "Do you have /bin/true installed?");

Add a check at the beginning of the test to ensure (via stat) that
/bin/true exists. That way you can skip this check.

+				if (WEXITSTATUS(st) != 0)
+					tst_brkm(TBROK, NULL, "chaild exits with non-zero value");

You didn't do a proper exit(0). How is this possible (unless the
forked child runs to completion and exits the loop first which just
seems like a bad idea because you're executing tst_exit() at the
bottom)?

+				tst_resm(TPASS, "thp01 pass");

How do you know it passes from just one run when it could cascade over
several iterations? My gut feeling is that this really should be moved
somewhere else.

+		}
+	}
+
+        tst_exit();

Indentation is off.

+}

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

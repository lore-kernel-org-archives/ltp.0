From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  2 Oct 2017 11:19:49 +0200
Subject: [LTP] [RFC] [PATCH] lib/tst_test: Do TBROK on unexpected arguments.
Message-ID: <20171002091949.21900-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The argument parsing code in the test library ignored positional arguments and
that lead to:

commit 8501feeb89e8a47e7feacd80179d852c3810249c
Author: Sandeep Patil <sspatil@google.com>
Date:   Fri Sep 22 15:59:41 2017 -0700

    mm: mmapstress04: Remove arguments passed to the test.

Which removed leftover arguments from the testcase much later after the test
was rewritten. The correct behavior for the library is to issue TBROK on
unexpected command line parameters.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index a627242a6..26414e31c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -491,6 +491,9 @@ static void parse_opts(int argc, char *argv[])
 			parse_topt(topts_len, opt, optarg);
 		}
 	}
+
+	if (optind < argc)
+		tst_brk(TBROK, "Unexpected argument(s) '%s'...", argv[optind]);
 }
 
 int tst_parse_int(const char *str, int *val, int min, int max)
-- 
2.13.5


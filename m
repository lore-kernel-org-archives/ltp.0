From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  3 Sep 2018 13:13:31 +0200
Subject: [LTP] [COMMITTED] [PATCH] lib/tst_test.c: Silence warnings.
Message-ID: <20180903111331.19189-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tst_brk() will call exit() which will exit the test but the compiler
does not know about this and produces useless warnings about fall
through in switch().

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index bdd47f562..adc525a1e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -352,6 +352,7 @@ static void check_child_status(pid_t pid, int status)
 	case TBROK:
 	case TCONF:
 		tst_brk(ret, "Reported by child (%i)", pid);
+	break;
 	default:
 		tst_brk(TBROK, "Invalid child (%i) exit value %i", pid, ret);
 	}
@@ -493,6 +494,7 @@ static void parse_opts(int argc, char *argv[])
 		case '?':
 			print_help();
 			tst_brk(TBROK, "Invalid option");
+		break;
 		case 'h':
 			print_help();
 			exit(0);
-- 
2.16.4


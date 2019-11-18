From: Dylan Chung <dylan@andestech.com>
Date: Mon, 18 Nov 2019 17:58:58 +0800
Subject: [LTP] [PATCH v2] pan/ltp-pan.c: Add file parsing protection
Message-ID: <20191118095858.22067-1-dylan@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

------------------
v1->v2:
1.replace "strlen(a)==0" with "a[0]== 0".
2.Add more detail description in commit message.
------------------

This patch adds protection and print warning when the command part
of the tests is empty.
A segmentation fault occurs when given the wrong format in test cases file.
for example:
    name  command line
    ----- -----------------
    dio10 diotest4 -b 65536    (O)
    dio10                      (X)
    dio10    diotest4 -b 65536 (X)
In this patch, ltp-pan will return empty collection when the given
testcase files are wrongly formatted and cause ltp-pan to abort.
The warning message will indicate the name of the error testcase.

Signed-off-by: Dylan Chung <dylan@andestech.com>
---
 pan/ltp-pan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 8ac484ec6..e3d2e619d 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -1200,6 +1200,14 @@ static struct collection *get_collection(char *file, int optind, int argc,
 				n->pcnt_f[1] = 's';
 			}
 			n->name = strdup(strsep(&a, " \t"));
+			while (a != NULL && isspace(*a))
+				a++;
+			if (a == NULL || a[0] == 0) {
+				fprintf(stderr,
+					"pan(%s): Testcase '%s' requires a command to execute.\n",
+					panname, n->name);
+				return NULL;
+			}
 			n->cmdline = strdup(a);
 			n->next = NULL;
 
-- 
2.17.0


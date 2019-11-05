From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Nov 2019 13:00:53 +0100
Subject: [LTP] [PATCH] lib/tst_test: Warn on repeated options
Message-ID: <20191105120053.9173-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The library is not designed in a way that would allow us to pass an
option mutiple times, if such case the last option occurence replaces
all previous ones.

This patch adds a warning in a case that the option pointer is non-NULL,
which means that it has been set at least once already.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index c7b46d0d5..f41baf3cf 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -468,6 +468,9 @@ static void parse_topt(unsigned int topts_len, int opt, char *optarg)
 	if (i >= topts_len)
 		tst_brk(TBROK, "Invalid option '%c' (should not happen)", opt);
 
+	if (*toptions[i].arg)
+		tst_res(TWARN, "Option passed -%c multiple times", opt);
+
 	*(toptions[i].arg) = optarg ? optarg : "";
 }
 
-- 
2.21.0


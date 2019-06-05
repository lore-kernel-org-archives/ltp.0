From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Jun 2019 15:56:41 +0200
Subject: [LTP] [PATCH] README: Add note about testing with Travis CI
Message-ID: <20190605135641.1848-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 README.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README.md b/README.md
index 1eb4747c3..c017b5032 100644
--- a/README.md
+++ b/README.md
@@ -185,3 +185,6 @@ list. Also note that these documents are available online at:
 * https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
 
 Although we accept GitHub pull requests, the preferred way is sending patches to our mailing list.
+
+It's recommended to test patches on Travis CI before posting to mailing list
+(sign up to Travis CI and enable running builds on your LTP fork on https://travis-ci.org/account/repositories).
-- 
2.21.0


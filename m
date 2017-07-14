From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 14 Jul 2017 11:55:23 +0200
Subject: [LTP] [PATCH v3 2/2] README: Update developer section
In-Reply-To: <20170714095523.5518-1-rpalethorpe@suse.com>
References: <20170714095523.5518-1-rpalethorpe@suse.com>
Message-ID: <20170714095523.5518-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the C tutorial and remove the comment about this being all the information
that is needed. That depends on the reader and the test they want to write or
edit.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 README.md | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index a7c0b8a91..85c612cc2 100644
--- a/README.md
+++ b/README.md
@@ -128,12 +128,13 @@ Before you start you should read following documents:
 * `doc/test-writing-guidelines.txt`
 * `doc/build-system-guide.txt`
 
-these two should contain all information needed for modifying or creating LTP
-testcases. If something is not covered there don't hesitate to ask on the LTP
-mailing list.
+There is also a step-by-step tutorial:
 
-Also note that these documents are available online at:
+* `doc/c-test-tutorial-simple.txt`
 
-https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
+If something is not covered there don't hesitate to ask on the LTP mailing
+list. Also note that these documents are available online at:
 
+https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
 https://github.com/linux-test-project/ltp/wiki/BuildSystem
+https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
-- 
2.13.2


From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 May 2021 17:49:53 +0200
Subject: [LTP] [PATCH 1/1] docparse: s/Tags/Tag/
Message-ID: <20210520154953.32623-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because allother header cells are singular.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 6e05982e5..c11064c05 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -428,7 +428,7 @@ sub content_all_tests
 
 		for my $tag (@sorted_tags) {
 			if (!defined($tmp2)) {
-				$content .= table . "|Tags|Info\n"
+				$content .= table . "|Tag|Info\n"
 			}
 			my $k = @$tag[0];
 			my $v = @$tag[1];
-- 
2.31.1


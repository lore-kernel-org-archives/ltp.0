From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 May 2021 21:02:40 +0200
Subject: [LTP] [PATCH v2 5/5] docparse: Fix headers
In-Reply-To: <20210504190240.24250-1-pvorel@suse.cz>
References: <20210504190240.24250-1-pvorel@suse.cz>
Message-ID: <20210504190240.24250-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

headers started from tag <h2> instead of <h1>. This results in bigger
font size for headers thus removing horizontal ruler (<hr />).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 857278ac8..8bc4623b6 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -87,11 +87,6 @@ sub code
 	return "+$_[0]+";
 }
 
-sub hr
-{
-	return "\n\n'''\n\n";
-}
-
 sub html_a
 {
 	my ($url, $text) = @_;
@@ -104,17 +99,17 @@ sub html_a
 
 sub h1
 {
-	return "== $_[0]\n";
+	return "= $_[0]\n";
 }
 
 sub h2
 {
-	return "=== $_[0]\n";
+	return "== $_[0]\n";
 }
 
 sub h3
 {
-	return "==== $_[0]\n";
+	return "=== $_[0]\n";
 }
 
 sub label
@@ -355,7 +350,6 @@ sub content_all_tests
 			$printed = $letter;
 		}
 
-		$content .= hr() if (defined($tmp));
 		$content .= label($name);
 		$content .= h3($name);
 		$content .= $letters;
-- 
2.31.1


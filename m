From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 May 2021 15:54:58 +0200
Subject: [LTP] [COMMITTED] [PATCH] Revert "docparse: Fix heading levels"
Message-ID: <20210512135458.12444-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This reverts commit 04a7608fe4f7fe2c267216d8b90acf019bdea824.

Fixes build with asciidoc that otherwise failed with:

...
asciidoc: ERROR: filters.txt: line 4: only book doctypes can contain level 0 sections
...
asciidoc: ERROR: all-tests.txt: line 4: only book doctypes can contain level 0 sections

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 8bc4623b6..857278ac8 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -87,6 +87,11 @@ sub code
 	return "+$_[0]+";
 }
 
+sub hr
+{
+	return "\n\n'''\n\n";
+}
+
 sub html_a
 {
 	my ($url, $text) = @_;
@@ -99,17 +104,17 @@ sub html_a
 
 sub h1
 {
-	return "= $_[0]\n";
+	return "== $_[0]\n";
 }
 
 sub h2
 {
-	return "== $_[0]\n";
+	return "=== $_[0]\n";
 }
 
 sub h3
 {
-	return "=== $_[0]\n";
+	return "==== $_[0]\n";
 }
 
 sub label
@@ -350,6 +355,7 @@ sub content_all_tests
 			$printed = $letter;
 		}
 
+		$content .= hr() if (defined($tmp));
 		$content .= label($name);
 		$content .= h3($name);
 		$content .= $letters;
-- 
2.26.3


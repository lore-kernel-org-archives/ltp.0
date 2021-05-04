From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 May 2021 21:02:38 +0200
Subject: [LTP] [PATCH v2 3/5] docparse: Make tags in table clickable
In-Reply-To: <20210504190240.24250-1-pvorel@suse.cz>
References: <20210504190240.24250-1-pvorel@suse.cz>
Message-ID: <20210504190240.24250-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

linked to the section.

Acked-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 194365ea3..2aeee1a17 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -95,6 +95,10 @@ sub hr
 sub html_a
 {
 	my ($url, $text) = @_;
+
+	# escape ]
+	$text =~ s/([]])/\\$1/g;
+
 	return "$url\[$text\]";
 }
 
@@ -125,7 +129,12 @@ sub paragraph
 
 sub reference
 {
-	return "xref:$_[0]\[$_[0]\]" . (defined($_[1]) ? $_[1] : "") . "\n";
+	my ($link, %args) = @_;
+
+	$args{text} //= $link;
+	$args{delimiter} //= "";
+
+	return "xref:$link\[$args{text}\]$args{delimiter}\n";
 }
 
 sub table
@@ -179,7 +188,7 @@ sub get_test_names
 			$content .= "\n";
 		}
 
-		$content .= reference($name, " ");
+		$content .= reference($name, delimiter => " ");
 		$prev_letter = $letter;
 	}
 	$content .= "\n";
@@ -388,7 +397,7 @@ sub content_all_tests
 				$content .= table . "|Key|Value\n\n"
 			}
 
-			$content .= "|" . tag2title($k) . "\n|";
+			$content .= "|" . reference($k, text => tag2title($k)) . "\n|";
 
 			if (ref($v) eq 'ARRAY') {
 				# two dimensional array
@@ -434,7 +443,7 @@ sub content_all_tests
 			}
 
 			$v = html_a(tag_url($k, @$tag[1]), $v);
-			$content .= "\n|$k\n|$v\n";
+			$content .= "\n|" . reference($k) . "\n|$v\n";
 			$tmp2 = 1;
 		}
 		if (defined($tmp2)) {
-- 
2.31.1


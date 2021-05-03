From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 May 2021 17:04:15 +0200
Subject: [LTP] [PATCH 1/1] docparse: Make tags in table clickable
Message-ID: <20210503150415.18835-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

linked to the section.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

minor but useful improvement.

 docparse/testinfo.pl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index ccce67be4..76ca7a66c 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -125,7 +125,12 @@ sub paragraph
 
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
@@ -179,7 +184,7 @@ sub get_test_names
 			$content .= "\n";
 		}
 
-		$content .= reference($name, " ");
+		$content .= reference($name, delimiter => " ");
 		$prev_letter = $letter;
 	}
 	$content .= "\n";
@@ -242,6 +247,7 @@ sub content_filters
 	for my $k (sort keys %$data) {
 		my $tag = tag2title($k);
 		my ($letter, $prev_letter);
+		$content .= label($k);
 		$content .= h2($tag);
 		$content .= paragraph("Tests containing $tag flag.");
 		$content .= get_test_names(\@{$h{$k}});
@@ -357,7 +363,7 @@ sub content_all_tests
 				$content .= table . "|Key|Value\n\n"
 			}
 
-			$content .= "|" . tag2title($k) . "\n|";
+			$content .= "|" . reference($k, text => tag2title($k)) . "\n|";
 
 			if (ref($v) eq 'ARRAY') {
 				# two dimensional array
-- 
2.31.1


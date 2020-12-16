From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Dec 2020 15:32:44 +0100
Subject: [LTP] [PATCH 1/1] Docparse: Escape | in table content
Message-ID: <20201216143244.8180-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

31708e815 added | in values displayed in table, which unescaped breaks
table formatting.

NOTE: Due asciidoc{,tor} markup design it's difficult to easily escape markup
handling only this particular case.

https://github.com/asciidoctor/asciidoctor/issues/901
https://discuss.asciidoctor.org/Difficulty-in-consistently-escaping-markup-td5318.html

Fixes: #754

Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index d8d9ea663..5aa7315e4 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -119,6 +119,14 @@ sub table
 	return "|===\n";
 }
 
+sub table_escape
+{
+	my $out = $_[0];
+
+	$out =~ s/\|/\\|/g;
+	return $out;
+}
+
 sub print_defined
 {
 	my ($key, $val, $val2) = @_;
@@ -329,10 +337,11 @@ sub content_all_tests
 
 			$content .= "|" . tag2title($k) . "\n|";
 			if (ref($v) eq 'ARRAY') {
-				$content .= join(', ', @$v),
+				$content .= table_escape(join(', ', @$v));
 			} else {
-				$content .= $v;
+				$content .= table_escape($v);
 			}
+
 			$content .= "\n";
 
 			$tmp2 = 1;
-- 
2.29.2


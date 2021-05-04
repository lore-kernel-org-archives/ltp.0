From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 May 2021 21:02:36 +0200
Subject: [LTP] [PATCH v2 1/5] docparse: Move CVE and git link into Info
 column
In-Reply-To: <20210504190240.24250-1-pvorel@suse.cz>
References: <20210504190240.24250-1-pvorel@suse.cz>
Message-ID: <20210504190240.24250-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously it was in Tags column (1st row), which is a bit confusing.

Also texts in 1st column will be made clickable too, pointing to the
section with tests with this key/tag.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index ccce67be4..7c74009d7 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -391,22 +391,19 @@ sub content_all_tests
 			}
 			my $k = @$tag[0];
 			my $v = @$tag[1];
-			my $text = $k;
 
 			if (defined($$git_url{$k})) {
-				$text .= "-$v";
-
 				$commits{$k} = () unless (defined($commits{$k}));
 				unless (defined($commits{$k}{$v})) {
 					chdir($$git_url{$k});
 					$commits{$k}{$v} = `git log --pretty=format:'%s' -1 $v`;
 					chdir(OUTDIR);
 				}
-				$v = $commits{$k}{$v};
+				$v .= ' ("' . $commits{$k}{$v} . '")';
 			}
 
-			my $a = html_a(tag_url($k, @$tag[1]), $text);
-			$content .= "\n|$a\n|$v\n";
+			$v = html_a(tag_url($k, @$tag[1]), $v);
+			$content .= "\n|$k\n|$v\n";
 			$tmp2 = 1;
 		}
 		if (defined($tmp2)) {
-- 
2.31.1


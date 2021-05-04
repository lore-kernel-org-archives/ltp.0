From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 May 2021 21:02:37 +0200
Subject: [LTP] [PATCH v2 2/5] docparse: Filter .tags by key
In-Reply-To: <20210504190240.24250-1-pvorel@suse.cz>
References: <20210504190240.24250-1-pvorel@suse.cz>
Message-ID: <20210504190240.24250-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

i.e. into CVE, linux-git, ... sections.

Flags has already been sorted, but .tags flag has arbitrary key,
further filtering by key improves a lot searching for particular info.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 53 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 7c74009d7..194365ea3 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -217,21 +217,46 @@ sub get_filters
 {
 	my $json = shift;
 	my %data;
+
 	while (my ($k, $v) = each %{$json->{'tests'}}) {
 		for my $j (keys %{$v}) {
-
 			next if ($j eq 'fname' || $j eq 'doc');
-
 			$data{$j} = () unless (defined($data{$j}));
-			push @{$data{$j}}, $k;
+
+			if ($j eq 'tags') {
+				for my $tags (@{$v}{'tags'}) {
+					for my $tag (@$tags) {
+						my $k2 = $$tag[0];
+						my $v2 = $$tag[1];
+						$data{$j}{$k2} = () unless (defined($data{$j}{$k2}));
+						push @{$data{$j}{$k2}}, $k unless grep{$_ eq $k} @{$data{$j}{$k2}};
+					}
+				}
+			} else {
+				push @{$data{$j}}, $k unless grep{$_ eq $k} @{$data{$j}};
+			}
 		}
 	}
 	return \%data;
 }
 
-# TODO: Handle better .tags (and anything else which contains array)
-# e.g. for .tags there could be separate list for CVE and linux-git
-# (now it's together in single list).
+sub content_filter
+{
+	my $k = $_[0];
+	my $title = $_[1];
+	my $desc = $_[2];
+	my $h = $_[3];
+	my ($letter, $prev_letter, $content);
+
+	$content = label($k);
+	$content .= $title;
+	$content .= paragraph("Tests containing $desc flag.");
+
+	$content .= get_test_names(\@{$h});
+
+	return $content;
+}
+
 sub content_filters
 {
 	my $json = shift;
@@ -240,11 +265,17 @@ sub content_filters
 	my $content;
 
 	for my $k (sort keys %$data) {
-		my $tag = tag2title($k);
-		my ($letter, $prev_letter);
-		$content .= h2($tag);
-		$content .= paragraph("Tests containing $tag flag.");
-		$content .= get_test_names(\@{$h{$k}});
+		my $title = tag2title($k);
+		if (ref($h{$k}) eq 'HASH') {
+			$content .= label($k);
+			$content .= h2($title);
+			for my $k2 (sort keys %{$h{$k}}) {
+				my $title2 = code($k2);
+				$content .= content_filter($k2, h3($title2), "$title $title2", $h{$k}{$k2});
+			}
+		} else {
+			$content .= content_filter($k, h2($title), $title, \@{$h{$k}});
+		}
 	}
 
 	return $content;
-- 
2.31.1


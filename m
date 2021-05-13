From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 May 2021 20:20:55 +0200
Subject: [LTP] [PATCH 1/1] testinfo.pl: Fix array sort on old perl
Message-ID: <20210513182055.31700-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

It fixes failure on perl v5.16.3 (Centos 7):
Can't use an undefined value as an ARRAY reference at docparse/testinfo.pl line 427.

Fixes: 824e34034 ("docparse: Sort alphabetically tags in table")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 docparse/testinfo.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 857278ac8..31148e3a4 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -424,7 +424,7 @@ sub content_all_tests
 
 		$tmp2 = undef;
 		my %commits;
-		my @sorted_tags = sort { $a->[0] cmp $b->[0] } @{$json->{'tests'}{$name}{tags}};
+		my @sorted_tags = sort { $a->[0] cmp $b->[0] } @{$json->{'tests'}{$name}{tags} // []};
 
 		for my $tag (@sorted_tags) {
 			if (!defined($tmp2)) {
-- 
2.31.1


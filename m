From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 May 2021 17:21:38 +0200
Subject: [LTP] [PATCH 1/1] docparse: Fix parsing URL containing '|' in links
Message-ID: <20210520152138.23772-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

That fixes formatting for commit in close_range01:
fec8a6a69103 ("close_range: unshare all fds for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC")

Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

hope this is enough to be escaped.
I tested various:
== \|= # - ## -- ___

Also one day I wrote docparser test :).

Kind regards,
Petr

 docparse/testinfo.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 31148e3a4..6e05982e5 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -96,8 +96,8 @@ sub html_a
 {
 	my ($url, $text) = @_;
 
-	# escape ]
-	$text =~ s/([]])/\\$1/g;
+	# escape: ] |
+	$text =~ s/([]|])/\\$1/g;
 
 	return "$url\[$text\]";
 }
-- 
2.31.1


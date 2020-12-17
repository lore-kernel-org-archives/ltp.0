From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 13:15:19 +0100
Subject: [LTP] [PATCH 1/2] docparse/parse.sh: Fix parsing on dash
In-Reply-To: <20201217121520.25713-1-pvorel@suse.cz>
References: <20201217121520.25713-1-pvorel@suse.cz>
Message-ID: <20201217121520.25713-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

bash keeps escape sequences (e.g. \t and \n) when using echo:

$ a="-v\tverbose output\n"; echo "$a"
-v\tverbose output\n
$

But dash interprets them (behaves like echo -e on bash):

$ a="-v\tverbose output\n"; echo -e "$a"
-e -v	verbose output

$

Using printf does not help, because it'd have to be separated with --
which cannot be used for printing variables.
Fortunately cat << EOF redirection is portable.
In the future we should probably avoid shell as much as possible.

Fixes: 0962c9a37 ("syscalls/perf_event_open02: Use anonymous .options")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/parse.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/docparse/parse.sh b/docparse/parse.sh
index 4ae0c42b2..172eab702 100755
--- a/docparse/parse.sh
+++ b/docparse/parse.sh
@@ -32,7 +32,9 @@ for test in `find testcases/ -name '*.c'`; do
 			echo ','
 		fi
 		first=
-		echo -n "$a"
+		cat <<EOF
+$a
+EOF
 	fi
 done
 
-- 
2.29.2


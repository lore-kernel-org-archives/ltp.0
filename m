From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 31 Aug 2021 13:25:54 +0100
Subject: [LTP] [PATCH 2/2] docs: Fix typo 'entires' -> 'entries'
In-Reply-To: <20210831122554.14590-1-rpalethorpe@suse.com>
References: <20210831122554.14590-1-rpalethorpe@suse.com>
Message-ID: <20210831122554.14590-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/test-writing-guidelines.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index e95373e84..12fe4922a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -307,7 +307,7 @@ NOTE: See also
 1. Test compiles and runs fine (check with `-i 10` too)
 2. `make check` does not emit any warnings for the test you are working on
    (hint: run it in the test's directory and/or use `make check-$TCID`)
-3. The runtest entires are in place
+3. The runtest entries are in place
 4. Test binaries are added into corresponding '.gitignore' files
 5. Patches apply over the latest git
 
-- 
2.31.1


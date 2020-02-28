From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Feb 2020 11:14:22 +0100
Subject: [LTP] [PATCH 2/2] doc: Add note about LAPI headers
In-Reply-To: <20200228101422.31011-1-pvorel@suse.cz>
References: <20200228101422.31011-1-pvorel@suse.cz>
Message-ID: <20200228101422.31011-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

into the Test Writing Guidelines.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Maybe some of this text belongs to library-api-writing-guidelines.txt,
not sure.

Kind regards,
Petr

 doc/test-writing-guidelines.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 9ff70b1bc..45bac223f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -327,6 +327,15 @@ time may vary arbitrarily, for these timeout can be disabled by setting it to
 Test can find out how much time (in seconds) is remaining to timeout,
 by calling 'tst_timeout_remaining()'.
 
+LAPI headers
+++++++++++++
+
+Use our LAPI headers ('include "lapi/foo.h"') to keep compatibility with old distributions.
+LAPI header should always include original header. Older linux headers were problematic,
+therefore we preferred to use libc headers. There are still some bugs when
+combining certain glibc headers with linux headers, see
+https://sourceware.org/glibc/wiki/Synchronizing_Headers.
+
 A word about the cleanup() callback
 +++++++++++++++++++++++++++++++++++
 
-- 
2.25.1


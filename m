From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jul 2019 11:20:37 +0200
Subject: [LTP] [PATCH] doc: Mention network tests in variables
Message-ID: <20190718092037.13594-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I'd prefer using hyperlinks in docs (as it's supposed to be viewed
mainly in a browser) but these are the only variants (which looks too
ugly to me):

NOTE: link:../../blob/master/testcases/network/README.md[Network tests] use additional variables
in 'tst_net.sh'.
(this one at least keeps links to forks)

NOTE: https://github.com/linux-test-project/ltp/blob/master/testcases/network/README.md[Network tests] use additional variables
in 'tst_net.sh'.

=> I'd be for giving up links.

Kind regards,
Petr

 doc/test-writing-guidelines.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 869e6ed35..e59d72065 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1883,6 +1883,9 @@ simply by setting right '$TST_NEEDS_FOO'.
 | 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
 |=============================================================================
 
+NOTE: Network tests (see testcases/network/README.md) use additional variables
+in 'tst_net.sh'.
+
 Checking for presence of commands
 +++++++++++++++++++++++++++++++++
 
-- 
2.22.0


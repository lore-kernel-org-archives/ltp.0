From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Jul 2021 08:11:53 +0100
Subject: [LTP] [PATCH v2 3/8] doc: Add rules and recommendations list
In-Reply-To: <20210714071158.15868-1-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
Message-ID: <20210714071158.15868-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Create a list of rules which are feasible to check automatically. The
file is a table of tab separated values. It's intended to be machine
readable.

For now there is just an ID column, with IDs that look similar to CWE
IDs or CVEs. For now these can just be used with 'git grep'. Also
there is a description column.

Clearly this is not an exhaustive list. It just contains a library
rule already stated in the guide and the issue Sparse checks for.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/rules.tsv                   | 3 +++
 doc/test-writing-guidelines.txt | 5 +++++
 2 files changed, 8 insertions(+)
 create mode 100644 doc/rules.tsv

diff --git a/doc/rules.tsv b/doc/rules.tsv
new file mode 100644
index 000000000..d4081ce0f
--- /dev/null
+++ b/doc/rules.tsv
@@ -0,0 +1,3 @@
+ID	DESCRIPTION
+LTP-001	Library source files have tst_ prefix
+LTP-002	TST_RET and TST_ERR are never modified by test library functions
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index d57e52655..74e8ad7ee 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -10,6 +10,11 @@ NOTE: See also
       https://github.com/linux-test-project/ltp/wiki/Shell-Test-API[Shell Test API],
       https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP Library API Writing Guidelines].
 
+Rules and recommendations which are "machine checkable" should be
+tagged with an ID like +LTP-XXX+. There will be a corresponding entry
+in 'doc/rules.tsv'. When you run 'make check' or 'make check-test' it
+will display these IDs as a reference.
+
 1. Guide to clean and understandable code
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.31.1


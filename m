From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Mar 2017 09:10:14 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] gitignore: Add run.sh files from open
	posix	testsuite
In-Reply-To: <20170329125346.8182-1-pvorel@suse.cz>
References: <20170329125346.8182-1-pvorel@suse.cz>
Message-ID: <1316825081.17380595.1490879414688.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Can't we add some pattern to topmost .gitignore to cover all these cases?

diff --git a/testcases/open_posix_testsuite/.gitignore b/testcases/open_posix_testsuite/.gitignore
index 56c9477d3568..7ddf3cd90572 100644
--- a/testcases/open_posix_testsuite/.gitignore
+++ b/testcases/open_posix_testsuite/.gitignore
@@ -12,3 +12,4 @@
 /stress/*/*/Makefile
 
 /bin/t0
+run.sh

Regards,
Jan

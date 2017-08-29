From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 29 Aug 2017 11:37:03 +0800
Subject: [LTP] [PATCH v4 3/3] CVE: Add some existing tests to runtest/cve
In-Reply-To: <20170829033703.5772-1-fenggw-fnst@cn.fujitsu.com>
References: <20170828110206.GA21355@rei.lan>
 <20170829033703.5772-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170829033703.5772-3-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add syscalls/keyctl02 and commands/keyctl01 to the CVE runtest file as
cve-2015-7550 and cve-2016-4470 respectively.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/cve | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 468f0b2..5b16e9e 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -5,6 +5,8 @@ cve-2011-2496 vma03
 cve-2012-0957 cve-2012-0957
 cve-2014-0196 cve-2014-0196
 cve-2015-0235 gethostbyname_r01
+cve-2015-7550 keyctl02
+cve-2016-4470 keyctl01.sh
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
-- 
2.9.4




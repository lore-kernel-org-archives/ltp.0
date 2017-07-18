From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 18 Jul 2017 14:31:43 +0800
Subject: [LTP] [PATCH v2 2/3] commands/keyctl01: Fix getting key serial
	number
In-Reply-To: <20170718063144.18856-1-fenggw-fnst@cn.fujitsu.com>
References: <20170717114235.GB11059@rei.lan>
 <20170718063144.18856-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170718063144.18856-2-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We expect to get the key serial number by matching "debug:fred":

Session Keyring
1072563454 --alswrv      0     0  keyring: _ses
 340758544 --alswrv      0 65534   \_ keyring: _uid.0
 783746283 --alswrv      0     0   \_ user: debug:fred

But in some kernels the key will be inaccessible immediately
after being requested with "debug:fred negate":

Session Keyring
        -3 --alswrv      0     0  keyring: _ses
 842289032 --alswrv      0    -1   \_ keyring: _uid.0
877125164: key inaccessible (Permission denied)

So fix this by adding a match with "inaccessible".

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/commands/keyctl/keyctl01.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 238b117..76226ae 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -76,6 +76,11 @@ do_test()
 		fi
 
 		local key=`keyctl show | awk '/debug:fred/ {print $1}'`
+		if [ -z "$key" ]; then
+			key=`keyctl show | \
+				awk -F ':' '/inaccessible/ {print $1}'`
+		fi
+
 		if [ -n "$key" ]; then
 			keyctl unlink $key @s >/dev/null
 			tst_sleep 50ms
-- 
2.9.4




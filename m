Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZAalq-00062V-KR
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 09:27:02 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZAalo-0005f3-Jn
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 09:27:02 +0000
Message-ID: <1435829214.19361.4.camel@G08FNSTD140232.g08.fujitsu.local>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 2 Jul 2015 17:26:54 +0800
In-Reply-To: <555A8744.5050300@cn.fujitsu.com>
References: <1431958682-15683-1-git-send-email-chase.qi@linaro.org>
	<555A8744.5050300@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuhotplug05.sh: Make test to support some old
 version of 'sar'
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: naresh.kamboju@linaro.org, milosz.wasilewski@linaro.org

In commit 841c0eebc50068d6595b97b50ae0ee8e8f57c8ca:
We changed "sar 1 0" to "sar 1", but it make the test not
work well before 'sysstat-8.1.4(include sar)'.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh      | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 4491d3a..8a0f13b 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -81,11 +81,17 @@ TST_CLEANUP=do_clean
 until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 
 	# Start up SAR and give it a couple cycles to run
-	sar 1 &>/dev/null &
+	sar 1 0 &>/dev/null &
+	if [ $? -ne 0 ]; then
+		sar 1 &>/dev/null &
+	fi
 	sleep 2
 	if ps -C sar &>/dev/null; then
 		pkill sar
-		sar -P ALL 1 > $TMP/log_$$ &
+		sar -P ALL 1 0 > $TMP/log_$$ &
+		if [ $? -ne 0 ]; then
+			sar -P ALL 1 > $TMP/log_$$ &
+		fi
 	else
 		sar -P ALL 1 > $TMP/log_$$ &
 	fi
-- 
1.9.3




------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

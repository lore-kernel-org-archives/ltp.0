Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZRcOI-0007Wu-4g
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 08:37:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRcOH-0002wK-8B
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 08:37:06 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 960CE98C2F
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Aug 2015 08:36:59 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp12-104.nay.redhat.com
	[10.66.12.104] (may be forged))
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t7I8amit026359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Aug 2015 04:36:58 -0400
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Aug 2015 16:36:46 +0800
Message-Id: <1439887006-17985-3-git-send-email-liwang@redhat.com>
In-Reply-To: <1439887006-17985-2-git-send-email-liwang@redhat.com>
References: <1439887006-17985-1-git-send-email-liwang@redhat.com>
	<1439887006-17985-2-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH 3/3] pounder/cpufreq: Skip the test if processors are
	not supported by cpufreq
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

During the pounder21/cpufreq test, it print so many errors:

[2015-08-17 08:43:24] (17818) cpufreq.bin: FAIL with code 4.
[2015-08-17 08:43:24] (17818) cpufreq.bin: START loop #2.
[2015-08-17 08:43:25] (17812) cpufreq.bin: FAIL with code 4.
[2015-08-17 08:43:25] (17812) cpufreq.bin: START loop #2.
[2015-08-17 08:43:27] (17812) cpufreq.bin: FAIL with code 4.
...

The reason is that the case canceled some cpufreq check steps before,
now reuse them to make sure it could be skiped on a system without
cpufreq support.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 tools/pounder21/test_scripts/cpufreq | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/pounder21/test_scripts/cpufreq b/tools/pounder21/test_scripts/cpufreq
index ba94a76..4df70a9 100755
--- a/tools/pounder21/test_scripts/cpufreq
+++ b/tools/pounder21/test_scripts/cpufreq
@@ -21,12 +21,12 @@
 
 
 # Do any CPU support cpufreq?
-#CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
+CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
 
-#if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
-#	echo "None of your CPUs support cpufreq.  Bye."
-#	exit 255
-#fi
+if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
+	echo "None of your CPUs support cpufreq.  Bye."
+	exit 255
+fi
 
 # Turn on acpi_pstate_strict to ensure that state transitions actually happen...
 if [ -f /sys/module/acpi_cpufreq/parameters/acpi_pstate_strict ]; then
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

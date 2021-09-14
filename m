From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Sep 2021 17:54:25 +0530
Subject: [LTP] [PATCH 2/2] runtest/smoketest: Adding ping01 and ping02 test
 cases
In-Reply-To: <20210914122425.85129-1-naresh.kamboju@linaro.org>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
Message-ID: <20210914122425.85129-2-naresh.kamboju@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adding two ping test case to smoketest
ping01 ping01.sh
ping602 ping02.sh -6

Suggested-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 runtest/smoketest | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/smoketest b/runtest/smoketest
index dd689bd6f..7bebe4a42 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -13,3 +13,5 @@ utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
+ping01 ping01.sh
+ping602 ping02.sh -6
-- 
2.30.2


From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon,  6 Sep 2021 14:04:44 +0530
Subject: [LTP] [PATCH 2/2] runtest/smoketest: Adding ping01 and ping02 test
 cases
In-Reply-To: <20210906083444.82394-1-naresh.kamboju@linaro.org>
References: <20210906083444.82394-1-naresh.kamboju@linaro.org>
Message-ID: <20210906083444.82394-2-naresh.kamboju@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adding two ping test case to smoketest
ping01 ping01.sh
ping02 ping02.sh

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 runtest/smoketest | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/smoketest b/runtest/smoketest
index dd689bd6f..361f1db29 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -13,3 +13,5 @@ utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
+ping01 ping01.sh
+ping02 ping02.sh
-- 
2.30.2


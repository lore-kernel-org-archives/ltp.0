From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:55 -0700
Subject: [LTP] [PATCH V3 22/23] pec: Replace obsoleted SA_ONESHOT with
	SA_RESETHAND
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-22-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

This is needed especially for musl, for glibc _GNU_SOURCE
is added by libc-features.h automatically. which defines SA_ONESHOT

Fixes

pec_listener.c: In function ‘main’:
pec_listener.c:233:27: error: ‘SA_ONESHOT’ undeclared (first use in this function)
  sigint_action.sa_flags = SA_ONESHOT;
                           ^~~~~~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/connectors/pec/pec_listener.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/connectors/pec/pec_listener.c b/testcases/kernel/connectors/pec/pec_listener.c
index a1beb13..d11e4dc 100644
--- a/testcases/kernel/connectors/pec/pec_listener.c
+++ b/testcases/kernel/connectors/pec/pec_listener.c
@@ -230,7 +230,7 @@ int main(int argc, char **argv)
 	struct sockaddr_nl src_addr;
 	struct pollfd pfd;
 
-	sigint_action.sa_flags = SA_ONESHOT;
+	sigint_action.sa_flags = SA_RESETHAND;
 	sigint_action.sa_handler = &sigint_handler;
 	sigaction(SIGINT, &sigint_action, NULL);
 
-- 
2.9.0


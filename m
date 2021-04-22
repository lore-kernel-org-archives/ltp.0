From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 22 Apr 2021 21:54:05 +0800
Subject: [LTP] [PATCH] syscalls/bind01: Close/recreate inet_socket after
 calling bind() successed
Message-ID: <20210422135405.14269-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the test running with -i option to run more than one time,
it will fail because of calling bind successed more than one time,
as follows:

#bind01 -i 2
tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
bind01.c:52: TPASS: invalid salen: EINVAL (22)
bind01.c:52: TPASS: invalid socket: ENOTSOCK (88)
bind01.c:55: TPASS: INADDR_ANYPORT passed
bind01.c:52: TPASS: UNIX-domain of current directory: EAFNOSUPPORT (97)
bind01.c:52: TPASS: non-local address: EADDRNOTAVAIL (99)
bind01.c:52: TPASS: invalid salen: EINVAL (22)
bind01.c:52: TPASS: invalid socket: ENOTSOCK (88)
bind01.c:55: TFAIL: INADDR_ANYPORT failed: EINVAL (22)
bind01.c:52: TPASS: UNIX-domain of current directory: EAFNOSUPPORT (97)
bind01.c:52: TPASS: non-local address: EADDRNOTAVAIL (99)

Summary:
passed   9
failed   1
broken   0
skipped  0
warnings 0

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/bind/bind01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 758d12863..c008819a8 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -53,6 +53,8 @@ void verify_bind(unsigned int nr)
 	} else {
 		TST_EXP_PASS(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
 		             "%s", tcase->desc);
+		SAFE_CLOSE(inet_socket);
+		inet_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	}
 }

--
2.17.1


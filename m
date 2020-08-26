From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 26 Aug 2020 12:39:13 +0200
Subject: [LTP] [PATCH] Re: [PATCH] syscalls/setsockopt05: associate receiver
 with destination address
In-Reply-To: <1390277350.9966000.1598362700248.JavaMail.zimbra@redhat.com>
References: <1390277350.9966000.1598362700248.JavaMail.zimbra@redhat.com>
Message-ID: <20200826103913.27678-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

OK, here's the correct test patch. The source port changes on every iteration
so different send() calls shouldn't interfere with one another. If you get
ECONNREFUSED with this patch applied, it's caused by broken implementation
of send(MSG_MORE), not delayed ICMP packets. If this patch prevents the error,
resubmit your patch with fixes.

I'll write the test for send(MSG_MORE) either way because if the flag isn't
honored by the kernel, setsockopt05 will be useless.

---
 testcases/kernel/syscalls/setsockopt/setsockopt05.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index e78ef236e..698396390 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -64,6 +64,9 @@ static void run(void)
 
 	for (i = 0; i < 1000; i++) {
 		sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+		addr.sin_port = 12346 + i;
+		SAFE_BIND(sock, (struct sockaddr *)&addr, sizeof(addr));
+		addr.sin_port = 12345;
 		SAFE_CONNECT(sock, (struct sockaddr *)&addr, sizeof(addr));
 		SAFE_SEND(1, sock, buf, BUFSIZE, MSG_MORE);
 		SAFE_SETSOCKOPT_INT(sock, SOL_SOCKET, SO_NO_CHECK, 1);
-- 
2.28.0


From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 10 Dec 2018 22:03:16 -0800
Subject: [LTP] [PATCH v2 2/3] tst_netlink: inline functions in header
In-Reply-To: <20181211060317.18698-1-ebiggers@kernel.org>
References: <20181211060317.18698-1-ebiggers@kernel.org>
Message-ID: <20181211060317.18698-3-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

safe_netlink_send() and safe_netlink_recv() need to be static inline,
since they're defined in a .h file.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/tst_netlink.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/tst_netlink.h b/include/tst_netlink.h
index 42232a169..892ef8f78 100644
--- a/include/tst_netlink.h
+++ b/include/tst_netlink.h
@@ -33,9 +33,9 @@
 #endif
 
 /** @private */
-ssize_t safe_netlink_send(const char *file, const int lineno,
-			  int fd, const struct nlmsghdr *nh,
-			  const void *payload)
+static inline ssize_t safe_netlink_send(const char *file, const int lineno,
+					int fd, const struct nlmsghdr *nh,
+					const void *payload)
 {
 	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
 	struct iovec iov[2] = {
@@ -68,8 +68,9 @@ ssize_t safe_netlink_send(const char *file, const int lineno,
 	safe_netlink_send(__FILE__, __LINE__, fd, nl_header, payload)
 
 /** @private */
-ssize_t safe_netlink_recv(const char *file, const int lineno,
-			  int fd, char *nl_headers_buf, size_t buf_len)
+static inline ssize_t safe_netlink_recv(const char *file, const int lineno,
+					int fd, char *nl_headers_buf,
+					size_t buf_len)
 {
 	struct iovec iov = { nl_headers_buf, buf_len };
 	struct sockaddr_nl sa;
-- 
2.19.2


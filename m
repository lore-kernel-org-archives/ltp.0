Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liaoqingwei@huawei.com>) id 1YzfCl-0003jc-3W
	for ltp-list@lists.sourceforge.net; Tue, 02 Jun 2015 05:57:39 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YzfCi-0008Vf-66
	for ltp-list@lists.sourceforge.net; Tue, 02 Jun 2015 05:57:39 +0000
From: Liao Qingwei <liaoqingwei@huawei.com>
Date: Tue, 2 Jun 2015 13:56:58 +0000
Message-ID: <1433253418-44054-1-git-send-email-liaoqingwei@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] rpc/basic_tests/rpc01:Fix the error parameters
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
To: ltp-list@lists.sourceforge.net
Cc: dingguofu@huawei.com, zhanyongming@huawei.com

There are some bugs in the testcase:
1.return_buffer be defined as a struct data * and is uninitialized,it
is a random value,maybe NULL,in function do_compare(rc,
"callrpc", &buffer, return_buffer->data) will cause a NULL pointer
reference and  "Segmentation fault".
2.in callrpc() the sixth and the eighth parameter is error,it should be
buffer.data and a valid char *,and the clnt_call() has the same error.
3.the malloc for buffer.data is not freed.

I change the definition of return_buffer to char *,malloc memory for
it,and free when test exit.

Please review it,thanks.

Signed-off-by: Liao Qingwei <liaoqingwei@huawei.com>
---
 testcases/network/rpc/basic_tests/rpc01/rpc1.c | 41 +++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc1.c b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
index bc9f35b..19835d5 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc1.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
@@ -24,7 +24,8 @@ void usage_error(char *program_name);
 int main(int argc, char *argv[])
 {
 	struct hostent *hp;
-	struct data buffer, *return_buffer;
+	struct data buffer;
+	char *return_buffer;
 	int i, n, rc;
 	FILE *fp;
 	struct stat stat_buffer;
@@ -121,14 +122,26 @@ int main(int argc, char *argv[])
 	}
 
 	buffer.data = malloc(buffer.data_length);
+	if (!buffer.data) {
+		fprintf(stderr, "malloc failed for buffer.data\n");
+		exit(1);
+	}
+
 	for (i = 0, p = buffer.data; i < buffer.data_length; i++, p++)
 		*p = getc(fp);
 	fclose(fp);
 
+	return_buffer = malloc(buffer.data_length);
+	if (!return_buffer) {
+		fprintf(stderr, "malloc failed for return_buffer\n");
+		free(buffer.data);
+		exit(1);
+	}
+
 	rc = callrpc(server, program, version, 1, (xdrproc_t)xdr_send_data,
-			(char *)&buffer, (xdrproc_t)xdr_receive_data,
-			(char *)&return_buffer);
-	do_compare(rc, "callrpc", &buffer, return_buffer->data);
+			buffer.data, (xdrproc_t)xdr_receive_data,
+			return_buffer);
+	do_compare(rc, "callrpc", &buffer, return_buffer);
 
 	server_sin.sin_port = 0;
 	sock = RPC_ANYSOCK;
@@ -137,30 +150,34 @@ int main(int argc, char *argv[])
 	clnt = clntudp_create(&server_sin, program, version, timeout, &sock);
 	if (clnt == NULL) {
 		fprintf(stderr, "clntudp_create failed\n");
+		free(buffer.data);
+		free(return_buffer);
 		exit(1);
 	}
 	timeout.tv_usec = 0;
 	timeout.tv_sec = 30;
 	rc = (int)clnt_call(clnt, 1, (xdrproc_t)xdr_send_data,
-				(char *)&buffer, (xdrproc_t)xdr_receive_data,
-				(char *)&return_buffer, timeout);
+				buffer.data, (xdrproc_t)xdr_receive_data,
+				return_buffer, timeout);
 	clnt_destroy(clnt);
-	do_compare(rc, "udp transport", &buffer, return_buffer->data);
+	do_compare(rc, "udp transport", &buffer, return_buffer);
 
 	server_sin.sin_port = 0;
 	sock = RPC_ANYSOCK;
 	clnt = clnttcp_create(&server_sin, program, version, &sock, 0, 0);
 	if (clnt == NULL) {
 		fprintf(stderr, "clntudp_create failed\n");
+		free(buffer.data);
+		free(return_buffer);
 		exit(1);
 	}
 	timeout.tv_usec = 0;
 	timeout.tv_sec = 30;
 	rc = (int)clnt_call(clnt, 1, (xdrproc_t)xdr_send_data,
-				(char *)&buffer, (xdrproc_t)xdr_receive_data,
-				(char *)&return_buffer, timeout);
+				buffer.data, (xdrproc_t)xdr_receive_data,
+				return_buffer, timeout);
 	clnt_destroy(clnt);
-	do_compare(rc, "tcp transport", &buffer, return_buffer->data);
+	do_compare(rc, "tcp transport", &buffer, return_buffer);
 
 	exit(0);
 }
@@ -173,11 +190,15 @@ void do_compare(int rpc_rc, char *msg, struct data *buffer, char *ret_data)
 		printf("RPC call with %s returned %d: ", msg, rpc_rc);
 		clnt_perrno(rpc_rc);
 		printf("\n");
+		free(buffer->data);
+		free(ret_data);
 		exit(1);
 	}
 	rc = memcmp(buffer->data, ret_data, buffer->data_length);
 	if (rc) {
 		printf("Data compare for %s returned %d\n", msg, rc);
+		free(buffer->data);
+		free(ret_data);
 		exit(1);
 	}
 }
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

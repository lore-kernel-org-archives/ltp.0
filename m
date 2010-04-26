Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6TES-00081L-A8
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 18:40:36 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id EEC858672B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 20:40:28 +0200 (CEST)
Date: Mon, 26 Apr 2010 20:48:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426184810.GB14970@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
Subject: [LTP] [PATCH] add missing include into rpc1.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch adds missing include unistd.h needed for gethostbyname() and
getpid() into rpc1.c.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--MnLPg7ZWsaic7Fhd
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix_missing_include_rpc1.patch"

Index: ltp-full-20100228/testcases/network/rpc/basic_tests/rpc01/rpc1.c
===================================================================
--- ltp-full-20100228.orig/testcases/network/rpc/basic_tests/rpc01/rpc1.c
+++ ltp-full-20100228/testcases/network/rpc/basic_tests/rpc01/rpc1.c
@@ -8,6 +8,7 @@
 #include <sys/stat.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 
 int program = 2000333;
 int version = 10;
@@ -28,8 +29,7 @@ int xdr_send_data(XDR *, struct data *);
 void do_compare(int, char *, struct data *, char *);
 void usage_error(char *program_name);
 
-int
-main(int argc, char *argv[])
+int main(int argc, char *argv[])
 {
     struct hostent *hp;
     struct data buffer, *return_buffer;

--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--MnLPg7ZWsaic7Fhd--


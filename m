Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHeu-0005ob-3g
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:08 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHet-00065f-Hf
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:08 +0000
Received: by mail-ob0-f175.google.com with SMTP id wm4so615709obc.20
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:21:02 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:43 -0700
Message-Id: <1383085243-5833-10-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 9/9] ltp-networking/rpc: gave precise test name
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
Cc: linaro-networking@linaro.org

---
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |    2 +-
 testcases/network/rpc/basic_tests/rup/rup01        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01 b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
index 7f8104f..cb063d8 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
@@ -57,7 +57,7 @@

 $trace_logic
 this_file=${0##*/}
-TC=rusers
+TC=rpcinfo01
 TCtmp=${TCtmp:=`pwd`}
 TCbin=${TCbin:=`pwd`}
 TCsrc=${TCsrc:=$TCbin}
diff --git a/testcases/network/rpc/basic_tests/rup/rup01 b/testcases/network/rpc/basic_tests/rup/rup01
index 5845528..99916d4 100755
--- a/testcases/network/rpc/basic_tests/rup/rup01
+++ b/testcases/network/rpc/basic_tests/rup/rup01
@@ -46,7 +46,7 @@

 $trace_logic
 this_file=${0##*/}
-TC=rusers
+TC=rup01
 TCtmp=${TCtmp:=`pwd`}
 TCbin=${TCbin:=`pwd`}
 TCsrc=${TCsrc:=$TCbin}
--
1.7.9.5


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VgnvB-0003rs-Cp
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:48:45 +0000
Received: from mail-pb0-f43.google.com ([209.85.160.43])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vgnv9-0003Cn-Fj
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:48:45 +0000
Received: by mail-pb0-f43.google.com with SMTP id md4so1410823pbc.16
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 19:48:37 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 11:38:33 +0800
Message-Id: <1384400319-30776-2-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 2/8] ltp-networking/rpc: gave precise test name
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

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
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
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

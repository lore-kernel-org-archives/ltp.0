Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHeo-0006aR-AE
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:02 +0000
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHen-0007Pu-JJ
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:02 +0000
Received: by mail-oa0-f46.google.com with SMTP id g12so624427oah.19
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:56 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:39 -0700
Message-Id: <1383085243-5833-6-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 5/9] ltp-networking/tcp_cmds/tcpdump: 1. RHOST IP
	won't appear in network interfaces. It should be LHOST. 2.
	Host commad can't fetch IP in no DNS enviroment. use ping
	intead of it
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
 testcases/network/tcp_cmds/tcpdump/tcpdump01 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
index 4866720..6d99398 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
@@ -47,8 +47,8 @@ do_setup()
     tst_setup

     exists awk grep host hostname ifconfig netstat ping tail tcpdump
-    RHOST=${RHOST:-`hostname`}
-    IP=`host ${RHOST} 2>/dev/null | awk '{print $4}'`
+    LHOST=${LHOST:-`hostname`}
+    IP=`ping ${LHOST} -c 1 | awk '{print $3}' | head -n1 | cut -f2 -d'(' | cut -f1 -d')'`
     IFNUMS=`netstat -i|wc -l`
     IFNUMS=$(( $IFNUMS - 2 ))
     IFNAME=${IFNAME:-$(netstat -i | awk '{print $1}' | tail -n ${IFNUMS})}
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

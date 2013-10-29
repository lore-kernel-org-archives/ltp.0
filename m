Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHej-0005nK-QQ
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:57 +0000
Received: from mail-oa0-f54.google.com ([209.85.219.54])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHej-0006t1-6M
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:57 +0000
Received: by mail-oa0-f54.google.com with SMTP id o20so628853oag.27
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:51 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:36 -0700
Message-Id: <1383085243-5833-3-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 2/9] ltp-networking/nfs: don't use absolute path
	for showmount. showmount does not locate at
	/user/sbin/showmount on Ubuntu 12.04.
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
 testcases/network/nfs/nfs02/nfs02 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs02/nfs02 b/testcases/network/nfs/nfs02/nfs02
index 5ff4651..3a157a1 100755
--- a/testcases/network/nfs/nfs02/nfs02
+++ b/testcases/network/nfs/nfs02/nfs02
@@ -100,7 +100,7 @@ $trace_logic
    fi

    #Verify export
-   /usr/sbin/showmount -e $RHOST | grep $TESTDIR
+   showmount -e $RHOST | grep $TESTDIR
    [ $? -eq 0 ] || end_testcase "$TESTDIR not exported"

    #Create $TCtmp for mount point
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

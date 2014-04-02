Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WVNOv-0000GV-Q9
	for ltp-list@lists.sourceforge.net; Wed, 02 Apr 2014 15:48:29 +0000
Date: Wed, 2 Apr 2014 17:47:50 +0200
From: chrubis@suse.cz
Message-ID: <20140402154750.GB16032@rei.Home>
References: <1395815142-3990-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395815142-3990-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] fork/fork14.c: cleanup
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Pushed with following changes:

 static void cleanup(void)
 {
+       free(pointer_vec);
        TEST_CLEANUP;
 }
 
@@ -102,7 +103,7 @@ static int fork_test(void)
                addr = mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
                            MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
                if (addr == MAP_FAILED) {
-                       pointer_vec[i] = 0;
+                       pointer_vec[i] = NULL;
                        fails++;
                        /*
                         * EXTENT is "16*1024+10", if fails count exceeds 10,

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

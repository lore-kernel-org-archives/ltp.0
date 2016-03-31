From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Mar 2016 12:19:51 +0200
Subject: [LTP] [PATCH] lib/tst_rmdir.c: close TESTDIR files before
	rmobj()
In-Reply-To: <56F11302.80502@oracle.com>
References: <1458228954-28372-1-git-send-email-alexey.kodanev@oracle.com>
 <20160317161546.GB31815@rei.lan> <56EBEE70.90902@oracle.com>
 <20160321122733.GC32294@rei.lan> <56F11302.80502@oracle.com>
Message-ID: <20160331101951.GB20485@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> OK, may be it's a good idea. So, should I wait till the merge or
> send youa new patch for your repo first?

Given that the new library patch may still change let's wait till it's
mergerd before we start adding more functionality to the new test
library.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jul 2016 15:19:12 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/access02: reconstruct and convert
 to new API
In-Reply-To: <1469011479-808-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20160719114953.GC6409@rei.lan>
 <1469011479-808-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160725131912.GB12533@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added missing SAFE_CLOSE() to the R_OK and W_OK cases in the
access_test() since otherwise the test will fail on large enough -i
since it will use all awailable file descriptors.

Both patches pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

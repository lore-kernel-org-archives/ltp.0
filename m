From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Apr 2019 17:22:45 +0200
Subject: [LTP] [PATCH v4 2/2] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190328202252.7927-1-fedebonfi95@gmail.com>
References: <20190326192052.GA15776@rei.lan>
 <20190328202252.7927-1-fedebonfi95@gmail.com>
Message-ID: <20190403152245.GC26464@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This is nearly done, the only outstanding problem (minus the missing
Signed-off-by line) is that tests number 01 and 06 does not work with
-i 2 option that causes the test to be executed more than once. The
obvious fix would be moving the unshare call to the test setup()
function instead.

Also why have you skipped test 03? We do have 02 and then 04.

Other than that the rest is done and ready.

-- 
Cyril Hrubis
chrubis@suse.cz

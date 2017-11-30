From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Nov 2017 15:50:27 +0100
Subject: [LTP] [PATCH] hugetlb: fix warnings in cleanup()
In-Reply-To: <20171027085632.18245-1-liwang@redhat.com>
References: <20171027085632.18245-1-liwang@redhat.com>
Message-ID: <20171130145027.GG2924@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The fix is OK, but we may as well do it better, if we move completly the
logic to the library we do not have to repeat the code in each test.

So what about adding two functions save_nr_hugepages() and
restore_nr_hugepages() to the library and call these from the test setup
and cleanup?

-- 
Cyril Hrubis
chrubis@suse.cz

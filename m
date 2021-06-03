From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jun 2021 13:26:54 +0200
Subject: [LTP] [PATCH v5] syscalls/chown: Rewrite chown/chown04.c with
 the new api
In-Reply-To: <20210531114935.26000-1-xieziyao@huawei.com>
References: <20210531114935.26000-1-xieziyao@huawei.com>
Message-ID: <YLi8fjhmEpXlzC9d@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two minor changes, thanks.

* Removed the cleanup() since there is no need to reset the UID at the
  end of the test in the new library

* Made use of tst_get_bad_addr() instead of the hardcoded mmap() call

-- 
Cyril Hrubis
chrubis@suse.cz

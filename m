From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Jul 2021 16:47:50 +0200
Subject: [LTP] [PATCH 1/3] tst_process_state: Add
 tst_process_state_wait2 to newlib
In-Reply-To: <20210727124507.28356-2-xieziyao@huawei.com>
References: <20210727124507.28356-1-xieziyao@huawei.com>
 <20210727124507.28356-2-xieziyao@huawei.com>
Message-ID: <YQAclm1a3juLgb0T@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add tst_process_state_wait2 to newlib for epoll_pwait01.

The original purpose of this function was to work around the limitation
of the old test library, where you couldn't use the test library API
from a child processes. There is no point in adding it to the new
library, the test should just switch to the TST_PROCESS_STATE_WAIT()
instead.

-- 
Cyril Hrubis
chrubis@suse.cz

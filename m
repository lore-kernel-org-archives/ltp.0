From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Jul 2021 14:25:46 +0200
Subject: [LTP] [PATCH 3/3] epoll_pwait2: Add test for epoll_pwait202
In-Reply-To: <20210628080424.245911-4-xieziyao@huawei.com>
References: <20210628080424.245911-1-xieziyao@huawei.com>
 <20210628080424.245911-4-xieziyao@huawei.com>
Message-ID: <YOw0ytqC1IJfZiui@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I guess that this can go in as most of the complexity is in the test
library and we create similar wrapper for the epoll_pwait() test.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Jul 2021 15:45:10 +0200
Subject: [LTP] [PATCH 0/5 v2] epoll_pwait2: Add test for epoll_pwait2
In-Reply-To: <20210716102257.20882-1-xieziyao@huawei.com>
References: <20210628080424.245911-3-xieziyao@huawei.com>
 <20210716102257.20882-1-xieziyao@huawei.com>
Message-ID: <YPWB5hvIVTPjF7fO@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Changed the include in lapi/epoll.h to tst_timer.h

* Added better description to epoll_wait02


Also it would be nice to convert the epoll_pwait01.c to the variants as
well...

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Jul 2021 15:38:20 +0200
Subject: [LTP] [PATCH 2/2 v2] epoll_pwait: Add test variants for
 epoll_pwait2 in epoll_pwait01
In-Reply-To: <20210728092918.202639-3-xieziyao@huawei.com>
References: <20210728092918.202639-1-xieziyao@huawei.com>
 <20210728092918.202639-3-xieziyao@huawei.com>
Message-ID: <YQFdzHHJZqCUrnZV@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Move the check_epoll_support() to the setup to abort the test early if
  syscall is not supported

* Revoved the .min_kver since we check for the syscall availability now

* Reformatted the description a bit so that it renders nicely in
  metadata

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Apr 2021 16:02:26 +0200
Subject: [LTP] [PATCH 1/2] syscalls/unshare: convert unshare01 to the
 new API
In-Reply-To: <20210419122246.7706-2-xieziyao@huawei.com>
References: <20210419122246.7706-1-xieziyao@huawei.com>
 <20210419122246.7706-2-xieziyao@huawei.com>
Message-ID: <YH2Ncrm6jzpGhocb@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Great cleanup, pushed with a minor change, thanks.

I've renamed the TC to tc since uppercase names are usually used for
macros and not for variables.

-- 
Cyril Hrubis
chrubis@suse.cz

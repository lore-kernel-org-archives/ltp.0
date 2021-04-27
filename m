From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Apr 2021 14:20:14 +0200
Subject: [LTP] [PATCH 2/3 v2] syscalls/close: Convert close02 to the new
 API
In-Reply-To: <20210426125224.150268-3-xieziyao@huawei.com>
References: <20210426125224.150268-1-xieziyao@huawei.com>
 <20210426125224.150268-3-xieziyao@huawei.com>
Message-ID: <YIgBftUgy0sUy3BS@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> +/*\
> + * [Description]
> + *
> + * Basic test for the close() syscall.

This sentence does not add any more information, so I've removed it and
kept the second sentence below as a description instead.

-- 
Cyril Hrubis
chrubis@suse.cz

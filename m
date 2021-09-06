From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 17:17:22 +0200
Subject: [LTP] [PATCH] getuid: Convert getuid01 and getuid03 to new API
In-Reply-To: <20210826090511.106853-1-threefifteen.wangkunfeng@huawei.com>
References: <20210826090511.106853-1-threefifteen.wangkunfeng@huawei.com>
Message-ID: <YTYxAnd1FDGq/nTW@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks good, but there is no value in keeping the getuid01.c because it
tests same assertion that is covered in getuid03.c as well.

So I would keep only getuid01.c and moved the functionality from
getuid03.c there.

-- 
Cyril Hrubis
chrubis@suse.cz

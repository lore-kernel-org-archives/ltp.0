From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Apr 2021 14:23:26 +0200
Subject: [LTP] [PATCH 1/2] syscalls/sendfile: Convert sendfile03 to the
 new API
In-Reply-To: <20210426084215.259071-2-xieziyao@huawei.com>
References: <20210426084215.259071-1-xieziyao@huawei.com>
 <20210426084215.259071-2-xieziyao@huawei.com>
Message-ID: <YIawvjVtydPib96d@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added two more cases for EBADFD where in_fd is opened O_WRONLY and
out_fd is opened O_RDONLY and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

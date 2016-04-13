From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 13 Apr 2016 18:32:15 +0800
Subject: [LTP] [PATCH] syscalls/msgctl13: fix error when run on the new
 system
In-Reply-To: <20160411165848.GA3466@rei.lan>
References: <1460187421-2578-1-git-send-email-cuibixuan@huawei.com>
 <20160411165848.GA3466@rei.lan>
Message-ID: <570E202F.4090709@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/4/12 0:58, Cyril Hrubis wrote:
> This change leaks memory (leaves the message queue with key = 0 on the
> system) and relies on a fact that IPC_PRIVATE == 0 which may not be
> necessarilly true. Can't we instead do IPC_STAT on the msg_q and expect
> it to fail?
Use msgctl with IPC_STAT to check it is better :-);

But why it return EINVAL, instead of EIDRM?

Thanks
Cui Bixuan

> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz


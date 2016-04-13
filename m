From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 12:51:47 +0200
Subject: [LTP] [PATCH] syscalls/msgctl13: fix error when run on the new
 system
In-Reply-To: <570E202F.4090709@huawei.com>
References: <1460187421-2578-1-git-send-email-cuibixuan@huawei.com>
 <20160411165848.GA3466@rei.lan> <570E202F.4090709@huawei.com>
Message-ID: <20160413105147.GB10941@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> But why it return EINVAL, instead of EIDRM?

Since at the point we do the IPC_STAT the ID is allready unused hence
it's not valid anymore. You get EIDRM only in case that process is
waiting in kernel (for example in msgrcv()) while another process
removes the queue.

-- 
Cyril Hrubis
chrubis@suse.cz

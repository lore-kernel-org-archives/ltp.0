From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 14 Apr 2016 09:17:03 +0800
Subject: [LTP] [PATCH] syscalls/msgctl13: fix error when run on the new
 system
In-Reply-To: <20160413105147.GB10941@rei.lan>
References: <1460187421-2578-1-git-send-email-cuibixuan@huawei.com>
 <20160411165848.GA3466@rei.lan> <570E202F.4090709@huawei.com>
 <20160413105147.GB10941@rei.lan>
Message-ID: <570EEF8F.2010507@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/4/13 18:51, Cyril Hrubis wrote:
> Hi!
>> But why it return EINVAL, instead of EIDRM?
> 
> Since at the point we do the IPC_STAT the ID is allready unused hence
> it's not valid anymore. You get EIDRM only in case that process is
> waiting in kernel (for example in msgrcv()) while another process
> removes the queue.
Get it, Thank you.
> 


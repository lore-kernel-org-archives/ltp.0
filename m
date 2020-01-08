From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 8 Jan 2020 10:34:59 +0800
Subject: [LTP] [PATCH 1/2] syscalls/capget01: Cleanup & convert to new
 library
In-Reply-To: <20200107122604.GC26408@rei.lan>
References: <1576049159-14014-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200107120224.GA26408@rei.lan> <20200107122604.GC26408@rei.lan>
Message-ID: <d10b9b79-1ab2-ba62-e67b-2262b5a8f2b1@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
> Also btw, we do not cover the case with pid == 0 now, which should
> return the capabilities for the calling thread. I guess that we can run
> the capget01 verify function twice, once for pid == getpid() and once
> for pid == 0.
>Sorry, I didn't notice this before.
I double read capget/capset man-pages and refer to kernel code.
pid = 0 that it indeed returns the the capabilities for the calling 
thread. I will add it.
Also, for capget syscall, it can get the  capabilities for any existed 
process. I think we should also test this by using child process in a 
new case like capset04.c.

Best Regards
Yang Xu



From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 8 Sep 2020 15:37:14 +0800
Subject: [LTP] LTP release
In-Reply-To: <20200908073138.GB2475@yuki.lan>
References: <20200908073138.GB2475@yuki.lan>
Message-ID: <6bbac309-b13d-2703-7b48-b8beffe04256@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
> As usual we should start preparing for a next release.
> 
> As usuall we will have a week or two where we should merge everthing
> that should go in before the release, then git freeze for another week
> and finally a release.
> 
> So let's start with a list of things that should go in.
> 
> For me it would be:
> 
> * ptrace08 fix
> 
> * if possible the shmctl() rewrite
> 
> 
> What else should go in?
For me, three patches:
1.syscalls/ioctl_loop07.c?Using LOOP_CONFIGURE to test lo_sizelimit field
2.syscalls/msgrcv07: Add functional test for MSG_COPY flag
3.syscalls/msgrcv03: Add error test for MSG_COPY flag

Best Regards
Yang Xu
> 



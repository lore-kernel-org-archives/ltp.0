From: Yuri Norov <ynorov@marvell.com>
Date: Mon, 13 May 2019 20:16:17 +0000
Subject: [LTP] [EXT] Re: [PATCH v9 00/24] ILP32 for ARM64
In-Reply-To: <mvmtvdyoi33.fsf@suse.de>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190508225900.GA14091@yury-thinkpad>,<mvmtvdyoi33.fsf@suse.de>
Message-ID: <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ ltp@lists.linux.it

> There is a problem with the stack size accounting during execve when
> there is no stack limit:
>
> $ ulimit -s
> 8192
> $ ./hello.ilp32 
> Hello World!
> $ ulimit -s unlimited
> $ ./hello.ilp32 
> Segmentation fault
> $ strace ./hello.ilp32 
> execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) = -1 ENOMEM (Cannot allocate memory)
> +++ killed by SIGSEGV +++
> Segmentation fault (core dumped)
>
> Andreas.

Thanks Andreas, I will take a look. Do we have such test in LTP?
    
Yury

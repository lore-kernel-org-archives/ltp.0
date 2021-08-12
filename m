From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Thu, 12 Aug 2021 16:51:43 +0300
Subject: [LTP] [PATCH v2 00/16] syscalls/sched_*: convert to new API and
 handle ENOSYS errno
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <35db9a29-b5fd-8b90-2649-cfbdfad502e7@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06.08.2021 19:47, Alexey Kodanev wrote:
> The patch-set adds new libc/sys_sched_* wrappers to test libc
> and syscall variants of sched_*() functions seperately.
> 
> This is needed because musl libc returns ENOSYS for those
> functions [1], and the tests just fails with it.
> 
> [1]: https://git.musl-libc.org/cgit/musl/commit/?id=1e21e78bf7a5
> 
> v2: Using test variants
> 

Hi Li and Cyril,

Thanks for the great review! Applied the patches with all your suggestions.


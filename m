From: Steve Muckle <smuckle@google.com>
Date: Fri, 22 Feb 2019 11:29:27 -0800
Subject: [LTP] [PATCH] syscalls/ustat: Move the syscall to lapi
In-Reply-To: <20190221112201.18324-1-chrubis@suse.cz>
References: <20190221112201.18324-1-chrubis@suse.cz>
Message-ID: <7e1cbfe7-6773-8ffc-2320-6a28ee0c799b@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/21/2019 03:22 AM, Cyril Hrubis wrote:
> The dev parameter needs to be casted to unsigned in some cases, let's
> move call to tst_syscall() from the tests to lapi so that the tests does
> not have to worry about the low level details.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Steve Muckle <smuckle@google.com>
> CC: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>   include/lapi/ustat.h                      | 7 +++++++
>   testcases/kernel/syscalls/ustat/ustat01.c | 5 ++---
>   testcases/kernel/syscalls/ustat/ustat02.c | 5 ++---
>   3 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Steve Muckle <smuckle@google.com>

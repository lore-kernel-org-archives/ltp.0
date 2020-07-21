From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Jul 2020 17:29:32 +0200
Subject: [LTP] [PATCH 3/3] iopl01: skip test if kernel is locked down
In-Reply-To: <20200720194920.22784-3-ernunes@redhat.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <20200720194920.22784-3-ernunes@redhat.com>
Message-ID: <20200721152932.GC13733@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> iopl is restricted under kernel lockdown.
> 
> Signed-off-by: Erico Nunes <ernunes@redhat.com>
> ---
>  testcases/kernel/syscalls/iopl/iopl01.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
> index edf586cd1..4237d3f10 100644
> --- a/testcases/kernel/syscalls/iopl/iopl01.c
> +++ b/testcases/kernel/syscalls/iopl/iopl01.c
> @@ -42,6 +42,12 @@ static void verify_iopl(void)
>  	}
>  }
>  
> +static void setup(void)
> +{
> +	/* iopl is restricted under kernel lockdown. */
> +	tst_lockdown_skip();
> +}
> +
>  static void cleanup(void)
>  {
>  	/*
> @@ -54,6 +60,7 @@ static void cleanup(void)
>  static struct tst_test test = {
>  	.test_all = verify_iopl,
>  	.needs_root = 1,
> +	.setup = setup,
>  	.cleanup = cleanup,
>  };

Here as well, shouldn't we add iopl03?

Or at least change the library so that we have a function that returns
if kernel is locked or not so that someone can write such test.

-- 
Cyril Hrubis
chrubis@suse.cz

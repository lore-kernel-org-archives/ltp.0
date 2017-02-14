From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 14 Feb 2017 16:18:45 +0100
Subject: [LTP] madvise07.c:72: FAIL: Did not receive SIGBUS
In-Reply-To: <227667312.4337607.1487081174657.JavaMail.zimbra@redhat.com>
References: <CAEemH2ddpwBet_2crzv+sOJ9P84fscFH1re4SCo1dD_PKGgsgA@mail.gmail.com>
 <20170213090837.GA16973@rei.lan>
 <227667312.4337607.1487081174657.JavaMail.zimbra@redhat.com>
Message-ID: <20170214161845.5dfca62b@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Tue, 14 Feb 2017 09:06:14 -0500 (EST)
"Jan Stancek" <jstancek@redhat.com> wrote:

> 
> Or maybe MADV_HWPOISON is supposed to work only for faulted-in pages?
> It works fine for me with change below:
> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
> index 2f8c42e..f5fd4b7 100644
> --- a/testcases/kernel/syscalls/madvise/madvise07.c
> +++ b/testcases/kernel/syscalls/madvise/madvise07.c
> @@ -44,13 +44,13 @@ static int maptypes[] = {
>  
>  static void run_child(int maptype)
>  {
> -       const size_t msize = 4096;
> +       const size_t msize = getpagesize();
>         void *mem = NULL;
>  
>         mem = SAFE_MMAP(NULL,
>                         msize,
>                         PROT_READ | PROT_WRITE,
> -                       MAP_ANONYMOUS | maptype,
> +                       MAP_ANONYMOUS | maptype | MAP_POPULATE,
>                         -1,
>                         0);
>  

My only concern is that this is not documented in the man pages, but
considering we are testing a test interface, I'm not sure it matters.

Thank you,
Richard.

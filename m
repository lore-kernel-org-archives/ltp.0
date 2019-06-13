From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Jun 2019 16:55:19 +0800
Subject: [LTP] [PATCH v3 2/3] lib: rename ltp_clone_malloc to
	ltp_clone_alloc
In-Reply-To: <fd8b05453a0c72f2810a53e49ca1dc9467d9dbf9.1560410182.git.jstancek@redhat.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <fd8b05453a0c72f2810a53e49ca1dc9467d9dbf9.1560410182.git.jstancek@redhat.com>
Message-ID: <CAEemH2f_oMYubEDLdOmhxrEguKkc+3smx682LF7D9uiwZ26OAQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 13, 2019 at 3:25 PM Jan Stancek <jstancek@redhat.com> wrote:

> There are no users outside of lib.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_clone.h | 2 +-
>  lib/cloner.c        | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/tst_clone.h b/include/tst_clone.h
> index 786cee5d1209..fd52097e2072 100644
> --- a/include/tst_clone.h
> +++ b/include/tst_clone.h
> @@ -29,7 +29,7 @@ int ltp_clone(unsigned long flags, int (*fn)(void *arg),
> void *arg,
>                 size_t stack_size, void *stack);
>  int ltp_clone7(unsigned long flags, int (*fn)(void *arg), void *arg,
>                 size_t stack_size, void *stack, ...);
> -int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
> +int ltp_clone_alloc(unsigned long clone_flags, int (*fn)(void *arg),
>                 void *arg, size_t stacksize);
>  int ltp_clone_quick(unsigned long clone_flags, int (*fn)(void *arg),
>                 void *arg);
> diff --git a/lib/cloner.c b/lib/cloner.c
> index cf37184aa22a..8469745d004b 100644
> --- a/lib/cloner.c
> +++ b/lib/cloner.c
> @@ -135,11 +135,11 @@ void *ltp_alloc_stack(size_t size)
>  }
>
>  /*
> - * ltp_clone_malloc: also does the memory allocation for clone with a
> + * ltp_clone_alloc: also does the memory allocation for clone with a
>   * caller-specified size.
>   */
>  int
> -ltp_clone_malloc(unsigned long clone_flags, int (*fn) (void *arg), void
> *arg,
> +ltp_clone_alloc(unsigned long clone_flags, int (*fn) (void *arg), void
> *arg,
>                  size_t stack_size)
>  {
>         void *stack;
> @@ -162,7 +162,7 @@ ltp_clone_malloc(unsigned long clone_flags, int (*fn)
> (void *arg), void *arg,
>  }
>
>  /*
> - * ltp_clone_quick: calls ltp_clone_malloc with predetermined stack size.
> + * ltp_clone_quick: calls ltp_clone_alloc with predetermined stack size.
>   * Experience thus far suggests that one page is often insufficient,
>   * while 6*getpagesize() seems adequate.
>   */
> @@ -170,5 +170,5 @@ int ltp_clone_quick(unsigned long clone_flags, int
> (*fn) (void *arg), void *arg)
>  {
>         size_t stack_size = getpagesize() * 6;
>
> -       return ltp_clone_malloc(clone_flags, fn, arg, stack_size);
> +       return ltp_clone_alloc(clone_flags, fn, arg, stack_size);
>  }
>

There is another legacy problem maybe we need take care.

Any thought about how releasing the stack memory[1] after calling
ltp_clone_quick() in a test?

[1] which allocated memory in ltp_clone_alloc().

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190613/56fd0c52/attachment-0001.html>

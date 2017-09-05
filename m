From: enh <enh@google.com>
Date: Tue, 5 Sep 2017 12:07:20 -0700
Subject: [LTP] [RFC PATCH 2/6] android: lib: Add missing include for
	tst_safe_pthread.h
In-Reply-To: <20170902005926.15923-3-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-3-petr.vorel@gmail.com>
Message-ID: <CAJgzZoqi9HX-iqAbm7nMzM1UCZredL5DMaXYUghmd1RoqcxFJA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

i'm not sure what's android-specific here. don't you want #include
<pthread.h> or #include <sys/types.h> for all platforms, to get
pthread_t and pthread_once_t?

On Fri, Sep 1, 2017 at 5:59 PM, Petr Vorel <petr.vorel@gmail.com> wrote:
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Maybe __ANDROID__ or __BIONIC__ should be used to test.
> ---
>  include/tst_safe_pthread.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/tst_safe_pthread.h b/include/tst_safe_pthread.h
> index 0242d4c76..0551f063f 100644
> --- a/include/tst_safe_pthread.h
> +++ b/include/tst_safe_pthread.h
> @@ -18,6 +18,10 @@
>  #ifndef TST_SAFE_PTHREAD_H__
>  #define TST_SAFE_PTHREAD_H__
>
> +#ifdef __ANDROID_API__
> +#include <pthread.h>
> +#endif
> +
>  /*
>   * Macro to use for making functions called only once in
>   * multi-threaded tests such as init or cleanup function.
> --
> 2.14.0
>



-- 
Elliott Hughes - http://who/enh - http://jessies.org/~enh/
Android native code/tools questions? Mail me/drop by/add me as a reviewer.

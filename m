From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Nov 2017 14:43:56 +0100
Subject: [LTP] [PATCH v3 1/2] ltp: fix some frequent typoes
In-Reply-To: <20171101051523.373-1-liwang@redhat.com>
References: <20171101051523.373-1-liwang@redhat.com>
Message-ID: <20171101134356.GA10818@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 9562005..ed9c73c 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -406,7 +406,7 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
>  #define SAFE_EXECL(file, arg, ...) do {				\
>         execl((file), (arg), ##__VA_ARGS__);			\
>         tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,		\
> -                "execlp(%s, %s, ...) failed", file, arg); 	\
> +                "execl(%s, %s, ...) failed", file, arg); 	\
>         } while (0)

Can you, pretty please, put this change into a separate patch?

Since the rest of the changes are just fixing typos, there is no change
in behaivor. But this one actually changes it and there is even no
description for it in the commit message.

-- 
Cyril Hrubis
chrubis@suse.cz

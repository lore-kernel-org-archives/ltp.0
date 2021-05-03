From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 May 2021 15:28:46 +0200
Subject: [LTP] [PATCH v5 7/7] madvise06: Convert to new CGroups API
In-Reply-To: <20210430112649.16302-8-rpalethorpe@suse.com>
References: <20210430112649.16302-1-rpalethorpe@suse.com>
 <20210430112649.16302-8-rpalethorpe@suse.com>
Message-ID: <YI/6jqaKEI4lTTqC@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -/*
> - * DESCRIPTION
> +/*\
> + * [DESCRIPTION]

This should be [Description] now.

>   *
>   *   Page fault occurs in spite that madvise(WILLNEED) system call is called
>   *   to prefetch the page. This issue is reproduced by running a program
> @@ -36,13 +36,14 @@
>   *   else unexpected, but irrelevant procedure, registers a fault to
>   *   our process.
>   *
> - */
> +\*/

And this should be just */.

Also there are spaces prepended to the description which I guess may end
up as a <pre> block markup. Can we please fix that as well?

Also if we are pedantic this go in as a separate patch.


The actuall changes to the code looks good to me, nice cleanup.

With the description comment sorted out:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

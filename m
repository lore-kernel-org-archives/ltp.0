From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Mar 2019 12:36:14 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] cpuset: Detect missing fts.h
In-Reply-To: <20190321223656.9615-1-petr.vorel@gmail.com>
References: <20190321223656.9615-1-petr.vorel@gmail.com>
Message-ID: <20190322113614.GA20408@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/configure.ac b/configure.ac
> index e002c248e..f05db9d2e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -235,6 +235,7 @@ LTP_DETECT_HOST_CPU
>  LTP_CHECK_PERF_EVENT
>  LTP_CHECK_SYNCFS
>  LTP_CHECK_SYNC_FILE_RANGE
> +LTP_CHECK_FTS_H

Any reason why we couldn't simply put the fts.h at the end of the
AC_CHECK_HEADERS() list in configure.ac?

-- 
Cyril Hrubis
chrubis@suse.cz

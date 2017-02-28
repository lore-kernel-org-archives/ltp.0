From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 16:43:10 +0100
Subject: [LTP] [PATCH 2/3] Added fcntl() and fallocate() lapi flags
In-Reply-To: <1488283196-11397-3-git-send-email-jracek@redhat.com>
References: <1488283196-11397-1-git-send-email-jracek@redhat.com>
 <1488283196-11397-3-git-send-email-jracek@redhat.com>
Message-ID: <20170228154310.GB13574@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef SEEK_HOLE
> +#define SEEK_HOLE 4
> +#endif
> +
> +#ifndef FALLOC_FL_KEEP_SIZE
> +#define FALLOC_FL_KEEP_SIZE 0x01
> +#endif
> +
> +#ifndef FALLOC_FL_PUNCH_HOLE
> +#define FALLOC_FL_PUNCH_HOLE 0x02
> +#endif
> +
> +#ifndef FALLOC_FL_COLLAPSE_RANGE
> +#define FALLOC_FL_COLLAPSE_RANGE 0x08
> +#endif
> +
> +#ifndef FALLOC_FL_ZERO_RANGE
> +#define FALLOC_FL_ZERO_RANGE 0x10
> +#endif
> +
> +#ifndef FALLOC_FL_INSERT_RANGE
> +#define FALLOC_FL_INSERT_RANGE 0x20
> +#endif

These defines should be indented with a space after the hash, but that
is very minor.

-- 
Cyril Hrubis
chrubis@suse.cz

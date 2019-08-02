From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Aug 2019 16:20:13 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190801092616.30553-2-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
Message-ID: <20190802142013.GB17684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
> index df048ede4..1a0f625c9 100644
> --- a/testcases/kernel/syscalls/accept/accept02.c
> +++ b/testcases/kernel/syscalls/accept/accept02.c

Sigh looks like I've added this test conversion to this patch as a
mistake, I will move it to a separate patch in v2.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 14:43:42 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls: modify_ldt02: Fix failure
In-Reply-To: <20210506115108.16751-1-chrubis@suse.cz>
References: <20210506115108.16751-1-chrubis@suse.cz>
Message-ID: <YJPkfpbvrFolajyG@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> The test was wrong to begin with, if we want to get SEGFAULT from the
> waitpid() we cannot setup a handler that catches it and exits with 0.

> Fixes: f5e8e6b11ce8 ("syscalls/modify_ldt: Replace TINFO with TPASS or TFAIL")

Thanks a lot!

Kind regards,
Petr

From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 25 Jun 2021 13:57:10 +0200
Subject: [LTP] [PATCH] getrlimit/getrlimit03: fix unavailable
 __NR_getrlimit for arm
In-Reply-To: <YNR7L2ftbwx6IUls@google.com>
References: <20210623134041.366838-1-balsini@android.com>
 <YNM6QGFYt/bpaPDS@yuki> <YNR7L2ftbwx6IUls@google.com>
Message-ID: <YNXEltZhCiuezIvP@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Here below the new patch that should fixed the unused functions warnings, as
> well as the useless definition of rlimit_long if the signed version of
> __NR_getrlimit does not exist.

I've adjusted the patch a bit and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

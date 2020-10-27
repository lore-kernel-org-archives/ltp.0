From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 27 Oct 2020 16:22:11 +0800
Subject: [LTP] [PATCH 01/19] Unify error handling in
 lib/tst_safe_macros.c
In-Reply-To: <20201026164756.30556-2-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-2-mdoucha@suse.cz>
Message-ID: <5F97D8B3.90404@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin
> - Properly format caller file:line location
> - Pedantically check for invalid syscall return values, don't ignore silently
> - Always return syscall result so that all SAFE_*() functions can be called
>    in test cleanup
It looks good to me,
Acked-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   include/tst_safe_macros.h |  30 ++++----
>   lib/tst_safe_macros.c     | 154 ++++++++++++++++++++++++++++++--------
>   2 files changed, 137 insertions(+), 47 deletions(-)




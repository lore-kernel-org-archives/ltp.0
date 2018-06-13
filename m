From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jun 2018 13:47:54 +0200
Subject: [LTP] [RFC PATCH 4/9] syscalls/ipc: Rewrite msgctl02 to new
 library.
In-Reply-To: <20180612154631.435-5-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-5-chrubis@suse.cz>
Message-ID: <20180613114754.rf5cc3c63om5ze6m@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/ipc/msgctl/msgctl02.c | 207 +++++++-----------------
>  1 file changed, 58 insertions(+), 149 deletions(-)

LGTM.

Kind regards,
Petr

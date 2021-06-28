From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Jun 2021 16:49:15 +0200
Subject: [LTP] [PATCH v3 1/4] include/tst_pid.h: fix language typo
 (subtraction)
In-Reply-To: <20210623135912.81156-2-krzysztof.kozlowski@canonical.com>
References: <20210623135912.81156-1-krzysztof.kozlowski@canonical.com>
 <20210623135912.81156-2-krzysztof.kozlowski@canonical.com>
Message-ID: <YNnhawovD2P/JBHu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Krzysztof,

>  /*
> - * Returns number of free pids by substarction of the number of pids
> + * Returns number of free pids by subtraction of the number of pids
>   * currently used ('ps -eT') from max_pids
Because you change the description of this function in the next commit,
I'd just fix this simple typo in 2nd commit. But of course it's not wrong
(prevents keeping the fix even if we'd removed second commit).

Kind regards,
Petr
>   */
>  int tst_get_free_pids_(void (*cleanup_fn)(void));

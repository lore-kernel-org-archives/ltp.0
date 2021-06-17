From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Jun 2021 13:34:03 +0200
Subject: [LTP] [PATCH v2 08/10] semctl03 :Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210609173601.29352-8-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
 <20210609173601.29352-8-vinay.m.engg@gmail.com>
Message-ID: <YMszKzdwfi7PeAMs@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TST_EXP_FAIL(sys_semctl(*(tc->sem_id), 0, tc->ipc_cmd, *(tc->buf)),
                     ^
		     Fixed this to tv->semctl

And adjusted a few whitespaces and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

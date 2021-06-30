From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jun 2021 16:27:50 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/ipc: Make use of TST_EXP_FAIL or
 TST_EXP_FAIL2 macro
In-Reply-To: <1624963486-6614-2-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YNHCQ8qWSBdHIAra@yuki>
 <1624963486-6614-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624963486-6614-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YNx/ZvzdI9AifBHK@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TST_EXP_FAIL(msgget(*tc->key, tc->flags), tc->exp_err, "msgget(%i, %i)",
> +		*tc->key, tc->flags);
>  }

I've changed this one to TST_EXP_FAIL2() since msgget() returns
non-negative integer on success and pushed the patchset, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

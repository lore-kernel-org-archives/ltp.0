From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 13:40:43 +0200
Subject: [LTP] [PATCH 3/6] lib/tst_run_cmd_*(): Turn int pass_exit_val
 into enum
In-Reply-To: <20200330113802.GE9845@yuki.lan>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-4-pvorel@suse.cz>
 <20200330113802.GE9845@yuki.lan>
Message-ID: <20200330114043.GA23915@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > This is a preparation for next commit.
> > Now uses the only flag TST_RUN_CMD_PASS_EXIT_VAL.

> That is quite long name, I wonder if we can shorten it.

> Maybe we can rename the whole tst_run_cmd() just to tst_cmd() and change
> this flag to TST_CMD_PASS_RETVAL.
This looks good to me, I'll change it.


> Other that this the patchset looks good.
And push whole patchset with your, Li's and Xiao Reviewed-by: tag.

Kind regards,
Petr

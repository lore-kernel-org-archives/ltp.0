From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 May 2021 16:31:27 +0200
Subject: [LTP] LTP Release
In-Reply-To: <YJPo4L0QnXHU7xks@pevik>
References: <YJOYgZNL7/qp5YCN@yuki>
 <YJPo4L0QnXHU7xks@pevik>
Message-ID: <YJVPP64LuDK7O564@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi Cyril,

> also solving Shell API timeout sleep orphan processes would be good [1]
> There is already C patch [2] + Li suggested to fix the shell implementation
> using trap in subshell [3].
OK there is shell implementation to fix orphan processes [4] from Joerg, which
would be worth do fix it, Li already did a review, I'll look into it today.

I'd like to rebase and send to ML IMA dm-crypt test for testing. If Mimi, Tushar
or Lakshmi find time to test it, I'd like to have it in the release.

I try to have a look on few cleanup patches today from Martin [6], Xie and Zhao.

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://lists.linux.it/pipermail/ltp/2021-May/022350.html
> [2] https://patchwork.ozlabs.org/project/ltp/list/?series=242439
> [3] https://lists.linux.it/pipermail/ltp/2021-May/022453.html
[4] https://patchwork.ozlabs.org/project/ltp/list/?series=242665
[5] https://patchwork.ozlabs.org/project/ltp/list/?series=230766
[6] https://patchwork.ozlabs.org/project/ltp/patch/20210505153847.6106-2-mdoucha@suse.cz/

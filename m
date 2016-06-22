From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jun 2016 15:38:38 +0200
Subject: [LTP] [PATCH 3/4] memcg/functional: use checkpoints
In-Reply-To: <1465917893-32074-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1465917893-32074-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1465917893-32074-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1465917893-32074-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160622133838.GF13962@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch implements the idea proposed in [1], [2], that
> we use the checkpoint interface to let memcg_process inform
> the parent process that it's ready.
> 
> In my enviroment it saves ~50 secs of time.

Nice :)

BTW, we should also change the test so that the allocation is not done
from the signal handlers, but that can be done later.

-- 
Cyril Hrubis
chrubis@suse.cz

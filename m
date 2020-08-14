From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Aug 2020 17:41:58 +0200
Subject: [LTP] [PATCH 3/4] Simplify syscalls/bind06 using new taint
 check API
In-Reply-To: <20200811130502.12010-3-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <20200811130502.12010-3-mdoucha@suse.cz>
Message-ID: <20200814154158.GC30390@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> The bug causes kernel crash when the process that performed the race exits.
> Now that taint checks are integrated in the LTP library, forking a child is no
> longer necessary.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice simplification, thanks!

Kind regards,
Petr

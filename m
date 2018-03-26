From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Mar 2018 15:39:31 +0200
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Add SAFE_GETGRNAM()
In-Reply-To: <20180326132242.GA20143@x230>
References: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <20180326132242.GA20143@x230>
Message-ID: <20180326133931.GD27423@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#define SAFE_GETGRNAM(cleanup_fn, name) \
> > +	safe_getgrnam(__FILE__, __LINE__, cleanup_fn, (name))
> Can you please sort it alphabetically (i.e. put SAFE_GETGRNAM() before SAFE_GETPWNAM())?
> 
> @Cyril: Do we want to change also safe_macros.h ?

We are not supposed to add anything into oldlib safe macros, the old
library is in a maintenance mode, only bugfixes should go there, no new
functionality.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Dec 2016 16:16:18 +0100
Subject: [LTP] [PATCH 1/2] syscalls/mq_timedsend: convert to new API
In-Reply-To: <20161215144249.ccotszsqja5o2rae@dell5510>
References: <20161214221713.4460-1-pvorel@suse.cz>
 <20161215144249.ccotszsqja5o2rae@dell5510>
Message-ID: <20161215151618.GB16771@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> >  .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  | 649 ++++++++-------------
> 
> It's a crap, sorry. Both mq_timedsend and mq_timedreceive need to be improved, in similar
> way as mq_open.

Don't worry too much, you are doing a good job here :-).

-- 
Cyril Hrubis
chrubis@suse.cz

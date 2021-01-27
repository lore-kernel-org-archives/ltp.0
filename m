From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 27 Jan 2021 20:30:38 +0800
Subject: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge
 systems
References: <20210127115606.28985-1-mdoucha@suse.cz>, 
 <YBFWrJoS1tVmWGFx@yuki.lan>, 
 <2021012720143348660139@chinatelecom.cn>, 
 <YBFcc/lc+KkC49Gq@yuki.lan>
Message-ID: <2021012720303822264041@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

OK,I also wanna know how to fix it.
Thanks!
 
From: Cyril Hrubis
Date: 2021-01-27 20:28
To: liuxp11@chinatelecom.cn
CC: mdoucha; ltp
Subject: Re: Re: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge systems
Hi!
> According my test,malloc amount greater than available memory,then invoke the oom-killer.
 
However that does not mean that allocating MemAvailable or slightly less
than MemAvailable is safe. In fact it's not, at least that I've been
told be kernel developers. I will try to figure out something safe
enough with their help.
 
-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/ed42b7e7/attachment.htm>

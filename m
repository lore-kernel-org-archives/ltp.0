From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2021 13:28:35 +0100
Subject: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge
 systems
In-Reply-To: <2021012720143348660139@chinatelecom.cn>
References: <20210127115606.28985-1-mdoucha@suse.cz>
 <YBFWrJoS1tVmWGFx@yuki.lan>
 <2021012720143348660139@chinatelecom.cn>
Message-ID: <YBFcc/lc+KkC49Gq@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> According my test,malloc amount greater than available memory,then invoke the oom-killer.

However that does not mean that allocating MemAvailable or slightly less
than MemAvailable is safe. In fact it's not, at least that I've been
told be kernel developers. I will try to figure out something safe
enough with their help.

-- 
Cyril Hrubis
chrubis@suse.cz

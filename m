From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Jul 2019 11:18:03 +0200
Subject: [LTP] [RFC PATCH] syscalls: Remove getcontext01
In-Reply-To: <5D357777.9030308@cn.fujitsu.com>
References: <20190722083356.10142-1-pvorel@suse.cz>
 <5D357777.9030308@cn.fujitsu.com>
Message-ID: <20190722091803.GB12237@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Hi Petr,

> gercontext is filtered for uclinux and android in syscalls/Makefile so we
> can remove it as well. :-)
Filtering by architecture is IMHO wrong, at least for cases like this one when
it can be detected. And uclinux has some filtering in Makefile other in sources.

Kind regards,
Petr

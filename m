From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Dec 2020 11:53:43 +0100
Subject: [LTP] [PATCH v1] openposix/fork/7-1.c: A bug fix
In-Reply-To: <750CB65B-8F87-484D-9373-5CE4E1003413@getmailspring.com>
References: <X9NB12pkaskYs8+l@yuki.lan>
 <750CB65B-8F87-484D-9373-5CE4E1003413@getmailspring.com>
Message-ID: <X9NPty84RhoUmgSE@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> By adding this comment I wanted to stress that the place of "errno =
> 0" is not randomly chosen, to prevent somebody from moving it back to
> the beginning of the file :) But if you find it not necessary, then
> please go ahead.

I think that this still falls under "do not comment the obvious" rule.
We do have more than hundred of testcases that do "errno = 0" and as far
as I can tell none of them includes a comment that says that we cannot
move the code around and I do not think that we should add hundred of
comments into these testcases either.

-- 
Cyril Hrubis
chrubis@suse.cz

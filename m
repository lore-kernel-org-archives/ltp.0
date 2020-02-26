From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Feb 2020 00:37:17 +0100
Subject: [LTP] [PATCH v1] Stringify flags to improve error msg of
 unshare()
In-Reply-To: <20200226172620.29815-1-cfamullaconrad@suse.de>
References: <20200226172620.29815-1-cfamullaconrad@suse.de>
Message-ID: <20200226233717.GA10163@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> If your test has multiple calls of unshare() it is hard to read which
> unshare() call really failed. With this we improve the error message to
> something like this:

>   sendmsg03.c:43: CONF: unshare(CLONE_NEWUSER) unsupported: EINVAL (22)

> Instead of having a hard to understand number like:

>   sendmsg03.c:43: CONF: unshare(268435456) unsupported: EINVAL (22)

> Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM. BTW I guess sendmsg03.c is part of patch you're working on atm, right?
It's a bit confusing to refer to file which does not exist in git yet.
Actually, no test is using yet since it's adding in db2f0ed9e.

Kind regards,
Petr

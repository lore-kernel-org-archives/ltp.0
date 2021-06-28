From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Jun 2021 21:29:16 +0200
Subject: [LTP] [PATCH v3 1/4] include/tst_pid.h: fix language typo
 (subtraction)
In-Reply-To: <c02beb1f-31f8-8902-8be8-27b4bf9ecfe2@canonical.com>
References: <20210623135912.81156-1-krzysztof.kozlowski@canonical.com>
 <20210623135912.81156-2-krzysztof.kozlowski@canonical.com>
 <YNnhawovD2P/JBHu@pevik>
 <c02beb1f-31f8-8902-8be8-27b4bf9ecfe2@canonical.com>
Message-ID: <YNojDI7jzK0P0QRS@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 28/06/2021 16:49, Petr Vorel wrote:
> > Hi Krzysztof,

> >>  /*
> >> - * Returns number of free pids by substarction of the number of pids
> >> + * Returns number of free pids by subtraction of the number of pids
> >>   * currently used ('ps -eT') from max_pids
> > Because you change the description of this function in the next commit,
> > I'd just fix this simple typo in 2nd commit. But of course it's not wrong
> > (prevents keeping the fix even if we'd removed second commit).

> The commits should do only one thing (fix one bug, bring one feature if
> possible) and the next commit does not touch that line. There is no
> re-doing of the same change in next commit.
As I wrote in this case I wouldn't bother (with test rewrite to new API there
are much more changes in single commit), but sure you're right this is the best
practice which we follow.

Kind regards,
Petr

> Best regards,
> Krzysztof

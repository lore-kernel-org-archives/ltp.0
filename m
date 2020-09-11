From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2020 08:56:35 +0200
Subject: [LTP] [PATCH 1/1] fanotify10: Treat ignore mask bug as TCONF
 for < v5.9
In-Reply-To: <CAOQ4uxjaiT4N1uvwzh8Jer4wc3HR+pqxNM_CLzFWZDbxZDxEHA@mail.gmail.com>
References: <20200910121628.18505-1-pvorel@suse.cz>
 <20200910153035.GA12601@yuki.lan>
 <CAOQ4uxjaiT4N1uvwzh8Jer4wc3HR+pqxNM_CLzFWZDbxZDxEHA@mail.gmail.com>
Message-ID: <20200911065635.GB3425@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> What I suggested was to skip only the test cases with non zero
> tc->ignored_onchild for kernel < 5.9.

> Those are the new test cases that are failing due to missing fix
> "497b0c5a7c06 fsnotify: send event to parent and child with single"
> Which is not likely to be backported.

> I see no reason to run those test cases and then report the failure as
> TCONF.
> The TCONF message can say that ignored mask in combination with
> flag FAN_EVENT_ON_CHILD have undefined behavior on kernel < 5.9.
Yep, that makes more sense.

> While at it, please remove the stray line from header comment:
>  *     497b0c5a7c06 fsnotify: send event to parent and child with single...
>  *     eca4784cbb18 fsnotify: send event to parent and child with single...
Apologize for not removing eca4784cbb18.

> And please remove commit id 497b0c5a7c06 from .tags, otherwise,
> stable kernel maintainers are still going to be bothered by attempting
> to find a backport if that test fails due to other reasons on a stable kernel.
+1. I kept comment in the commit (in v2) and explicitly mention why it's not in
tags.

Thanks for all suggestions. Just in case I sent v2 instead of merging it directly.

Kind regards,
Petr

From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 May 2021 13:13:46 +0200
Subject: [LTP] [PATCH v3 6/6] Add test for CVE 2020-25705
In-Reply-To: <4ea9d02a-2867-1977-cfd3-bd591d211733@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-6-mdoucha@suse.cz> <YJJtpXWM4BxH2ffu@pevik>
 <4ea9d02a-2867-1977-cfd3-bd591d211733@suse.cz>
Message-ID: <YJJ96mpakcatiQ4z@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Yes, I should fix this and the <time.h> issue. Please push everything up
> to patch 5 and then I'll resubmit v4 just for this patch.
NOTE: <time.h> must be included *before* <linux/errqueue.h>
(maybe bug in musl headers).
I suppose Cyril will merge these 4 patches soon.

> > FYI I tested the test on several VM. Very old kernel detects problem only on
> > more runs. But given it's 3.16 (and b38e7819cae9 is a fix for 4cdf507d5452 from
> > v3.18-rc1 we can ignore this).

> Pass is expected here. Vanilla v3.16 AFAIK does not have the global ICMP
> rate limiter which introduced the real vulnerability in the first place.
Sure. I was just surprised to get different result on -i1 and on -i >= 2.

Kind regards,
Petr

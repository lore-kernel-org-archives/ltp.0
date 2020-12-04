From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Dec 2020 15:27:08 +0100
Subject: [LTP] [PATCH 0/5] Fanotify cleanup and test for v5.9 regression
In-Reply-To: <20201204095930.866421-1-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
Message-ID: <X8pHPA/8hI2zf4Qo@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Hi Petr,

> Here are my followup patches to your great cleanup and
> a new test for a bug fix that is already included in v5.9.y.

> Note that I resurrected the helper from your V5 patches that
> you turned into a macro following Cyril's comment.
> I hope you both find the result satisfying.
Nice clean patchset, as usually. Thank you.
I'll do some testing on Monday.
@Jan, if you have time please have a quick look into the patchset.

> There are no direct calls to fanotify_init() after those
> cleanups (except for the intended use in fanotify14).
+1

> FYI, I have another test (inotify) for another v5.9 regression.
> The fix is queued for upstream, but did reach upstream yet, so
> I will post that test later.
+1

> Thanks,
> Amir.

Kind regards,
Petr

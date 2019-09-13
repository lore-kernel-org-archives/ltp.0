From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Sep 2019 15:07:28 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190906130707.GA7515@rei.lan>
References: <20190906130707.GA7515@rei.lan>
Message-ID: <20190913130728.GA335@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> As usually we should start prepare for a release somewhere at the end of
> the September.

> I will try to review as much patches as possible next week, then I would
> like to start the pre-release testing. So if there is something that
> really should go in before the release let me know.
I'd like to have shell timeout fixes + enhancements [1].
I hope I'll send route shell tests rewrite v5, tst_res return exit value [2] is a preparation
for it (if acceptable).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=130562&state=*
[2] https://patchwork.ozlabs.org/patch/1161773/

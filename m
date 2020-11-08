From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 8 Nov 2020 22:43:06 +0100
Subject: [LTP] [PATCH 1/1] fanotify16: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <CAOQ4uxgAk_k8de0XTewYoFKYYr2Ykpe3Ww5vy7Xfqy9hbUb7VA@mail.gmail.com>
References: <20201016112441.4838-1-pvorel@suse.cz>
 <CAOQ4uxixzOtXjyVTUNR03ffJHgTQCm5+L46zNNgdxvB0n9ZuhA@mail.gmail.com>
 <20201020070017.GA4263@dell5510>
 <CAOQ4uxgAk_k8de0XTewYoFKYYr2Ykpe3Ww5vy7Xfqy9hbUb7VA@mail.gmail.com>
Message-ID: <20201108214306.GA115861@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> On Tue, Oct 20, 2020 at 10:00 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Amir,

> > thanks for your suggestions, I'll send v2 shortly.
> > I've been thinking about it for a while and agree it's better to simplify
> > safe_fanotify_mark() hints.
> > I'll also separate fixes into more commits to be more readable.


> Hi Petr,

> I guess v2 got delayed,
Yes, I'm sorry. While being in the middle of the work, but higher priority work
arrived :). I'll try to get to v2 soon, but just let me know if it block you and
you're going to implement the cleanup yourself.

> so while at it let me ask -
> Did you maybe consider also moving the checks for
> "FAN_REPORT_FID not supported in kernel?" and
> "FAN_REPORT_NAME not supported in kernel?"
> into safe_fanotify_init()?
Sure.

> The reason I am asking is because I am working on adding a test case
> to fanotify09 [1], which involves converting SAFE_FANOTIFY_INIT()
> to fanotify_init(), due to pottenitally unsupported init flags in the kernel.
I see, third patch.

Kind regards,
Petr

> Thanks,
> Amir.

> [1] https://github.com/amir73il/ltp/commits/fsnotify-fixes

From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 8 Nov 2020 10:43:03 +0200
Subject: [LTP] [PATCH 1/1] fanotify16: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <20201020070017.GA4263@dell5510>
References: <20201016112441.4838-1-pvorel@suse.cz>
 <CAOQ4uxixzOtXjyVTUNR03ffJHgTQCm5+L46zNNgdxvB0n9ZuhA@mail.gmail.com>
 <20201020070017.GA4263@dell5510>
Message-ID: <CAOQ4uxgAk_k8de0XTewYoFKYYr2Ykpe3Ww5vy7Xfqy9hbUb7VA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 20, 2020 at 10:00 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> thanks for your suggestions, I'll send v2 shortly.
> I've been thinking about it for a while and agree it's better to simplify
> safe_fanotify_mark() hints.
> I'll also separate fixes into more commits to be more readable.
>

Hi Petr,

I guess v2 got delayed, so while at it let me ask -
Did you maybe consider also moving the checks for
"FAN_REPORT_FID not supported in kernel?" and
"FAN_REPORT_NAME not supported in kernel?"
into safe_fanotify_init()?

The reason I am asking is because I am working on adding a test case
to fanotify09 [1], which involves converting SAFE_FANOTIFY_INIT()
to fanotify_init(), due to pottenitally unsupported init flags in the kernel.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fsnotify-fixes

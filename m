From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 23 Jun 2019 20:13:45 +0300
Subject: [LTP] [PATCH v5 2/4] syscalls/fanotify14: new test to validate
 FAN_REPORT_FID interface return values
In-Reply-To: <20190621140009.GA26200@rei.lan>
References: <cover.1561018312.git.mbobrowski@mbobrowski.org>
 <98bc3a5d9591387964b913c497f930a11ea4f7a8.1561018312.git.mbobrowski@mbobrowski.org>
 <20190621140009.GA26200@rei.lan>
Message-ID: <CAOQ4uxjUtmrAfjwxhSU3g3QJ-2Nk9795pdT=nd8Mza_ETo+_2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 21, 2019 at 5:00 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > +#else
> > +     TST_TEST_TCONF("System does not have required fanotify support")
>                                                                         ^
>                                                         I've added
>                                                         missing
>                                                         semicolon here.
> > +#endif
>
> And applied whole patchset together with the fix from Amir.
>

Hi Cyril,

v5 series has 4 patches and I only see you applied the 3 first patches.
This one was not applied:

syscalls/fanotify13: add test coverage for fsid cache bug

The extra patch adds coverage to a bug found round rc5 time whose
fix was merged to kernel v5.2-rc6:
c285a2f01d69 fanotify: update connector fsid cache on add mark

Thanks,
Amir.

From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 28 Apr 2020 18:18:48 +0300
Subject: [LTP] [PATCH 2/2] fanotify: Test with tst_variant both raw
 syscall and libc
In-Reply-To: <20200428133748.GA5349@dell5510>
References: <20200428113501.24711-1-pvorel@suse.cz>
 <20200428113501.24711-2-pvorel@suse.cz>
 <CAOQ4uxjTh5r3JWVzt6Gazh61Cb1Fr7Y90k1mXn=q2WbsSRs2NQ@mail.gmail.com>
 <20200428133748.GA5349@dell5510>
Message-ID: <CAOQ4uxjJ7qFZVf4YNNK=JYDSc=_+fRoU6v+OAwQ3Vp7soNSAbQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 28, 2020 at 4:37 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > FWIW, I have no objection to these changes.
> Thanks!
>
> > I trust that you tested build with all supported configurations, because
> > I am not good at reviewing portable code.
> Not sure if I understand you. There is just a single configuration (test are run
> twice, first with raw syscall than with libc wrapper). Previously there were two
> configurations (tests were run only once, mostly with libc wrapper, raw syscalls
> was on systems with old glibc, where only kernel supports fanotify syscall).
>

My confusion is because you removed the HAVE_SYS_FANOTIFY_H ifdef
and now you include sys/fanotify.h unconditionally.
So I meant if this code builds with all supported system configurations.

Thanks,
Amir.

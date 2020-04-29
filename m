From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Apr 2020 17:27:51 +0300
Subject: [LTP] [PATCH 2/2] fanotify: Test with tst_variant both raw
 syscall and libc
In-Reply-To: <20200429120611.GA10236@dell5510>
References: <20200428113501.24711-1-pvorel@suse.cz>
 <20200428113501.24711-2-pvorel@suse.cz>
 <CAOQ4uxjTh5r3JWVzt6Gazh61Cb1Fr7Y90k1mXn=q2WbsSRs2NQ@mail.gmail.com>
 <20200428133748.GA5349@dell5510>
 <CAOQ4uxjJ7qFZVf4YNNK=JYDSc=_+fRoU6v+OAwQ3Vp7soNSAbQ@mail.gmail.com>
 <20200429120611.GA10236@dell5510>
Message-ID: <CAOQ4uxjRD_gjLYS_kujAR--GO7QAqUX_B7x=3m9K4Ffzq_Ewmw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 29, 2020 at 3:06 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > My confusion is because you removed the HAVE_SYS_FANOTIFY_H ifdef
> > and now you include sys/fanotify.h unconditionally.
> > So I meant if this code builds with all supported system configurations.
> Thanks! I overlook an obvious error. Patch is wrong, because fanotify.h must be
> included in tests below #if defined(HAVE_SYS_FANOTIFY_H).
> Below is fix to posted patch, tested without <sys/fanotify.h>.
>

That looks sane.

Thanks,
Amir.

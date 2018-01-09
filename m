From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Jan 2018 13:38:58 +0100
Subject: [LTP] More CI testing on git push
In-Reply-To: <20180109105431.GB31448@rei>
References: <20180108140856.w5qaavlzfavoamuf@dell5510>
 <1887263757.4869615.1515491297851.JavaMail.zimbra@redhat.com>
 <20180109105431.GB31448@rei>
Message-ID: <20180109123858.anendti6vfipnksq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > currently we use Travis for various gcc/clang based builds, cross-compile arm
> > > and i868.
> > > I've been talking some time ago with Cyril about more CI testing. It would be
> > > great to
> > > test also LTP compiled old glibc an kernel headers + testing musl/uclibc.

> > I'm not sure how much success you will have with uclibc - we stopped
> > caring about it some time ago, so I'm assuming it's broken.

> The uClinux seems to be dead at this point. I tried to send an email
> asking if we should keep the suport to the mailing list but I couldn't
> even subscribe (moderator wasn't responding to the request).

> The last post to the uclinux.org was done on May 2016, that will be two
> years old soon.
Sorry I meant uclibc-ng [1]. It is living project, the same is musl.
But I know that our main concern is glibc, so there should be more tests on it.
And as I said, my goal is just to have it compilable.

> So I assumed that CPUs with MMU are so cheap these days that nobody
> keeps hacking on non-MMU machines.


> > Other than that, I'd choose something very recent, like latest Fedora.

> Sounds reasonable. Something really old + bleeding edge is a good
> combination.
Thanks for info!


Kind regards,
Petr

[1] https://cgit.openadk.org/cgi/cgit/uclibc-ng.git/
[2] https://wip.pkgsrc.org/cgi-bin/gitweb.cgi?p=pkgsrc-wip.git;a=tree;f=ltp-git

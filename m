From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Jan 2018 11:54:31 +0100
Subject: [LTP] More CI testing on git push
In-Reply-To: <1887263757.4869615.1515491297851.JavaMail.zimbra@redhat.com>
References: <20180108140856.w5qaavlzfavoamuf@dell5510>
 <1887263757.4869615.1515491297851.JavaMail.zimbra@redhat.com>
Message-ID: <20180109105431.GB31448@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > currently we use Travis for various gcc/clang based builds, cross-compile arm
> > and i868.
> > I've been talking some time ago with Cyril about more CI testing. It would be
> > great to
> > test also LTP compiled old glibc an kernel headers + testing musl/uclibc.
> 
> I'm not sure how much success you will have with uclibc - we stopped
> caring about it some time ago, so I'm assuming it's broken.

The uClinux seems to be dead at this point. I tried to send an email
asking if we should keep the suport to the mailing list but I couldn't
even subscribe (moderator wasn't responding to the request).

The last post to the uclinux.org was done on May 2016, that will be two
years old soon.

So I assumed that CPUs with MMU are so cheap these days that nobody
keeps hacking on non-MMU machines.

> > I was thinking to use doozer.io. It provides some quite new distros:
> > Debian 8 Jessie (i386), glibc 2.19
> > Ubuntu 12.04 LTS Precise (i386, amd64), glibc 2.15
> > Ubuntu 14.04 LTS Trusty (i386, amd64), glibc 2.19
> > Ubuntu 16.04 LTS Xenial (i386, amd64), glibc 2.23
> > Fedora 24 (x86_64), glibc 2.23.1
> > Centos 7 (x86_64), glibc 2.17
> > Raspbian Jessie ARM 32bit
> > Raspbian Stretch ARM 32bit
> > 
> > It provides some variety of distros and glibc + kernel headers.
> > Docker based CI would give us more variants.
> > 
> > Cyril, Jan, which glibc and kernel header versions would you like to test?
> 
> Is there an option to use some older distro? e.g. glibc-2.12 + 2.6.32
> That's equivalent of RHEL6.2. I wouldn't go older than that - I still
> sometimes check with RHEL5, but that one is likely not worth the effort
> given that EOL is in couple years.
> 
> Other than that, I'd choose something very recent, like latest Fedora.

Sounds reasonable. Something really old + bleeding edge is a good
combination.

-- 
Cyril Hrubis
chrubis@suse.cz

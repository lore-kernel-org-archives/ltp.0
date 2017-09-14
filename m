From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Sep 2017 17:14:53 +0200
Subject: [LTP] LTP release
In-Reply-To: <1118211565.15787694.1505398656441.JavaMail.zimbra@redhat.com>
References: <20170907105921.GB775@rei.lan>
 <1118211565.15787694.1505398656441.JavaMail.zimbra@redhat.com>
Message-ID: <20170914151453.GC11303@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > It's about a time we should start preparing for another release.
> > 
> > As usuall let's start with pointing out patches that should be part of
> > it, then we will proceed with freezing the repo and round of pre-release
> > testing, etc.
> 
> I started running tests (syscalls, misc, commands, etc.) across RHELs:
> 6.2-6.10(i386,x86_64,ppc64,s390x) and 7.0-7.4(x86_64, ppc64, ppc64le, s390x).
> 
> Other than couple small issues that have been fixed, and known kernel bugs,
> it's looking good.

It's looking good on my side as well.

I still want to fix the utimensat_tests.sh before the release that fails
on stable kernels that backported the fix.

Apart from that I would consider tmpfs for EROFS patch, since that one
may be a good speed up. And possibly the synchronization library for CVE
tests, if Richard manages to send updated patchset.

And that should ideally be all, or have I missed something?

-- 
Cyril Hrubis
chrubis@suse.cz

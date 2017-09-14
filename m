From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Sep 2017 10:17:36 -0400 (EDT)
Subject: [LTP] LTP release
In-Reply-To: <20170907105921.GB775@rei.lan>
References: <20170907105921.GB775@rei.lan>
Message-ID: <1118211565.15787694.1505398656441.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> It's about a time we should start preparing for another release.
> 
> As usuall let's start with pointing out patches that should be part of
> it, then we will proceed with freezing the repo and round of pre-release
> testing, etc.

I started running tests (syscalls, misc, commands, etc.) across RHELs:
6.2-6.10(i386,x86_64,ppc64,s390x) and 7.0-7.4(x86_64, ppc64, ppc64le, s390x).

Other than couple small issues that have been fixed, and known kernel bugs,
it's looking good.

I'm planning on repeating the tests after the freeze.

Regards,
Jan

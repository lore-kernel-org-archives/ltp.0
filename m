From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 May 2020 16:26:21 +0200
Subject: [LTP] [PATCH 3/5] syscalls: semctl: Add new test to verify the
 _time_high fields
In-Reply-To: <CAK8P3a0pxv5wauMcf223n=_7zNJ4mn1Y0WvcssFC13pcvz9wmQ@mail.gmail.com>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <5d502fbc7070644ed83c423713941b457c3a7aff.1590057824.git.viresh.kumar@linaro.org>
 <CAK8P3a0pxv5wauMcf223n=_7zNJ4mn1Y0WvcssFC13pcvz9wmQ@mail.gmail.com>
Message-ID: <20200521142621.GE7833@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The _time_high fields must be reset by the kernel, add a test to verify
> > that.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Right, here you do need to copy the struct definitions since I forgot
> to add a way to detect the presence in the kernel header files,
> sorry about that.
> 
> Possibly you could just have a check in the Makefile that lets
> skips the test if it fails to build because of old kernel headers?
> Or maybe check LINUX_VERSION_CODE to see if the headers
> are at least from linux-4.19?

We usually include autotools checks and fallback definitions in
include/lapi.h in this case.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Dec 2019 13:22:37 +0100
Subject: [LTP] ??? FAIL: Test report for kernel 5.3.13-cc9917b.cki
 (stable-queue)
In-Reply-To: <546bd6ac-8ab1-9a9b-5856-e6410fb8ee89@redhat.com>
References: <cki.B4696121A3.SRVKVUGWT3@redhat.com>
 <546bd6ac-8ab1-9a9b-5856-e6410fb8ee89@redhat.com>
Message-ID: <20191203122236.GC2844@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We ran automated tests on a recent commit from this kernel tree:
> > 
> >         Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
> >              Commit: cc9917b40848 - mdio_bus: Fix init if CONFIG_RESET_CONTROLLER=n
> > 
> > The results of these automated tests are provided below.
> > 
> >      Overall result: FAILED (see details below)
> >               Merge: OK
> >             Compile: OK
> >               Tests: FAILED
> > 
> > All kernel binaries, config files, and logs are available for download here:
> > 
> >    https://artifacts.cki-project.org/pipelines/309848
> > 
> > One or more kernel tests failed:
> > 
> >      ppc64le:
> >       ??? LTP
> 
> I see a slew of syscalls failures here for LTP:
> https://artifacts.cki-project.org/pipelines/309848/logs/ppc64le_host_1_LTP_resultoutputfile.log
> https://artifacts.cki-project.org/pipelines/309848/logs/ppc64le_host_1_LTP_syscalls.run.log

There are a few syslog failures, which does not seem to be related to
the kernel commit at all. The commit above seems to touch error handling
in a mdio bus which is used to configure network hardware. I would say
that this is connected to the rest of the unexplained failures on
ppc64le that seems to happen randomly.

-- 
Cyril Hrubis
chrubis@suse.cz

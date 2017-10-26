From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Oct 2017 12:09:11 +0200
Subject: [LTP] [lkp-robot] [x86/topology] 379a4bb988:
 dmesg.WARNING:at_arch/x86/events/intel/uncore.c:#uncore_change_type_ctx
In-Reply-To: <48cfd754-886d-38b0-b9e5-55088e5a9665@redhat.com>
References: <20171012064439.GN26196@yexl-desktop>
 <48cfd754-886d-38b0-b9e5-55088e5a9665@redhat.com>
Message-ID: <20171026100911.GD3873@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  bin/lkp install job.yaml
> 
> [root@hpe-dl385gen10-02 lkp-tests]# ls
> allot        daemon  filters       include   Makefile  pkg        repo    spec
> bin          distro  Gemfile       jobs      monitors  plot       rootfs  stats
> cluster      doc     Gemfile.lock  lib       pack      Rakefile   sbin    tests
> _config.yml  etc     hosts         lkp-exec  params    README.md  setup   tools
> [root@hpe-dl385gen10-02 lkp-tests]#  bin/lkp install ../job.yaml
> Not a supported system, cannot install packages.
> [root@hpe-dl385gen10-02 lkp-tests]#
> 
> Well that's useful.

Sorry for the late reply, you may have figured it out already, you can
install and run LTP without the lkp framework and that should be pretty
straightforward, then you can just run it by:

'cd /opt/ltp && ./runltp -f cpuhotplug'

Looking at the test it may need a kernel source unpacked /usr/src/linux
as well.


Short HOWTO for building LTP from git is here:

https://github.com/linux-test-project/ltp/blob/master/doc/mini-howto-building-ltp-from-git.txt

And we do have (unofficional) packages for some SUSE distributions:

https://build.opensuse.org/package/show/benchmark/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

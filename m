From: Prarit Bhargava <prarit@redhat.com>
Date: Wed, 18 Oct 2017 09:19:11 -0400
Subject: [LTP] [lkp-robot] [x86/topology] 379a4bb988:
 dmesg.WARNING:at_arch/x86/events/intel/uncore.c:#uncore_change_type_ctx
In-Reply-To: <20171012064439.GN26196@yexl-desktop>
References: <20171012064439.GN26196@yexl-desktop>
Message-ID: <48cfd754-886d-38b0-b9e5-55088e5a9665@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 10/12/2017 02:44 AM, kernel test robot wrote:
>  bin/lkp install job.yaml

[root@hpe-dl385gen10-02 lkp-tests]# ls
allot        daemon  filters       include   Makefile  pkg        repo    spec
bin          distro  Gemfile       jobs      monitors  plot       rootfs  stats
cluster      doc     Gemfile.lock  lib       pack      Rakefile   sbin    tests
_config.yml  etc     hosts         lkp-exec  params    README.md  setup   tools
[root@hpe-dl385gen10-02 lkp-tests]#  bin/lkp install ../job.yaml
Not a supported system, cannot install packages.
[root@hpe-dl385gen10-02 lkp-tests]#

Well that's useful.

P.

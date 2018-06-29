From: umeshyv <umeshyv@gmail.com>
Date: Fri, 29 Jun 2018 11:19:38 +0530
Subject: [LTP] runltp fails with Buildroot
In-Reply-To: <CA+Kjy2xkPvL+MY=p9AVkmgaqY8LAJXXhYE1hgAF4jmZ4WfpgbQ@mail.gmail.com>
References: <CA+Kjy2zzPOUcUP7yYu-OcA4NrKhp+fNW9PNObfxiAuPWsUw0eg@mail.gmail.com>
 <20180625134200.GB24288@rei>
 <CA+Kjy2zehQeA8c1gfmj4jXDDdPwdTWkS41aH=B7guXnRDS8m4A@mail.gmail.com>
 <20180626160543.GA24350@rei.lan>
 <CA+Kjy2yAH7-VYoMsZ_XQOuhY3UK_HXzKxxwMdMedW+-wkirY5A@mail.gmail.com>
 <20180627083801.GB24350@rei.lan>
 <CA+Kjy2xkPvL+MY=p9AVkmgaqY8LAJXXhYE1hgAF4jmZ4WfpgbQ@mail.gmail.com>
Message-ID: <CA+Kjy2wM8V3ig_u96yTURz6na4kK65RT5dNzr--8z+LSf1JOsQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Any suggestions on my previous mail posted with runltp logs.

On Thu 28 Jun, 2018, 00:35 umeshyv, <umeshyv@gmail.com> wrote:

> Hi All,
> Please find below complete log of my previous screenshots,
>
> # ./runltp -a [  769.538489] smsc95xx 1-1.1:1.0 eth0: link up,
> 100Mbps, full-duplex, lpa 0x41E1
> [  769.551566] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> ^C
> # ./runltp -a umeshyv@gmail.com -p -o output.log -f sensor_test
> INFO: creating /usr/lib/ltp-testsuite/output directory
> INFO: creating /usr/lib/ltp-testsuite/results directory
> Checking for required user/group ids
>
> 'nobody' user id and group found.
> 'bin' user id and group found.
> 'daemon' user id and group found.
> Users group found.
> Sys group found.
> Required users/groups exist.
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> NAME=3DBuildroot
> VERSION=3D2018.02.1
> ID=3Dbuildroot
> VERSION_ID=3D2018.02.1
> PRETTY_NAME=3D"Buildroot 2018.02.1"
> Linux buildroot 4.14.39-v7 #7 SMP Mon Jun 4 12:10:05 IST 2018 armv7l
> GNU/Linux
>
> Gnu C
> util-linux             version'
> util-linux             call binary.
> util-linux
> util-linux             n] DEVICE
> util-linux
> util-linux             Format floppy disk
> util-linux
> util-linux             n        Don't verify after format
> mount                  /dev/root on / type ext4 (rw,relatime,data=3Dorder=
ed)
> mount                  devtmpfs on /dev type devtmpfs
> (rw,relatime,size=3D457936k,nr_inodes=3D114484,mode=3D755)
> mount                  proc on /proc type proc (rw,relatime)
> mount                  devpts on /dev/pts type devpts
> (rw,relatime,gid=3D5,mode=3D620,ptmxmode=3D666)
> mount                  tmpfs on /dev/shm type tmpfs (rw,relatime,mode=3D7=
77)
> mount                  tmpfs on /tmp type tmpfs (rw,relatime)
> mount                  tmpfs on /run type tmpfs
> (rw,nosuid,nodev,relatime,mode=3D755)
> mount                  sysfs on /sys type sysfs (rw,relatime)
> modutils               directory
> /bin/sh: is setuid
> Linux C Library        1.0.28
> Linux C Library        uClibc.so.1
> -v: No such file or directory
> Procps                 `--version'
> iproute2               binary.
> iputils                V
> Kbd                    73:
> Sh-utils               --v
> Modules Loaded         ipv6
>
> free reports:
>              total       used       free     shared    buffers     cached
> Mem:        925092      21064     904028         52        888       3256
> -/+ buffers/cache:      16920     908172
> Swap:            0          0          0
>
> /proc/cpuinfo
> processor       : 0
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 38.40
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4
> idiva idivt vfpd32 lpae evtstrm
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x0
> CPU part        : 0xc07
> CPU revision    : 5
>
> processor       : 1
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 38.40
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4
> idiva idivt vfpd32 lpae evtstrm
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x0
> CPU part        : 0xc07
> CPU revision    : 5
>
> processor       : 2
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 38.40
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4
> idiva idivt vfpd32 lpae evtstrm
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x0
> CPU part        : 0xc07
> CPU revision    : 5
>
> processor       : 3
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 38.40
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4
> idiva idivt vfpd32 lpae evtstrm
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x0
> CPU part        : 0xc07
> CPU revision    : 5
>
> Hardware        : BCM2835
> Revision        : a21041
> Serial          : 0000000093e3c1dd
> no big block device was specified on commandline.
> Tests which require a big block device are disabled.
> You can specify it with option -z
> COMMAND:    /usr/lib/ltp-testsuite/bin/ltp-pan   -e -S   -a 145     -n
> 145 -p -f /tmp/ltp-XXXX9KSUqp/alltests -l
> /usr/lib/ltp-testsuite/results/LTP_Rf
> LOG File:
> /usr/lib/ltp-testsuite/results/LTP_RUN_ON-1970_01_01-00h_14m_06s.log
> OUTPUT File: /usr/lib/ltp-testsuite/output/output.log
> FAILED COMMAND File:
> /usr/lib/ltp-testsuite/output/LTP_RUN_ON-output.log.failed
> TCONF COMMAND File:
> /usr/lib/ltp-testsuite/output/LTP_RUN_ON-output.log.tconf
> Running tests.......
> Segmentation fault
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20180118
> sh: !: unknown operand
> tar: removing leading '/' from member names
> Created TAR File: ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar
> successfully, added /usr/lib/ltp-testsuite/output
> tar: invalid option -- u
> BusyBox v1.27.2 (2018-05-03 22:47:13 IST) multi-call binary.
>
> Usage: tar -[cxthvO] [-X FILE] [-T FILE] [-f TARFILE] [-C DIR] [FILE]...
>
> Create, extract, or list files from a tar file
>
> Operation:
>         c       Create
>         x       Extract
>         t       List
>         f       Name of TARFILE ('-' for stdin/out)
>         C       Change to DIR before operation
>         v       Verbose
>         O       Extract to stdout
>         h       Follow symlinks
>         exclude File to exclude
>         X       File with names to exclude
>         T       File with names to include
> Cannot Update TAR File: ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar
> for adding /usr/lib/ltp-testsuite/results
> Gunzipped TAR File: ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar
> Starting mailing reports to: umeshyv@gmail.com, file:
> ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar.gz
> ./runltp: line 1043: mail: not found
> Reports cannot be mailed to: umeshyv@gmail.com
>
>        ###############################################################
>
>             Done executing testcases.
>             LTP Version:  20180118
>        ###############################################################
>
> #
>
> My LTP test output
>
> # ./sensor_test
> sample01    1  TPASS  :  I2C DRIVER OPEN TEST Passed
> ---------LTP READ TEST----------
> Contents of WHO AM I Register bd
> sample01    2  TPASS  :  I2C READ TEST Passed
> ----------LTP WRITE TEST--------
> sample01    3  TPASS  :  I2C WRITE TEST Passed
> --------SENSOR TEST OUTPUT------
> temp low 1
> temp high 1
> temp out 257
> Temperature(without calibration)
>  =3D 43.04=C2=B0C
> sample01    0  TINFO  :  I2C Tests Done!
>
>
> Thanks
> Umamahesh
>
>
>
>
> On Wed 27 Jun, 2018, 14:08 Cyril Hrubis, <chrubis@suse.cz> wrote:
> >
> > Hi!
> > > As suggested runtest was updated and output is attached for your
> reference
> > > and at the end of the test it says reports cannot be mailed.
> >
> > Can you please send text logs as a text next time?
> >
> > You are wasting a traffic and time for everyone with screenshots.
> >
> > > Is there any documentation how runtest is executed.
> > >
> > > Please suggest.
> >
> > The runtest file format is explained in the C test case tutorial:
> >
> >
> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#3-cre=
ate-the-test-skeleton
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180629/06f3b6b6/att=
achment-0001.html>

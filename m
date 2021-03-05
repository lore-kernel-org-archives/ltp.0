From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Fri, 5 Mar 2021 12:14:51 +0000
Subject: [LTP] kdump failing
Message-ID: <BMXPR01MB2870FFDC3E54FA0F9350C5D6EE969@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am trying to run kdump test but i am getting following error.Can you suggest what will be the reason for failure ??

root@test:/home/test/ltp/testcases/kdump# make
chmod a+x runkdump.sh lib/*.sh
./runkdump.sh
+ conf=./runkdump.conf
+ lib=lib
+ log=log
+ . ./runkdump.conf
+ ITERATION=1
+ CRASH=0
+ REBOOT=0
+ uname -r
+ VMLINUX=/usr/lib/debug/lib/modules/5.3.0-28-generic/vmlinux
+ COREDIR=/var/crash
+ FILTER=0
+ MAKE_OPTIONS=
+ LINK_DELAY=
+ CRASHER=ACS ACP ACB ACE ACL
+ BASIC_LKDTM=KPIDB KPIEB KPTEE KPBL
+ EXTRA_LKDTM=
KPIDE KPIDL KPIDP KPIDO
KPIEE KPIEL KPIEP KPIEO
KPTEB KPTEL KPTEP KPTEO
KPBB KPBE KPBP KPBO
KPMSB KPMSE KPMSL KPMSP KPMSO
KPTB KPTE KPTL KPTP KPTO
KPSB KPSE KPSL KPSP KPSO
KPIB KPIE KPIL KPIP KPIO

+ EXTRA_DUMP=KLEXT KLLBL KLUID KLRAW KNSCP KNNFS KDENB
+ EXT3_PART=
+ EXT3_LABEL=
+ EXT3_UID=
+ RAW_PART=
+ SCP_PATH=
+ SCP_PASS=
+ NFS_PATH=
+ [ -z 1 ]
+ [ -z 0 ]
+ [ -z /var/crash ]
+ cd lib
+ [ 1 -ge 1 ]
+ [ -z 0 ]
+ [ 0 -eq 0 ]
+ echo Setup test environment.
Setup test environment.
+ SetupCrontab
+ echo Setup crontab.
Setup crontab.
+ set +e
+ crontab -r
no crontab for root
+ set -e
+ pwd
+ date +%F-%T
+ cat
+ crontab kdump.cron
+ echo Enable cron daemon by default.
Enable cron daemon by default.
+ [ -f /etc/init.d/crond ]
+ cron=cron
+ [ -x /sbin/chkconfig ]
+ [ -x /sbin/update-rc.d ]
+ ./setup.sh .././runkdump.conf
+ conf=.././runkdump.conf
+ uname -m
+ arch=x86_64
+ uname -r
+ kver=5.3.0-28-generic
+ . .././runkdump.conf
+ ITERATION=1
+ CRASH=0
+ REBOOT=0
+ uname -r
+ VMLINUX=/usr/lib/debug/lib/modules/5.3.0-28-generic/vmlinux
+ COREDIR=/var/crash
+ FILTER=0
+ MAKE_OPTIONS=
+ LINK_DELAY=
+ CRASHER=ACS ACP ACB ACE ACL
+ BASIC_LKDTM=KPIDB KPIEB KPTEE KPBL
+ EXTRA_LKDTM=
KPIDE KPIDL KPIDP KPIDO
KPIEE KPIEL KPIEP KPIEO
KPTEB KPTEL KPTEP KPTEO
KPBB KPBE KPBP KPBO
KPMSB KPMSE KPMSL KPMSP KPMSO
KPTB KPTE KPTL KPTP KPTO
KPSB KPSE KPSL KPSP KPSO
KPIB KPIE KPIL KPIP KPIO

+ EXTRA_DUMP=KLEXT KLLBL KLUID KLRAW KNSCP KNNFS KDENB
+ EXT3_PART=
+ EXT3_LABEL=
+ EXT3_UID=
+ RAW_PART=
+ SCP_PATH=
+ SCP_PASS=
+ NFS_PATH=
+ echo Verify Kernel version >= 2.6.16.
Verify Kernel version >= 2.6.16.
+ kx=5
+ tmp=3.0-28-generic
+ ky=3
+ tmp=0-28-generic
+ tmp=0-28-generic
+ kz=0
+ [ 5 -lt 2 ]
+ [ 5 -eq 2 ]
+ [  ]
+ echo Verify user is root.
Verify user is root.
+ id -u
+ [ 0 != 0 ]
+ echo Verify prerequisite.
Verify prerequisite.
+ [ ! -x /sbin/kexec ]
+ [ ! -d /lib/modules/5.3.0-28-generic/build ]
+ [ 0 ]
+ [ 0 -eq 1 ]
+ [  ]
+ echo Compile Kernel modules.
Compile Kernel modules.
+ make clean
make[1]: Entering directory '/home/test/ltp/testcases/kdump/lib'
make -C crasher clean
make[2]: Entering directory '/home/test/ltp/testcases/kdump/lib/crasher'
make -C /lib/modules/5.3.0-28-generic/build M=/home/test/ltp/testcases/kdump/lib/crasher clean
make[3]: Entering directory '/usr/src/linux-headers-5.3.0-28-generic'
make[3]: Leaving directory '/usr/src/linux-headers-5.3.0-28-generic'
rm -f Module.symvers
make[2]: Leaving directory '/home/test/ltp/testcases/kdump/lib/crasher'
make -C lkdtm clean
make[2]: Entering directory '/home/test/ltp/testcases/kdump/lib/lkdtm'
make -C /lib/modules/5.3.0-28-generic/build M=/home/test/ltp/testcases/kdump/lib/lkdtm clean
make[3]: Entering directory '/usr/src/linux-headers-5.3.0-28-generic'
make[3]: Leaving directory '/usr/src/linux-headers-5.3.0-28-generic'
rm -f Module.symvers
make[2]: Leaving directory '/home/test/ltp/testcases/kdump/lib/lkdtm'
make[1]: Leaving directory '/home/test/ltp/testcases/kdump/lib'
+ make -C kprobes
+ make
make[1]: Entering directory '/home/test/ltp/testcases/kdump/lib'
make -C crasher
make[2]: Entering directory '/home/test/ltp/testcases/kdump/lib/crasher'
make -C /lib/modules/5.3.0-28-generic/build M=/home/test/ltp/testcases/kdump/lib/crasher modules
make[3]: Entering directory '/usr/src/linux-headers-5.3.0-28-generic'
  CC [M]  /home/test/ltp/testcases/kdump/lib/crasher/crasher.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/test/ltp/testcases/kdump/lib/crasher/crasher.mod.o
  LD [M]  /home/test/ltp/testcases/kdump/lib/crasher/crasher.ko
make[3]: Leaving directory '/usr/src/linux-headers-5.3.0-28-generic'
make[2]: Leaving directory '/home/test/ltp/testcases/kdump/lib/crasher'
make -C lkdtm
make[2]: Entering directory '/home/test/ltp/testcases/kdump/lib/lkdtm'
make -C /lib/modules/5.3.0-28-generic/build M=/home/test/ltp/testcases/kdump/lib/lkdtm modules
make[3]: Entering directory '/usr/src/linux-headers-5.3.0-28-generic'
  CC [M]  /home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.o
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?jp_do_irq?:
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:139:2: error: implicit declaration of function ?jprobe_return?; did you mean ?probe_irq_on?? [-Werror=implicit-function-declaration]
  jprobe_return();
  ^~~~~~~~~~~~~
  probe_irq_on
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?lkdtm_lookup_name?:
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:295:10: error: invalid use of undefined type ?struct jprobe?
   *(lkdtm.kp.addr) = addr;
          ^
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:296:8: error: invalid use of undefined type ?struct jprobe?
   lkdtm.entry = JPROBE_ENTRY(entry);
        ^
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:296:17: error: implicit declaration of function ?JPROBE_ENTRY?; did you mean ?KPROBE_REENTER?? [-Werror=implicit-function-declaration]
   lkdtm.entry = JPROBE_ENTRY(entry);
                 ^~~~~~~~~~~~
                 KPROBE_REENTER
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?lkdtm_module_init?:
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:468:13: error: implicit declaration of function ?register_jprobe?; did you mean ?register_kprobe?? [-Werror=implicit-function-declaration]
  if ((ret = register_jprobe(&lkdtm)) < 0) {
             ^~~~~~~~~~~~~~~
             register_kprobe
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?lkdtm_module_exit?:
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:480:2: error: implicit declaration of function ?unregister_jprobe?; did you mean ?unregister_kprobe?? [-Werror=implicit-function-declaration]
  unregister_jprobe(&lkdtm);
  ^~~~~~~~~~~~~~~~~
  unregister_kprobe
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: At top level:
/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:110:22: error: storage size of ?lkdtm? isn?t known
 static struct jprobe lkdtm;
                      ^~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:288: recipe for target '/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.o' failed
make[4]: *** [/home/test/ltp/testcases/kdump/lib/lkdtm/lkdtm.o] Error 1
Makefile:1655: recipe for target '_module_/home/test/ltp/testcases/kdump/lib/lkdtm' failed
make[3]: *** [_module_/home/test/ltp/testcases/kdump/lib/lkdtm] Error 2
make[3]: Leaving directory '/usr/src/linux-headers-5.3.0-28-generic'
Makefile:11: recipe for target 'default' failed
make[2]: *** [default] Error 2
make[2]: Leaving directory '/home/test/ltp/testcases/kdump/lib/lkdtm'
Makefile:2: recipe for target 'default' failed
make[1]: *** [default] Error 2
make[1]: Leaving directory '/home/test/ltp/testcases/kdump/lib'
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 2


Thanks

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210305/dd9be156/attachment.htm>

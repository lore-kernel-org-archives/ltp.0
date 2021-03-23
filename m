From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 23 Mar 2021 14:27:03 +0000
Subject: [LTP] kdump failure on x86
Message-ID: <BMXPR01MB2870D7110A3D2AD3DF1B495AEE649@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am trying to run kdump on x86 with 5.5.6 kernel but i am getting following errors, can someone please tell whats going wrong here. I have lkdtm config in the kernel and installed kexec-tools as well what could be the cause of issue ???


ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?jp_do_irq?:
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:139:2: error: implicit declaration of function ?jprobe_return?; did you mean ?probe_irq_on?? [-Werror=implicit-function-declaration]
  jprobe_return();
  ^~~~~~~~~~~~~
  probe_irq_on
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?lkdtm_lookup_name?:
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:295:10: error: invalid use of undefined type ?struct jprobe?
   *(lkdtm.kp.addr) = addr;
          ^
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:296:8: error: invalid use of undefined type ?struct jprobe?
   lkdtm.entry = JPROBE_ENTRY(entry);
        ^
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:296:17: error: implicit declaration of function ?JPROBE_ENTRY?; did you mean ?KPROBE_REENTER?? [-Werror=implicit-function-declaration]
   lkdtm.entry = JPROBE_ENTRY(entry);
                 ^~~~~~~~~~~~
                 KPROBE_REENTER
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?lkdtm_module_init?:
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:468:13: error: implicit declaration of function ?register_jprobe?; did you mean ?register_kprobe?? [-Werror=implicit-function-declaration]
  if ((ret = register_jprobe(&lkdtm)) < 0) {
             ^~~~~~~~~~~~~~~
             register_kprobe
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: In function ?lkdtm_module_exit?:
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:480:2: error: implicit declaration of function ?unregister_jprobe?; did you mean ?unregister_kprobe?? [-Werror=implicit-function-declaration]
  unregister_jprobe(&lkdtm);
  ^~~~~~~~~~~~~~~~~
  unregister_kprobe
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c: At top level:
/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.c:110:22: error: storage size of ?lkdtm? isn?t known
 static struct jprobe lkdtm;
                      ^~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:265: recipe for target '/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.o' failed
make[3]: *** [/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm/lkdtm.o] Error 1
Makefile:1693: recipe for target '/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm' failed
make[2]: *** [/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm] Error 2
make[2]: Leaving directory '/usr/ksrc/linux-5.5.6'
Makefile:11: recipe for target 'default' failed
make[1]: *** [default] Error 2
make[1]: Leaving directory '/home/pankaj-hmem/ltp-r2.4/ltp/testcases/kdump/lib/lkdtm'
Makefile:2: recipe for target 'default' failed
make: *** [default] Error 2



Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210323/27c3ad55/attachment-0001.htm>

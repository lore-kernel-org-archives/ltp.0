From: Mason <slash.tmp@free.fr>
Date: Tue, 5 Apr 2016 13:22:09 +0200
Subject: [LTP] ltp_tbio kernel module fails to build with recent kernel
Message-ID: <57039FE1.6080401@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

I noticed that the ltp_tbio.c kernel module fails to build for an ARM platform.
(I tried building for Linux 4.5)
Note: I was using buildroot, but I think the issue is not with buildroot.

make[6]: Entering directory '/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel'
Building modules: ltp_tbio.c
/usr/bin/make -C /linux-4.5 M=/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel
make[7]: Entering directory '/linux-4.5'
  LD      /ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/built-in.o
  CC [M]  /ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.o
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c: In function ‘send_request’:
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:103:20: error: ‘struct bio’ has no member named ‘bi_sector’
  rq->__sector = bio->bi_sector;
                    ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c: In function ‘tbio_io’:
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:150:9: error: implicit declaration of function ‘bio_map_user’ [-Werror=implicit-function-declaration]
   bio = bio_map_user(q, bdev, (unsigned long)inter.data,
         ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:150:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
   bio = bio_map_user(q, bdev, (unsigned long)inter.data,
       ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c: In function ‘test_bio_alloc’:
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:278:7: error: ‘struct bio’ has no member named ‘bi_sector’
  tbiop->bi_sector = 0;
       ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c: In function ‘test_bio_split’:
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:324:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
   bio = bio_map_user(q, bdev, (unsigned long)inter.data,
       ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:340:16: error: too few arguments to function ‘bio_split’
    bio_pairp = bio_split(bio, 2);
                ^
In file included from include/linux/blkdev.h:19:0,
                 from /ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:47:
include/linux/bio.h:408:20: note: declared here
 extern struct bio *bio_split(struct bio *bio, int sectors,
                    ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:351:29: error: dereferencing pointer to incomplete type ‘struct bio_pair’
  send_request(q, &(bio_pairp->bio1), bdev, &inter, writing);
                             ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:356:3: error: implicit declaration of function ‘bio_pair_release’ [-Werror=implicit-function-declaration]
   bio_pair_release(bio_pairp);
   ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c: In function ‘test_bio_get_nr_vecs’:
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:368:11: error: implicit declaration of function ‘bio_get_nr_vecs’ [-Werror=implicit-function-declaration]
  number = bio_get_nr_vecs(tbio_dev.bdev);
           ^
In file included from include/linux/blkdev.h:19:0,
                 from /ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:47:
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c: In function ‘tbio_transfer’:
include/linux/bio.h:237:9: error: incompatible types when assigning to type ‘struct bio_vec *’ from type ‘struct bio_vec’
   ((bvl = bio_iter_iovec((bio), (iter))), 1);  \
         ^
include/linux/bio.h:241:2: note: in expansion of macro ‘__bio_for_each_segment’
  __bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
  ^
include/linux/blkdev.h:752:3: note: in expansion of macro ‘bio_for_each_segment’
   bio_for_each_segment(bvl, _iter.bio, _iter.iter)
   ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:434:2: note: in expansion of macro ‘rq_for_each_segment’
  rq_for_each_segment(bv, req, iter) {
  ^
include/linux/bio.h:237:41: warning: left-hand operand of comma expression has no effect [-Wunused-value]
   ((bvl = bio_iter_iovec((bio), (iter))), 1);  \
                                         ^
include/linux/bio.h:241:2: note: in expansion of macro ‘__bio_for_each_segment’
  __bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
  ^
include/linux/blkdev.h:752:3: note: in expansion of macro ‘bio_for_each_segment’
   bio_for_each_segment(bvl, _iter.bio, _iter.iter)
   ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:434:2: note: in expansion of macro ‘rq_for_each_segment’
  rq_for_each_segment(bv, req, iter) {
  ^
include/linux/bio.h:238:45: error: request for member ‘bv_len’ in something not a structure or union
       bio_advance_iter((bio), &(iter), (bvl).bv_len))
                                             ^
include/linux/bio.h:241:2: note: in expansion of macro ‘__bio_for_each_segment’
  __bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
  ^
include/linux/blkdev.h:752:3: note: in expansion of macro ‘bio_for_each_segment’
   bio_for_each_segment(bvl, _iter.bio, _iter.iter)
   ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:434:2: note: in expansion of macro ‘rq_for_each_segment’
  rq_for_each_segment(bv, req, iter) {
  ^
In file included from include/linux/kernel.h:13:0,
                 from include/linux/list.h:8,
                 from include/linux/module.h:9,
                 from /ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:38:
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:439:12: error: ‘struct bio’ has no member named ‘bi_sector’
    iter.bio->bi_sector, offset);
            ^
include/linux/printk.h:259:34: note: in definition of macro ‘pr_info’
  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                  ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:436:3: note: in expansion of macro ‘prk_info’
   prk_info("%s bio(%u), segs(%u) sect(%u) pos(%lu) off(%u)",
   ^
In file included from include/linux/printk.h:6:0,
                 from include/linux/kernel.h:13,
                 from include/linux/list.h:8,
                 from include/linux/module.h:9,
                 from /ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:38:
include/linux/kern_levels.h:4:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 2 has type ‘sector_t {aka long long unsigned int}’ [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^
include/linux/kern_levels.h:13:19: note: in expansion of macro ‘KERN_SOH’
 #define KERN_INFO KERN_SOH "6" /* informational */
                   ^
include/linux/printk.h:259:9: note: in expansion of macro ‘KERN_INFO’
  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:60:2: note: in expansion of macro ‘pr_info’
  pr_info(TBIO_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
  ^
/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:442:4: note: in expansion of macro ‘prk_info’
    prk_info("Error, small capacity %zu, offset %u",
    ^
cc1: some warnings being treated as errors
scripts/Makefile.build:264: recipe for target '/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.o' failed
make[8]: *** [/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.o] Error 1
Makefile:1391: recipe for target '_module_/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel' failed
make[7]: *** [_module_/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel] Error 2
make[7]: Leaving directory '/linux-4.5'
../../../../../include/mk/module.mk:59: recipe for target '.dep_modules' failed
make[6]: [.dep_modules] Error 2 (ignored)
rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
make[6]: Leaving directory '/ltp-testsuite-20160126/testcases/kernel/device-drivers/tbio/tbio_kernel'


Regards.

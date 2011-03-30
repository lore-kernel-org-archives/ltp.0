Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <zliu@redhat.com>) id 1Q4tEd-0003Uw-AH
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 11:06:47 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q4tEb-00068d-JA
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 11:06:47 +0000
Date: Wed, 30 Mar 2011 07:06:38 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <132508409.670123.1301483198974.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1472927069.670110.1301483104408.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_670122_1427068736.1301483198973"
Subject: Re: [LTP] [PATCH 2/2] add nr_overcommit_hugepages vm tunable test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, yanegomi@gmail.com

------=_Part_670122_1427068736.1301483198973
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

sorry, forgot the attachment...

----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: ltp-list@lists.sourceforge.net, yanegomi@gmail.com
> Sent: Wednesday, March 30, 2011 7:05:04 PM
> Subject: [LTP][PATCH 2/2] add nr_overcommit_hugepages vm tunable test
> Hi, Garrett,
> Please review the new test case.
> 
> * The program is designed to test /proc/sys/vm/nr_overcommit_hugepages
> * tunable. /proc/sys/vm/nr_overcommit_hugepages specifies how large
> * the pool of huge pages can grow, if more huge pages than
> * /proc/sys/vm/nr_hugepages are requested by applications.
> * Writing any non-zero value into this file indicates that the hugetlb
> * subsystem is allowed to try to obtain that number of "surplus" huge
> * pages from the kernel's normal page pool, when the persistent huge
> * page pool is exhausted. As these surplus huge pages become unused,
> * they are freed back to the kernel's normal page pool. When
> applicatons
> * alloc more huge pages, it will overcommit the hugepage pool, we can
> * confirmed the correction by /proc/meminfo: HugePages_Surp.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
> .../kernel/mem/vmtunable/nr_overcommit_hugepages.c | 300
> ++++++++++++++++++++
> 1 files changed, 300 insertions(+), 0 deletions(-)
> create mode 100644
> testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
> 
> diff --git a/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
> b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
> new file mode 100644
> index 0000000..00d4983
> --- /dev/null
> +++ b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
> @@ -0,0 +1,300 @@
> +/*
> + * vm tunable test
> + *
> + *
> ********************************************************************
> + * Copyright (C) 2011 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like. Any license provided herein, whether
> + * implied or otherwise, applies only to this software file. Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + *
> + *
> ********************************************************************
> + *
> + * File Name: nr_overcommit_hugepage.c
> + * Author: Zhouping Liu <zliu@redhat.com>
> + * Description:
> + * The program is designed to test
> /proc/sys/vm/nr_overcommit_hugepages
> + * tunable. /proc/sys/vm/nr_overcommit_hugepages specifies how large
> + * the pool of huge pages can grow, if more huge pages than
> + * /proc/sys/vm/nr_hugepages are requested by applications.
> + * Writing any non-zero value into this file indicates that the
> hugetlb
> + * subsystem is allowed to try to obtain that number of "surplus"
> huge
> + * pages from the kernel's normal page pool, when the persistent huge
> + * page pool is exhausted. As these surplus huge pages become unused,
> + * they are freed back to the kernel's normal page pool. When
> applicatons
> + * alloc more huge pages, it will overcommit the hugepage pool, we
> can
> + * confirmed the correction by /proc/meminfo: HugePages_Surp.
> + *
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +
> +char *TCID = "nr_overcommit_hugepages";
> +int TST_TOTAL = 1;
> +
> +#define NUM 50UL /* the amount of hugepages try to mmap */
> +#define HUGEPAGES 30 /* set /proc/sys/vm/nr_hugepages */
> +#define OVER_HUGEPAGES 30 /* set /proc/sys/vm/nr_overcommit_hugepages
> */
> +#define BUFFER_SIZE 256
> +#define FILE_NAME "/mnt/hugepagefile"
> +#define PROTECTION (PROT_READ | PROT_WRITE) /* mmap mode */
> +
> +/* Only ia64 requires this */
> +#ifdef __ia64__
> +#define ADDR (void *)(0x8000000000000000UL)
> +#define FLAGS (MAP_SHARED | MAP_FIXED)
> +#else
> +#define ADDR (void *)(0x0UL)
> +#define FLAGS (MAP_SHARED)
> +#endif
> +
> +/* Check whether there're the two tunable or not */
> +int check_system();
> +
> +/* We're not sure one hugepag size is 2048kb or not, we can confirm
> + * it by catting /proc/meminfo: Hugepagesize
> + */
> +unsigned long get_one_hugepage_size();
> +
> +/* set hugepages */
> +int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages);
> +
> +/* get the total of hugepages and surplus hugepages */
> +int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages);
> +
> +/* try to alloc overcommit hugepage */
> +int test_overcommit_hugepages();
> +
> +/* do some clean after test */
> +void cleanup();
> +
> +int old_hugepages;
> +int old_overcommit; /* save the original data */
> +
> +int main(int argc, char *argv[])
> +{
> + int lc = 0; /* loop counter */
> + char *msg;
> +
> + /* if check_system() return zero, the system can't support the
> testing */
> + if (check_system() == 0) {
> + tst_resm(TFAIL, "Can't test nr_hugepages and \
> + nr_overcommit_hugepages,no such file");
> + tst_exit();
> + }
> +
> + if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
> + tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s", msg);
> + }
> + get_hugepages(&old_hugepages, &old_overcommit);
> + tst_resm(TINFO, "old nr_hugepages value is %d", old_hugepages);
> + tst_resm(TINFO, "old nr_overcommit hugepages is %d",
> old_overcommit);
> +
> + for (lc = 0; TEST_LOOPING(lc); lc++) {
> + set_hugepages(HUGEPAGES, OVER_HUGEPAGES);
> + if (test_overcommit_hugepages() == 0) {
> + set_hugepages(old_hugepages, old_overcommit);
> + tst_resm(TPASS, "succeeded to overcommit hugepages");
> + } else {
> + tst_resm(TFAIL, "FAIL mapping!");
> + }
> + cleanup();
> + }
> +
> + tst_exit();
> + return 0;
> +}
> +
> +/* try to overcommit hugepages */
> +int test_overcommit_hugepages()
> +{
> + char *addr;
> + int fd;
> + int hugepages = 0;
> + int overcommit = 0;
> + unsigned long i;
> + unsigned long length = 0;
> + unsigned long one_hugepage_size = 0;
> +
> + /* mount hugetlbfs */
> + if (system("mount -t hugetlbfs nodev /mnt") != 0) {
> + tst_brkm(TBROK, cleanup, "Can't mount hugetlbfs");
> + }
> +
> + fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
> + if (fd < 0) {
> + tst_brkm(TBROK, cleanup, "OPEN File %s error", FILE_NAME);
> + tst_exit();
> + }
> +
> + one_hugepage_size = get_one_hugepage_size();
> + length = NUM * one_hugepage_size;
> + addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
> + if (addr == MAP_FAILED) {
> + tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s", \
> + FILE_NAME, errno, strerror(errno));
> + munmap(addr, length);
> + close(fd);
> + unlink(FILE_NAME);
> + cleanup();
> + tst_exit();
> + }
> +
> + tst_resm(TINFO, "Returned address is %p", addr);
> + tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
> + for (i = 0; i < length; i++) {
> + *(addr + i) = (char)i;
> + }
> +
> + sleep(1);
> + /* get the hugepages and surplus hugepages after mmap successfully
> */
> + get_hugepages(&hugepages, &overcommit);
> +
> + munmap(addr, length);
> + close(fd);
> + unlink(FILE_NAME);
> + tst_resm(TINFO, "the current hugepages is %d and overcommit is %d ",
> hugepages, overcommit);
> +
> + /* if everything is okay, overcommit should equal (NUM - HUGEPAGES)
> */
> + if(hugepages == NUM && overcommit == (NUM - HUGEPAGES)) {
> + return 0;
> + } else {
> + return -1;
> + }
> +}
> +
> +unsigned long get_one_hugepage_size()
> +{
> + FILE *f;
> + int retcode = 0;
> + char buff[BUFFER_SIZE];
> + unsigned long one_hugepage_size = 0;
> +
> + f = fopen("/proc/meminfo", "r");
> + if (f == NULL) {
> + tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
> + }
> + while(fgets(buff,BUFFER_SIZE, f) != NULL) {
> + if((retcode = sscanf(buff, "Hugepagesize: %lu kB",
> + &one_hugepage_size)) == 1)
> + break;
> + }
> + tst_resm(TINFO, "one hugepagesize is %lu", one_hugepage_size);
> + fclose(f);
> +
> + if(one_hugepage_size == 0) {
> + tst_brkm(TFAIL, cleanup, "Can't read out hugepage size");
> + }
> +
> + return one_hugepage_size * 1024UL;
> +}
> +
> +/* get nr_hugepages and nr_overcommit_hugepages values */
> +int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages)
> +{
> + FILE *f;
> + int flag = 0;
> + int retcode = 0;
> + char buff[BUFFER_SIZE];
> +
> + f = fopen("/proc/meminfo", "r");
> + if (f == NULL) {
> + tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
> + }
> + while(fgets(buff,BUFFER_SIZE, f) != NULL && flag < 2) {
> + if((retcode = sscanf(buff, "HugePages_Total: %d ",
> + nr_hugepages)) == 1)
> + flag++;
> + if((retcode = sscanf(buff, "HugePages_Surp: %d ",
> + nr_overcommit_hugepages)) == 1)
> + flag++;
> + }
> +
> + if (flag != 2) {
> + fclose(f);
> + tst_brkm(TFAIL, cleanup, "Failed reading size of huge page.");
> + }
> + fclose(f);
> +
> + return 0;
> +}
> +
> +/* set nr_hugepages and nr_overcommit_hugepages values */
> +int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages)
> +{
> + FILE *f1, *f2;
> +
> + f1 = fopen("/proc/sys/vm/nr_hugepages", "w");
> + if (f1 == NULL) {
> + tst_brkm(TFAIL, tst_exit, "No permission, using root user");
> + }
> +
> + f2 = fopen("/proc/sys/vm/nr_overcommit_hugepages", "w");
> + if (f2 == NULL) {
> + tst_brkm(TFAIL, tst_exit, "No permission, using root user");
> + }
> +
> + /* write nr_hugepages to /proc/sys/vm/nr_hugepages and
> + * nr_overcommit_hugepages to /proc/sys/vm/nr_overcommit_hugepages
> + */
> + if (fprintf(f1, "%d", nr_hugepages) == 0) {
> + tst_brkm(TFAIL, cleanup, "write date error to nr_hugepages");
> + }
> + if (fprintf(f2, "%d", nr_overcommit_hugepages) ==0 ) {
> + tst_brkm(TFAIL, cleanup, "write date error to
> nr_overcommit_hugepages");
> + }
> + fclose(f1);
> + fclose(f2);
> +
> + return 0;
> +}
> +
> +int check_system()
> +{
> + int flag1 = -1;
> + int flag2 = -1;
> +
> + flag1 = access("/proc/sys/vm/nr_hugepages", F_OK);
> + flag2 = access("/proc/sys/vm/nr_overcommit_hugepages", F_OK);
> +
> + if (flag1 == 0 && flag2 == 0) {
> + return 1;
> + } else {
> + return 0;
> + }
> +}
> +
> +void cleanup()
> +{
> + set_hugepages(old_hugepages, old_overcommit);
> + tst_exit();
> +
> + return;
> +}
> +
> --
> 1.7.3.4

-- 
Name: Zhouping Liu
Team: Kernel-QE
Timezone: GMT+0800 (Asia/Shanghai)
IRC: zliu @ #kernel-qe, #eng-china
Cellphone: +86-187-0166-8285

------=_Part_670122_1427068736.1301483198973
Content-Type: text/x-patch;
	name=0002-add-nr_overcommit_hugepages-vm-tunable-test.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0002-add-nr_overcommit_hugepages-vm-tunable-test.patch

RnJvbSA1NDNmYzcwMWQzNzhmNDYzMGM5ZjljYWQxODIxYzA5NjRiMzE3ZTU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaG91cGluZyBMaXUgPHpsaXVAcmVkaGF0LmNvbT4KRGF0ZTog
V2VkLCAzMCBNYXIgMjAxMSAxNDoxNzowMCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBhZGQg
bnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMgdm0gdHVuYWJsZSB0ZXN0CgoKU2lnbmVkLW9mZi1ieTog
WmhvdXBpbmcgTGl1IDx6bGl1QHJlZGhhdC5jb20+Ci0tLQogLi4uL2tlcm5lbC9tZW0vdm10dW5h
YmxlL25yX292ZXJjb21taXRfaHVnZXBhZ2VzLmMgfCAgMzAwICsrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGVzIGNoYW5nZWQsIDMwMCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL3ZtdHVuYWJsZS9ucl9vdmVyY29t
bWl0X2h1Z2VwYWdlcy5jCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vdm10dW5h
YmxlL25yX292ZXJjb21taXRfaHVnZXBhZ2VzLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS92bXR1
bmFibGUvbnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwLi4wMGQ0OTgzCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vdm10dW5hYmxlL25yX292ZXJjb21taXRfaHVnZXBhZ2VzLmMKQEAgLTAsMCArMSwzMDAgQEAK
Ky8qCisgKiB2bSB0dW5hYmxlIHRlc3QKKyAqCisgKiAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICogQ29weXJpZ2h0
IChDKSAyMDExICBSZWQgSGF0LCBJbmMuCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICogTGlj
ZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisg
KiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3b3VsZCBi
ZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUg
aW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLgorICoKKyAqIEZ1cnRoZXIsIHRoaXMgc29mdHdhcmUgaXMgZGlz
dHJpYnV0ZWQgd2l0aG91dCBhbnkgd2FycmFudHkgdGhhdCBpdAorICogaXMgZnJlZSBvZiB0aGUg
cmlnaHRmdWwgY2xhaW0gb2YgYW55IHRoaXJkIHBlcnNvbiByZWdhcmRpbmcKKyAqIGluZnJpbmdl
bWVudCBvciB0aGUgbGlrZS4gIEFueSBsaWNlbnNlIHByb3ZpZGVkIGhlcmVpbiwgd2hldGhlcgor
ICogaW1wbGllZCBvciBvdGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNvZnR3YXJlIGZp
bGUuICBQYXRlbnQKKyAqIGxpY2Vuc2VzLCBpZiBhbnksIHByb3ZpZGVkIGhlcmVpbiBkbyBub3Qg
YXBwbHkgdG8gY29tYmluYXRpb25zIG9mCisgKiB0aGlzIHByb2dyYW0gd2l0aCBvdGhlciBzb2Z0
d2FyZSwgb3IgYW55IG90aGVyIHByb2R1Y3Qgd2hhdHNvZXZlci4KKyAqCisgKiBZb3Ugc2hvdWxk
IGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQor
ICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdh
cmUKKyAqIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3Is
IEJvc3RvbiwgTUEKKyAqIDAyMTEwLTEzMDEsIFVTQS4KKyAqCisgKiAqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICoK
KyAqIEZpbGUgTmFtZTogbnJfb3ZlcmNvbW1pdF9odWdlcGFnZS5jCisgKiBBdXRob3I6IFpob3Vw
aW5nIExpdSA8emxpdUByZWRoYXQuY29tPgorICogRGVzY3JpcHRpb246ICAKKyAqIFRoZSBwcm9n
cmFtIGlzIGRlc2lnbmVkIHRvIHRlc3QgL3Byb2Mvc3lzL3ZtL25yX292ZXJjb21taXRfaHVnZXBh
Z2VzCisgKiB0dW5hYmxlLiAvcHJvYy9zeXMvdm0vbnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMgc3Bl
Y2lmaWVzIGhvdyBsYXJnZSAKKyAqIHRoZSBwb29sIG9mIGh1Z2UgcGFnZXMgY2FuIGdyb3csIGlm
IG1vcmUgaHVnZSBwYWdlcyB0aGFuIAorICogL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyBhcmUg
cmVxdWVzdGVkIGJ5IGFwcGxpY2F0aW9ucy4gIAorICogV3JpdGluZyBhbnkgbm9uLXplcm8gdmFs
dWUgaW50byB0aGlzIGZpbGUgaW5kaWNhdGVzIHRoYXQgdGhlIGh1Z2V0bGIgCisgKiBzdWJzeXN0
ZW0gaXMgYWxsb3dlZCB0byB0cnkgdG8gb2J0YWluIHRoYXQgbnVtYmVyIG9mICJzdXJwbHVzIiBo
dWdlIAorICogcGFnZXMgZnJvbSB0aGUga2VybmVsJ3Mgbm9ybWFsIHBhZ2UgcG9vbCwgd2hlbiB0
aGUgcGVyc2lzdGVudCBodWdlIAorICogcGFnZSBwb29sIGlzIGV4aGF1c3RlZC4gQXMgdGhlc2Ug
c3VycGx1cyBodWdlIHBhZ2VzIGJlY29tZSB1bnVzZWQsIAorICogdGhleSBhcmUgZnJlZWQgYmFj
ayB0byB0aGUga2VybmVsJ3Mgbm9ybWFsIHBhZ2UgcG9vbC4gV2hlbiBhcHBsaWNhdG9ucworICog
YWxsb2MgbW9yZSBodWdlIHBhZ2VzLCB0aGF0IHdpbGwgb3ZlcmNvbW1pdCB0aGUgaHVnZXBhZ2Ug
cG9vbCwgIHdlIGNhbiAKKyAqIGNvbmZpcm1lZCB0aGUgY29ycmVjdGlvbiBieSAvcHJvYy9tZW1p
bmZvOiBIdWdlUGFnZXNfU3VycC4KKyAqIAorICovCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNs
dWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUgPHVuaXN0ZC5oPgor
I2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisjaW5jbHVkZSA8c3lzL3N0
YXQuaD4KKyNpbmNsdWRlIDxzeXMvbW1hbi5oPgorI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorCisj
aW5jbHVkZSAidGVzdC5oIgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKworY2hhciAqVENJRCA9ICJu
cl9vdmVyY29tbWl0X2h1Z2VwYWdlcyI7IAoraW50IFRTVF9UT1RBTCA9IDE7CisKKyNkZWZpbmUg
TlVNIDUwVUwgLyogdGhlIGFtb3VudCBvZiBodWdlcGFnZXMgdHJ5IHRvIG1tYXAgKi8KKyNkZWZp
bmUgSFVHRVBBR0VTIDMwIC8qIHNldCAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzICovCisjZGVm
aW5lIE9WRVJfSFVHRVBBR0VTIDMwIC8qIHNldCAvcHJvYy9zeXMvdm0vbnJfb3ZlcmNvbW1pdF9o
dWdlcGFnZXMgKi8KKyNkZWZpbmUgQlVGRkVSX1NJWkUgMjU2IAorI2RlZmluZSBGSUxFX05BTUUg
Ii9tbnQvaHVnZXBhZ2VmaWxlIgorI2RlZmluZSBQUk9URUNUSU9OIChQUk9UX1JFQUQgfCBQUk9U
X1dSSVRFKSAvKiBtbWFwIG1vZGUgKi8KKworLyogT25seSBpYTY0IHJlcXVpcmVzIHRoaXMgKi8K
KyNpZmRlZiBfX2lhNjRfXworI2RlZmluZSBBRERSICh2b2lkICopKDB4ODAwMDAwMDAwMDAwMDAw
MFVMKQorI2RlZmluZSBGTEFHUyAoTUFQX1NIQVJFRCB8IE1BUF9GSVhFRCkKKyNlbHNlCisjZGVm
aW5lIEFERFIgKHZvaWQgKikoMHgwVUwpCisjZGVmaW5lIEZMQUdTIChNQVBfU0hBUkVEKQorI2Vu
ZGlmCisKKy8qIENoZWNrIHdoZXRoZXIgdGhlcmUncmUgdGhlIHR3byB0dW5hYmxlIG9yIG5vdCAq
LworaW50IGNoZWNrX3N5c3RlbSgpOworCisvKiBXZSdyZSBub3Qgc3VyZSBvbmUgaHVnZXBhZyBz
aXplIGlzIDIwNDhrYiBvciBub3QsIHdlIGNhbiBjb25maXJtCisgKiBpdCBieSBjYXR0aW5nIC9w
cm9jL21lbWluZm86IEh1Z2VwYWdlc2l6ZQorICovCit1bnNpZ25lZCBsb25nIGdldF9vbmVfaHVn
ZXBhZ2Vfc2l6ZSgpOworCisvKiBzZXQgaHVnZXBhZ2VzICovCitpbnQgc2V0X2h1Z2VwYWdlcyhp
bnQgbnJfaHVnZXBhZ2VzLCBpbnQgbnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMpOworCisvKiBnZXQg
dGhlIHRvdGFsIG9mIGh1Z2VwYWdlcyBhbmQgc3VycGx1cyBodWdlcGFnZXMgKi8gCitpbnQgZ2V0
X2h1Z2VwYWdlcyhpbnQgKm5yX2h1Z2VwYWdlcywgaW50ICpucl9vdmVyY29tbWl0X2h1Z2VwYWdl
cyk7CisKKy8qIHRyeSB0byBhbGxvYyBvdmVyY29tbWl0IGh1Z2VwYWdlICovCitpbnQgdGVzdF9v
dmVyY29tbWl0X2h1Z2VwYWdlcygpOworCisvKiBkbyBzb21lIGNsZWFuIGFmdGVyIHRlc3QgKi8K
K3ZvaWQgY2xlYW51cCgpOworCitpbnQgb2xkX2h1Z2VwYWdlczsKK2ludCBvbGRfb3ZlcmNvbW1p
dDsgLyogc2F2ZSB0aGUgb3JpZ2luYWwgZGF0YSAqLworCitpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQoreworCWludCBsYyA9IDA7IC8qIGxvb3AgY291bnRlciAqLworCWNoYXIgKm1z
ZzsKKwkKKwkvKiBpZiBjaGVja19zeXN0ZW0oKSByZXR1cm4gemVybywgdGhlIHN5c3RlbSBjYW4n
dCBzdXBwb3J0IHRoZSB0ZXN0aW5nICovCisJaWYgKGNoZWNrX3N5c3RlbSgpID09IDApIHsKKwkJ
dHN0X3Jlc20oVEZBSUwsICJDYW4ndCB0ZXN0IG5yX2h1Z2VwYWdlcyBhbmQgXAorCQkJCW5yX292
ZXJjb21taXRfaHVnZXBhZ2VzLG5vIHN1Y2ggZmlsZSIpOworCQl0c3RfZXhpdCgpOworCX0KKwor
CWlmICgobXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKSkgIT0gTlVMTCkg
eworCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0lcyIs
IG1zZyk7CisJfQorCWdldF9odWdlcGFnZXMoJm9sZF9odWdlcGFnZXMsICZvbGRfb3ZlcmNvbW1p
dCk7CisJdHN0X3Jlc20oVElORk8sICJvbGQgbnJfaHVnZXBhZ2VzIHZhbHVlIGlzICVkIiwgb2xk
X2h1Z2VwYWdlcyk7CisJdHN0X3Jlc20oVElORk8sICJvbGQgbnJfb3ZlcmNvbW1pdCBodWdlcGFn
ZXMgaXMgJWQiLCBvbGRfb3ZlcmNvbW1pdCk7CisJCisJZm9yIChsYyA9IDA7IFRFU1RfTE9PUElO
RyhsYyk7IGxjKyspIHsKKwkJc2V0X2h1Z2VwYWdlcyhIVUdFUEFHRVMsIE9WRVJfSFVHRVBBR0VT
KTsKKwkJaWYgKHRlc3Rfb3ZlcmNvbW1pdF9odWdlcGFnZXMoKSA9PSAwKSB7CisJCQlzZXRfaHVn
ZXBhZ2VzKG9sZF9odWdlcGFnZXMsIG9sZF9vdmVyY29tbWl0KTsKKwkJCXRzdF9yZXNtKFRQQVNT
LCAic3VjY2VlZGVkIHRvIG92ZXJjb21taXQgaHVnZXBhZ2VzIik7CisJCX0gZWxzZSB7CisJCQl0
c3RfcmVzbShURkFJTCwgIkZBSUwgbWFwcGluZyEiKTsKKwkJfQorCQljbGVhbnVwKCk7CisJfQor
CisJdHN0X2V4aXQoKTsKKwlyZXR1cm4gMDsKK30KKworLyogdHJ5IHRvIG92ZXJjb21taXQgaHVn
ZXBhZ2VzICovCitpbnQgdGVzdF9vdmVyY29tbWl0X2h1Z2VwYWdlcygpCit7CisJY2hhciAqYWRk
cjsKKwlpbnQgZmQ7CisJaW50IGh1Z2VwYWdlcyA9IDA7CisJaW50IG92ZXJjb21taXQgPSAwOwor
CXVuc2lnbmVkIGxvbmcgaTsKKwl1bnNpZ25lZCBsb25nIGxlbmd0aCA9IDA7CisJdW5zaWduZWQg
bG9uZyBvbmVfaHVnZXBhZ2Vfc2l6ZSA9IDA7CisKKwkvKiBtb3VudCBodWdldGxiZnMgKi8KKwlp
ZiAoc3lzdGVtKCJtb3VudCAtdCBodWdldGxiZnMgbm9kZXYgL21udCIpICE9IDApIHsKKwkJdHN0
X2Jya20oVEJST0ssIGNsZWFudXAsICJDYW4ndCBtb3VudCBodWdldGxiZnMiKTsKKwl9CisKKwlm
ZCA9IG9wZW4oRklMRV9OQU1FLCBPX0NSRUFUIHwgT19SRFdSLCAwNzU1KTsKKwlpZiAoZmQgPCAw
KSB7CisJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiT1BFTiBGaWxlICVzIGVycm9yIiwgRklM
RV9OQU1FKTsKKwkJdHN0X2V4aXQoKTsKKwl9CisJCisJb25lX2h1Z2VwYWdlX3NpemUgPSBnZXRf
b25lX2h1Z2VwYWdlX3NpemUoKTsKKwlsZW5ndGggPSBOVU0gKiBvbmVfaHVnZXBhZ2Vfc2l6ZTsK
KwlhZGRyID0gKGNoYXIgKiltbWFwKEFERFIsIGxlbmd0aCwgUFJPVEVDVElPTiwgRkxBR1MsIGZk
LCAwKTsKKwlpZiAoYWRkciA9PSBNQVBfRkFJTEVEKSB7CisJCXRzdF9yZXNtKFRGQUlMLCAibW1h
cCgpIEZhaWxlZCBvbiAlcywgZXJybm89JWQgOiAlcyIsIFwKKwkJCQlGSUxFX05BTUUsIGVycm5v
LCBzdHJlcnJvcihlcnJubykpOworCQltdW5tYXAoYWRkciwgbGVuZ3RoKTsKKwkJY2xvc2UoZmQp
OworCQl1bmxpbmsoRklMRV9OQU1FKTsKKwkJY2xlYW51cCgpOworCQl0c3RfZXhpdCgpOworCX0K
KworCXRzdF9yZXNtKFRJTkZPLCAiUmV0dXJuZWQgYWRkcmVzcyBpcyAlcCIsIGFkZHIpOworCXRz
dF9yZXNtKFRJTkZPLCAiRmlyc3QgaGV4IGlzICV4IiwgKigodW5zaWduZWQgaW50ICopYWRkcikp
OworCWZvciAoaSA9IDA7IGkgPCBsZW5ndGg7IGkrKykgeworCQkqKGFkZHIgKyBpKSA9IChjaGFy
KWk7CisJfQorCisJc2xlZXAoMSk7CisJLyogZ2V0IHRoZSBodWdlcGFnZXMgYW5kIHN1cnBsdXMg
aHVnZXBhZ2VzIGFmdGVyIG1tYXAgc3VjY2Vzc2Z1bGx5ICovCisJZ2V0X2h1Z2VwYWdlcygmaHVn
ZXBhZ2VzLCAmb3ZlcmNvbW1pdCk7CisJCisJbXVubWFwKGFkZHIsIGxlbmd0aCk7CisJY2xvc2Uo
ZmQpOworCXVubGluayhGSUxFX05BTUUpOworCXRzdF9yZXNtKFRJTkZPLCAidGhlIGN1cnJlbnQg
aHVnZXBhZ2VzIGlzICVkIGFuZCBvdmVyY29tbWl0IGlzICVkICIsIGh1Z2VwYWdlcywgb3ZlcmNv
bW1pdCk7CisJCisJLyogaWYgZXZlcnl0aGluZyBpcyBva2F5LCBvdmVyY29tbWl0IHNob3VsZCBl
cXVhbCAoTlVNIC0gSFVHRVBBR0VTKSAqLworCWlmKGh1Z2VwYWdlcyA9PSBOVU0gJiYgb3ZlcmNv
bW1pdCA9PSAoTlVNIC0gSFVHRVBBR0VTKSkgeworCQlyZXR1cm4gMDsKKwl9IGVsc2UgeworCQly
ZXR1cm4gLTE7CisJfQorfQorCit1bnNpZ25lZCBsb25nIGdldF9vbmVfaHVnZXBhZ2Vfc2l6ZSgp
Cit7CisJRklMRSAqZjsKKwlpbnQgcmV0Y29kZSA9IDA7CisJY2hhciBidWZmW0JVRkZFUl9TSVpF
XTsKKwl1bnNpZ25lZCBsb25nIG9uZV9odWdlcGFnZV9zaXplID0gMDsKKworCWYgPSBmb3Blbigi
L3Byb2MvbWVtaW5mbyIsICJyIik7CisJaWYgKGYgPT0gTlVMTCkgeworCQl0c3RfYnJrbShURkFJ
TCwgY2xlYW51cCwgIlBsZWFzZSBydW4gdGhlIHRlc3QgdXNpbmcgcm9vdCB1c2VyLiIpOworCX0K
Kwl3aGlsZShmZ2V0cyhidWZmLEJVRkZFUl9TSVpFLCBmKSAhPSBOVUxMKSB7CisJCWlmKChyZXRj
b2RlID0gc3NjYW5mKGJ1ZmYsICJIdWdlcGFnZXNpemU6ICVsdSBrQiIsCisJCQkmb25lX2h1Z2Vw
YWdlX3NpemUpKSA9PSAxKQorCQkJYnJlYWs7CisJfQorCXRzdF9yZXNtKFRJTkZPLCAib25lIGh1
Z2VwYWdlc2l6ZSBpcyAlbHUiLCBvbmVfaHVnZXBhZ2Vfc2l6ZSk7CisJZmNsb3NlKGYpOworCQor
CWlmKG9uZV9odWdlcGFnZV9zaXplID09IDApIHsKKwkJdHN0X2Jya20oVEZBSUwsIGNsZWFudXAs
ICJDYW4ndCByZWFkIG91dCBodWdlcGFnZSBzaXplIik7CisJfQorCisJcmV0dXJuIG9uZV9odWdl
cGFnZV9zaXplICogMTAyNFVMOworfQorCisvKiBnZXQgbnJfaHVnZXBhZ2VzIGFuZCBucl9vdmVy
Y29tbWl0X2h1Z2VwYWdlcyB2YWx1ZXMgKi8KK2ludCBnZXRfaHVnZXBhZ2VzKGludCAqbnJfaHVn
ZXBhZ2VzLCBpbnQgKm5yX292ZXJjb21taXRfaHVnZXBhZ2VzKSAKK3sKKwlGSUxFICpmOworCWlu
dCBmbGFnID0gMDsKKwlpbnQgcmV0Y29kZSA9IDA7CisJY2hhciBidWZmW0JVRkZFUl9TSVpFXTsK
KworCWYgPSBmb3BlbigiL3Byb2MvbWVtaW5mbyIsICJyIik7CisJaWYgKGYgPT0gTlVMTCkgewor
CQl0c3RfYnJrbShURkFJTCwgY2xlYW51cCwgIlBsZWFzZSBydW4gdGhlIHRlc3QgdXNpbmcgcm9v
dCB1c2VyLiIpOworCX0KKwl3aGlsZShmZ2V0cyhidWZmLEJVRkZFUl9TSVpFLCBmKSAhPSBOVUxM
ICYmIGZsYWcgPCAyKSB7CisJCWlmKChyZXRjb2RlID0gc3NjYW5mKGJ1ZmYsICJIdWdlUGFnZXNf
VG90YWw6ICVkICIsCisJCQlucl9odWdlcGFnZXMpKSA9PSAxKQorCQkJZmxhZysrOworCQlpZigo
cmV0Y29kZSA9IHNzY2FuZihidWZmLCAiSHVnZVBhZ2VzX1N1cnA6ICVkICIsIAorCQkJbnJfb3Zl
cmNvbW1pdF9odWdlcGFnZXMpKSA9PSAxKSAKKwkJCWZsYWcrKzsKKwl9CisKKwlpZiAoZmxhZyAh
PSAyKSB7CisJCWZjbG9zZShmKTsgCisJCXRzdF9icmttKFRGQUlMLCBjbGVhbnVwLCAiRmFpbGVk
IHJlYWRpbmcgc2l6ZSBvZiBodWdlIHBhZ2UuIik7CisJfQorCWZjbG9zZShmKTsKKworCXJldHVy
biAwOworfQorCisvKiBzZXQgbnJfaHVnZXBhZ2VzIGFuZCBucl9vdmVyY29tbWl0X2h1Z2VwYWdl
cyB2YWx1ZXMgKi8KK2ludCBzZXRfaHVnZXBhZ2VzKGludCBucl9odWdlcGFnZXMsIGludCBucl9v
dmVyY29tbWl0X2h1Z2VwYWdlcykKK3sKKwlGSUxFICpmMSwgKmYyOworCisJZjEgPSBmb3Blbigi
L3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyIsICJ3Iik7CisJaWYgKGYxID09IE5VTEwpIHsKKwkJ
dHN0X2Jya20oVEZBSUwsIHRzdF9leGl0LCAiTm8gcGVybWlzc2lvbiwgdXNpbmcgcm9vdCB1c2Vy
Iik7CisJfQorCisJZjIgPSBmb3BlbigiL3Byb2Mvc3lzL3ZtL25yX292ZXJjb21taXRfaHVnZXBh
Z2VzIiwgInciKTsKKwlpZiAoZjIgPT0gTlVMTCkgeworCQl0c3RfYnJrbShURkFJTCwgdHN0X2V4
aXQsICJObyBwZXJtaXNzaW9uLCB1c2luZyByb290IHVzZXIiKTsKKwl9CisKKwkvKiB3cml0ZSBu
cl9odWdlcGFnZXMgdG8gL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyBhbmQgCisJICogbnJfb3Zl
cmNvbW1pdF9odWdlcGFnZXMgdG8gL3Byb2Mvc3lzL3ZtL25yX292ZXJjb21taXRfaHVnZXBhZ2Vz
CisJICovCisJaWYgKGZwcmludGYoZjEsICIlZCIsIG5yX2h1Z2VwYWdlcykgPT0gMCkgeworCQl0
c3RfYnJrbShURkFJTCwgY2xlYW51cCwgIndyaXRlIGRhdGUgZXJyb3IgdG8gbnJfaHVnZXBhZ2Vz
Iik7CisJfQorCWlmIChmcHJpbnRmKGYyLCAiJWQiLCBucl9vdmVyY29tbWl0X2h1Z2VwYWdlcykg
PT0wICkgeworCQl0c3RfYnJrbShURkFJTCwgY2xlYW51cCwgIndyaXRlIGRhdGUgZXJyb3IgdG8g
bnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMiKTsKKwl9CisJZmNsb3NlKGYxKTsKKwlmY2xvc2UoZjIp
OworCQorCXJldHVybiAwOworfQorCitpbnQgY2hlY2tfc3lzdGVtKCkKK3sKKwlpbnQgZmxhZzEg
PSAtMTsKKwlpbnQgZmxhZzIgPSAtMTsKKworCWZsYWcxID0gYWNjZXNzKCIvcHJvYy9zeXMvdm0v
bnJfaHVnZXBhZ2VzIiwgRl9PSyk7CisJZmxhZzIgPSBhY2Nlc3MoIi9wcm9jL3N5cy92bS9ucl9v
dmVyY29tbWl0X2h1Z2VwYWdlcyIsIEZfT0spOworCisJaWYgKGZsYWcxID09IDAgJiYgZmxhZzIg
PT0gMCkgeworCQlyZXR1cm4gMTsKKwl9IGVsc2UgeworCQlyZXR1cm4gMDsKKwl9Cit9CisKK3Zv
aWQgY2xlYW51cCgpCit7CisJc2V0X2h1Z2VwYWdlcyhvbGRfaHVnZXBhZ2VzLCBvbGRfb3ZlcmNv
bW1pdCk7CisJdHN0X2V4aXQoKTsKKworCXJldHVybjsKK30KKwotLSAKMS43LjMuNAoK
------=_Part_670122_1427068736.1301483198973
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
------=_Part_670122_1427068736.1301483198973
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_670122_1427068736.1301483198973--


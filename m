Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWnfI-0001pe-H7
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 08:40:36 +0000
Received: from rv-out-0708.google.com ([209.85.198.241])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWnf7-0007oy-7G
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 08:40:31 +0000
Received: by rv-out-0708.google.com with SMTP id b17so513858rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2009 01:40:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907310138v2708c6dfmb378df4004669c4f@mail.gmail.com>
References: <364299f40907310138v2708c6dfmb378df4004669c4f@mail.gmail.com>
Date: Fri, 31 Jul 2009 01:40:19 -0700
Message-ID: <364299f40907310140k2031e88ve39a175d9ca45e8f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix C coding issues and integrate ima into LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

On Fri, Jul 31, 2009 at 1:38 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> 1. None of the ima C files which required openssl/sha.h were using the
> HAVE_OPENSSL_SHA_H macro define.
> 2. Add tst_resm support.
> 3. Fix some missing includes in ima_mmap.c.
> 4. Remove an unused var.
> 5. Shuffle around some fields in ima_boot_aggregate.c so that it
> compiles with -Wunused and consumes less memory when 1. applies.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/src/im=
a_boot_aggregate.c,v
> retrieving revision 1.1
> diff -u -r1.1 ima_boot_aggregate.c
> --- testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c =A0 =
=A031
> Mar 2009 13:58:14 -0000 1.1
> +++ testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c =A0 =
=A031
> Jul 2009 08:37:08 -0000
> @@ -23,14 +23,21 @@
> =A0#include <fcntl.h>
> =A0#include <string.h>
> =A0#include <unistd.h>
> +#include "config.h"
> +#include "test.h"
> +#if HAVE_OPENSSL_SHA_H
> =A0#include <openssl/sha.h>
> +#endif
>
> =A0#define MAX_EVENT_SIZE 500
> =A0#define EVENT_HEADER_SIZE 32
> =A0#define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
> =A0#define NUM_PCRS 8 =A0 =A0 /* =A0PCR registers 0-7 in boot aggregate */
>
> -static void *display_sha1_digest(char *pcr)
> +char *TCID =3D "ima_boot_aggregate";
> +int TST_TOTAL =3D 1;
> +
> +static void display_sha1_digest(unsigned char *pcr)
> =A0{
> =A0 =A0 =A0 =A0int i;
>
> @@ -39,8 +46,10 @@
> =A0 =A0 =A0 =A0printf("\n");
> =A0}
>
> -int main(int argc, char *argv[])
> +int
> +main(int argc, char *argv[])
> =A0{
> +#if HAVE_OPENSSL_SHA_H
> =A0 =A0 =A0 =A0unsigned char boot_aggregate[SHA_DIGEST_LENGTH];
> =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct {
> @@ -74,7 +83,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&pcr[i].digest, 0, SHA_DIGEST_LENGT=
H);
>
> =A0 =A0 =A0 =A0/* Extend the pseudo PCRs with the event digest */
> - =A0 =A0 =A0 while (fread(&event, sizeof event.header, 1, fp)) {
> + =A0 =A0 =A0 while (fread(&event, sizeof(event.header), 1, fp)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (debug) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("%03u ", event.head=
er.pcr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0display_sha1_digest(event.=
header.digest);
> @@ -105,6 +114,8 @@
>
> =A0 =A0 =A0 =A0printf("boot_aggregate:");
> =A0 =A0 =A0 =A0display_sha1_digest(boot_aggregate);
> -
> - =A0 =A0 =A0 return 0;
> +#else
> + =A0 =A0 =A0 tst_resm(TCONF, "System doesn't have openssl/sha.h");
> +#endif
> + =A0 =A0 =A0 tst_exit();
> =A0}
> Index: testcases/kernel/security/integrity/ima/src/ima_measure.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/src/im=
a_measure.c,v
> retrieving revision 1.1
> diff -u -r1.1 ima_measure.c
> --- testcases/kernel/security/integrity/ima/src/ima_measure.c =A0 31 Mar
> 2009 13:58:14 -0000 =A0 =A0 1.1
> +++ testcases/kernel/security/integrity/ima/src/ima_measure.c =A0 31 Jul
> 2009 08:37:08 -0000
> @@ -22,18 +22,23 @@
> =A0#include <fcntl.h>
> =A0#include <string.h>
> =A0#include <unistd.h>
> +//#include "config.h"
> +#include "test.h"
> +#if HAVE_OPENSSL_SHA_H
> =A0#include <openssl/sha.h>
> +#endif
>
> =A0#define TCG_EVENT_NAME_LEN_MAX 255
>
> -static int verbose =3D 0;
> -static int validate =3D 0;
> -static int verify =3D 0;
> +char *TCID =3D "ima_measure";
> +int TST_TOTAL =3D 1;
>
> =A0#define print_info(format, arg...) \
> =A0 =A0 =A0 =A0if (verbose) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(format, ##arg)
>
> +#if HAVE_OPENSSL_SHA_H
> +
> =A0static u_int8_t zero[SHA_DIGEST_LENGTH];
> =A0static u_int8_t fox[SHA_DIGEST_LENGTH];
>
> @@ -90,6 +95,8 @@
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#endif
> +
> =A0/*
> =A0* ima_measurements.c - calculate the SHA1 aggregate-pcr value based
> =A0* on the IMA runtime binary measurements.
> @@ -120,13 +127,19 @@
> =A0* Return code: if verification enabled, returns number of verification
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 errors.
> =A0*/
> -int main(int argc, char *argv[])
> +int
> +main(int argc, char *argv[])
> =A0{
> +
> +#if HAVE_OPENSSL_SHA_H
> =A0 =A0 =A0 =A0FILE *fp;
> =A0 =A0 =A0 =A0struct event template;
> =A0 =A0 =A0 =A0u_int8_t pcr[SHA_DIGEST_LENGTH];
> =A0 =A0 =A0 =A0int i, count =3D 0, len;
> - =A0 =A0 =A0 int failed_count =3D 0; =A0 /* number of template verificat=
ions failed */
> +
> + =A0 =A0 =A0 int verbose =3D 0;
> + =A0 =A0 =A0 int validate =3D 0;
> + =A0 =A0 =A0 int verify =3D 0;
>
> =A0 =A0 =A0 =A0if (argc < 2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("format: %s binary_runtime_measurem=
ents" \
> @@ -191,12 +204,17 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_info(" %s\n", template.ima_data.file=
name);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (verify)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 failed_count +=3D verify_te=
mplate_hash(&template);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (verify_template_hash(&t=
emplate) !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TF=
AIL, "Hash failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0fclose(fp);
>
> =A0 =A0 =A0 =A0verbose=3D1;
> =A0 =A0 =A0 =A0print_info("PCRAggr (re-calculated):");
> =A0 =A0 =A0 =A0display_sha1_digest(pcr);
> - =A0 =A0 =A0 return failed_count;
> +#else
> + =A0 =A0 =A0 tst_resm(TCONF, "System doesn't have openssl/sha.h");
> +#endif
> + =A0 =A0 =A0 tst_exit();
> =A0}
> Index: testcases/kernel/security/integrity/ima/src/ima_mmap.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/src/im=
a_mmap.c,v
> retrieving revision 1.2
> diff -u -r1.2 ima_mmap.c
> --- testcases/kernel/security/integrity/ima/src/ima_mmap.c =A0 =A0 =A019 =
May 2009
> 09:57:42 -0000 =A01.2
> +++ testcases/kernel/security/integrity/ima/src/ima_mmap.c =A0 =A0 =A031 =
Jul 2009
> 08:37:08 -0000
> @@ -16,16 +16,20 @@
> =A0*/
> =A0#include <stdio.h>
> =A0#include <string.h>
> +#include <unistd.h>
> =A0#include <sys/stat.h>
> =A0#include <sys/mman.h>
> =A0#include <fcntl.h>
> +#include "test.h"
> +
> +char *TCID =3D "ima_mmap";
> +int TST_TOTAL =3D 1;
>
> =A0int main(int argc, char *argv[])
> =A0{
> =A0 =A0 =A0 =A0int fd;
> =A0 =A0 =A0 =A0void *file;
> =A0 =A0 =A0 =A0char *filename;
> - =A0 =A0 =A0 int rc;
>
> =A0 =A0 =A0 =A0if (argc !=3D 2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("%s: filename\n", argv[1]);
> @@ -48,6 +52,5 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("unmap");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return(-1);
> =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 tst_exit();
> =A0}

This also requires that -lltp be added to the src/Makefile Makefile,
so I'm not sure whether or not this has any value beyond just being a
review tool.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

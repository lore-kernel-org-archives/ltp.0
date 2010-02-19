Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NiWtk-00007u-9q
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 17:44:16 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NiWtj-0004IT-4J
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 17:44:16 +0000
Received: by pxi40 with SMTP id 40so160063pxi.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Feb 2010 09:44:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100219112904.27416.55542.sendpatchset@subratamodak.linux.ibm.com>
References: <20100219112904.27416.55542.sendpatchset@subratamodak.linux.ibm.com>
Date: Fri, 19 Feb 2010 09:44:08 -0800
Message-ID: <364299f41002190944x7f001194h3e980e41db03a29b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix LTP Scritps as per the new build/install
	system in place
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Fri, Feb 19, 2010 at 3:29 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Hi,
>
> Scripts under LTPROOT/testscripts/ need to access ltp-pan from some
> other loaction now. Moreover there are scripts to run MATH and SYSCALL
> tests which are not required as they can be directly run through
> ./runltp -f <math/runltp>
> This patch fixes them. Probably the scripts need to be looked on
> more to fix such anomalies.
>
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> ---
>
> diff -uprN ltp-full-20100131/testscripts.orig/diskio.sh ltp-full-20100131=
/testscripts/diskio.sh
> --- ltp-full-20100131/testscripts.orig/diskio.sh =A0 =A0 =A0 =A02010-02-1=
9 16:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/diskio.sh =A0 =A0 2010-02-19 16:20:27.0=
00000000 +0530
> @@ -27,7 +27,7 @@ export PATH=3D"${PATH}:${LTPROOT}/testcase
>
> =A0${LTPROOT}/ver_linux
>
> -${LTPROOT}/pan/ltp-pan -e -l /tmp/diskiopan.log -S -a ltpdiskio -n ltpdi=
skio -f ${LTPROOT}/runtest/io_floppy -f ${LTPROOT}/runtest/io_cd
> +${LTPROOT}/bin/ltp-pan -e -l /tmp/diskiopan.log -S -a ltpdiskio -n ltpdi=
skio -f ${LTPROOT}/runtest/io_floppy -f ${LTPROOT}/runtest/io_cd
>
> =A0if [ $? -eq "0" ]; then
> =A0 echo ltp-pan reported PASS
> diff -uprN ltp-full-20100131/testscripts.orig/ltp-aiodio.sh ltp-full-2010=
0131/testscripts/ltp-aiodio.sh
> --- ltp-full-20100131/testscripts.orig/ltp-aiodio.sh =A0 =A02010-02-19 16=
:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/ltp-aiodio.sh 2010-02-19 16:25:53.00000=
0000 +0530
> @@ -227,9 +227,9 @@ dd if=3D$file1 of=3D/test/aiodio/junkfile bs
> =A0date
> =A0echo "************ Running aio-stress tests "
> =A0echo "current working dir =3D ${PWD}"
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part1 > $=
{TMPBASE}/ltp-aio-stress.part1
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part1 >=
 ${TMPBASE}/ltp-aio-stress.part1
>
> -${LTPROOT}/pan/ltp-pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 =
-l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-st=
ress.part1 &
> +${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 =
-l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-st=
ress.part1 &
>
> =A0wait $!
>
> @@ -239,9 +239,9 @@ echo ""
>
> =A0if [ "$runExtendedStress" -eq 1 ];then
> =A0echo "************ Running EXTENDED aio-stress tests "
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part2 > $=
{TMPBASE}/ltp-aio-stress.part2
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part2 >=
 ${TMPBASE}/ltp-aio-stress.part2
>
> -${LTPROOT}/pan/ltp-pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 =
-l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-st=
ress.part2 &
> +${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 =
-l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-st=
ress.part2 &
>
> =A0wait $!
> =A0sync
> @@ -254,9 +254,9 @@ dd if=3D$file1 of=3D/test/aiodio/ff2 =A0 =A0 =A0bs
> =A0dd if=3D$file1 of=3D/test/aiodio/ff3 =A0 =A0 =A0bs=3D512 =A0conv=3Dblo=
ck,sync
>
> =A0echo "************ Running aiocp tests "
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part1 > ${TMP=
BASE}/ltp-aiodio.part1
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part1 > ${T=
MPBASE}/ltp-aiodio.part1
>
> -${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltp=
aiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
> +${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltp=
aiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
>
> =A0wait $!
> =A0sync
> @@ -264,9 +264,9 @@ echo "************ End Running aiocp tes
> =A0echo ""
>
> =A0echo "************ Running aiodio_sparse tests "
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part2 > ${TMP=
BASE}/ltp-aiodio.part2
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part2 > ${T=
MPBASE}/ltp-aiodio.part2
>
> -${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltp=
aiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
> +${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltp=
aiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
>
> =A0wait $!
> =A0sync
> @@ -276,9 +276,9 @@ echo ""
>
> =A0if [ "$runExtendedStress" -eq 1 ];then
> =A0echo "************ Running fsx-linux tests "
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part3 > ${TMP=
BASE}/ltp-aiodio.part3
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part3 > ${T=
MPBASE}/ltp-aiodio.part3
>
> -${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltp=
aiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
> +${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltp=
aiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
>
>
>
> @@ -295,8 +295,8 @@ dd if=3D$file1 of=3D/test/aiodio/file5
>
>
> =A0echo "************ Running dio_sparse & miscellaneous tests "
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part4 > ${TMP=
BASE}/ltp-aiodio.part4
> -${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltp=
aiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part4 > ${T=
MPBASE}/ltp-aiodio.part4
> +${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltp=
aiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
>
> =A0wait $!
> =A0sync
> diff -uprN ltp-full-20100131/testscripts.orig/ltpfslvm.sh ltp-full-201001=
31/testscripts/ltpfslvm.sh
> --- ltp-full-20100131/testscripts.orig/ltpfslvm.sh =A0 =A0 =A02010-02-19 =
16:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/ltpfslvm.sh =A0 2010-02-19 16:26:27.000=
000000 +0530
> @@ -156,9 +156,9 @@ mount -v /dev/ltp_test_vg2/ltp_test_lv4
> =A0mount -v /dev/ram =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /test/gr=
owfiles/ramdisk
>
> =A0echo "************ Running tests "
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/lvm.part1 > ${TMPBASE}/l=
vm.part1
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/lvm.part1 > ${TMPBASE}=
/lvm.part1
>
> -${LTPROOT}/pan/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${=
TMPBASE}/lvm.part1 &
> +${LTPROOT}/bin/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${=
TMPBASE}/lvm.part1 &
>
> =A0wait $!
>
> @@ -188,9 +188,9 @@ mount -v -t ext3 =A0 /dev/$part4 =A0 =A0 =A0 =A0 /
> =A0mount -v -t jfs =A0 =A0/dev/hdc1 =A0 =A0 =A0 =A0 =A0 /test/growfiles/j=
fs
>
> =A0echo "************ Running EXT3 & JFS tests... =A0"
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/lvm.part2 > ${TMPBASE}/l=
vm.part2
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/lvm.part2 > ${TMPBASE}=
/lvm.part2
>
> -${LTPROOT}/pan/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${=
TMPBASE}/lvm.part2 &
> +${LTPROOT}/bin/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${=
TMPBASE}/lvm.part2 &
>
> =A0wait $!
>
> diff -uprN ltp-full-20100131/testscripts.orig/ltpfsnolvm.sh ltp-full-2010=
0131/testscripts/ltpfsnolvm.sh
> --- ltp-full-20100131/testscripts.orig/ltpfsnolvm.sh =A0 =A02010-02-19 16=
:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/ltpfsnolvm.sh 2010-02-19 16:28:03.00000=
0000 +0530
> @@ -116,9 +116,9 @@ mount -v /dev/$part4
> =A0mount -v /dev/ram =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /test/gr=
owfiles/ramdisk
>
> =A0echo "************ Running tests "
> -${LTPROOT}/../bin/rand_lines -g ${LTPROOT}/../runtest/lvm.part1 > ${TMPB=
ASE}/lvm.part1
> +${LTPROOT}/../tools/rand_lines -g ${LTPROOT}/../runtest/lvm.part1 > ${TM=
PBASE}/lvm.part1
>
> -${LTPROOT}/../pan/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f=
 ${TMPBASE}/lvm.part1 &
> +${LTPROOT}/../bin/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f=
 ${TMPBASE}/lvm.part1 &
>
> =A0wait $!
>
> @@ -138,9 +138,9 @@ mount -v -t ext3 =A0 /dev/$part4 =A0 =A0 =A0 =A0 /
> =A0mount -v -t jfs =A0 =A0/dev/$part1 =A0 =A0 =A0 =A0 /test/growfiles/jfs
>
> =A0echo "************ Running EXT3 & JFS tests... =A0"
> -${LTPROOT}/../bin/rand_lines -g ${LTPROOT}/../runtest/lvm.part2 > ${TMPB=
ASE}/lvm.part2
> +${LTPROOT}/../tools/rand_lines -g ${LTPROOT}/../runtest/lvm.part2 > ${TM=
PBASE}/lvm.part2
>
> -${LTPROOT}/../pan/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f=
 ${TMPBASE}/lvm.part2 &
> +${LTPROOT}/../bin/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f=
 ${TMPBASE}/lvm.part2 &
>
> =A0wait $!
>
> diff -uprN ltp-full-20100131/testscripts.orig/ltp-scsi_debug.sh ltp-full-=
20100131/testscripts/ltp-scsi_debug.sh
> --- ltp-full-20100131/testscripts.orig/ltp-scsi_debug.sh =A0 =A0 =A0 =A02=
010-02-19 16:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/ltp-scsi_debug.sh =A0 =A0 2010-02-19 16=
:31:51.000000000 +0530
> @@ -204,9 +204,9 @@ mount /dev/$part4 /test/growfiles/msdos
>
> =A0echo "----- Running tests ----- "
> =A0echo "The test may take about 2 hours to finish..."
> -${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/scsi_debug.part1 > ${TMP=
BASE}/scsi_debug
> +${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/scsi_debug.part1 > ${T=
MPBASE}/scsi_debug
>
> -${LTPROOT}/pan/ltp-pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/f=
s-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug
> +${LTPROOT}/bin/ltp-pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/f=
s-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug
>
> =A0wait $!
>
> diff -uprN ltp-full-20100131/testscripts.orig/ltpstress.sh ltp-full-20100=
131/testscripts/ltpstress.sh
> --- ltp-full-20100131/testscripts.orig/ltpstress.sh =A0 =A0 2010-02-19 16=
:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/ltpstress.sh =A02010-02-19 16:32:24.000=
000000 +0530
> @@ -275,9 +275,9 @@ output1=3D${TMPBASE}/ltpstress.$$.output1
> =A0output2=3D${TMPBASE}/ltpstress.$$.output2
> =A0output3=3D${TMPBASE}/ltpstress.$$.output3
>
> -${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress1 -n stress1 -l=
 $logfile -f ${TMP}/stress.part1 -o $output1 &
> -${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress2 -n stress2 -l=
 $logfile -f ${TMP}/stress.part2 -o $output2 &
> -${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress3 -n stress3 -l=
 $logfile -f ${TMP}/stress.part3 -o $output3 &
> +${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress1 -n stress1 -l=
 $logfile -f ${TMP}/stress.part1 -o $output1 &
> +${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress2 -n stress2 -l=
 $logfile -f ${TMP}/stress.part2 -o $output2 &
> +${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress3 -n stress3 -l=
 $logfile -f ${TMP}/stress.part3 -o $output3 &
>
> =A0echo "Running LTP Stress for $hours hour(s) using $(($memsize/1024)) M=
b"
> =A0echo ""
> diff -uprN ltp-full-20100131/testscripts.orig/math.sh ltp-full-20100131/t=
estscripts/math.sh
> --- ltp-full-20100131/testscripts.orig/math.sh =A02010-02-19 16:20:05.000=
000000 +0530
> +++ ltp-full-20100131/testscripts/math.sh =A0 =A0 =A0 1970-01-01 05:30:00=
.000000000 +0530
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -cd `dirname $0`
> -cd ..
> -./runltp -f ${PWD}/runtest/math -q "$@"
> diff -uprN ltp-full-20100131/testscripts.orig/networkstress.sh ltp-full-2=
0100131/testscripts/networkstress.sh
> --- ltp-full-20100131/testscripts.orig/networkstress.sh 2010-02-19 16:20:=
05.000000000 +0530
> +++ ltp-full-20100131/testscripts/networkstress.sh =A0 =A0 =A02010-02-19 =
16:38:21.000000000 +0530
> @@ -124,10 +124,10 @@ if [ ${VERBOSE} =3D "yes" ]; then
> =A0 =A0 =A0 =A0cat $TMPDIR/network_stress.tests
> =A0 =A0 =A0 =A0${LTPROOT}/ver_linux
> =A0 =A0 =A0 =A0echo ""
> - =A0 =A0 =A0 echo ${LTPROOT}/pan/ltp-pan -e -l /tmp/netstress.log -S -a =
netstress -n netstress -f ${TMPDIR}/network_stress.tests
> + =A0 =A0 =A0 echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netstress.log -S -a =
netstress -n netstress -f ${TMPDIR}/network_stress.tests
> =A0fi
>
> -${LTPROOT}/pan/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netst=
ress -f ${TMPDIR}/network_stress.tests
> +${LTPROOT}/bin/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netst=
ress -f ${TMPDIR}/network_stress.tests
>
> =A0if [ $? -eq "0" ]; then
> =A0 echo ltp-pan reported PASS
> diff -uprN ltp-full-20100131/testscripts.orig/networktests.sh ltp-full-20=
100131/testscripts/networktests.sh
> --- ltp-full-20100131/testscripts.orig/networktests.sh =A02010-02-19 16:2=
0:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/networktests.sh =A0 =A0 =A0 2010-02-19 =
16:38:55.000000000 +0530
> @@ -119,10 +119,10 @@ if [ ${VERBOSE} =3D "yes" ]; then
> =A0 =A0 cat $CMDFILE
> =A0 =A0 ${LTPROOT}/ver_linux
> =A0 =A0 echo ""
> - =A0 =A0echo ${LTPROOT}/pan/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -=
n ltpnet -f $CMDFILE
> + =A0 =A0echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -=
n ltpnet -f $CMDFILE
> =A0fi
>
> -${LTPROOT}/pan/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $=
CMDFILE
> +${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $=
CMDFILE
>
> =A0if [ $? -eq "0" ]; then
> =A0 echo ltp-pan reported PASS
> diff -uprN ltp-full-20100131/testscripts.orig/runEALtests.sh ltp-full-201=
00131/testscripts/runEALtests.sh
> --- ltp-full-20100131/testscripts.orig/runEALtests.sh =A0 2010-02-19 16:2=
0:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/runEALtests.sh =A0 =A0 =A0 =A02010-02-1=
9 16:42:25.000000000 +0530
> @@ -186,14 +186,14 @@ fi
> =A0# to execute.
> =A0if [ -z $cmdfile ]
> =A0then
> - =A0 =A0 =A0 cat ${LTPROOT}/../runtest/admin_tools > ${TMP}/alltests
> + =A0 =A0 =A0 cat ${LTPROOT}/runtest/admin_tools > ${TMP}/alltests
> =A0else
> =A0 =A0 cat $cmdfile > ${TMP}/alltests
> =A0fi
>
> =A0if [ $run_netest -eq 1 ]
> =A0then
> - =A0 =A0 =A0 cat ${LTPROOT}/../runtest/network_commands >> ${TMP}/alltes=
ts
> + =A0 =A0 =A0 cat ${LTPROOT}/runtest/network_commands >> ${TMP}/alltests
> =A0fi
>
> =A0# The fsx-linux tests use the SCRATCHDEV environment variable as a loc=
ation
> @@ -201,13 +201,13 @@ fi
> =A0# these tests. =A0As a safeguard, this is disabled.
> =A0unset SCRATCHDEV
> =A0if [ -n "$SCRATCHDEV" ]; then
> - =A0cat ${LTPROOT}/../runtest/fsx >> ${TMP}/alltests
> + =A0cat ${LTPROOT}/runtest/fsx >> ${TMP}/alltests
> =A0fi
>
> =A0# display versions of installed software
> -${LTPROOT}/../ver_linux
> +${LTPROOT}/ver_linux
>
> -${LTPROOT}/../pan/ltp-pan $quiet_mode -e -S $instances $duration -a $$ -=
n $$ $pretty_prt -f ${TMP}/alltests $logfile
> +${LTPROOT}/bin/ltp-pan $quiet_mode -e -S $instances $duration -a $$ -n $=
$ $pretty_prt -f ${TMP}/alltests $logfile
>
> =A0if [ $? -eq 0 ]; then
> =A0 echo ltp-pan reported PASS
> diff -uprN ltp-full-20100131/testscripts.orig/runpan.sh ltp-full-20100131=
/testscripts/runpan.sh
> --- ltp-full-20100131/testscripts.orig/runpan.sh =A0 =A0 =A0 =A02010-02-1=
9 16:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/runpan.sh =A0 =A0 2010-02-19 16:42:45.0=
00000000 +0530
> @@ -14,7 +14,7 @@ cd /tmp/runpan-$$
>
> =A0export PATH=3D"${PATH}:${LTPROOT}/doio:${LTPROOT}/testcases/bin"
>
> -${LTPROOT}/pan/ltp-pan -e $@ -a ltp -n ltp -f ${LTPROOT}/runtest/quickhit
> +${LTPROOT}/bin/ltp-pan -e $@ -a ltp -n ltp -f ${LTPROOT}/runtest/quickhit
>
> =A0if [ $? -eq "0" ]; then
> =A0 echo ltp-pan reported PASS
> diff -uprN ltp-full-20100131/testscripts.orig/syscalls.sh ltp-full-201001=
31/testscripts/syscalls.sh
> --- ltp-full-20100131/testscripts.orig/syscalls.sh =A0 =A0 =A02010-02-19 =
16:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/syscalls.sh =A0 1970-01-01 05:30:00.000=
000000 +0530
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -cd `dirname $0`
> -cd ..
> -./runltp -f ${PWD}/runtest/syscalls -q "$@"
> diff -uprN ltp-full-20100131/testscripts.orig/tpm_tools.sh ltp-full-20100=
131/testscripts/tpm_tools.sh
> --- ltp-full-20100131/testscripts.orig/tpm_tools.sh =A0 =A0 2010-02-19 16=
:20:05.000000000 +0530
> +++ ltp-full-20100131/testscripts/tpm_tools.sh =A02010-02-19 16:47:38.000=
000000 +0530
> @@ -167,7 +167,7 @@ export P11_USER_PWD=3D"P11 USER PWD"
> =A0export NEW_P11_USER_PWD=3D"NEW P11 USER PWD"
>
> =A0echo "Running the tpm-tools testsuite..."
> -$LTPROOT/pan/ltp-pan -d 5 -S -a $LTPROOT/results/tpm_tools -n ltp-tpm-to=
ols -l $LTPROOT/results/tpm_tools.logfile -o $LTPROOT/results/tpm_tools.out=
file -p -f $LTPROOT/runtest/tpm_tools
> +$LTPROOT/bin/ltp-pan -d 5 -S -a $LTPROOT/results/tpm_tools -n ltp-tpm-to=
ols -l $LTPROOT/results/tpm_tools.logfile -o $LTPROOT/results/tpm_tools.out=
file -p -f $LTPROOT/runtest/tpm_tools
>
> =A0echo "Done."
> =A0exit 0

Committed -- cheers!
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

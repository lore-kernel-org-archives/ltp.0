Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PosoP-0007Vu-O2
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 07:25:33 +0000
Received: from mail-ww0-f42.google.com ([74.125.82.42])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PosoM-0006H1-LO
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 07:25:31 +0000
MIME-Version: 1.0
In-Reply-To: <1297666711.25215.1.camel@subratamodak.linux.ibm.com>
References: <20110212175827.6308.29198.sendpatchset@subratamodak.linux.ibm.com>
	<071128CA-BC84-401E-B7C9-7ABC66B1574D@gmail.com>
	<1297666711.25215.1.camel@subratamodak.linux.ibm.com>
Date: Sun, 13 Feb 2011 23:25:23 -0800
Message-ID: <AANLkTi=r3qNXkjogSzPigu96fV4fdka+aMKPZykBXYqi@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix Usage Reference of those tools utilities
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
To: subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sf.net>

    Must have been an iPhone or other PEBKAC fail. Sure, looks good.
Thanks,
-Garrett

On Sun, Feb 13, 2011 at 10:58 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Garret,
>
> Did you mean to comment something ? I did not receive any feedback in
> the mail, just blank reply :-(
>
> Regards--
> Subrata
>
> On Sat, 2011-02-12 at 11:13 -0800, Garrett Cooper wrote:
>> On Feb 12, 2011, at 9:58 AM, Subrata Modak <subrata@linux.vnet.ibm.com> =
wrote:
>>
>> > Useful scripts under ltp/tools are no more installed @{LTP_ROOT}/tools,
>> > they are done under @{LTP_ROOT}/bin. Change their reference accordingly
>> > inside 'runltp' script. Nobody noticed this early as probably these
>> > options are least used in LTP ;-)
>> >
>> > Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
>> >
>> > ---
>> > diff --git a/runltp b/runltp
>> > index 2c6785f..381e123 100755
>> > --- a/runltp
>> > +++ b/runltp
>> > @@ -779,7 +779,7 @@ main()
>> > =A0 =A0 =A0 =A0 =A0 =A0#Go ahead to Inject Fault & Create required
>> > =A0 =A0 =A0 =A0 =A0 =A0#Command Files for LTP run
>> > =A0 =A0 =A0 =A0 =A0 =A0echo Running tests with Fault Injection Enabled=
 in the Kernel...
>> > - =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/tools/create_kernel_faults_in_loop=
s_and_probability.pl\
>> > + =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/bin/create_kernel_faults_in_loops_=
and_probability.pl\
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${TMP}/alltests $INJECT_FAULT_LOOPS_PER=
_TEST $INJECT_KERNEL_FAULT_PERCENTAGE > ${TMP}/alltests.tmp
>> > =A0 =A0 =A0 =A0 =A0 =A0cp ${TMP}/alltests.tmp ${TMP}/alltests
>> > =A0 =A0 =A0 =A0 =A0 =A0rm -rf ${TMP}/alltests.tmp
>> > @@ -796,15 +796,15 @@ main()
>> > =A0 =A0 =A0 =A0 =A0 =A0which valgrind || VALGRIND_CHECK_TYPE=3DXYZ
>> > =A0 =A0 =A0 =A0 =A0 =A0case $VALGRIND_CHECK_TYPE in
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/tools/create_valgrind_chec=
k.pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/bin/create_valgrind_check.=
pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cp ${TMP}/alltests.tmp ${TMP}/alltests
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rm -rf ${TMP}/alltests.tmp;;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/tools/create_valgrind_chec=
k.pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/bin/create_valgrind_check.=
pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cp ${TMP}/alltests.tmp ${TMP}/alltests
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rm -rf ${TMP}/alltests.tmp;;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/tools/create_valgrind_chec=
k.pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/bin/create_valgrind_check.=
pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cp ${TMP}/alltests.tmp ${TMP}/alltests
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rm -rf ${TMP}/alltests.tmp;;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*) echo "Invalid Memory Check Type, or,=
 Valgrind is not available";;
>> > @@ -859,7 +859,7 @@ main()
>> > =A0 =A0 =A0 =A0export TEST_OUTPUT_DIRECTORY=3D"$LTPROOT/output"
>> > =A0 =A0 =A0 =A0export TEST_LOGS_DIRECTORY=3D$LOGS_DIRECTORY
>> > =A0 =A0 =A0 =A0echo "Generating HTML Output.....!!"
>> > - =A0 =A0 =A0 ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/tools/html_repor=
t_header.txt test_start test_end test_output execution_status $OUTPUT_DIREC=
TORY =A0> $HTMLFILE; )
>> > + =A0 =A0 =A0 ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/bin/html_report_=
header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTO=
RY =A0> $HTMLFILE; )
>> > =A0 =A0 =A0 =A0echo "Generated HTML Output.....!!"
>> > =A0 =A0 =A0 =A0echo "Location: $HTMLFILE";
>> >
>> > ---
>> >
>> > Regards--
>> > Subrata
>> >
>> >
>> > ----------------------------------------------------------------------=
--------
>> > The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio =
XE:
>> > Pinpoint memory and threading errors before they happen.
>> > Find and fix more than 250 security defects in the development cycle.
>> > Locate bottlenecks in serial and parallel code that limit performance.
>> > http://p.sf.net/sfu/intel-dev2devfeb
>> > _______________________________________________
>> > Ltp-list mailing list
>> > Ltp-list@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

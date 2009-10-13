Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxlD8-00040l-2B
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 17:30:58 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxlD2-0004dX-My
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 17:30:58 +0000
Received: by pzk26 with SMTP id 26so9178242pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 10:30:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255436019.8438.37.camel@subratamodak.linux.ibm.com>
References: <364299f40910022123k700ee146q5c8a8aa5ccf535eb@mail.gmail.com>
	<1255436019.8438.37.camel@subratamodak.linux.ibm.com>
Date: Tue, 13 Oct 2009 10:30:47 -0700
Message-ID: <364299f40910131030n501177d4g11353e40f43da6b6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Remove `verbose mode' from runltp*
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Oct 13, 2009 at 5:13 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-10-02 at 21:23 -0700, Garrett Cooper wrote:
>> 1. This option really doesn't buy us much in runltp*, and we've almost
>> already run out of options anyhow...
>> 2. Correct some ugly indentation.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Was difficult to apply over the changes you recently made. However, i
> was able to ;-)
>
> Regards--
> Subrata
>
>>
>> Index: runltp
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /cvsroot/ltp/ltp/runltp,v
>> retrieving revision 1.49
>> diff -u -r1.49 runltp
>> --- runltp =A0 =A026 Aug 2009 07:00:25 -0000 =A0 =A0 =A01.49
>> +++ runltp =A0 =A03 Oct 2009 04:21:33 -0000
>> @@ -156,7 +156,6 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-t 24h =3D 24 hours
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-t 2d =A0=3D 2 days
>> =A0 =A0 =A0-T REPETITION =A0 Execute the testsuite for REPETITION no. of=
 times
>> - =A0 =A0-v =A0 =A0 =A0 =A0 =A0 =A0 =A0Print more verbose output to scre=
en.
>> =A0 =A0 =A0-w CMDFILEADDR =A0Uses wget to get the user's list of testcas=
es.
>> =A0 =A0 =A0-x INSTANCES =A0 =A0Run multiple instances of this testsuite.
>> =A0 =A0 =A0-b DEVICE =A0 =A0 =A0 Some tests require an unmounted block d=
evice
>> @@ -182,18 +181,17 @@
>> =A0 =A0 =A0local RUN_NETEST=3D0
>> =A0 =A0 =A0local RUN_REPEATED=3D0
>> =A0 =A0 =A0local QUIET_MODE=3D""
>> - =A0 =A0local VERBOSE_MODE=3D""
>> =A0 =A0 =A0local NETPIPE=3D0
>> =A0 =A0 =A0local GENLOAD=3D0
>> =A0 =A0 =A0local MEMSIZE=3D0
>> =A0 =A0 =A0local DURATION=3D""
>> =A0 =A0 =A0local CMDFILEADDR=3D""
>> =A0 =A0 =A0local FAILCMDFILE=3D""
>> - =A0 =A0 local INJECT_KERNEL_FAULT=3D""
>> - =A0 =A0 local INJECT_KERNEL_FAULT_PERCENTAGE=3D""
>> - =A0 =A0 local INJECT_FAULT_LOOPS_PER_TEST=3D""
>> - =A0 =A0 local VALGRIND_CHECK=3D""
>> - =A0 =A0 local VALGRIND_CHECK_TYPE=3D""
>> + =A0 =A0local INJECT_KERNEL_FAULT=3D""
>> + =A0 =A0local INJECT_KERNEL_FAULT_PERCENTAGE=3D""
>> + =A0 =A0local INJECT_FAULT_LOOPS_PER_TEST=3D""
>> + =A0 =A0local VALGRIND_CHECK=3D""
>> + =A0 =A0local VALGRIND_CHECK_TYPE=3D""
>> =A0 =A0 =A0local LOGFILE_NAME=3D""
>> =A0 =A0 =A0local LOGFILE=3D""
>> =A0 =A0 =A0local OUTPUTFILE_NAME=3D""
>> @@ -207,7 +205,7 @@
>> =A0 =A0 =A0local DEFAULT_FILE_NAME_GENERATION_TIME=3D`date +"%Y_%b_%d-%H=
h_%Mm_%Ss"`
>> =A0 =A0 =A0version_date=3D`head -n 1 $LTPROOT/ChangeLog`
>>
>> - =A0 =A0while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:vw:x:b:=
B: arg
>> + =A0 =A0while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B=
: arg
>> =A0 =A0 =A0do =A0case $arg in
>> =A0 =A0 =A0 =A0 =A0a) =A0EMAIL_TO=3D$OPTARG
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0ALT_EMAIL_OUT=3D1;;
>> @@ -398,8 +396,6 @@
>> =A0 =A0 =A0 =A0 =A0T) =A0# In case you want the testcases to runsequenti=
ally
>> RUN_REPEATED times
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0RUN_REPEATED=3D$OPTARG;;
>>
>> - =A0 =A0 =A0 =A0v) =A0VERBOSE_MODE=3D1;;
>> -
>> =A0 =A0 =A0 =A0 =A0w) =A0CMDFILEADDR=3D$OPTARG;;
>>
>> =A0 =A0 =A0 =A0 =A0x) =A0# number of ltp's to run
>> @@ -755,11 +751,9 @@
>> =A0 =A0 =A0[ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(da=
te)" ; }
>> =A0 =A0 =A0PAN_COMMAND=3D"${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INST=
ANCES
>> $DURATION -a $$ \
>> =A0 =A0 =A0-n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FA=
ILCMDFILE"
>> - =A0 =A0if [ ! -z "$VERBOSE_MODE" ] ; then
>> - =A0 =A0 =A0echo "COMMAND: =A0 =A0$PAN_COMMAND"
>> - =A0 =A0 =A0if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
>> - =A0 =A0 =A0 =A0echo "INFO: Restricted to $TAG_RESTRICT_STRING"
>> - =A0 =A0 =A0fi
>> + =A0 =A0echo "COMMAND: =A0 =A0$PAN_COMMAND"
>> + =A0 =A0if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
>> + =A0 =A0 =A0echo "INFO: Restricted to $TAG_RESTRICT_STRING"
>> =A0 =A0 =A0fi
>> =A0 =A0 =A0#$PAN_COMMAND #Duplicated code here, because otherwise if we
>> fail, only "PAN_COMMAND" gets output
>>
>> Index: runltplite.sh
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /cvsroot/ltp/ltp/runltplite.sh,v
>> retrieving revision 1.5
>> diff -u -r1.5 runltplite.sh
>> --- runltplite.sh =A0 =A0 19 May 2009 09:39:11 -0000 =A0 =A0 =A01.5
>> +++ runltplite.sh =A0 =A0 3 Oct 2009 04:21:33 -0000
>> @@ -85,7 +85,6 @@
>> =A0 =A0 =A0-p =A0 =A0 =A0 =A0 =A0 =A0 =A0Human readable format logfiles.
>> =A0 =A0 =A0-q =A0 =A0 =A0 =A0 =A0 =A0 =A0Print less verbose output to sc=
reen.
>> =A0 =A0 =A0-r LTPROOT =A0 =A0 =A0Fully qualified path where testsuite is=
 installed.
>> - =A0 =A0-v =A0 =A0 =A0 =A0 =A0 =A0 =A0Print more verbose output to scre=
en.
>>
>> =A0 =A0 =A0example: ./${0##*/} -i 1024 -m 128 -p -q =A0-l /tmp/resultlog=
.$$ -d ${PWD}
>>
>> @@ -114,7 +113,7 @@
>> =A0 =A0 =A0local TAG_RESTRICT_STRING=3D""
>> =A0 =A0 =A0local PAN_COMMAND=3D""
>>
>> - =A0 =A0while getopts c:d:hi:l:m:No:pqr:v arg
>> + =A0 =A0while getopts c:d:hi:l:m:No:pqr: arg
>> =A0 =A0 =A0do =A0case $arg in
>> =A0 =A0 =A0 =A0 =A0c)
>> =A0 =A0 =A0 =A0 =A0 NUM_PROCS=3D$(($OPTARG))

    Sorry -- if it gets too hard, just let me know that it looks sane
and I'll commit it directly to CVS ><...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

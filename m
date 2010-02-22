Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NjSRT-0006Os-0d
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:10:55 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjSRS-0007Ut-31
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:10:54 +0000
Received: by pwi5 with SMTP id 5so2060513pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 21 Feb 2010 23:10:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001801cab363$9ff5a2d0$dfe0e870$@co.jp>
References: <000f01caae08$ce91e640$6bb5b2c0$@co.jp>
	<20100217150214.GB9825@rishikesh.in.ibm.com>
	<364299f41002170936q1f0c4723qd7ad7f10df6745af@mail.gmail.com>
	<001801cab363$9ff5a2d0$dfe0e870$@co.jp>
Date: Sun, 21 Feb 2010 23:10:47 -0800
Message-ID: <364299f41002212310r6e8107c4m89d8970fdb8a9553@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "logrotate01" has problem
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
To: Yuki Yao <y_yao@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Sun, Feb 21, 2010 at 6:06 PM, Yuki Yao <y_yao@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Thursday, February 18, 2010 2:36 AM
>> To: Rishikesh K Rajak
>> Cc: Yuki Yao; ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] "logrotate01" has problem
>>
>> On Wed, Feb 17, 2010 at 7:02 AM, Rishikesh K Rajak
>> <risrajak@linux.vnet.ibm.com> wrote:
>> > On Mon, Feb 15, 2010 at 03:33:37PM +0900, Yuki Yao wrote:
>> >> Hi,
>> >>
>> >> I contributed following problem previously, but it's not yet revised.
>> >> So, I contribute this again.
>> >>
>> >> After "./runltp" execution, all log files such as "/var/log/messages*"
>> >> disappeared, and there is only new log file created after the test.
>> >>
>> >> This seems a problem that occurs after the "logrotate01" test.
>> >> I found that the past log files were deleted by forcing a "logrotate"
>> >> (logrotate -fv $LTPTMP/tst_logrotate.conf).
>> >>
>> >> Besides, logrotate01's shell script "./testcases/commands/logrotate
>> >> /logrotate_tests.sh" creats logrotate configuration file ($LTPTMP
>> >> /tst_logrotate.conf) for the test, and this configration file includes
>> >> "/etc/logrotate.d" as follows:
>> >>
>> >> [ ./testcases/commands/logrotate/logrotate_tests.sh line:156~ ]
>> >> ----------
>> >> # create config file.
>> >> =A0 =A0 =A0 cat >$LTPTMP/tst_logrotate.conf <<-EOF
>> >> =A0 =A0 =A0 #****** Begin Config file *******
>> >> =A0 =A0 =A0 # create new (empty) log files after rotating old ones
>> >> =A0 =A0 =A0 create
>> >>
>> >> =A0 =A0 =A0 # compress the log files
>> >> =A0 =A0 =A0 compress
>> >>
>> >> =A0 =A0 =A0 # RPM packages drop log rotation information into this di=
rectory
>> >> =A0 =A0 =A0 include /etc/logrotate.d
>> >>
>> >> =A0 =A0 =A0 /var/log/tst_logfile {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotate 5
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 weekly
>> >> =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 #****** End Config file *******
>> >> =A0 =A0 =A0 EOF
>> >> ----------
>> >>
>> >> By This, not only a log file for the test (/var/log/tst_logfile)
>> >> but also 30 fies such as "/var/log/messages*" become "logrotate"
>> >> command target.
>> >> Only a log file for this test must become a target of the forced
>> >> execution of "logrotate".
>> >>
>> >> To resolve this problem, we must change "/logrotate_tests.sh" not to
>> >> include "/etc/logrotate.d", I think.
>> >>
>> >> Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>
>> >
>> > Hello Garret,
>> >
>> > Any input for this patch ?
>> >
>> > Thanks
>> > -Rishi
>> >>
>> >> Index: ./testcases/commands/logrotate/logrotate_tests.sh
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>
>> --- ./testcases/commands/logrotate/logrotate_tests.sh.orig =A0 =A02008-1=
0-
>> 21
>> >> 15:54:15.000000000 +0900
>> >> +++ ./testcases/commands/logrotate/logrotate_tests.sh 2010-02-15
>> >> 13:32:02.000000000 +0900
>> >> @@ -163,7 +163,7 @@
>> >> =A0 =A0 =A0 compress
>> >>
>> >> =A0 =A0 =A0 # RPM packages drop log rotation information into this di=
rectory
>> >> - =A0 =A0 include /etc/logrotate.d
>> >> + =A0 =A0 # include /etc/logrotate.d
>> >>
>> >> =A0 =A0 =A0 /var/log/tst_logfile {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotate 5
>> >> @@ -200,7 +200,7 @@
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # check if =A0/etc/logrotate.d is include=
d/
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # check if 5 rotations are forced.
>> >> =A0 =A0 =A0 =A0 =A0# check if compression is done.
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 grep "including /etc/logrotate.d"
>> $LTPTMP/tst_logrotate.out
>> >> \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 # grep "including /etc/logrotate.d"
>> >> $LTPTMP/tst_logrotate.out \
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 > $LTPTMP/tst_logrotate.e=
rr 2>&1 || RC=3D$?
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 grep "reading config file $LTPTMP/tst_log=
rotate.conf"
>> \
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $LTPTMP/tst_logrotate.out=
 =A0 >
>> >> $LTPTMP/tst_logrotate.err 2>&1 || RC=3D$?
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> The problem statement isn't clearly worded, thus I'm confused whether
>> or not the patch is fixing a symptom or the root cause itself.
>
> Hi,
>
> I want to explain about the problem and patch.
>
> <About Problem>
> After "logrotate01" test, log files (such as "/var/log/messages*")
> --which are important to system administration-- are disappeared.
>
> *** In the following explanation, I will call these important files
> =A0 =A0"System-Logs" for convenience.
>
> The following explain about the problem.
> 1. "logrotate01" tests the forced rotation "logrotate -f <config_file>".
> =A0 This rotation deletes the past log files which stored until now,
> =A0 and creates the new log file.
> =A0 The target of this forced rotation is /var/log/tst_logfile which
> =A0 created for this test.
>
> 2. $LTPTMP/tst_logrotate.conf is created as logrotate configuration
> =A0 file for this test.
> =A0 This config-file includes /etc/logrotate.d, and all files under
> =A0 /etc/logrotate.d are loaded.
>
> 3. In the files under the /etc/logrotate.d, the rotation of
> =A0 "System-Logs" are set.
>
> 4. Because, "System-Logs" also became a target for forced rotation.
> =A0 Therefore, after this test, all past "System-Logs" are disappeared.
>
> Only /var/log/tst_logfile should be the target of this test, I think.
> What is the reason why actual "System-Logs" becomes the target?
> In a system for exclusive use of the LTP test, this may not be problem.
> But, it will be troubled that important logs disappeared when general
> users execute runltp in the system which is operating.
>
> <About Patch>
> The contributed patch doesn't load the file under the /etc/logrotate.d
> by commenting-out "include /etc/logrotate.d" in $LTPTMP/tst_logrotate.con=
f.
> And it can let only /var/log/tst_logfile be the target of the forced
> rotation.

    So from what you described I see a singular problem: logrotate01
should _restore_ a system log as that is a valid feature to test. I
don't think that omitting that directive would be a wise idea because
you're effectively disabling that functionality.
    If you can make the test interrupt-resistant under normal
conditions and restore on exit, you should be fine (hint... try
something like the following)

save() {
    cp "${SYSTEM_LOG}" "${SYSTEM_LOG}.bk"
}

restore() {
    # Disable the signal handler.
    trap "" EXIT

    # Shouldn't be the case -- if so the test should be rewritten to
use a mktemp generated file.
    if [ "x${SYSTEM_LOG}" =3D "x${TEST_SYSTEM_LOG}" ] ; then
        cp "${TEST_SYSTEM_LOG}" "${TEST_SYSTEM_LOG}.test"
        TEST_SYSTEM_LOG=3D"${TEST_SYSTEM_LOG}.test"
    fi

    # XXX: Stop syslogd here...

    mv "${SYSTEM_LOG}.bk" "${SYSTEM_LOG}"
    cat "${SYSTEM_LOG}.test" >> "${SYSTEM_LOG}"

    # XXX: Start syslogd again here...

}

# XXX: in ``main``, swap around the configuration; call save.

# Make sure restore will be called at the end of the script's lifetime.
trap restore EXIT

# Do test stuff here..

Cheers,
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

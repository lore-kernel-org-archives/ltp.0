Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <y_yao@ryobi.co.jp>) id 1NjNgt-0006bK-GH
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 02:06:31 +0000
Received: from out04.sjc.mx.trendmicro.com ([216.99.131.8])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjNgr-0006aB-S2
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 02:06:31 +0000
From: "Yuki Yao" <y_yao@ryobi.co.jp>
References: <000f01caae08$ce91e640$6bb5b2c0$@co.jp>	
	<20100217150214.GB9825@rishikesh.in.ibm.com>
	<364299f41002170936q1f0c4723qd7ad7f10df6745af@mail.gmail.com>
In-Reply-To: <364299f41002170936q1f0c4723qd7ad7f10df6745af@mail.gmail.com>
Date: Mon, 22 Feb 2010 11:06:19 +0900
Message-ID: <001801cab363$9ff5a2d0$dfe0e870$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Thursday, February 18, 2010 2:36 AM
> To: Rishikesh K Rajak
> Cc: Yuki Yao; ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] "logrotate01" has problem
> =

> On Wed, Feb 17, 2010 at 7:02 AM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
> > On Mon, Feb 15, 2010 at 03:33:37PM +0900, Yuki Yao wrote:
> >> Hi,
> >>
> >> I contributed following problem previously, but it's not yet revised.
> >> So, I contribute this again.
> >>
> >> After "./runltp" execution, all log files such as "/var/log/messages*"
> >> disappeared, and there is only new log file created after the test.
> >>
> >> This seems a problem that occurs after the "logrotate01" test.
> >> I found that the past log files were deleted by forcing a "logrotate"
> >> (logrotate -fv $LTPTMP/tst_logrotate.conf).
> >>
> >> Besides, logrotate01's shell script "./testcases/commands/logrotate
> >> /logrotate_tests.sh" creats logrotate configuration file ($LTPTMP
> >> /tst_logrotate.conf) for the test, and this configration file includes
> >> "/etc/logrotate.d" as follows:
> >>
> >> [ ./testcases/commands/logrotate/logrotate_tests.sh line:156~ ]
> >> ----------
> >> # create config file.
> >> =A0 =A0 =A0 cat >$LTPTMP/tst_logrotate.conf <<-EOF
> >> =A0 =A0 =A0 #****** Begin Config file *******
> >> =A0 =A0 =A0 # create new (empty) log files after rotating old ones
> >> =A0 =A0 =A0 create
> >>
> >> =A0 =A0 =A0 # compress the log files
> >> =A0 =A0 =A0 compress
> >>
> >> =A0 =A0 =A0 # RPM packages drop log rotation information into this dir=
ectory
> >> =A0 =A0 =A0 include /etc/logrotate.d
> >>
> >> =A0 =A0 =A0 /var/log/tst_logfile {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotate 5
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 weekly
> >> =A0 =A0 =A0 }
> >> =A0 =A0 =A0 #****** End Config file *******
> >> =A0 =A0 =A0 EOF
> >> ----------
> >>
> >> By This, not only a log file for the test (/var/log/tst_logfile)
> >> but also 30 fies such as "/var/log/messages*" become "logrotate"
> >> command target.
> >> Only a log file for this test must become a target of the forced
> >> execution of "logrotate".
> >>
> >> To resolve this problem, we must change "/logrotate_tests.sh" not to
> >> include "/etc/logrotate.d", I think.
> >>
> >> Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>
> >
> > Hello Garret,
> >
> > Any input for this patch ?
> >
> > Thanks
> > -Rishi
> >>
> >> Index: ./testcases/commands/logrotate/logrotate_tests.sh
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> --- ./testcases/commands/logrotate/logrotate_tests.sh.orig =A0 =A02008-10-
> 21
> >> 15:54:15.000000000 +0900
> >> +++ ./testcases/commands/logrotate/logrotate_tests.sh 2010-02-15
> >> 13:32:02.000000000 +0900
> >> @@ -163,7 +163,7 @@
> >> =A0 =A0 =A0 compress
> >>
> >> =A0 =A0 =A0 # RPM packages drop log rotation information into this dir=
ectory
> >> - =A0 =A0 include /etc/logrotate.d
> >> + =A0 =A0 # include /etc/logrotate.d
> >>
> >> =A0 =A0 =A0 /var/log/tst_logfile {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotate 5
> >> @@ -200,7 +200,7 @@
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # check if =A0/etc/logrotate.d is included/
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # check if 5 rotations are forced.
> >> =A0 =A0 =A0 =A0 =A0# check if compression is done.
> >> - =A0 =A0 =A0 =A0 =A0 =A0 grep "including /etc/logrotate.d"
> $LTPTMP/tst_logrotate.out
> >> \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 # grep "including /etc/logrotate.d"
> >> $LTPTMP/tst_logrotate.out \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 > $LTPTMP/tst_logrotate.er=
r 2>&1 || RC=3D$?
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 grep "reading config file $LTPTMP/tst_logr=
otate.conf"
> \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $LTPTMP/tst_logrotate.out =
=A0 >
> >> $LTPTMP/tst_logrotate.err 2>&1 || RC=3D$?
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> The problem statement isn't clearly worded, thus I'm confused whether
> or not the patch is fixing a symptom or the root cause itself.

Hi,

I want to explain about the problem and patch.

<About Problem>
After "logrotate01" test, log files (such as "/var/log/messages*")
--which are important to system administration-- are disappeared.

*** In the following explanation, I will call these important files =

    "System-Logs" for convenience.

The following explain about the problem.
1. "logrotate01" tests the forced rotation "logrotate -f <config_file>".
   This rotation deletes the past log files which stored until now, =

   and creates the new log file.
   The target of this forced rotation is /var/log/tst_logfile which =

   created for this test.

2. $LTPTMP/tst_logrotate.conf is created as logrotate configuration =

   file for this test.
   This config-file includes /etc/logrotate.d, and all files under =

   /etc/logrotate.d are loaded.

3. In the files under the /etc/logrotate.d, the rotation of =

   "System-Logs" are set.

4. Because, "System-Logs" also became a target for forced rotation.
   Therefore, after this test, all past "System-Logs" are disappeared.

Only /var/log/tst_logfile should be the target of this test, I think.
What is the reason why actual "System-Logs" becomes the target?
In a system for exclusive use of the LTP test, this may not be problem.
But, it will be troubled that important logs disappeared when general
users execute runltp in the system which is operating.

<About Patch>
The contributed patch doesn't load the file under the /etc/logrotate.d
by commenting-out "include /etc/logrotate.d" in $LTPTMP/tst_logrotate.conf.
And it can let only /var/log/tst_logfile be the target of the forced =

rotation.


Thank you,
-Yuki Yao

> Thanks,
> -Garrett



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

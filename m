Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nhnp8-0006M1-HI
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:36:30 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nhnp7-0000IK-Ns
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:36:30 +0000
Received: by pwi5 with SMTP id 5so1026398pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Feb 2010 09:36:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100217150214.GB9825@rishikesh.in.ibm.com>
References: <000f01caae08$ce91e640$6bb5b2c0$@co.jp>
	<20100217150214.GB9825@rishikesh.in.ibm.com>
Date: Wed, 17 Feb 2010 09:36:23 -0800
Message-ID: <364299f41002170936q1f0c4723qd7ad7f10df6745af@mail.gmail.com>
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Feb 17, 2010 at 7:02 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Mon, Feb 15, 2010 at 03:33:37PM +0900, Yuki Yao wrote:
>> Hi,
>>
>> I contributed following problem previously, but it's not yet revised.
>> So, I contribute this again.
>>
>> After "./runltp" execution, all log files such as "/var/log/messages*"
>> disappeared, and there is only new log file created after the test.
>>
>> This seems a problem that occurs after the "logrotate01" test.
>> I found that the past log files were deleted by forcing a "logrotate"
>> (logrotate -fv $LTPTMP/tst_logrotate.conf).
>>
>> Besides, logrotate01's shell script "./testcases/commands/logrotate
>> /logrotate_tests.sh" creats logrotate configuration file ($LTPTMP
>> /tst_logrotate.conf) for the test, and this configration file includes
>> "/etc/logrotate.d" as follows:
>>
>> [ ./testcases/commands/logrotate/logrotate_tests.sh line:156~ ]
>> ----------
>> # create config file.
>> =A0 =A0 =A0 cat >$LTPTMP/tst_logrotate.conf <<-EOF
>> =A0 =A0 =A0 #****** Begin Config file *******
>> =A0 =A0 =A0 # create new (empty) log files after rotating old ones
>> =A0 =A0 =A0 create
>>
>> =A0 =A0 =A0 # compress the log files
>> =A0 =A0 =A0 compress
>>
>> =A0 =A0 =A0 # RPM packages drop log rotation information into this direc=
tory
>> =A0 =A0 =A0 include /etc/logrotate.d
>>
>> =A0 =A0 =A0 /var/log/tst_logfile {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotate 5
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 weekly
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 #****** End Config file *******
>> =A0 =A0 =A0 EOF
>> ----------
>>
>> By This, not only a log file for the test (/var/log/tst_logfile)
>> but also 30 fies such as "/var/log/messages*" become "logrotate"
>> command target.
>> Only a log file for this test must become a target of the forced
>> execution of "logrotate".
>>
>> To resolve this problem, we must change "/logrotate_tests.sh" not to
>> include "/etc/logrotate.d", I think.
>>
>> Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>
>
> Hello Garret,
>
> Any input for this patch ?
>
> Thanks
> -Rishi
>>
>> Index: ./testcases/commands/logrotate/logrotate_tests.sh
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ./testcases/commands/logrotate/logrotate_tests.sh.orig =A0 =A02008-1=
0-21
>> 15:54:15.000000000 +0900
>> +++ ./testcases/commands/logrotate/logrotate_tests.sh 2010-02-15
>> 13:32:02.000000000 +0900
>> @@ -163,7 +163,7 @@
>> =A0 =A0 =A0 compress
>>
>> =A0 =A0 =A0 # RPM packages drop log rotation information into this direc=
tory
>> - =A0 =A0 include /etc/logrotate.d
>> + =A0 =A0 # include /etc/logrotate.d
>>
>> =A0 =A0 =A0 /var/log/tst_logfile {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotate 5
>> @@ -200,7 +200,7 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # check if =A0/etc/logrotate.d is included/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # check if 5 rotations are forced.
>> =A0 =A0 =A0 =A0 =A0# check if compression is done.
>> - =A0 =A0 =A0 =A0 =A0 =A0 grep "including /etc/logrotate.d" $LTPTMP/tst_=
logrotate.out
>> \
>> + =A0 =A0 =A0 =A0 =A0 =A0 # grep "including /etc/logrotate.d"
>> $LTPTMP/tst_logrotate.out \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 > $LTPTMP/tst_logrotate.err =
2>&1 || RC=3D$?
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 grep "reading config file $LTPTMP/tst_logrot=
ate.conf" \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $LTPTMP/tst_logrotate.out =
=A0 >
>> $LTPTMP/tst_logrotate.err 2>&1 || RC=3D$?
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The problem statement isn't clearly worded, thus I'm confused whether
or not the patch is fixing a symptom or the root cause itself.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

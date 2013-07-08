Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1Uw15w-0004Fn-TT
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 02:22:28 +0000
Received: from mail-wi0-f170.google.com ([209.85.212.170])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uw15t-0005sl-9G
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 02:22:28 +0000
Received: by mail-wi0-f170.google.com with SMTP id ey16so9581677wid.3
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Jul 2013 19:22:19 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 8 Jul 2013 10:22:19 +0800
Message-ID: <CAPwn2JQ6bZtXkmvY-73U8njMHJ-LWeJyd9qqmbwuV8p7oqsJaQ@mail.gmail.com>
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH]xinetd/xinetd_tests.sh:disable the IPV6 localhost
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Cc: LTP List <ltp-list@lists.sourceforge.net>

2013/7/6 Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>:
> I'm so sorry for the previous email.
> The telnet on my test environment points to /usr/kerberos/bin/telnet, not
> the same as /usr/bin/telnet on Fedora 19.
> I will modify the telnet command in xinetd_test.sh to /usr/bin/telnet, and
> remove the "Unable to " line.
> I also want to add the IPv6 test for xinetd separately.

Good.

+ list

>
> Thank
> you for your help
> ,
>
> Lingyun Xie
>
>
> 2013/7/5 Hangbin Liu <liuhangbin@gmail.com>
>>
>> If you cloned the ltp repo with git, you can use git reset --hard
>> $commit_id to the latest commit. If you download the tar ball, then
>> just download a new one.
>>
>> 2013/7/5 Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>:
>> > Sorry, I didn't test the telnet command in latest version.
>> > The "Unable to connect to remote host" line comes out in previous
>> > version.
>> > Is there any better way to fix the test script?
>> >
>> >
>> >
>> > Thanks,
>> > Lingyun Xie
>> >
>> >
>> > 2013/7/5 Hangbin Liu <liuhangbin@gmail.com>
>> >>
>> >> 2013/7/4 Caspar Zhang <caspar@casparzhang.com>:
>> >> > Hangbin, have you executed such tests before, and/or met any ipv4/v6
>> >> > issue?
>> >> >
>> >> > Thanks,
>> >> > Caspar
>> >> >
>> >> >
>> >> >
>> >> > On 07/04/2013 09:30 PM, Xie Lingyun wrote:
>> >> >>
>> >> >> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
>> >> >> 127.0.0.1.
>> >> >> The first one makes the command output different from the expected
>> >> >> result.
>> >> >>
>> >> >>
>> >> >> Thanks,
>> >> >> Lingyun Xie
>> >> >>
>> >> >> 0001-xinetd-xinetd_tests.sh-disable-the-IPV6-localhost.patch
>> >> >>
>> >> >>
>> >> >>  From 75c79721c095cce27548e74260c1e42681e1a267 Mon Sep 17 00:00:00
>> >> >> 2001
>> >> >> From: mellonwand<mellonwand@gmail.com>
>> >> >> Date: Thu, 4 Jul 2013 16:42:42 +0800
>> >> >> Subject: [PATCH] xinetd/xinetd_tests.sh:disable the IPV6 localhost
>> >> >>
>> >> >> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
>> >> >> 127.0.0.1. The first one makes the command's output different from
>> >> >> the
>> >> >> expected output.
>> >> >>
>> >> >> Signed-off-by: Xie Lingyun<lingyun.xie@bj.cs2c.com.cn>
>> >> >> ---
>> >> >>   testcases/network/xinetd/xinetd_tests.sh | 5 +++--
>> >> >>   1 file changed, 3 insertions(+), 2 deletions(-)
>> >> >>
>> >> >> diff --git a/testcases/network/xinetd/xinetd_tests.sh
>> >> >> b/testcases/network/xinetd/xinetd_tests.sh
>> >> >> index 83eb8a7..d2c851d 100755
>> >> >> --- a/testcases/network/xinetd/xinetd_tests.sh
>> >> >> +++ b/testcases/network/xinetd/xinetd_tests.sh
>> >> >> @@ -128,6 +128,7 @@ init()
>> >> >>
>> >> >>       # Create expected file with telnet disabled.
>> >> >>       cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
>> >> >> +       telnet: connect to address 127.0.0.1: Connection refused
>> >> >>         telnet: Unable to connect to remote host: Connection refused
>> >>
>> >> Here we should remove the "Unable to connectto remote host" line
>> >>
>> >> >>         EOF
>> >> >>
>> >> >> @@ -263,7 +264,7 @@ test01()
>> >> >>
>> >> >>         # Not checking for exit code from telnet command because
>> >> >> telnet
>> >> >> is
>> >> >>         # not terminated by the test gracefully.
>> >> >> -       echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out
>> >> >> 1>/dev/null
>> >> >> +       echo " " | telnet 127.0.0.1 2>$LTPTMP/tst_xinetd.out
>> >> >> 1>/dev/null
>> >> >>         diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
>> >> >>                 > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>> >> >>       if [ $RC -ne 0 ]
>> >> >> @@ -312,7 +313,7 @@ test01()
>> >> >>
>> >> >>         # Not checking for exit code from telnet command because
>> >> >> telnet
>> >> >> is
>> >> >>         # not terminated by the test gracefully.
>> >> >> -       echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
>> >> >> +       echo " " | telnet 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
>> >> >>
>> >> >>         diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
>> >> >>                 > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>> >> >> -- 1.8.3.1
>> >> >>
>> >> >
>> >>
>> >>
>> >
>>
>>
>

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

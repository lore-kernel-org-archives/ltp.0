Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1UuwWK-0008BO-F6
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 03:17:16 +0000
Received: from mail-wi0-f174.google.com ([209.85.212.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UuwWI-0005ap-A5
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 03:17:16 +0000
Received: by mail-wi0-f174.google.com with SMTP id k10so6790155wiv.13
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Jul 2013 20:17:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51D58003.1020500@casparzhang.com>
References: <CALGiYOH4uhAoPgEQ+-p889GbjTazpXkyXabXs021xdmOTbYkoA@mail.gmail.com>
	<51D58003.1020500@casparzhang.com>
Date: Fri, 5 Jul 2013 11:17:08 +0800
Message-ID: <CAPwn2JTpq-rVATF-_jk3Avok8KXd9x4M-Xse7J2txDhVEFaAkg@mail.gmail.com>
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

2013/7/4 Caspar Zhang <caspar@casparzhang.com>:
> Hangbin, have you executed such tests before, and/or met any ipv4/v6 issue?
>
> Thanks,
> Caspar
>
>
>
> On 07/04/2013 09:30 PM, Xie Lingyun wrote:
>>
>> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
>> 127.0.0.1.
>> The first one makes the command output different from the expected result.
>>
>>
>> Thanks,
>> Lingyun Xie
>>
>> 0001-xinetd-xinetd_tests.sh-disable-the-IPV6-localhost.patch
>>
>>
>>  From 75c79721c095cce27548e74260c1e42681e1a267 Mon Sep 17 00:00:00 2001
>> From: mellonwand<mellonwand@gmail.com>
>> Date: Thu, 4 Jul 2013 16:42:42 +0800
>> Subject: [PATCH] xinetd/xinetd_tests.sh:disable the IPV6 localhost
>>
>> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
>> 127.0.0.1. The first one makes the command's output different from the
>> expected output.
>>
>> Signed-off-by: Xie Lingyun<lingyun.xie@bj.cs2c.com.cn>
>> ---
>>   testcases/network/xinetd/xinetd_tests.sh | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/network/xinetd/xinetd_tests.sh
>> b/testcases/network/xinetd/xinetd_tests.sh
>> index 83eb8a7..d2c851d 100755
>> --- a/testcases/network/xinetd/xinetd_tests.sh
>> +++ b/testcases/network/xinetd/xinetd_tests.sh
>> @@ -128,6 +128,7 @@ init()
>>
>>       # Create expected file with telnet disabled.
>>       cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
>> +       telnet: connect to address 127.0.0.1: Connection refused
>>         telnet: Unable to connect to remote host: Connection refused

Here we should remove the "Unable to connectto remote host" line

>>         EOF
>>
>> @@ -263,7 +264,7 @@ test01()
>>
>>         # Not checking for exit code from telnet command because telnet is
>>         # not terminated by the test gracefully.
>> -       echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>> +       echo " " | telnet 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>>         diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
>>                 > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>>       if [ $RC -ne 0 ]
>> @@ -312,7 +313,7 @@ test01()
>>
>>         # Not checking for exit code from telnet command because telnet is
>>         # not terminated by the test gracefully.
>> -       echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
>> +       echo " " | telnet 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
>>
>>         diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
>>                 > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>> -- 1.8.3.1
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

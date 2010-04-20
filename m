Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O47Bz-0001kz-4t
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:44:19 +0000
Received: from mail-iw0-f183.google.com ([209.85.223.183])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O47Bw-0003IH-WB
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:44:19 +0000
Received: by iwn13 with SMTP id 13so4119635iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Apr 2010 23:44:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000601cae050$9f25f1b0$dd71d510$@co.jp>
References: <000601cae050$9f25f1b0$dd71d510$@co.jp>
Date: Mon, 19 Apr 2010 23:44:08 -0700
Message-ID: <w2w364299f41004192344l524ea939z95e529cbcdeeba72@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "su01" test
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Mon, Apr 19, 2010 at 11:13 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I ran "su01" test.
> This test failed:
> ------------<log>
> userdel: user su_usr1 does not exist
> Creating mailbox file: File exists
> userdel: user su_usr2 does not exist
> Creating mailbox file: File exists
> YOU NEED TO SET ENVIROMENT VARIABLE PASSWD.
> ------------
>
> This failure was caused by "PASSWD" environment variable not being set:
> ------------<su01_s1>
> #Grab input from enviroment
> if [info exists env(PASSWD)] {
> =A0 =A0 =A0 =A0set PASSWD $env(PASSWD)
> } else {
> =A0 =A0 =A0 =A0send_user "YOU NEED TO SET ENVIROMENT VARIABLE PASSWD. \n"
> =A0 =A0 =A0 =A0exit 1
> }
> ------------
>
> According to "su01_s1", this "PASSWD" is the password of "root" user:
> ------------<su01_s1>
> spawn /bin/su -c whoami
> set i_am_root 0
> expect {
> =A0"Password:" {
> =A0 =A0 =A0 =A0send "$PASSWD\r"
> =A0 =A0expect {
> =A0 =A0 =A0"root" { set i_am_root 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set i_can_root 1
> =A0 =A0 =A0 =A0 }
> =A0 =A0}
> =A0}
> }
> ------------
>
> I think whether this test program is unfinished.
> Probably the author of this program thought that there was a problem
> to set a password in the shell, I think.
> Because, the password of root is various by each users who run the test,
> and it cannot be gotten from environment variable or file etc.
>
> So, I suggest that "su01" shell demands root password when it is run.
> But, when user forgot to input, it should return and finish with error.
>
>
> I attach the patch for "su01" file.

    I don't agree; this item is already mentioned in INSTALL (but I
think that it should probably be moved to a README file or
something... INSTALL doesn't seem intuitive) for another set of tests:

    iv) Finally, before running the networktests.sh script, two variables m=
ust
        be set within the script file.  The "RHOST" variable should be set =
to
        the hostname of the server.  The "PASSWD" variable should be set to
        root's password on the server machine.  This is necessary for tests
        such as telnet01 and ftp01.

    All of the applications which require $PASSWD need to be
documented though as this is far from intuitive.
Thanks,
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

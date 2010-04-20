Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O47Qq-0007AJ-GO
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:59:40 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O47Ql-0007Fp-Pa
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:59:40 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000601cae050$9f25f1b0$dd71d510$@co.jp>	
	<w2w364299f41004192344l524ea939z95e529cbcdeeba72@mail.gmail.com>
	<v2q364299f41004192345l7f5f119bva09c150d69428182@mail.gmail.com>
In-Reply-To: <v2q364299f41004192345l7f5f119bva09c150d69428182@mail.gmail.com>
Date: Tue, 20 Apr 2010 15:59:26 +0900
Message-ID: <000001cae057$042683d0$0c738b70$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Sorry.

I understand.
I was careless.


Thank you--

-Tomonori Mitani

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, April 20, 2010 3:46 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net; kamimura@ryobi.co.jp
> Subject: Re: [LTP] [PATCH] fix "su01" test
> =

> On Mon, Apr 19, 2010 at 11:44 PM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> > On Mon, Apr 19, 2010 at 11:13 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> Hi,
> >>
> >> I ran "su01" test.
> >> This test failed:
> >> ------------<log>
> >> userdel: user su_usr1 does not exist
> >> Creating mailbox file: File exists
> >> userdel: user su_usr2 does not exist
> >> Creating mailbox file: File exists
> >> YOU NEED TO SET ENVIROMENT VARIABLE PASSWD.
> >> ------------
> >>
> >> This failure was caused by "PASSWD" environment variable not being
> set:
> >> ------------<su01_s1>
> >> #Grab input from enviroment
> >> if [info exists env(PASSWD)] {
> >> =A0 =A0 =A0 =A0set PASSWD $env(PASSWD)
> >> } else {
> >> =A0 =A0 =A0 =A0send_user "YOU NEED TO SET ENVIROMENT VARIABLE PASSWD. =
\n"
> >> =A0 =A0 =A0 =A0exit 1
> >> }
> >> ------------
> >>
> >> According to "su01_s1", this "PASSWD" is the password of "root"
> user:
> >> ------------<su01_s1>
> >> spawn /bin/su -c whoami
> >> set i_am_root 0
> >> expect {
> >> =A0"Password:" {
> >> =A0 =A0 =A0 =A0send "$PASSWD\r"
> >> =A0 =A0expect {
> >> =A0 =A0 =A0"root" { set i_am_root 1
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set i_can_root 1
> >> =A0 =A0 =A0 =A0 }
> >> =A0 =A0}
> >> =A0}
> >> }
> >> ------------
> >>
> >> I think whether this test program is unfinished.
> >> Probably the author of this program thought that there was a problem
> >> to set a password in the shell, I think.
> >> Because, the password of root is various by each users who run the
> test,
> >> and it cannot be gotten from environment variable or file etc.
> >>
> >> So, I suggest that "su01" shell demands root password when it is
> run.
> >> But, when user forgot to input, it should return and finish with
> error.
> >>
> >>
> >> I attach the patch for "su01" file.
> >
> > =A0 =A0I don't agree; this item is already mentioned in INSTALL (but
> I
> > think that it should probably be moved to a README file or
> > something... INSTALL doesn't seem intuitive) for another set of
> tests:
> >
> > =A0 =A0iv) Finally, before running the networktests.sh script, two
> variables must
> > =A0 =A0 =A0 =A0be set within the script file. =A0The "RHOST" variable s=
hould
> be set to
> > =A0 =A0 =A0 =A0the hostname of the server. =A0The "PASSWD" variable sho=
uld
> be set to
> > =A0 =A0 =A0 =A0root's password on the server machine. =A0This is necess=
ary
> for tests
> > =A0 =A0 =A0 =A0such as telnet01 and ftp01.
> >
> > =A0 =A0All of the applications which require $PASSWD need to be
> > documented though as this is far from intuitive.
> =

>     Also, what you're suggesting would fix _interactive_ tests, not
> _non-interactive_ tests, where the majority of all users should *not*
> be running LTP interactively -- thus I don't think that it's a
> worthwhile addition (sorry :(...).
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

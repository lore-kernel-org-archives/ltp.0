Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O1yw1-0008O1-8b
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 09:31:01 +0000
Received: from mail-gx0-f213.google.com ([209.85.217.213])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O1yw0-000380-Ec
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 09:31:01 +0000
Received: by gxk5 with SMTP id 5so3055662gxk.6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Apr 2010 02:30:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
References: <000001cadad6$c061c590$412550b0$@co.jp>
	<4BC487C9.9080300@xenotime.net>
	<000901cadb78$a2d05080$e870f180$@co.jp>
	<g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>
	<000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
Date: Wed, 14 Apr 2010 02:30:54 -0700
Message-ID: <p2y364299f41004140230u4e312ea7y7623fce2dbfd0ba6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
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
Cc: ltp-list@lists.sourceforge.net

On Wed, Apr 14, 2010 at 1:58 AM, Mitani <mitani@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Wednesday, April 14, 2010 3:18 PM
>> To: Mitani
>> Cc: Randy Dunlap; ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
>>
>> On Tue, Apr 13, 2010 at 7:17 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> > Hi Randy,
>> >
>> > I couldn't notice a misspelling. Sorry.
>> > I decided to use "due to" according to your advice.
>> >
>> > May I suggest revised patch?
>> >
> [...]
>> >
>> > Thank you--
>> >
>> > -Tomonori Mitani
>> >
>> >
>> >> -----Original Message-----
>> >> From: Randy Dunlap [mailto:rdunlap@xenotime.net]
>> >> Sent: Wednesday, April 14, 2010 12:04 AM
>> >> To: Mitani
>> >> Cc: ltp-list@lists.sourceforge.net
>> >> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
>> >>
>> >> On 04/12/10 23:58, Mitani wrote:
>> >> > ------------
>> >> > =A0a) All tests:
>> >> > "TBROK =A0: =A0Test cannot be continued owning to sufficient
>> >> availability of
>> >> > Hugepages on the system"
>> >> >
>> >> > =A0b) 2), 3), 5), 6), 8), 10), 11) tests:
>> >> > "TWARN =A0: =A0tst_rmdir(): TESTDIR was NULL; no removal attempted"
>> >> > ------------
>> >> >
>> >> > Both case a) and case b) are caused by the same reason.
>> >> >
>> >> > All of case a) failures occured at the following points (for
>> example
>> >> > hugemmap04):
>> >> > ------------<hugemmap04.c - main()>
>> >> > =A0 =A0 =A0 =A0 /* Check number of hugepages */
>> >> > =A0 =A0 =A0 =A0 if (get_no_of_hugepages() <=3D 0 || hugepages_size(=
) <=3D
>> 0)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "Test cann=
ot be
>> continued
>> >> owning to
>> >> > \
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suf=
ficient availability of
>> >> Hugepages on the
>> >> > system");
>> >> > ------------
>> >> >
>> >> > I found out that "HugePages_Total" parameter of "/proc/meminfo"
>> file
>> >> > is set to "0". This caused above TBROK failure. It is environment
>> >> problem.
>> >> >
>> >> > But, in this case, tests must not return with TBROK, but with TCONF,
>> >> > I think.
>> >>
>> >> That makes sense to me.
>> >>
>> >> > And, in case b), these tests try to delete "TESTDIR" directory
>> by
>> >> > calling "tst_rmdir()" function in "cleanup()" function.
>> >> > But, "TESTDIR" never set if "tst_tmpdir()" function isn't called.
>> >> > I think that case b)'s tests must not call cleanup() function.
>> >> >
>> >> >
>> >> > I want to suggest following patch.
>> >> >
>> >> > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

    Sorry to ask again, but Gmail always mangles patches. Could you
please attach it as a file?
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

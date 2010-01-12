Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUk2f-0001EB-9A
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 16:56:29 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUk2e-0007FC-4x
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 16:56:29 +0000
Received: by pzk31 with SMTP id 31so1187127pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 08:56:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100112153827.GB7975@us.ibm.com>
References: <1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com>
	<364299f41001120029x15b2e7adwe30d925717a1dc89@mail.gmail.com>
	<20100112153827.GB7975@us.ibm.com>
Date: Tue, 12 Jan 2010 08:56:22 -0800
Message-ID: <364299f41001120856k2e1e4d71g7b7949f8b3e6ba98@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] regression: selinux testsuite broken since October
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

On Tue, Jan 12, 2010 at 7:38 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
>> On Mon, Jan 11, 2010 at 1:00 PM, Serge E. Hallyn <serue@us.ibm.com> wrot=
e:
>> > Quoting Serge E. Hallyn (serue@us.ibm.com):
>> >> Quoting Serge E. Hallyn (serue@us.ibm.com):
>> >> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> >> > > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
>> >> > > > > Fails with:
>> >> > > > > cp: cannot stat
>> >> > > > > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/re=
fpolicy/policy_files/generic/test_policy.*': No such file or directory
>> >> > > >
>> >> > > > You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
>> >> > > >
>> >> > > > I think we are supposed to actually be running
>> >> > > > /opt/ltp/testscripts/test_selinux.sh. =A0So then the first ques=
tion for
>> >> > > > Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR fr=
om a
>> >> > > > testscript? =A0Or should the policy sources be copied into /opt?
>> >> > >
>> >> > > Ok, but regardless: =A0the refpolicy Makefile is still broken.
>> >> >
>> >> > Yup.
>> >>
>> >> All right, baby-steps.
>> >>
>> >> The attached test_selinux.diff is not to be applied, but something
>> >> like it is needed. =A0Should we have the ltp 'make install' fill in
>> >> TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh? =A0BTW, Garrett,
>> >> that is the issue I was saying is shared between test_selinux.sh
>> >> and some others including test_robind.sh. =A0That's why I'm not just
>> >> sending a patch to make it work, bc i think we need more general
>> >> guidance.
>> >>
>> >> The second match makes the 'make load' part of test_selinux.sh
>> >> succeed on rhel5.4. =A0Stephen, how does it do on fedora?
>> >>
>> >> After loading policy it fails to execute ltp-pan, but I figure let's
>> >> get policy loading working first.
>> >>
>> >> -serge
>> >
>> > gah, attaching the actual patches this time.
>> >
>> > -serge
>>
>> 1. I'm rejecting the test_selinux.diff solely because it has /root/ltp
>> hardcoded as LTPROOT.
>
> I said 'not to be applied'. =A0You're not rejecting.
>
>> 2. Why is the redhat stuff support to work
>> agnostic to the major and minor version?
>
> It's not agnostic to the major version. =A0Only the minor version.
>
> And since you've made ltp not compile on rhel4 (requiring make-3.81. =A0f=
eh)
> i suppose we can just get rid of rhel4 support selinux-testsuite.
>
> Or pull it out altogether.

Ok... sorry for the misunderstanding (looks around sheepishly :\).
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUc7l-0000Rl-IA
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 08:29:13 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUc7k-0000A6-Lb
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 08:29:13 +0000
Received: by pzk31 with SMTP id 31so908085pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 00:29:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100111210006.GA26554@us.ibm.com>
References: <1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
	<1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081408sf9d740ew55dad7b542463416@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com>
Date: Tue, 12 Jan 2010 00:29:06 -0800
Message-ID: <364299f41001120029x15b2e7adwe30d925717a1dc89@mail.gmail.com>
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

On Mon, Jan 11, 2010 at 1:00 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Serge E. Hallyn (serue@us.ibm.com):
>> Quoting Serge E. Hallyn (serue@us.ibm.com):
>> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> > > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
>> > > > > Fails with:
>> > > > > cp: cannot stat
>> > > > > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpo=
licy/policy_files/generic/test_policy.*': No such file or directory
>> > > >
>> > > > You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
>> > > >
>> > > > I think we are supposed to actually be running
>> > > > /opt/ltp/testscripts/test_selinux.sh. =A0So then the first questio=
n for
>> > > > Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
>> > > > testscript? =A0Or should the policy sources be copied into /opt?
>> > >
>> > > Ok, but regardless: =A0the refpolicy Makefile is still broken.
>> >
>> > Yup.
>>
>> All right, baby-steps.
>>
>> The attached test_selinux.diff is not to be applied, but something
>> like it is needed. =A0Should we have the ltp 'make install' fill in
>> TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh? =A0BTW, Garrett,
>> that is the issue I was saying is shared between test_selinux.sh
>> and some others including test_robind.sh. =A0That's why I'm not just
>> sending a patch to make it work, bc i think we need more general
>> guidance.
>>
>> The second match makes the 'make load' part of test_selinux.sh
>> succeed on rhel5.4. =A0Stephen, how does it do on fedora?
>>
>> After loading policy it fails to execute ltp-pan, but I figure let's
>> get policy loading working first.
>>
>> -serge
>
> gah, attaching the actual patches this time.
>
> -serge

1. I'm rejecting the test_selinux.diff solely because it has /root/ltp
hardcoded as LTPROOT. 2. Why is the redhat stuff support to work
agnostic to the major and minor version?
Thanks,
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

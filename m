Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSoJa-0003qj-KG
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:05:58 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSoJZ-0005ph-QG
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:05:58 +0000
Received: by pxi38 with SMTP id 38so7272483pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Jan 2010 01:05:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100106185837.GA20097@us.ibm.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
	<20100106185837.GA20097@us.ibm.com>
Date: Thu, 7 Jan 2010 01:05:51 -0800
Message-ID: <364299f41001070105p3bf32bbdwff0edf9315c333da@mail.gmail.com>
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

On Wed, Jan 6, 2010 at 10:58 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> It seems the Makefile rewrite last October broke the selinux testsuite.
>> Is it unreasonable to expect that someone who rewrote the Makefile would
>> actually try running the testsuite?
>>
>> Please, revert the changes or fix them.
>>
>> See testcases/kernel/security/selinux-testsuite/README for the
>> instructions.
>
> Ok, Garrett, two particular scripts that are broken since the move
> to running out of /opt/ltp are
> =A0 =A0 =A0 =A0test_robind.sh
> =A0 =A0 =A0 =A0test_selinux.sh
>
> Guidance?

    I need output in order to judge what needs to be fixed. Gentoo
doesn't have a selinux policy package (at least not in portage), thus
I cannot run the tests as they're Redhat centric.
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

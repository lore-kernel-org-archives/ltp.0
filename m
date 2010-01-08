Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NTMY1-0006CQ-IP
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 21:39:09 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NTMXx-0001k8-Lg
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 21:39:09 +0000
Received: by pxi38 with SMTP id 38so8453152pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Jan 2010 13:39:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
	<20100106185019.GA19647@us.ibm.com>
	<1262893258.2821.50.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081020r7ee941f4w1b91bcb79849b406@mail.gmail.com>
	<1262976343.20881.4.camel@moss-pluto.epoch.ncsc.mil>
	<1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 8 Jan 2010 13:38:59 -0800
Message-ID: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Fri, Jan 8, 2010 at 10:50 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2010-01-08 at 13:47 -0500, Stephen Smalley wrote:
>> On Fri, 2010-01-08 at 10:20 -0800, Garrett Cooper wrote:
>> > =A0 =A0 Thanks for the feedback and details Stephen.
>> > =A0 =A0 Would you be kind enough to try out the version from CVS to see
>> > whether or not it resolves your issue? You'll also need to update
>> > $LTPROOT/scripts in order to use the new version as I added a distro
>> > detection script which opens up /etc/redhat-release (for redhat) as
>> > opposed to using rpm to query the release.
>> > Thanks,
>> > -Garrett
>>
>> The attempt to make the test policy immediately dies with:
>> detect_distro.sh: ERROR: Bad release file: /etc/redhat-release
>
> I should note that I'm running it on Fedora, so I wouldn't expect that
> file to exist. =A0But the script needs to handle it gracefully; we just
> use the generic test policy files in that situation.

    What does /etc/redhat-release look like (feel free to reply to me off-l=
ist)?
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

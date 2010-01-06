Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSP6T-00083u-C5
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 06:10:45 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSP6S-0007uk-F4
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 06:10:45 +0000
Received: by pxi38 with SMTP id 38so6223619pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 22:10:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F8523418-52E0-4EEE-BEF3-FE159EAF6D56@gmail.com>
References: <20100104004355.GA760@us.ibm.com>
	<51111C51-DD4E-44E6-B093-3B3FC0DEE8C5@gmail.com>
	<20100104153843.GA25671@us.ibm.com>
	<F8523418-52E0-4EEE-BEF3-FE159EAF6D56@gmail.com>
Date: Tue, 5 Jan 2010 22:10:38 -0800
Message-ID: <364299f41001052210o6b4f9d2ewe5e98cd6a67e3cea@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH ltp] p9auth: add missing checkp9auth.sh script
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Mon, Jan 4, 2010 at 3:34 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> Sent from my iPhone
>
> On Jan 4, 2010, at 7:38 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
>
>> Quoting Garrett Cooper (yanegomi@gmail.com):
>>>
>>> Hi Serge,
>>> =A0 When do this script need to be run? Before compiling or before /
>>> while running?
>>> -Garrett
>>
>> Hi,
>>
>> Either could do, but there's reason to do it at both. =A0It doesn't need=
 to
>> be
>> run before each test, but has to load the module and set up devices after
>> each
>> boot. =A0So I originally had it both in the makefile, as a condition for
>> doing
>> the compilation (and especially installation), as well as before the tes=
t,
>> in
>> case the system was rebooted after compilation and before running.
>>
>> -serge
>
> Ok, that's why I yanked it. Here's what we should do then:
>
> 1. Take code required for compile and put it in an autoconf test.
> 2. Take code required for execution (loading modules, etc) and move it in=
to
> a separate script.
> 3. Take all sourceable code and move it into a separate script that gets
> sourced in both places.
>
> I'll add it back into the repo when I get back tomorrow, but we need to g=
et
> a proper plan as far as how we are going to enable / disable features and
> tests that require interpreters, special system configs, etc.

File revived.
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

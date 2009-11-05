Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5xuE-0001k0-A3
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 08:41:22 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5xu7-0008K1-Uq
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 08:41:22 +0000
Received: by pzk26 with SMTP id 26so5310139pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 05 Nov 2009 00:41:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF2EC662FD.A8CC841C-ON85257665.00084CCC-85257665.00097DBB@us.ibm.com>
References: <mailman.103093.1257283106.5825.ltp-list@lists.sourceforge.net>
	<OFB7192512.13ED74E7-ON85257664.001981A6-85257664.001F3BB6@us.ibm.com>
	<364299f40911032158s4356a90bkf06686f7aea01b87@mail.gmail.com>
	<OF2EC662FD.A8CC841C-ON85257665.00084CCC-85257665.00097DBB@us.ibm.com>
Date: Thu, 5 Nov 2009 00:41:10 -0800
Message-ID: <364299f40911050041u79d0fe11j17ed2e8e3c73adc9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build Fails on some archs
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
To: Mark Ver <markver@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Nov 4, 2009 at 5:43 PM, Mark Ver <markver@us.ibm.com> wrote:
>>> On SLES-10 SP3, the make attempt gets nowhere ...
>>> h91distr02:~/ltp-full-20091031 # make all
>>> make: *** No rule to make target `/$*', needed by `pan-all'. =A0Stop.
>>> h91distr02:~/ltp-full-20091031 #
>
>>> ...
>>> On RHEL5.4 and SLES-11 am getting build problem with the controllers
>>> subdirs, =A0ex:
>>> ...
>>
>> =A0 =A0 Someone else reported similar recently. Can you please tell us
>> what version of Gnu make you're using?
>
> SLES-10 SP3: =A0make-3.80-202.2

I just talked with SimonXu on #ltp, and he ran into the same issue, so
I added some additional sections to describe the problem in the
INSTALL file.

> As for the ones failing on the controllers/cgroup stuff:
>
> SLES-11: make-3.81-128.20
> RHEL5.4: make-3.81-3.el5

I'll take a look at that.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

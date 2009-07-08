Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mbligh@google.com>) id 1MOZ34-0003x0-5j
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 15:27:06 +0000
Received: from smtp-out.google.com ([216.239.45.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOZ2y-0000vk-57
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 15:27:06 +0000
MIME-Version: 1.0
In-Reply-To: <1247048369.5405.35.camel@subratamodak.linux.ibm.com>
References: <a50cf5ab0907052240xf22b2b2rf7b90cc819d0ee87@mail.gmail.com>
	<1246863519.2865.18.camel@localhost.localdomain>
	<33307c790907061137h3da12536q47517b1662498793@mail.gmail.com>
	<a50cf5ab0907070024g2b1519acudd0d1a6a21c630ea@mail.gmail.com>
	<33307c790907071045v72e19614i571c36ad8af8062c@mail.gmail.com>
	<1247048369.5405.35.camel@subratamodak.linux.ibm.com>
Date: Wed, 8 Jul 2009 08:05:33 -0700
Message-ID: <33307c790907080805r78016b3cl21b065e2a0d50c3b@mail.gmail.com>
From: Martin Bligh <mbligh@google.com>
Subject: Re: [LTP] [PATCH 1/2] Add latest LTP test in autotest
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>, kvm-devel <kvm@vger.kernel.org>, Lucas Meneghel Rodrigues <mrodrigu@redhat.com>, Autotest mailing list <autotest@test.kernel.org>, Uri Lublin <uril@redhat.com>, sudhir kumar <smalikphy@gmail.com>

>> Yup, we can pass an excluded test list. I really wish they'd fix their
>> tests, but I've been saying that for 6 years now, and it hasn't happened
>> yet ;-(
>
> I would slightly disagree to that. 6 years is history. But, have you
> recently checked with LTP ?

I hate to be completely cynical about this, but that's exactly the same
message I get every year.

Yes, absolute, the best thing would be for someone to run all the tests,
work through all the problems, categorize them as kernel / library / distro,
and get each of them fixed. However, it's a fair chunk of work that I don't
have time to do.

So all I'm saying is that I know which of the current tests we have issues
with, and I don't want to upgrade LTP without a new set of data, and that
work being done. From previous experience, I would be extremely
surprised if there's not at least one new problem, and I'm not just going
to dump that on users.

Does the LTP project do this itself on a regular basis ... ie are you running
LTP against the latest kernel (or even some known stable kernel) and
seeing which tests are broken? If you can point me to that, I'd have much
more faith about picking this up ...

Up until this point we've not even managed to agree that PASS means
"ran as expected" and FAIL meant "something is wrong". LTP always
had "expected failures" which seems like a completely broken model
to me.

M.

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

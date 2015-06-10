Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2fNh-0008Mw-Bw
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 12:45:21 +0000
Date: Wed, 10 Jun 2015 14:44:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150610124415.GB31980@rei.suse.de>
References: <CAHNg1Sr60LoroQxr7mLw9jA-USA8bca7VNLed0=YPVM0NdLKfw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHNg1Sr60LoroQxr7mLw9jA-USA8bca7VNLed0=YPVM0NdLKfw@mail.gmail.com>
Subject: Re: [LTP] Advantages of LTP over Autotest
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
To: Pratik Prajapati <pratik.prajapati12@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I have to select a test framework for kernel and peripheral testing. I
> found two frameworks LTP and Autotest.
> Autotest has provided advantage over LTP in its documentation.

You are comparing apples and oranges.

LTP is just a testsuite, it runs tests and generates results nothing
more nothing less.

If you are looking for something that builds, installs, boots and tests
new kernel automatically you have to look elsewhere.

This may be solved by LKP[1], for example, that can run LTP tests as
well. Or you can create your own solution based on somethign that can
automatically install machines like Jenkins[2].

[1] https://github.com/gaowanlong/lkp-tests
[2] https://wiki.jenkins-ci.org/display/JENKINS/Meet+Jenkins

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ns40A-0005Ie-2C
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 00:54:18 +0000
Received: from mail-iw0-f175.google.com ([209.85.223.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ns408-0001v0-QE
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 00:54:18 +0000
Received: by iwn5 with SMTP id 5so1102648iwn.24
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Mar 2010 17:54:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b9d696241003171721w10512579waabdc19c253218ae@mail.gmail.com>
References: <b9d696241003171721w10512579waabdc19c253218ae@mail.gmail.com>
Date: Wed, 17 Mar 2010 17:54:10 -0700
Message-ID: <364299f41003171754m6440053ek5e1439e0e029c6cb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Compiling and running on ARM
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Wed, Mar 17, 2010 at 5:21 PM, K.D. Lucas <kdlucas@gmail.com> wrote:
> Does anyone compile and run the suite of LTP test for ARM devices?

Yes, several people in the past have, and there are some organizations
that run LTP on smartphones (like WindRiver via the Limo project), and
many smartphones have ARM processors. Several people have run LTP on
Android too (I think...).

> If so, do
> you run all of the tests or some subset of them? I'm guessing some or most
> of the code will compile on ARM, but maybe not all of it.

Everything should compile on ARM if the toolchain's sane, but not all
tests are ARM compatible; please submit reports as you find them so we
can help end the endless `LTP doesn't build on my version of Linux'
build issue saga...

Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

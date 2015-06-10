Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maxin.john@gmail.com>) id 1Z2eOb-0000wG-Nc
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 11:42:13 +0000
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2eOa-0004JP-ND
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 11:42:13 +0000
Received: by wibut5 with SMTP id ut5so45488964wib.1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Jun 2015 04:42:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNg1Sr60LoroQxr7mLw9jA-USA8bca7VNLed0=YPVM0NdLKfw@mail.gmail.com>
References: <CAHNg1Sr60LoroQxr7mLw9jA-USA8bca7VNLed0=YPVM0NdLKfw@mail.gmail.com>
Date: Wed, 10 Jun 2015 13:42:06 +0200
Message-ID: <CAMhs6YxXL3x3WuWFn9DfSiL0buveRx=ZTrSemUkVL6j4Qbzwug@mail.gmail.com>
From: "Maxin B. John" <maxin.john@gmail.com>
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Pratik,

On Wed, Jun 10, 2015 at 1:04 PM, Pratik Prajapati
<pratik.prajapati12@gmail.com> wrote:
> Hi,
>
> I have to select a test framework for kernel and peripheral testing. I found
> two frameworks LTP and Autotest.
> Autotest has provided advantage over LTP in its documentation.
>
> "LTP (http://ltp.sourceforge.net/) The Linux Test Project is a functional /
> regression test suite. It contains approximately 2900 small regression tests
> which are applied to the system running LTP. There is no support for
> building kernels or booting them, performance testing or profiling. Whilst
> it contains a lot of useful tests, it is not a general heavy weight testing
> client."
>
> I haven't find any advantage of LTP over Autotest on your documentation or
> on google.

AFAIK, autotest just uses LTP as one of the client tests. So, a one to one
comparison doesn't make much sense, IMHO.

> So Is there any advantage of LTP over Autotest ?
> Regards,
> Pratik

Best Regards,
Maxin

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

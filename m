Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1XAVgb-0007Yy-Kb
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 02:56:45 +0000
Received: from mail-pd0-f180.google.com ([209.85.192.180])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XAVga-00057u-FV
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 02:56:45 +0000
Received: by mail-pd0-f180.google.com with SMTP id y13so4840800pdi.39
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Jul 2014 19:56:38 -0700 (PDT)
Message-ID: <53D1C7A3.2060002@casparzhang.com>
Date: Fri, 25 Jul 2014 10:57:39 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <239904743.14759248.1406204300232.JavaMail.zimbra@redhat.com>
In-Reply-To: <239904743.14759248.1406204300232.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] cpuset01 -I 3600
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
To: Jan Stancek <jstancek@redhat.com>, ltp-list <ltp-list@lists.sourceforge.net>
Cc: CAI Qian <caiqian@redhat.com>

On 07/24/2014 08:18 PM, Jan Stancek wrote:
> Hi,
>
> is it necessary for this reproducer to run for an hour?
>
> Would anyone object if it's moved to some stress runtest?
> Or we can keep it also in mm, but with some smaller runtime, say 5 minutes.
>
> Any thoughts?

This case was originally designed to test regression of this bug: 
http://lkml.org/lkml/2010/5/4/77 and from the link we can see the bug 
was not easy to reproduce.

Agreed to move to stress runtest.

Thanks,
Caspar

>
> Regards,
> Jan

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

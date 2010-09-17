Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eramoto.masaya@jp.fujitsu.com>) id 1OwUPe-0001dw-Dx
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 06:27:10 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwUPc-00041y-OK
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 06:27:10 +0000
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o8H6R100004727 for <ltp-list@lists.sourceforge.net> (envelope-from
	eramoto.masaya@jp.fujitsu.com); Fri, 17 Sep 2010 15:27:01 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 076D145DE4F
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 15:27:01 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id D5C5345DE51
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 15:27:00 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id C1AD2E18003
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 15:27:00 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 75006E38001
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 15:27:00 +0900 (JST)
Received: from ml13.css.fujitsu.com (ml13 [127.0.0.1])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id 4D85FFD0002
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 15:27:00 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.124.101.175])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id EC904FD0001
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 15:26:59 +0900 (JST)
Message-ID: <4C930A2F.1000007@jp.fujitsu.com>
Date: Fri, 17 Sep 2010 15:26:55 +0900
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
MIME-Version: 1.0
References: <4C92EBBE.8090108@jp.fujitsu.com>
	<AANLkTin9tmLMZQyvBh898Z7pYAAn_BzVZEYkGZjCJNv-@mail.gmail.com>
In-Reply-To: <AANLkTin9tmLMZQyvBh898Z7pYAAn_BzVZEYkGZjCJNv-@mail.gmail.com>
Subject: Re: [LTP] Fix warning at cpuset_syscall_test.c
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hi Garrett,

> 1. Negative return values from main are bad.
> 2. 0 would be better, otherwise it's going to cause more churn on the
> list because people without the support are going to start asking the
> question: "why is this testcase failing"?
>
> I'll implement return 0 instead.

I ACK it.

Thanks you for your explanation,
ERAMOTO


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

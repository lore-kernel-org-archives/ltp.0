Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Xj8Po-0000eV-R1
	for ltp-list@lists.sourceforge.net; Tue, 28 Oct 2014 15:10:32 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xj8Pn-0003x2-Az
	for ltp-list@lists.sourceforge.net; Tue, 28 Oct 2014 15:10:32 +0000
Date: Tue, 28 Oct 2014 11:10:23 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <497288326.1163443.1414509023348.JavaMail.zimbra@redhat.com>
In-Reply-To: <1414169252-19374-1-git-send-email-gary.robertson@linaro.org>
References: <90019386.14686839.1414156011036.JavaMail.zimbra@redhat.com>
	<1414169252-19374-1-git-send-email-gary.robertson@linaro.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2] Realtime tests: Fix robust mutex conditionals
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
To: "Gary S. Robertson" <gary.robertson@linaro.org>
Cc: ltp-list@lists.sourceforge.net, mike holmes <mike.holmes@linaro.org>





----- Original Message -----
> From: "Gary S. Robertson" <gary.robertson@linaro.org>
> To: jstancek@redhat.com
> Cc: ltp-list@lists.sourceforge.net, "mike holmes" <mike.holmes@linaro.org>
> Sent: Friday, 24 October, 2014 6:47:30 PM
> Subject: [LTP][PATCH V2] Realtime tests: Fix robust mutex conditionals
> 
> Here are the two new patches which correct the robust mutex conditionals
> and also fix the erroneous correction of the PI conditional in testpi-5.c
> Thanks for straightening me out on this one!
> 

Hi,

sorry for delay, I'm out of office this week.
I tested and pushed both.

Thank you,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

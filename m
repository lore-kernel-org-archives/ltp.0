Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1Xhi2C-0001zo-5r
	for ltp-list@lists.sourceforge.net; Fri, 24 Oct 2014 16:48:16 +0000
Received: from mail-oi0-f47.google.com ([209.85.218.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Xhi2B-0004KX-Cs
	for ltp-list@lists.sourceforge.net; Fri, 24 Oct 2014 16:48:16 +0000
Received: by mail-oi0-f47.google.com with SMTP id a141so606185oig.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 24 Oct 2014 09:48:09 -0700 (PDT)
From: "Gary S. Robertson" <gary.robertson@linaro.org>
Date: Fri, 24 Oct 2014 11:47:30 -0500
Message-Id: <1414169252-19374-1-git-send-email-gary.robertson@linaro.org>
In-Reply-To: <90019386.14686839.1414156011036.JavaMail.zimbra@redhat.com>
References: <90019386.14686839.1414156011036.JavaMail.zimbra@redhat.com>
Subject: [LTP] [PATCH V2] Realtime tests: Fix robust mutex conditionals
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net, mike.holmes@linaro.org

Here are the two new patches which correct the robust mutex conditionals
and also fix the erroneous correction of the PI conditional in testpi-5.c
Thanks for straightening me out on this one!


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

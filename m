Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QUWbP-0000NM-AL
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 04:12:15 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QUWbO-0007IK-J9
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 04:12:15 +0000
Received: by pwj9 with SMTP id 9so750479pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jun 2011 21:12:08 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1307591638-1662-1-git-send-email-ratbert.chuang@gmail.com>
Date: Wed, 8 Jun 2011 21:12:07 -0700
Message-Id: <CA7435E1-1588-4A21-A380-45D13479AC69@gmail.com>
References: <1307591638-1662-1-git-send-email-ratbert.chuang@gmail.com>
Subject: Re: [LTP] [PATCH] acl_test01: fix incorrect failure losetup.1
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
To: Po-Yu Chuang <ratbert.chuang@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Po-Yu Chuang <ratbert@faraday-tech.com>

On Jun 8, 2011, at 8:53 PM, Po-Yu Chuang wrote:

> From: Po-Yu Chuang <ratbert@faraday-tech.com>
> 
> The LOOP_DEV empty checking was incorrect.
> 
> Use `command` for command substitution.
> 
> Also move the assignment out of condition expression. Bash 3.2.9 and
> Busybox 1.17.3 ash do not seem to support this kind of usage.

	Yeah... looking back and knowing what I do now, that would never work because that's executed in a subshell.
Thanks!
-Garrett
------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

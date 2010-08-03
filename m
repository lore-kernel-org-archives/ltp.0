Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OgKKa-0001ow-3F
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 16:27:08 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OgKKU-0006cT-V5
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 16:27:08 +0000
Received: by yxi11 with SMTP id 11so2147817yxi.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Aug 2010 09:26:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1280829868-10286-1-git-send-email-harsh@linux.vnet.ibm.com>
References: <1280829868-10286-1-git-send-email-harsh@linux.vnet.ibm.com>
Date: Tue, 3 Aug 2010 09:26:57 -0700
Message-ID: <AANLkTikOv_F0fVP2xqxJL1wz1zOrmpZiCXrcET8KZMe0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] setrlimit testcase fix
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
To: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Aug 3, 2010 at 3:04 AM, Harsh Prateek Bora
<harsh@linux.vnet.ibm.com> wrote:
> Current testcase for setrlimit for parameter RLIMIT_FSIZE
> does not convey the number of bytes actually written from
> child process to parent, as the child process writes to its
> own copy of global variable. This patch introduces a pipe
> to send the information from child to the parent process.

1. The style's a bit wonky, but that might be the fault with how the
original test was written.
2. You aren't checking how many bytes are actually being read/written
in your patch but assuming that the stream `bytes' is correctly
written each time ;)...

Thanks,
-Garrett

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NmklY-0002rt-Bh
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:21:16 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmklW-0000Wm-1O
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:21:16 +0000
Received: by pvf33 with SMTP id 33so327699pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 01:21:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9debc4411003021317p4b7a2872lb200d17726df24c4@mail.gmail.com>
References: <9debc4411003021317p4b7a2872lb200d17726df24c4@mail.gmail.com>
Date: Wed, 3 Mar 2010 01:21:08 -0800
Message-ID: <364299f41003030121o634253ahb8ffc008627ef705@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Makefile fix for 'createfile.c' build in
	network/tcp_cmds/echo
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
To: Maxin John <maxin.john@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Mar 2, 2010 at 1:17 PM, Maxin John <maxin.john@gmail.com> wrote:
> Hi,
>
> I have observed that the 'createfile.c' in
> testcases/network/tcp_cmds/echo directory is not getting compiled and
> installed during the LTP build. The "echo_createfile.patch" makes the
> necessary changes in the Makefile.

Good catch!
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

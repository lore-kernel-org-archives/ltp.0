Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1ZovnO-0001DL-VB
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2015 15:59:22 +0000
Received: from mail-qk0-f182.google.com ([209.85.220.182])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZovnN-00007x-9z
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2015 15:59:22 +0000
Received: by qkcy65 with SMTP id y65so40284854qkc.0
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2015 08:59:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
References: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
Date: Wed, 21 Oct 2015 21:29:13 +0530
Message-ID: <CANKSX+EC8p803DByyYE4ECw11gQk4a3Hr1SKZXpPPjw8aoz-fQ@mail.gmail.com>
From: "$rik@nth " <srikanth007m@gmail.com>
Subject: Re: [LTP] how to cross compile linux test project?
Reply-To: srikanth007m@gmail.com
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
To: vichy <vichy.kuo@gmail.com>
Cc: ltp-list@lists.sourceforge.net

you need to run autoconf program with no arguments and then autoconf
processes `configure.ac' to generate configure file.

On Wed, Oct 21, 2015 at 9:05 PM, vichy <vichy.kuo@gmail.com> wrote:
> hi All:
> I try to compile linux test project for Arm platform.
> And below is the link suggest how to configure it.
> http://sourceforge.net/p/ltp/mailman/message/34480155/
>
> But when I git clone https://github.com/linux-test-project/ltp
> it seems no configure in the git repository.
> Should I run and bootstrap to get configure file?
>
> Appreciate your kind help,
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



-- 
Thanks & Regards,
M.Srikanth Kumar.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

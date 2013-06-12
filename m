Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sulfurfff@gmail.com>) id 1UmoZ4-0003pp-3P
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 17:10:30 +0000
Received: from mail-we0-f182.google.com ([74.125.82.182])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UmoZ3-0000QP-Af
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 17:10:30 +0000
Received: by mail-we0-f182.google.com with SMTP id p60so5376713wes.41
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Jun 2013 10:10:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <602677798.1890199.1371052049559.JavaMail.root@redhat.com>
References: <CANXECd4nytMbMBtrnnD+aaEaE1NMQ8+x=gO7qCFrEFcFBGBUCg@mail.gmail.com>
	<880296419.1609038.1371019910126.JavaMail.root@redhat.com>
	<CANXECd7uzb9Rc2H1LMDuBXcExC6RHbHhJ2rv-tEz9uOcDW+Vhw@mail.gmail.com>
	<602677798.1890199.1371052049559.JavaMail.root@redhat.com>
Date: Wed, 12 Jun 2013 12:10:23 -0500
Message-ID: <CANXECd5nFxsJsTTnrFdXAnGpEX0VBAzPMsO=HKKrcjkMqvDoeA@mail.gmail.com>
From: =?UTF-8?Q?Ismael_Farf=C3=A1n?= <sulfurfff@gmail.com>
Subject: Re: [LTP] Help compiling in AIX 6.1
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

>
> ----- Original Message -----
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 12 June, 2013 4:34:24 PM
>> Subject: Re: [LTP] Help compiling in AIX 6.1
>>
>> Thanks for the answer.
>>
>> Since configure didn't fail I thought it didn't mind a few missing
>> headers.
>
> <SNIP>
>
> Right, I also don't see anything suspicious. Your output shows
> that include.mk is created, so the only other thing that comes to mind
> is that $(abs_top_builddir) is wrong.
>
> You can try making change according to diff below and re-running gmake.
> If everything works OK, this should be warning with path: /tmp/ltp-full-20130109
>
> diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
> index f1584a8..1d284ea 100644
> --- a/include/mk/env_pre.mk
> +++ b/include/mk/env_pre.mk
> @@ -74,6 +74,8 @@ else
>  abs_top_builddir               := $(abspath $(top_builddir))
>  endif
>
> +$(warning abs dirs: $(abs_top_srcdir) $(abs_top_builddir))
> +
>  # Where's the root object directory?
>  builddir                       := .
>
> Regards,
> Jan

I'm using gmake 3.8

I got this new line from gmake after the patch:
/tmp/ltp-full-20130109/include/mk/env_pre.mk:77: abs dirs: -n
/tmp/ltp-full-20130109 -n /tmp/ltp-full-20130109

The appended "-n" looks kind of suspicious?

Cheers



--
Do not let me induce you to satisfy my curiosity, from an expectation,
that I shall gratify yours. What I may judge proper to conceal, does
not concern myself alone.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OlSFj-0004x8-NG
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:55:19 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSFi-00050C-Rw
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:55:19 +0000
Received: by bwz12 with SMTP id 12so4084774bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 12:55:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C6AD62B.2010905@redhat.com>
References: <4C6AD62B.2010905@redhat.com>
Date: Tue, 17 Aug 2010 12:50:06 -0700
Message-ID: <AANLkTimTbSmbAf+sVJz6KsMxcYsg0Em6+1jrgcNLuDcF@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] problems building lchown02.c for uClinux
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
To: dmarlin@redhat.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 11:34 AM, David Marlin <dmarlin@redhat.com> wrote:
>
> 'lchown02.c' does not build properly due to calls to mmap and
> get_high_address (which references sbrk) when UCLINUX=1 is defined.
>
> Attached is a patch to skip those sections of the test when building for
> uClinux.

    I understand the mmap(2) part, but couldn't the get_high_address
portion be done in the LTP headers and library files? It would help if
there was a breakdown of what functionality is and isn't available in
uclinux that's gating builds / testing (I honestly don't know right
offhand what those pieces are).
Thanks!
-Garrett

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

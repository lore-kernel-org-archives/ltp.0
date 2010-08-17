Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OlS8k-0005Wg-QL
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:48:06 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlS8j-0003Hq-Qy
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 19:48:06 +0000
Received: by bwz12 with SMTP id 12so4077339bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 12:47:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C6AD534.2020109@redhat.com>
References: <4C6AD534.2020109@redhat.com>
Date: Tue, 17 Aug 2010 12:47:59 -0700
Message-ID: <AANLkTimPmB9fNdv2f+zS42Y_+T+6_4y1enDv=K_sHkY=@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] problems building mallopt01.c for uClinux
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

On Tue, Aug 17, 2010 at 11:30 AM, David Marlin <dmarlin@redhat.com> wrote:
>
> The testcase mallopt01 skips performing the test when UCLINUX=1, but the
> mallinfo structure is defined outside the #if !defined(UCLINUX) block.
>
> Attached is a patch to move the mallinfo structure definition inside the
> #if !defined(UCLINUX) block.

ACK.

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

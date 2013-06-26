Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrpgN-0003N2-1F
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 13:22:47 +0000
Date: Wed, 26 Jun 2013 15:24:16 +0200
From: chrubis@suse.cz
Message-ID: <20130626132415.GB16146@rei.suse.cz>
References: <1372208571-9642-1-git-send-email-sedat.dilek@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372208571-9642-1-git-send-email-sedat.dilek@gmail.com>
Subject: Re: [LTP] [PATCH] runtest: Add new syscalls-ipc test-suite
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Run via './runltp -f syscalls-ipc'.
> 
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  runtest/syscalls-ipc | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 runtest/syscalls-ipc

What about adding these to the existing runtest/ipc file? Would that
work for you? (I'm trying to avoid state where we have zilion runtest
files with not clearly defined content.)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

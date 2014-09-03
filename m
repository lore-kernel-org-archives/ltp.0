Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XP5lR-00045P-MI
	for ltp-list@lists.sourceforge.net; Wed, 03 Sep 2014 08:18:01 +0000
Date: Wed, 3 Sep 2014 10:17:48 +0200
From: chrubis@suse.cz
Message-ID: <20140903081748.GA18674@rei.suse.cz>
References: <1409672694-32108-1-git-send-email-zlang@redhat.com>
	<20140903072238.GA16534@rei.suse.cz> <5406CE2C.5080006@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5406CE2C.5080006@redhat.com>
Subject: Re: [LTP] [PATCH] fs/fsstress: modify compile warning about
	fsstress.c
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
To: Zorro Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> when compile kernel/fs/fsstress/fsstress.c, some warning always be printed.
> >> Because there is a new field 'isxfs' be added in opdesc_t struct,
> >> but some lines of opdesc_t ops[] forget to init this field.
> > Pushed, thanks.
> >
> Thank you very much.
> 
> How about the other patch, named "fs/fsstress: prevent orphan and zombie 
> processes to be left".
> That is we really want to be merged.

I will have a look ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

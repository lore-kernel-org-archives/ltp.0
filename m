Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XPUtQ-0002tj-8L
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 11:07:56 +0000
Date: Thu, 4 Sep 2014 13:07:43 +0200
From: chrubis@suse.cz
Message-ID: <20140904110743.GA4322@rei.suse.cz>
References: <1409672758-32402-1-git-send-email-zlang@redhat.com>
	<20140904103019.GB3151@rei.suse.cz> <5408450C.6000201@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5408450C.6000201@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] [PATCH-V2]fs/fsstress: prevent orphan and
 zombie processes to be left
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
> Sorry about that. That's a mistake and not intended.
> I said it took from xfstests in my first email about this patch. I just 
> forgot to do that after I ping you and re-created this patch several 
> times. I will notice that in the future. Sorry again.
> 
> BTW, I am 'not' do nothing and just verbatim copy from xfstests. LTP 
> fsstress.c is not all same with xfstests fsstress.c, I have tried to 
> make the patch suitable for LTP, and did many test about the patch, to 
> make sure it's good.

Ok. This information is exactly what should have been included in the
commit message. I.e. include the original message from the xfstest
commit and add a paragraph about what you did.

> You can write the original authors and without my name, I just hope this 
> feature can be in fsstress. That will useful for our test.

The right solution is to keep the original signed-off-by and since you
ported the code back to LTP you should also add your signed-off-by.

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

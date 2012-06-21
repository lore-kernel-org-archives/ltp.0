Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Shh8v-0000KO-H6
	for ltp-list@lists.sourceforge.net; Thu, 21 Jun 2012 13:09:49 +0000
Date: Thu, 21 Jun 2012 14:26:27 +0200
From: chrubis@suse.cz
Message-ID: <20120621122626.GA30428@saboteur.suse.cz>
References: <CADyYWLnDv=Zf5LdUkYqsDCKAGG3r9=DhTPcsVf0rnNBHBtx1XQ@mail.gmail.com>
	<20120615120709.GD16073@saboteur.suse.cz>
	<CADyYWLmoLwZNe0t1L92eQV787vemJxgv9B-W2asDQYBFE3d7eA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADyYWLmoLwZNe0t1L92eQV787vemJxgv9B-W2asDQYBFE3d7eA@mail.gmail.com>
Subject: Re: [LTP] Found a bug in the file_test.sh
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
To: sujith h <sujith.h@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I had updated the patch with the signoff and the instructions mentioned as
> above. Hope this patch now looks better.

The patch is better.

But I'm wondering what version of gzip you are using, because the GNU
variant leaves the gziped files in the original directory.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

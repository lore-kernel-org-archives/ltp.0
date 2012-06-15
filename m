Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SfVzT-0001LS-7U
	for ltp-list@lists.sourceforge.net; Fri, 15 Jun 2012 12:51:03 +0000
Date: Fri, 15 Jun 2012 14:07:09 +0200
From: chrubis@suse.cz
Message-ID: <20120615120709.GD16073@saboteur.suse.cz>
References: <CADyYWLnDv=Zf5LdUkYqsDCKAGG3r9=DhTPcsVf0rnNBHBtx1XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADyYWLnDv=Zf5LdUkYqsDCKAGG3r9=DhTPcsVf0rnNBHBtx1XQ@mail.gmail.com>
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
> Here we can see that the script couldn't find the files.tar.gz file and
> exited. The problem I noticed in the script was, when the script executes
> the gzip command on the files.tar, the files.tar.gz file is created in the
> $PWD and hence it has to be moved to the $LTPTMP directory. After doing
> this change the output of the script was mentioned below:

Maybe it would be better to create the file directly in LTPTMP.

And regarding the patch. Please send one with signed-of-by, line (git
can create these for you). And change the comment a little. Usuall
format is:

First line with short description
(empty line)
Longer description composing possibly of several lines.

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

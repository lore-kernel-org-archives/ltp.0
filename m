Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QW5cB-0000RP-Lg
	for ltp-list@lists.sourceforge.net; Mon, 13 Jun 2011 11:47:31 +0000
Date: Mon, 13 Jun 2011 13:33:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110613113321.GA8740@saboteur.suse.cz>
References: <BANLkTinjK1N+jzhSOJrECj3O95k16+6Fkg@mail.gmail.com>
	<20110603130036.GA7155@saboteur.suse.cz>
	<BANLkTi=MR+H7htd3XmqkHGGxoQvfBFRerQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTi=MR+H7htd3XmqkHGGxoQvfBFRerQ@mail.gmail.com>
Subject: Re: [LTP] open posix "sigpause" test defect
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
To: "Kevin R. Whitney" <krwhitney@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm new- I don't know how to do that.  I'll look around the website, but if
> you have the
> info handy it'd be great if you could give me a pointer.

I would start with reading git community book (which would be quite easy
to if you are familiar with other SCM tools like svn). Don't need to
read it all, just get familiar with git to be able to clone repository,
commit changes, generate patches...

The development process here is something like:

* Get LTP souces via git
* Do the changes in the code, test them
* Commmit changes localy (commits should be signed)
* Generate patches from local commits and send them to LTP mailing list
  for review and merge

If you have any questions regarding LTP don't hesitate to ask ;).

PS: We follow LKML coding style which is described in:
    http://www.kernel.org/doc/Documentation/CodingStyle

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Ogxg6-00082c-EY
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 10:27:58 +0000
Date: Thu, 5 Aug 2010 12:44:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100805104429.GA13500@saboteur.suse.cz>
References: <20100802155347.GA1878@saboteur.suse.cz>
	<AANLkTi=x46Wh1U_byaw-9mBkkYoMZvTeFnOWsAVEQni0@mail.gmail.com>
	<20100803092704.GA29069@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20100803092704.GA29069@saboteur.suse.cz>
Subject: Re: [LTP] ltp buildsystem bugreport
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > "Don't expect a project that uses Makefiles to function properly with
> > paths that have colons, spaces, etc to function properly". Keep things
> > as simple as possible and you won't have issues with building LTP :).
> 
> Okay, at least add this into the INSTALL file so that other people
> doesn't get confused as I did.
> 

Here is a patch for that, hope you don't mind I've quoted your mail
reply in it :).

Hmm and there is still Rishkesh K Rajak as main LTP maintainer in
README.

And CREDITS file seems to be pretty old too.

-- 
Cyril Hrubis
chrubis@suse.cz

--ZPt4rx8FFjLCG7dd
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="INSTALL.patch"

Index: ltp-dev-local/INSTALL
===================================================================
--- ltp-dev-local.orig/INSTALL
+++ ltp-dev-local/INSTALL
@@ -65,6 +65,12 @@ what to do next...
 Compiling LTP
 -------------------
 
+Prerequisites
+-------------------
+Don't expect LTP to build properly with paths that have colons, spaces,
+semicolons and other strange characters in. Keep things as simple as possible
+and you won't have issues with building LTP :).
+
 In-build-tree
 -------------------
 In-build-tree support is when you build binaries (applications, binary objects)

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--ZPt4rx8FFjLCG7dd--


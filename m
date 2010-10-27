Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB4Pt-0007fi-1x
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:43:41 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB4Ps-0007U9-9k
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:43:41 +0000
Received: by ywo32 with SMTP id 32so310624ywo.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:43:35 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 12:43:34 +0100
Message-ID: <AANLkTim5HeA2TKJnUXXWu8B7NCd_MxkUfzNoUtRCMK_-@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] IDCheck.sh during make install
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
To: ltp-list@lists.sourceforge.net

Hi all,

When you "make install" the makefile runs IDCheck.sh. For
cross-compiled targets this is only valid if you're installing
directly to the actual filesystem which will be used on the embedded
target. Would it be worth forcing SKIP_IDCHECK=1if in a cross-compile
environment? Configure deduces this from whether "build_alias" !"=
"host_alias". I suspect this ought to be a run-time test - especially
given that I missed this on my first run and had lots of errors as a
result which wasn't clear :-D Is there any kind of validation for
system build (or kernel config!) prerequisites before running tests?
Would be sensible to do this before running tests rather than running
them and failing as a result (also relevent in the case of
memory-constrained tests that fail on embedded targets)

Side-note : I suspect there may be a cross-compile related error in
configure in "ltp-full-20100831". I've never dug deeply into configure
scripts but this looks inverted based on other similar parts of
configure :
    if test x$cross_compiling = xyes; then
     CROSS_COMPILATION_TRUE=
     CROSS_COMPILATION_FALSE='#'
   else
     CROSS_COMPILATION_TRUE='#'
     CROSS_COMPILATION_FALSE=
   fi

Cheers,

~Pev

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

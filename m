Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1NWnpP-0005yI-1T
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 09:23:19 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1NWnpN-00011R-RT@g45xhf1.ch3.sourceforge.com>
Date: Mon, 18 Jan 2010 09:23:17 +0000
Subject: [LTP] [ ltp-Bugs-2931756 ] Mangled C++ names in LCOV functions
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
To: noreply@sourceforge.net

Bugs item #2931756, was opened at 2010-01-14 02:20
Message generated for change (Comment added) made by oberpapr
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2931756&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: None
Group: None
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Marc Alff (crispydev)
Assigned to: Nobody/Anonymous (nobody)
Summary: Mangled C++ names in LCOV functions

Initial Comment:
Hi.

I just looked at a LCOV report for some code using C++, generated with LCOV 1.7.

First, thanks a lot for the new function coverage feature.

A minor bug:
In the report showing the function_name / hit count table,
names for C++ methods are using the C++ encoded name (_ZN13MYSQL_BIN_LOG25set_purge_index_file_nameEPKc),
where the demangled name (MYSQL_BIN_LOG::set_purge_index_file_name(char const*)) would be much nicer.

malff@linux-su11:~> c++filt --version
GNU c++filt (GNU Binutils; openSUSE 11.1) 2.19

malff@linux-su11:~> c++filt
"_ZN13MYSQL_BIN_LOG25set_purge_index_file_nameEPKc"
MYSQL_BIN_LOG::set_purge_index_file_name(char const*)

Regards,
-- Marc Alff


----------------------------------------------------------------------

Comment By: Peter Oberparleiter (oberpapr)
Date: 2010-01-18 10:23

Message:
The CVS version of LCOV already handles this problem: genhtml has a new
switch --demangle-cpp which, when called, will use c++filt to convert all
function names. There will be a new LCOV release soon containing this new
switch.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2931756&group_id=3382

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

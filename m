Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <sds@tycho.nsa.gov>) id 1QDGOz-00046j-OC
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 13:28:05 +0000
Received: from msux-gh1-uea02.nsa.gov ([63.239.65.40])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QDGOz-00087v-0X
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 13:28:05 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 22 Apr 2011 09:08:47 -0400
Message-ID: <1303477727.18220.15.camel@moss-pluto>
Mime-Version: 1.0
Subject: [LTP] selinux-testsuite has moved
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
To: ltp-list <ltp-list@lists.sf.net>

Hi,

A recent posting on lkml noted that the selinux testsuite in ltp doesn't
work anymore.  As no one seems to be maintaining it in the ltp, I'd
suggest just removing it entirely. You may want to leave a README.MOVED
or similar file pointing to the new location, e.g.:

The selinux testsuite has been moved to a standalone testsuite
separate from the ltp.  You can obtain it via:
 git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite

Thanks.

-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
Fulfilling the Lean Software Promise
Lean software platforms are now widely adopted and the benefits have been 
demonstrated beyond question. Learn why your peers are replacing JEE 
containers with lightweight application servers - and what you can gain 
from the move. http://p.sf.net/sfu/vmware-sfemails
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

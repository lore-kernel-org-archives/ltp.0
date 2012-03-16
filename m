Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <serge.hallyn@canonical.com>) id 1S8Y03-0000ia-70
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 14:19:23 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S8Xzx-0006Z2-O4
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 14:19:23 +0000
Date: Fri, 16 Mar 2012 09:19:06 -0500
From: Serge Hallyn <serge.hallyn@canonical.com>
Message-ID: <20120316141906.GB2897@peqn>
References: <OFEC1872A7.8CB8CA8C-ON652579C3.004D1716-652579C3.004DAE00@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OFEC1872A7.8CB8CA8C-ON652579C3.004D1716-652579C3.004DAE00@in.ibm.com>
Subject: Re: [LTP] Are you still maintaining Selinux testsuite
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
To: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>

Quoting Poornima Nayak (Poornima.Nayak@in.ibm.com):
> Hi Serge
> 
> I was looking out for selinux test suite after the call was taken to move 
> it out of LTP. Latest discussion is this 
> http://permalink.gmane.org/gmane.linux.ltp/15301. Any progress beyond this 
> ?

Hi Poornima,

yes, I'm sorry it's taken this long, but I finally got a copy up at:

http://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=summary

Thanks James for the account, and Stephen for the copy of the git tree.

Now I should get back to getting this to pass on Ubuntu - unfortunately
the changes I"d been staging for that were the victim of a hard drive
crash.

-serge

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

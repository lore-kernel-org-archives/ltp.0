Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1OTysc-0002w2-MX
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 15:07:14 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.65.39])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OTysZ-0003qA-0E
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 15:07:14 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1277900005.5710.8.camel@subratamodak.linux.ibm.com>
References: <20100629195210.GA14549@hallyn.com>
	<1277900005.5710.8.camel@subratamodak.linux.ibm.com>
Date: Wed, 30 Jun 2010 10:52:24 -0400
Message-ID: <1277909544.21903.142.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Subject: Re: [LTP] selinux testsuite
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, James Morris <jmorris@redhat.com>, kaigai@ak.jp.nec.com, SELinux <selinux@tycho.nsa.gov>, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, 2010-06-30 at 17:43 +0530, Subrata Modak wrote:
> Hi Serge,
> 
> On Tue, 2010-06-29 at 14:52 -0500, Serge E. Hallyn wrote:
> > Just a little note to announce that the selinux testsuite is now up as a
> > git tree at kernel.org.  You can fetch it using
> > 
> > 	git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
> 
> Great. So, how far does it differ from that we have in LTP ?
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree;f=testcases/kernel/security/selinux-testsuite;h=066df4cdf2f8a80a0045e338b4bb2bf0f5d37091;hb=HEAD
> 
> As you, Stephen and others in SELinux <selinux@tycho.nsa.gov> were the
> main contributors to the SELinux test(s) in LTP, i guess the next/future
> development for SELinux tests will be happening in the new tree.
> 
> So, i would rather keep pulling to LTP from your tree. Now, could you
> please let me know:
> 
>      1. Whether the new tree contains all scenarios which is present in
>         LTP. In such a case a complete pruning of LTP SELinux tests can
>         be done and replaced with your tree contents,
>      2. If some of the LTP tests are not there, then i would like to
>         retain them in LTP side-by-side your tree contents,

The new tree contains all of the selinux tests present in the LTP.  You
cannot however simply replace the ltp version of the tests with this
tree, as this tree is a standalone testsuite and will not run within the
ltp test harness. This testsuite is based on the original standalone
selinux testsuite that was contributed by us to IBM to port to the LTP.
We have internally maintained this testsuite in parallel to the ltp
version as we have found it easier to set up, use, debug, and maintain.

-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

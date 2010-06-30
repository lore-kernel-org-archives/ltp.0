Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OTwba-0006PG-SJ
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 12:41:30 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTwbZ-0002ns-RS
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 12:41:30 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100629195210.GA14549@hallyn.com>
References: <20100629195210.GA14549@hallyn.com>
Date: Wed, 30 Jun 2010 17:43:24 +0530
Message-Id: <1277900005.5710.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] selinux testsuite
Reply-To: subrata@linux.vnet.ibm.com
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
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@redhat.com>, ltp-list <ltp-list@lists.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com

Hi Serge,

On Tue, 2010-06-29 at 14:52 -0500, Serge E. Hallyn wrote:
> Just a little note to announce that the selinux testsuite is now up as a
> git tree at kernel.org.  You can fetch it using
> 
> 	git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite

Great. So, how far does it differ from that we have in LTP ?
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree;f=testcases/kernel/security/selinux-testsuite;h=066df4cdf2f8a80a0045e338b4bb2bf0f5d37091;hb=HEAD

As you, Stephen and others in SELinux <selinux@tycho.nsa.gov> were the
main contributors to the SELinux test(s) in LTP, i guess the next/future
development for SELinux tests will be happening in the new tree.

So, i would rather keep pulling to LTP from your tree. Now, could you
please let me know:

     1. Whether the new tree contains all scenarios which is present in
        LTP. In such a case a complete pruning of LTP SELinux tests can
        be done and replaced with your tree contents,
     2. If some of the LTP tests are not there, then i would like to
        retain them in LTP side-by-side your tree contents,

Regards--
Subrata

> 
> The README shows how to run.
> 
> Many thanks to Stephen for keeping it running so nicely and allowing me
> to post it.  I intend to test against Fedora regularly-ish, and to start
> seeing how best to nudge it to work against Debian and Ubuntu in the next
> month or so.
> 
> -serge
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

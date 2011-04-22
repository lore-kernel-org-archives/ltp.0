Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1QDNzQ-0002KW-R1
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 21:34:12 +0000
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QDNzP-0000dp-JX
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 21:34:12 +0000
Message-ID: <4DB1E88D.2030808@linux.vnet.ibm.com>
Date: Sat, 23 Apr 2011 02:13:57 +0530
From: Shubham Goyal <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <1303477727.18220.15.camel@moss-pluto>
In-Reply-To: <1303477727.18220.15.camel@moss-pluto>
Subject: Re: [LTP] selinux-testsuite has moved
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>

On Friday 22 April 2011 06:38 PM, Stephen Smalley wrote:
> Hi,
>
> A recent posting on lkml noted that the selinux testsuite in ltp doesn't
> work anymore.  As no one seems to be maintaining it in the ltp, I'd
> suggest just removing it entirely. You may want to leave a README.MOVED
> or similar file pointing to the new location, e.g.:
>
> The selinux testsuite has been moved to a standalone testsuite
> separate from the ltp.  You can obtain it via:
>   git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
>
> Thanks.
>

Hi Stephan,

Can you please tell what was the exact problem in running LTP's selinux 
testsuite?
I tried running them and it worked for me with a minor modification. The 
current
'test_selinux.sh' sets the LTPROOT as the LTP source's 'testscripts' 
directory but as
per current build process '/opt/ltp' is the install directory. After 
making these changes
in 'test_selinux.sh' script, the test cases worked fine for me.

I believe keeping it as a part of LTP tree is a better idea and would 
have better
chances of getting it maintained along with other LTP test case and modules.

Thanks,
Shubham

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

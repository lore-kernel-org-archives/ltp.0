Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <sds@tycho.nsa.gov>) id 1QELuI-0007Vl-Rf
	for ltp-list@lists.sourceforge.net; Mon, 25 Apr 2011 13:32:54 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.65.39])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QELuH-0003WN-LY
	for ltp-list@lists.sourceforge.net; Mon, 25 Apr 2011 13:32:54 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <4DB1E88D.2030808@linux.vnet.ibm.com>
References: <1303477727.18220.15.camel@moss-pluto>
	<4DB1E88D.2030808@linux.vnet.ibm.com>
Date: Mon, 25 Apr 2011 09:32:36 -0400
Message-ID: <1303738356.4244.67.camel@moss-pluto>
Mime-Version: 1.0
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
To: Shubham Goyal <shubham@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Sat, 2011-04-23 at 02:13 +0530, Shubham Goyal wrote:
> On Friday 22 April 2011 06:38 PM, Stephen Smalley wrote:
> > Hi,
> >
> > A recent posting on lkml noted that the selinux testsuite in ltp doesn't
> > work anymore.  As no one seems to be maintaining it in the ltp, I'd
> > suggest just removing it entirely. You may want to leave a README.MOVED
> > or similar file pointing to the new location, e.g.:
> >
> > The selinux testsuite has been moved to a standalone testsuite
> > separate from the ltp.  You can obtain it via:
> >   git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
> >
> > Thanks.
> >
> 
> Hi Stephan,
> 
> Can you please tell what was the exact problem in running LTP's selinux 
> testsuite?
> I tried running them and it worked for me with a minor modification. The 
> current
> 'test_selinux.sh' sets the LTPROOT as the LTP source's 'testscripts' 
> directory but as
> per current build process '/opt/ltp' is the install directory. After 
> making these changes
> in 'test_selinux.sh' script, the test cases worked fine for me.

I don't know the exact problem; I just know that it didn't work for the
person who mentioned it in passing on lkml.  And apparently it didn't
work for you either until you changed test_selinux.sh.  But I know that
test_selinux.sh has worked in the past, even after the change
to /opt/ltp, and that we haven't changed it recently.

Actually, I just tried running it via cd /opt/ltp
&& ./testscripts/test_selinux.sh and it seemed to work fine.  This was
with the current git, building in-tree, installing to /opt/ltp.

> I believe keeping it as a part of LTP tree is a better idea and would 
> have better
> chances of getting it maintained along with other LTP test case and modules.

This has been discussed a bit in the past, e.g. see this thread:
http://marc.info/?t=127790181000003&r=1&w=2

At present we see no benefit, only cost, to maintaining the selinux
testsuite in the ltp as it is regularly broken by unrelated changes
elsewhere in the ltp and as it is not truly integrated into the ltp (you
have to perform separate steps to build and run it).  In comparison, we
don't have to worry about unrelated changes breaking the standalone
selinux testsuite, and it is certainly no harder to do this:

git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
cd selinux-testsuite
sudo make test

than to do this:

git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
cd ltp
make autotools
./configure
make all
make install
cd testcases/kernel/security/selinux-testsuite
make all
make install
cd /opt/ltp
./testscripts/test_selinux.sh

If the selinux testsuite were fully integrated into the ltp (e.g. built
and run by default if SELinux is enabled on the system), then that might
be more worthwhile to keep it as part of the ltp.  But in the 6 years
since it was added to the ltp, that hasn't happened. 

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

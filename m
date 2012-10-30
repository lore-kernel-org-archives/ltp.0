Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TT9bU-0007tH-Io
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 11:03:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TT9bO-0007u1-Ke
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 11:03:28 +0000
Message-ID: <508FB40D.5050600@cn.fujitsu.com>
Date: Tue, 30 Oct 2012 19:03:41 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <7714323b7c85bc53de14c05d1f5b47085a9a7ae2.1351593924.git.jstancek@redhat.com>
In-Reply-To: <7714323b7c85bc53de14c05d1f5b47085a9a7ae2.1351593924.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v4] ipc/shmat: pick suitable base_addr before each
 testcase
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 10/30/2012 06:52 PM, Jan Stancek wrote:
> This test picked fixed address in setup() which was used throughout
> the test. There has been reports that it can fail with EINVAL.
> 
> I could reproduce it by adding single printf in between
> detach/attach:
> http://article.gmane.org/gmane.linux.ltp/16480
> 
> This patch picks suitable base_addr before each test. So even if glibc
> would mmap extra page with addr == base_addr picked by setup(),
> new suitable address will be chosen.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Pushed, thank you. 

Wanlong Gao


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

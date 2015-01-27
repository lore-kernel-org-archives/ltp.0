Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YG0bg-0006YM-6y
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 07:30:40 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YG0be-0003p6-Rs
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 07:30:40 +0000
Message-ID: <1422343778.1619.46.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 27 Jan 2015 15:29:38 +0800
In-Reply-To: <54C22A59.6020108@oracle.com>
References: <54B7D920.7050402@oracle.com>
	<1421818093-24202-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<54C22A59.6020108@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 1/3] rlogin: Cleanup
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
On Fri, 2015-01-23 at 14:02 +0300, Alexey Kodanev wrote:
> On 21.01.2015 8:28, Zeng Linggang wrote:
> > * Add 'TCID' and 'TST_TOTAL'.
> > * Use 'test.sh'.
> > * Delete some useless comment.
> > * Some cleanup.
> >
> > Signed-off-by: Zeng Linggang<zenglg.jy@cn.fujitsu.com>
...
> > +
> > +	if [ -z $PASSWD ]; then
> > +		tst_brkm TCONF "Please set PASSWD for $RUSER."
> > +	fi
> >   
> 
> What about password-less configuration, do we really need to exit with 
> TCONF in that case?
> 

To be honest, it is really not need to exit. I just want to make the
test as simple as possible. We cannot expect everyone to setup
password-less.

Best regards,
Zeng


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

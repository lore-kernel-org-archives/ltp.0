From: Eryu Guan <eguan@redhat.com>
Date: Tue, 21 Jun 2016 18:59:05 +0800
Subject: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs
 and btrfs
In-Reply-To: <57691C1B.7040309@oracle.com>
References: <20160524074936.11253-1-bxue@redhat.com>
 <882847003.325886.1464098472012.JavaMail.zimbra@redhat.com>
 <20160524152621.GB12920@rei.suse.cz>
 <977252429.1084123.1464157861719.JavaMail.zimbra@redhat.com>
 <57454EC5.7050700@oracle.com>
 <20160617042825.GJ5140@eguan.usersys.redhat.com>
 <57691C1B.7040309@oracle.com>
Message-ID: <20160621105905.GV5140@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 21, 2016 at 01:51:07PM +0300, Stanislav Kholmanskikh wrote:
> Hi
> 
[snip]
> >>
> >>I'd ack the patch, since it affects only one test case.
> >
> >Any decision made on this patch?
> >
> >I agreed with acking this patch, it's a targeted fix and only only
> >affects robind tests and is the easiest way to fix the failure at this
> >moment :)
> 
> Sorry for my late response.
> 
> I pushed the patch.

Thanks!

Eryu

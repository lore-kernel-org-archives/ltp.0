From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Jul 2020 09:17:41 -0400 (EDT)
Subject: [LTP] [PATCH v5 1/2] tst_device: Add new api
 tst_find_backing_dev(path, dev)
In-Reply-To: <20200702122728.GB9101@yuki.lan>
References: <1904309747.19085433.1593428894028.JavaMail.zimbra@redhat.com>
 <1593430883-6131-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <370764327.568888.1593681513002.JavaMail.zimbra@redhat.com>
 <20200702122728.GB9101@yuki.lan>
Message-ID: <1534761957.602642.1593695861092.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

----- Original Message -----
> Hi!
> > > This api uses stat() to get major/minor devnumber of the path, assign the
> > > 10th column value to dev when match succeeds in "/proc/self/mountinfo".
> > > 
> > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > 
> > Cyril, any objections to v5?
> 
> Looks good, Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thank you, pushed.


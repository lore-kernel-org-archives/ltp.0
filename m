From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Jul 2020 14:27:28 +0200
Subject: [LTP] [PATCH v5 1/2] tst_device: Add new api
 tst_find_backing_dev(path, dev)
In-Reply-To: <370764327.568888.1593681513002.JavaMail.zimbra@redhat.com>
References: <1904309747.19085433.1593428894028.JavaMail.zimbra@redhat.com>
 <1593430883-6131-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <370764327.568888.1593681513002.JavaMail.zimbra@redhat.com>
Message-ID: <20200702122728.GB9101@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This api uses stat() to get major/minor devnumber of the path, assign the
> > 10th column value to dev when match succeeds in "/proc/self/mountinfo".
> > 
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> 
> Cyril, any objections to v5?

Looks good, Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

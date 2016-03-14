From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 18:15:58 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <1050034192.28240408.1457627067176.JavaMail.zimbra@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309174337.GA32758@rei>
 <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
 <20160310100425.GA18650@rei.lan>
 <149857450.28159183.1457611239055.JavaMail.zimbra@redhat.com>
 <20160310121914.GA18922@rei.lan>
 <762780060.28180858.1457616611675.JavaMail.zimbra@redhat.com>
 <20160310140653.GA19672@rei.lan>
 <1050034192.28240408.1457627067176.JavaMail.zimbra@redhat.com>
Message-ID: <20160314171557.GB3364@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Oh, if you want to mkfs.btrfs on a device less than 100MB, you can use --mixed
> option. I know it can support small device less than 100MB, but I haven't try
> the smallest size.

I would rather use the default options since that is what most of the
users will use anyway and since 100Mb is not that much either.

-- 
Cyril Hrubis
chrubis@suse.cz

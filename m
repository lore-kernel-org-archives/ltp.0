From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Mar 2016 11:04:25 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
 <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
 <20160309155258.GA32248@rei.lan>
 <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
 <20160309160924.GA28234@rei.lan>
 <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
 <20160309174337.GA32758@rei>
 <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
Message-ID: <20160310100425.GA18650@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> OK...
> 
> But actually I want to check all testcases which use tst_mkfs(), and
> give them a fs_size limit if big device will effect them in my 2nd
> patch, after the new "fs size" parameter be accepted. I think it looks
> clearly.

This begs a question what exactly is your motivation? Why do you pass a
big device in LTP_DEV in the first place? The testcases that use the
device just need it to be big enough to be formatted with a filesystem
which is about 100MB at the moment.

-- 
Cyril Hrubis
chrubis@suse.cz

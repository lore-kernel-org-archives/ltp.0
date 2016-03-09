From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 17:09:25 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
 <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
 <20160309155258.GA32248@rei.lan>
 <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
Message-ID: <20160309160924.GA28234@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes, this likes what I just said to you. add another parameter char *fs_opts[], which
> store all parameters for mkfs need to behind device name.

Given that all mkfs programs that I have installed have either one
(fs-size) or zero paremeters it does not have to be array at all.

We can just do:

void safe_mkfs(const int lineno, const char *fname, const char *dev,
               const char *fs_type, const char *fs_size,
	       const char *const fs_opts[]);

And append fs_size after device if it's non-NULL.

-- 
Cyril Hrubis
chrubis@suse.cz

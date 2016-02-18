From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Feb 2016 13:03:05 +0100
Subject: [LTP] [PATCH 1/3] llistxattr/llistxattr01.c: add new testcase
In-Reply-To: <56C5969B.4080107@cn.fujitsu.com>
References: <1454058489-25625-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160210140414.GD10106@rei.lan> <56C5969B.4080107@cn.fujitsu.com>
Message-ID: <20160218120305.GE19157@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I do not like the special case for seliux here. What we should do
> > instead is to:
> >
> > * Create file/symlink and store it's attribute list
> >
> > * Add an attribute
> >
> > * Check that the list has exactly one more attribute
> >
> > * Remove the file/symlink
> >
> >
> If we don't check that selinux adds default attribute to symlinks, What 
> about the return value.
> 
> We're not going to judge the size of  the extended attribute name list. 
> That's OK?

By "Check that the list has exactly one more attribute" I meant that we
compare the result to the previous state. If we store the attribute list
right after the symlink was created we can check if the increase in list
size is as expected. Or is there a reason why we can't do this?

-- 
Cyril Hrubis
chrubis@suse.cz

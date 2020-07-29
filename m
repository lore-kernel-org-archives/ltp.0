From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Jul 2020 13:39:46 +0200
Subject: [LTP] [PATCH v3 2/2] syscalls/ioctl_loop05: Using
 LOOP_CONFIGURE to set direct io
In-Reply-To: <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200722125946.GA22573@yuki.lan>
 <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200729113946.GB7152@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I started look at this patch however the first thing I've found out is that
our mountinfo parser is wrong. If you look at man 5 proc it says:

36 35 98:0 /mnt1 /mnt2 rw,noatime master:1 - ext3 /dev/root rw,errors=continue
(1)(2)(3)   (4)   (5)      (6)      (7)   (8) (9)   (10)         (11)


(7)  optional fields: zero or more fields of the form
     "tag[:value]"; see below.

So we cannot really parse the information with a static scanf() string,
since the number of elements in the line is not constant.

And it does fail on some of the machines I do have here since there is
no optional fields present.

So I guess that we will have to write a parser that reads that
information line by line after all.

-- 
Cyril Hrubis
chrubis@suse.cz

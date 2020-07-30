From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Jul 2020 11:28:02 +0200
Subject: [LTP] [PATCH v3 2/2] syscalls/ioctl_loop05: Using
 LOOP_CONFIGURE to set direct io
In-Reply-To: <924c3fc1-c56c-a752-0720-bb12d6cf8ec0@cn.fujitsu.com>
References: <20200722125946.GA22573@yuki.lan>
 <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200729113946.GB7152@yuki.lan>
 <924c3fc1-c56c-a752-0720-bb12d6cf8ec0@cn.fujitsu.com>
Message-ID: <20200730092802.GA3457@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So I guess that we will have to write a parser that reads that
> > information line by line after all.
> I doubt how machies will have more or zero fields in (7). But I think 
> you are right,

Well that's what I do have here.

> How about using the (3) field and second to last field. Then we can 
> avoid zero or more filed in (7). the code as below??

Actually looking into util-linux code it says that th the optional
fields are terminated with " - ", see:

https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/libmount/src/tab_parse.c#n177

So I guess the safest option would be:

* Match the line by major:minor as you do
* Then strstr() for " - " should land us directly to field (8)

-- 
Cyril Hrubis
chrubis@suse.cz

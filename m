From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 5 Aug 2016 18:08:35 +0800
Subject: [LTP] [PATCH 1/2] syscalls/access04: reconstruct and convert to
 new API
In-Reply-To: <20160804165028.GD3367@rei.lan>
References: <1469698729-5860-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20160804165028.GD3367@rei.lan>
Message-ID: <57A465A3.8020306@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Thanks for your comments!

On 08/05/2016 12:50 AM, Cyril Hrubis wrote:
> Hi!
> Once we remote the directory the accessfile is in this is just the same
> as access01.c.
> 

Sorry, do you mean once we "remote" the directory? or "remove" the directory?
And I think access04 does a little more: checks if the file exists actually
via stat(), maybe I should add this part(check existence) to access02?

> Looks like the whole point of the test was to put the file into a
> directory and pass the path to the syscall.
> 
> What about we remote this test and add a few more cases with a file in
> subdirectory to the access01 test instead?
> 

OK, I will put this part into access01 and add a few more cases instead, thanks.

Regards,
Guangwen Feng



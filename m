From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 May 2021 10:44:10 +0200
Subject: [LTP] LTP pre-release git freeze and call for testing
In-Reply-To: <CAEemH2eo7LOvz0LBwuaNkM2aRRWxD_rErOWFyHjVOpRB3oNCsw@mail.gmail.com>
References: <YJOYgZNL7/qp5YCN@yuki> <YJpq26w8NBvBzUSc@yuki>
 <YJz4A3mR3jHciihe@yuki>
 <CAEemH2eo7LOvz0LBwuaNkM2aRRWxD_rErOWFyHjVOpRB3oNCsw@mail.gmail.com>
Message-ID: <YKN+Wi4qo4TnJGkg@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Tested the latest LTP branch on RHEL8 (with itself kernel-4.18~ and
> mainline kernel-v5.13-rc1), the result looks pretty good to me.

Thanks a lot!

> Mainline kernel:
>   mkswap01 6 TBROK: "check_for_file /dev/disk/by-label/ltp_testswap" timed out
>     - looks like hit the race condition issue as before
>   hugemmap05.c:84: TBROK: mmap((nil),2147483648,3,1,3,0) failed: ENOMEM (12)
>     - seems caused by memory fragmentation, not a big deal

This should be probably changed to TCONF but that can wait after the
release.

-- 
Cyril Hrubis
chrubis@suse.cz

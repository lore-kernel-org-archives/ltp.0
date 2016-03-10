From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Mar 2016 13:19:14 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <149857450.28159183.1457611239055.JavaMail.zimbra@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309155258.GA32248@rei.lan>
 <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
 <20160309160924.GA28234@rei.lan>
 <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
 <20160309174337.GA32758@rei>
 <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
 <20160310100425.GA18650@rei.lan>
 <149857450.28159183.1457611239055.JavaMail.zimbra@redhat.com>
Message-ID: <20160310121914.GA18922@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I don't mean give size limit to all cases use tst_mkfs. I mean the limited size
> used for cases which will effected by test device size. Actually, I just pass
> size limit to mmap16 until now:) I don't know which case need it or will need it too.
> 
> I found that mmap16 ETIMEDOUT problem by test on a 1G /dev/loop0. I don't think
> it's too big as a general test device.

Well that could be fixed easily by the extra blocksize parameter.

And I guess that the testcase can also run faster if we limit the fs
size to minimal ext4 size. So this looks like a good idea.

Are there any other testcases that fail with a device of size 1GB or
less?

> I think make an appointed size fs can be used for 3 parts:
> 1) If someone case need a specially appointed fs size, it can do it. e.g. quota test.

We do not have this need at the moment.

Are you about the write such testcase?

> 2) Generally most QE will prepare some partitions or some special device(FC, SAS...)
> in his test machine, and use them for many different test suit(LTP, xfstests ...).
> These partitions or devices maybe 15G, 80G, 1T, 2T... they always pass them as test
> devices directly. I think we shouldn't say "NO, you can't pass a device more than
> 1G to LTP, that will cause failures.", I think LTP should deal with big test device
> problem, so mkfs_sized is needed.

I do not agree. Since if you do not pass any device to LTP, it will
simply create small enough loopback device. So in this case the solution
is simply not passing any device to LTP at all.

It's not that LTP does any device specific testing or I/O stress on the
LTP_DEV so it does not matter that we use loopback device or some real
peartition. These testcases just need a device because the underlying
syscall needs to work with one or we need to simluate read only mounted
fs, etc. So there is absolutly _no_ reason to pass terabyte sized device
to these testcases.

> 3) If someone case try to full the whole test fs, and it don't need big size fs, it can use
> mkfs_sized to prevent this case run too long time.

Again passing too big device to the test ends means that the test will
take a long time to run. There is nothing unexpected on this.

> I think the reason that LTP don't care make a sized fs is LTP doesn't do many fs test,
> if LTP have more and more fs test cases, it will feel mkfs_sized is important.

I'm against adding functions that _may_ be needed in the future. If you
are writing a testcase that needs some functionality just clearly
describe what exactly do you need.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2016 17:26:22 +0200
Subject: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs
 and	btrfs
In-Reply-To: <882847003.325886.1464098472012.JavaMail.zimbra@redhat.com>
References: <20160524074936.11253-1-bxue@redhat.com>
 <882847003.325886.1464098472012.JavaMail.zimbra@redhat.com>
Message-ID: <20160524152621.GB12920@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Alternative would be to zero-erase first blocks of LTP_BIG_DEV
> in runltp, but I'm not sure we want to assume that all tests
> are going to write over it.
> 
> I found only 3 tests using LTP_BIG_DEV, this is the only
> one that is using xfs/btrfs, the other two are ext3/4.

Or we can move the dd that erases first blocks from tst_acquire_device()
to tst_mkfs().

Or we can create an API function to get the path to big device and erase
it there...

-- 
Cyril Hrubis
chrubis@suse.cz

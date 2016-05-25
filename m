From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 May 2016 16:10:12 +0200
Subject: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs
 and btrfs
In-Reply-To: <57454EC5.7050700@oracle.com>
References: <20160524074936.11253-1-bxue@redhat.com>
 <882847003.325886.1464098472012.JavaMail.zimbra@redhat.com>
 <20160524152621.GB12920@rei.suse.cz>
 <977252429.1084123.1464157861719.JavaMail.zimbra@redhat.com>
 <57454EC5.7050700@oracle.com>
Message-ID: <20160525141011.GD17981@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Or we can move the dd that erases first blocks from tst_acquire_device()
> >> to tst_mkfs().
> >
> > I went to re-read why we are avoiding -f, and this does sound better
> > than adding -f back.
> 
> If we move 'dd' to tst_mkfs(), then tst_acquire_device will return 
> "uncleared" devices, and mkfs_ext* test cases from runtest/commands will 
> start failing in our environment, i.e. we revert f79021c5d168256.

Well the mkfs testcase is special in a sense that it calls the mkfs
directly. So we may as well move the dd to tst_mfks() and do separate dd
in the mkfs testcase.

But doing 'git grep mkfs' reveals that we have more tests that call mkfs
directly and may start to fail in this case. :(

-- 
Cyril Hrubis
chrubis@suse.cz
